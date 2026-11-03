const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const {parseHTML} = require('../node_modules/linkedom');
const script = fs.readFileSync('comments-focus.js', 'utf8');

function page(html, url = 'https://example.com/book/12') {
  const dom = parseHTML('<html><body>'+html+'</body></html>');
  const {document} = dom;
  const events = new dom.window.EventTarget();
  // A separate Window per navigation, as on a real WebView. Linkedom's proxy
  // otherwise forwards custom Window properties into shared Node globals.
  const window = {location: new URL(url),
    addEventListener: events.addEventListener.bind(events),
    removeEventListener: events.removeEventListener.bind(events),
    dispatchEvent: events.dispatchEvent.bind(events), Event: dom.window.Event};
  const timers = new Map(), scrolls = []; let nextId = 0, clicks = 0;
  window.location = new URL(url);
  window.top = window;
  Object.defineProperty(document, 'readyState', {value: 'complete'});
  dom.window.Element.prototype.getClientRects = function() {return this.closest('[hidden]') ? [] : [{}];};
  dom.window.Element.prototype.scrollIntoView = function() {scrolls.push(this);};
  dom.window.Element.prototype.click = () => { clicks++; };
  const context = vm.createContext({window, document, URL,
    MutationObserver: dom.window.MutationObserver,
    getComputedStyle: () => ({visibility: 'visible'}),
    setTimeout: (fn, delay) => {timers.set(++nextId, {fn, delay});return nextId;},
    clearTimeout: id => timers.delete(id),
    fetch: () => {throw Error('The comment locator must never fetch or post');},
  });
  const run = () => vm.runInContext(script, context);
  const flush = async () => {
    await new Promise(resolve => setImmediate(resolve));
    for (const [id, timer] of [...timers]) if(timer.delay === 250) {
      timers.delete(id); timer.fn();
    }
  };
  return {window, document, timers, scrolls, run, flush, clicks: () => clicks};
}

test('uppercase Manhuagui Comment placeholder loads without clicking its form', async () => {
  const p = page('<a id="toComment">我要吐槽</a><div class="comment mt10" id="Comment"></div>');
  p.run();
  assert.equal(p.scrolls[0].id, 'Comment');
  p.document.getElementById('Comment').innerHTML = '<p>Comment 1</p>';
  await p.flush();
  assert.equal(p.scrolls.at(-1).id, 'Comment');
  assert.equal(p.timers.size, 0);
  assert.equal(p.clicks(), 0);
});
test('late comments are located after the website adds them', async () => {
  const p = page('<main>Book</main>');p.run();
  assert.equal(p.scrolls.length, 0);
  p.document.body.innerHTML += '<section id="comments"><p>Comment 1</p></section>';
  await p.flush();
  assert.equal(p.scrolls.at(-1).id, 'comments');
  assert.equal(p.timers.size, 0);
});
test('a visible review heading is preferred over a hidden comment panel', () => {
  const p = page('<div id="comments" hidden>Hidden</div><h2>最新評論 (12)</h2>');p.run();
  assert.equal(p.scrolls[0].tagName, 'H2');
  assert.equal(p.timers.size, 0);
});
test('a comment panel revealed by the website is located', async () => {
  const p = page('<div id="comments" hidden>Comment 1</div>');p.run();
  assert.equal(p.scrolls.length, 0);
  p.document.getElementById('comments').removeAttribute('hidden');
  await p.flush();
  assert.equal(p.scrolls.at(-1).id, 'comments');assert.equal(p.timers.size, 0);
});
test('manual scrolling cancels any delayed jump', async () => {
  const p = page('<main>Book</main>');p.run();
  p.window.dispatchEvent(new p.window.Event('wheel'));
  p.document.body.innerHTML += '<div id="comments">Comment 1</div>';
  await p.flush();
  assert.equal(p.scrolls.length, 0);assert.equal(p.timers.size, 0);
});
test('a page without comments stays intact and the observer times out', async () => {
  const p = page('<main>Book</main><a href="/login">Log in</a>');
  const original = p.document.body.innerHTML;p.run();
  const [id, timer] = [...p.timers].find(([, t]) => t.delay === 20000);
  p.timers.delete(id);timer.fn();
  await p.flush();
  assert.equal(p.document.body.innerHTML, original);
  assert.equal(p.scrolls.length, 0);assert.equal(p.timers.size, 0);assert.equal(p.clicks(), 0);
});
test('login redirects and other works do not get an unsolicited scroll', () => {
  for (const url of ['https://example.com/login','https://example.com/book/13','https://other.example/book/12']) {
    const p = page('<div id="comments">Comment 1</div>', url);p.run();
    assert.equal(p.scrolls.length, 0);assert.equal(p.timers.size, 0);
  }
});
test('repeated load callbacks do not scroll a completed page again', () => {
  const p = page('<div id="comments">Comment 1</div>');p.run();p.run();
  assert.equal(p.scrolls.length, 1);assert.equal(p.timers.size, 0);
});
test('the script never runs inside an embedded third-party frame', () => {
  const p = page('<div id="comments">Comment 1</div>');p.window.top = {};p.run();
  assert.equal(p.scrolls.length, 0);assert.equal(p.timers.size, 0);
});
