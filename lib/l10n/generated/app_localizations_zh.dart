// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get library => '图书馆';

  @override
  String get updates => '更新';

  @override
  String get history => '历史';

  @override
  String get browse => '浏览';

  @override
  String get more => '更多';

  @override
  String get open_random_entry => '随机打开条目';

  @override
  String get import => '导入';

  @override
  String get filter => '筛选';

  @override
  String get ignore_filters => '忽略\n筛选';

  @override
  String get downloaded => '已下载';

  @override
  String get unread => '未读';

  @override
  String get unwatched => '未观看';

  @override
  String get started => '已开始';

  @override
  String get bookmarked => '已书签';

  @override
  String get sort => '排序';

  @override
  String get alphabetically => '按字母顺序';

  @override
  String get last_read => '最后阅读';

  @override
  String get last_watched => '上次观看';

  @override
  String get last_update_check => '最后更新检查';

  @override
  String last_entry_delete_warning(
    num count,
    Object entryType,
    Object entryTypePlural,
    Object mediaType,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '你正在从你的库中删除此$mediaType的全部$count$entryTypePlural。',
      one: '你正在从你的库中删除此$mediaType的唯一$entryType。',
    );
    return '$_temp0\n这也会将整个$mediaType从你的库中移除。\n\n注意：文件本身不会被删除。';
  }

  @override
  String get chapter => '章节';

  @override
  String get episode => '剧集';

  @override
  String get unread_count => '未读计数';

  @override
  String get unwatched_count => '未观看计数';

  @override
  String get latest_chapter => '最新章节';

  @override
  String get latest_episode => '最新一集';

  @override
  String get date_added => '添加日期';

  @override
  String get display => '显示';

  @override
  String get display_mode => '显示模式';

  @override
  String get compact_grid => '紧凑网格';

  @override
  String get compression_level => '压缩级别';

  @override
  String compression_info(Object level) {
    return '压缩率越高，备份文件占用的空间越小，但会消耗更多的CPU。默认值：$level';
  }

  @override
  String get comfortable_grid => '舒适网格';

  @override
  String get cover_only_grid => '仅封面网格';

  @override
  String get list => '列表';

  @override
  String get badges => '徽章';

  @override
  String get downloaded_chapters => '已下载章节';

  @override
  String get downloaded_episodes => '下载的剧集';

  @override
  String get language => '语言';

  @override
  String get local_source => '本地来源';

  @override
  String get tabs => '标签';

  @override
  String get show_category_tabs => '显示类别标签';

  @override
  String get show_numbers_of_items => '显示项目数';

  @override
  String get other => '其他';

  @override
  String get show_continue_reading_buttons => '显示继续阅读按钮';

  @override
  String get show_continue_watching_buttons => '显示继续观看按钮';

  @override
  String get empty_library => '空图书馆';

  @override
  String get search => '搜索...';

  @override
  String get no_recent_updates => '无最近更新';

  @override
  String get remove_everything => '删除所有';

  @override
  String get remove_everything_msg => '你确定吗？所有历史将丢失';

  @override
  String get remove_all_update_msg => '你确定吗？所有更新将被清除';

  @override
  String get ok => '好';

  @override
  String get cancel => '取消';

  @override
  String get remove => '移除';

  @override
  String get remove_history_msg => '这将移除此章节的阅读日期。你确定吗？';

  @override
  String get last_used => '最后使用';

  @override
  String get pinned => '已固定';

  @override
  String get sources => '来源';

  @override
  String get install => '安装';

  @override
  String get update => '更新';

  @override
  String get latest => '最新';

  @override
  String get extensions => '扩展';

  @override
  String get migrate => '迁移';

  @override
  String get mass_migration_title => '批量迁移';

  @override
  String get mass_migration_preview_items => '预览项目';

  @override
  String get mass_migration_destination_source => '目标源';

  @override
  String get mass_migration_no_library_items => '没有可供批量迁移的图库项目。';

  @override
  String get mass_migration_no_destination_sources => '没有可用的已安装目标源。';

  @override
  String get mass_migration_installed => '已安装';

  @override
  String mass_migration_items_ready_for_review(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个项目准备好复检',
      one: '1个项目准备好复检',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_item_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个项目',
      one: '1个项目',
    );
    return '$_temp0';
  }

  @override
  String get mass_migration_select_destination_source => '选择目标源';

  @override
  String mass_migration_finding_matches(Object source, Object language) {
    return '正在 $source · $language 中寻找匹配项';
  }

  @override
  String mass_migration_processing_item(int current, int total) {
    return '正在处理第 $current / $total 个项目';
  }

  @override
  String get mass_migration_waiting_next_item => '等待2秒后处理下一个项目...';

  @override
  String get mass_migration_waiting_next_migration => '等待2秒后处理下一项迁移...';

  @override
  String mass_migration_matched_so_far(int count) {
    return '目前已匹配: $count';
  }

  @override
  String mass_migration_no_match_count(int count) {
    return '未匹配: $count';
  }

  @override
  String mass_migration_review_matches(Object source) {
    return '复检 $source 的匹配项';
  }

  @override
  String mass_migration_found_matches(int count) {
    return '找到匹配项: $count';
  }

  @override
  String mass_migration_no_matches(int count) {
    return '未找到匹配: $count';
  }

  @override
  String mass_migration_selected_to_migrate(int count) {
    return '选定迁移: $count';
  }

  @override
  String get mass_migration_finish_review => '结束复检';

  @override
  String mass_migration_migrate_selected(int count) {
    return '迁移选定项目 ($count)';
  }

  @override
  String mass_migration_migrating_selected(Object source) {
    return '正在将选定项目迁移至 $source';
  }

  @override
  String get mass_migration_no_items_selected => '未选定任何迁移项目。';

  @override
  String mass_migration_migrating_item(int current, int total) {
    return '正在迁移第 $current / $total 个项目';
  }

  @override
  String get mass_migration_complete => '批量迁移完成';

  @override
  String get mass_migration_complete_success_message => '所有选定项目均已处理成功。';

  @override
  String get mass_migration_complete_partial_message => '迁移结束，但部分项目仍需手动处理。';

  @override
  String mass_migration_route_summary(Object source, Object destination) {
    return '$source → $destination';
  }

  @override
  String get mass_migration_processed => '已处理';

  @override
  String get mass_migration_matched => '已匹配';

  @override
  String get mass_migration_migrated => '已迁移';

  @override
  String get mass_migration_skipped => '已跳过';

  @override
  String get mass_migration_failed => '失败';

  @override
  String get mass_migration_failed_items => '失败项目';

  @override
  String get mass_migration_exit => '退出批量迁移';

  @override
  String get mass_migration_no_destination_match => '未找到目标匹配项';

  @override
  String mass_migration_query(Object query) {
    return '查询条件: $query';
  }

  @override
  String get mass_migration_skip => '跳过';

  @override
  String get mass_migration_loading => '正在加载...';

  @override
  String get mass_migration_choose_another_result => '选择其他结果';

  @override
  String get mass_migration_source_chapters => '原章节';

  @override
  String get mass_migration_destination_chapters => '目标章节';

  @override
  String mass_migration_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个章节',
      one: '1个章节',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_source_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个原章节',
      one: '1个原章节',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_destination_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个目标章节',
      one: '1个目标章节',
    );
    return '$_temp0';
  }

  @override
  String get mass_migration_no_chapters_found => '未找到章节。';

  @override
  String mass_migration_and_more_chapters(int count) {
    return '以及更多 $count 个...';
  }

  @override
  String get mass_migration_unknown_title => '未知标题';

  @override
  String get mass_migration_unknown_match => '未知匹配';

  @override
  String get mass_migration_unknown_source => '未知源';

  @override
  String get mass_migration_unknown_chapter => '未知章节';

  @override
  String get migrate_confirm => '迁移到另一个来源';

  @override
  String get clean_database => '清理数据库';

  @override
  String cleaned_database(Object x) {
    return '数据库已清理！已移除 $x 条目';
  }

  @override
  String get clean_database_desc => '这将移除所有未添加到图书馆的项目！';

  @override
  String get incognito_mode => '隐身模式';

  @override
  String get incognito_mode_description => '暂停阅读历史';

  @override
  String get downloaded_only => '仅已下载';

  @override
  String get downloaded_only_description => '仅显示库中已下载的条目';

  @override
  String get download_queue => '下载队列';

  @override
  String get categories => '类别';

  @override
  String get statistics => '统计';

  @override
  String get settings => '设置';

  @override
  String get about => '关于';

  @override
  String get open_source_licenses => '开源许可证';

  @override
  String get open_source_licenses_subtitle => 'Mangayomi 所使用的软件包及其许可证';

  @override
  String get open_source_licenses_empty => '没有可用的许可证信息。';

  @override
  String get help => '帮助';

  @override
  String get no_downloads => '无下载';

  @override
  String get edit_categories => '编辑类别';

  @override
  String get edit_categories_description => '你还没有类别。点击加号按钮创建一个来组织你的图书馆';

  @override
  String get add => '添加';

  @override
  String get add_category => '添加类别';

  @override
  String get name => '名称';

  @override
  String label_value(Object label, Object value) {
    return '$label：$value';
  }

  @override
  String get url => 'URL';

  @override
  String get category_name_required => '*必填';

  @override
  String get add_category_error_exist => '此名称的类别已存在！';

  @override
  String get delete_category => '删除类别';

  @override
  String delete_category_msg(Object name) {
    return '你希望删除类别 $name 吗？';
  }

  @override
  String get rename_category => '重命名类别';

  @override
  String get general => '通用';

  @override
  String get general_subtitle => '应用语言';

  @override
  String get app_language => '应用语言';

  @override
  String get default_subtitle_language => '默认字幕语言';

  @override
  String get appearance => '外观';

  @override
  String get appearance_subtitle => '主题，日期和时间格式';

  @override
  String get theme => '主题';

  @override
  String get dark_mode => '暗模式';

  @override
  String get follow_system_theme => '跟随系统主题';

  @override
  String get on => '开';

  @override
  String get off => '关';

  @override
  String get pure_black_dark_mode => '纯黑暗模式';

  @override
  String get tint_surfaces_with_palette => '用调色板为界面着色';

  @override
  String get tint_surfaces_with_palette_subtitle =>
      '像以前一样，用所选调色板为背景、卡片和栏着色。关闭时它们保持中性色，调色板只用于强调色。';

  @override
  String get timestamp => '时间戳';

  @override
  String get relative_timestamp => '相对时间戳';

  @override
  String get relative_timestamp_short => '短（今天，昨天）';

  @override
  String get relative_timestamp_long => '长（短+，n天前）';

  @override
  String get date_format => '日期格式';

  @override
  String get reader => '阅读器';

  @override
  String get refresh => '刷新';

  @override
  String get reader_subtitle => '阅读模式，显示，导航';

  @override
  String get default_reading_mode => '默认阅读模式';

  @override
  String get reading_mode_vertical => '垂直';

  @override
  String get reading_mode_horizontal => '水平';

  @override
  String get reading_mode_left_to_right => '从左到右';

  @override
  String get reading_mode_right_to_left => '从右到左';

  @override
  String get reading_mode_vertical_continuous => '垂直连续';

  @override
  String get reading_mode_webtoon => '网络漫画';

  @override
  String get double_tap_animation_speed => '双击动画速度';

  @override
  String get normal => '正常';

  @override
  String get fast => '快';

  @override
  String get no_animation => '无动画';

  @override
  String get animate_page_transitions => '动画页面过渡';

  @override
  String get crop_borders => '裁剪边框';

  @override
  String get downloads => '下载';

  @override
  String get downloads_subtitle => '下载设置';

  @override
  String get download_location => '下载位置';

  @override
  String get custom_location => '自定义位置';

  @override
  String get only_on_wifi => '仅在wifi下';

  @override
  String get save_as_cbz_archive => '保存为CBZ档案';

  @override
  String get delete_download_after_reading => '完成阅读后删除下载内容';

  @override
  String get delete_after_reading_slot => '删除哪个章节';

  @override
  String get delete_after_reading_last => '刚读完的章节';

  @override
  String delete_after_reading_nth(int n) {
    return '往前 $n 个章节';
  }

  @override
  String get delete_after_reading_slot_subtitle => '保留几个已读章节，方便离线时回看。';

  @override
  String get delete_bookmarked_after_reading => '同时删除已书签的章节';

  @override
  String get auto_download => '自动下载';

  @override
  String get download_new_chapters => '下载新章节';

  @override
  String get download_new_chapters_subtitle => '图书馆更新后，将库中作品的新未读章节加入下载队列。';

  @override
  String get download_new_chapters_included => '仅限这些类别';

  @override
  String get download_new_chapters_excluded => '这些类别除外';

  @override
  String get download_new_chapters_all_categories => '所有类别';

  @override
  String get download_ahead => '阅读时提前下载';

  @override
  String get download_ahead_subtitle => '阅读库中作品的已下载章节时，下载接下来的未读章节。';

  @override
  String download_ahead_count(int n) {
    return '接下来的 $n 个章节';
  }

  @override
  String get concurrent_downloads => '并发下载';

  @override
  String get browse_subtitle => '来源，全球搜索';

  @override
  String get only_include_pinned_sources => '仅包括固定来源';

  @override
  String get nsfw_sources => 'NSFW（18+）来源';

  @override
  String get nsfw_sources_show => '在来源和扩展列表中显示';

  @override
  String get nsfw_sources_info => '这不会阻止非官方或可能被错误标记的扩展在应用内显示NSFW（18+）内容';

  @override
  String get version => '版本';

  @override
  String beta_version(Object version) {
    return '测试版 ($version)';
  }

  @override
  String get check_for_update => '检查更新';

  @override
  String get logs_on => '启用日志';

  @override
  String get share_app_logs => '分享应用日志';

  @override
  String get no_app_logs => '没有可用的 log.txt 文件！';

  @override
  String get failed => '失败！';

  @override
  String n_days_ago(Object days) {
    return '$days天前';
  }

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get a_week_ago => '一周前';

  @override
  String get next_week => '下周';

  @override
  String get add_to_library => '添加到图书馆';

  @override
  String get completed => '已完成';

  @override
  String get ongoing => '进行中';

  @override
  String get on_hiatus => '暂停';

  @override
  String get canceled => '已取消';

  @override
  String get publishing_finished => '发布完成';

  @override
  String get unknown => '未知';

  @override
  String get empty_placeholder => '空';

  @override
  String get error => '错误';

  @override
  String error_with_message(Object error) {
    return '错误：$error';
  }

  @override
  String get no_pages_available => '错误：无可用页面';

  @override
  String get set_categories => '设置类别';

  @override
  String get edit => '编辑';

  @override
  String get in_library => '在图书馆';

  @override
  String get filter_scanlator_groups => '筛选扫描翻译组';

  @override
  String get reset => '重置';

  @override
  String get by_source => '按来源';

  @override
  String get by_chapter_number => '按章节号';

  @override
  String get by_episode_number => '按集数';

  @override
  String get by_upload_date => '按上传日期';

  @override
  String get source_title => '来源标题';

  @override
  String get create_extension => '创建扩展';

  @override
  String get developer_mode => '开发者模式';

  @override
  String get developer_mode_subtitle => '显示扩展开发者工具（创建扩展、编辑代码）';

  @override
  String get choose_extension_language => '选择扩展语言';

  @override
  String get lang => '语言';

  @override
  String get base_url => '基础 URL';

  @override
  String get api_url_optional => 'API URL（可选）';

  @override
  String get icon_url => '图标 URL';

  @override
  String get source_icon_url => '图源图标 URL';

  @override
  String get notes => '备注';

  @override
  String get extension_name_example => '例如：myAnime';

  @override
  String get language_code_example => '例如：zh';

  @override
  String get base_url_example => '例如：https://example.com';

  @override
  String get api_url_example => '例如：https://api.example.com';

  @override
  String get extension_notes_example => '例如：此扩展需要登录';

  @override
  String get type => '类型';

  @override
  String get target => '目标';

  @override
  String get source_type_single => '单一';

  @override
  String get source_type_multi => '多源';

  @override
  String get source_type_torrent => '种子 (Torrent)';

  @override
  String get source_language_dart => 'Dart';

  @override
  String get source_language_javascript => 'JavaScript';

  @override
  String get source_language_lnreader_compiled_js => 'LNReader 编译 JS';

  @override
  String get source_created_successfully => '图源创建成功';

  @override
  String get source_already_exists => '图源已存在';

  @override
  String get error_when_creating_source => '创建图源时出错';

  @override
  String get cookies_deleted => 'Cookie 已删除！';

  @override
  String get delete_all_cookies => '删除所有 Cookie';

  @override
  String get chapter_number => '章节号';

  @override
  String get episode_number => '集数';

  @override
  String get share => '分享';

  @override
  String n_chapters(Object n) {
    return '$n章';
  }

  @override
  String missing_chapters(Object count) {
    return '缺少 $count 个章节';
  }

  @override
  String get no_description => '无描述';

  @override
  String get resume => '继续';

  @override
  String get read => '阅读';

  @override
  String get watch => '观看';

  @override
  String get popular => '流行';

  @override
  String get open_in_browser => '在浏览器中打开';

  @override
  String get clear_cookie => '清除Cookie';

  @override
  String get show_page_number => '显示页码';

  @override
  String get from_library => '来自图书馆';

  @override
  String get downloaded_chapter => '已下载章节';

  @override
  String page(Object page) {
    return '页面 $page';
  }

  @override
  String get global_search => '全球搜索';

  @override
  String get color_blend_level => '颜色混合级别';

  @override
  String current(Object char) {
    return '当前 $char';
  }

  @override
  String finished(Object char) {
    return '完成 $char';
  }

  @override
  String next(Object char) {
    return '下一个 $char';
  }

  @override
  String previous(Object char) {
    return '上一个 $char';
  }

  @override
  String get no_more_chapter => '没有更多章节';

  @override
  String get no_result => '无结果';

  @override
  String get send => '发送';

  @override
  String get delete => '删除';

  @override
  String get start_downloading => '立即开始下载';

  @override
  String get retry => '重试';

  @override
  String get add_chapters => '添加章节';

  @override
  String get delete_chapters => '删除章节？';

  @override
  String get default0 => '默认';

  @override
  String get total_chapters => '总章节数';

  @override
  String get total_episodes => '总集数';

  @override
  String get import_local_file => '导入本地文件';

  @override
  String get import_files => '文件';

  @override
  String get split_epub_chapters => '分章节导入';

  @override
  String get split_epub_chapters_description => '将每个EPUB章节作为单独条目导入';

  @override
  String get nothing_read_recently => '最近未阅读';

  @override
  String get status => '状态';

  @override
  String get not_started => '未开始';

  @override
  String get score => '评分';

  @override
  String get start_date => '开始日期';

  @override
  String get finish_date => '完成日期';

  @override
  String get reading => '阅读';

  @override
  String get on_hold => '搁置';

  @override
  String get dropped => '已放弃';

  @override
  String get plan_to_read => '计划阅读';

  @override
  String get re_reading => '重读';

  @override
  String get chapters => '章节';

  @override
  String get add_tracker => '添加追踪';

  @override
  String get one_tracker => '1个追踪器';

  @override
  String n_tracker(Object n) {
    return '$n个追踪器';
  }

  @override
  String get tracking => '追踪';

  @override
  String get syncing => '同步';

  @override
  String get sync_logged => '登录成功';

  @override
  String get syncing_subtitle =>
      '通过自托管的 \n服务器在多个设备上同步你的进度。查看我们的 discord 服务器，了解更多信息！';

  @override
  String get last_sync => '上次同步时间：';

  @override
  String get sync_login_browser => '使用浏览器登录';

  @override
  String get sync_server => '同步服务器地址';

  @override
  String get sync_starting => '开始同步...';

  @override
  String get sync_finished => '同步完成';

  @override
  String get sync_failed => '同步失败';

  @override
  String get sync_restore_in_progress => '已跳过同步 — 正在恢复中';

  @override
  String sync_progress_percent(Object percent) {
    return '正在同步… $percent%';
  }

  @override
  String get sync_progress_indeterminate => '正在同步…';

  @override
  String get sync_button_sync => '同步进度';

  @override
  String get sync_button_upload => '仅上传';

  @override
  String get sync_button_upload_info => '此操作将完全用本地数据替换远程数据！';

  @override
  String get sync_button_download => '仅下载';

  @override
  String get sync_button_download_info => '此操作将完全用远程数据替换本地数据！';

  @override
  String get sync_status_not_configured => '未连接';

  @override
  String get sync_status_checking => '正在检查连接...';

  @override
  String get sync_status_connected => '已连接';

  @override
  String get sync_status_unauthorized => '会话已过期，请重新登录';

  @override
  String get sync_status_unreachable => '无法连接到服务器';

  @override
  String get sync_section_general => '通用';

  @override
  String get sync_on => '启用同步';

  @override
  String get sync_auto => '自动同步';

  @override
  String get sync_auto_warning => '自动同步目前是实验性功能！';

  @override
  String get sync_auto_off => '关闭';

  @override
  String get sync_auto_5_minutes => '每5分钟';

  @override
  String get sync_auto_10_minutes => '每10分钟';

  @override
  String get sync_auto_30_minutes => '每30分钟';

  @override
  String get sync_auto_1_hour => '每1小时';

  @override
  String get sync_auto_3_hours => '每3小时';

  @override
  String get sync_auto_6_hours => '每6小时';

  @override
  String get sync_auto_12_hours => '每12小时';

  @override
  String get server_error => '服务器错误！';

  @override
  String get dialog_confirm => '确认';

  @override
  String get description => '描述';

  @override
  String get reorder_navigation => '自定义导航';

  @override
  String get reorder_navigation_description => '根据需要重新排序和切换每个导航。';

  @override
  String get floating_navigation_bar => '悬浮导航栏';

  @override
  String get floating_navigation_bar_description => '使用悬浮胶囊代替固定的导航栏。';

  @override
  String get show_updates_badge => '在“更新”图标上显示角标';

  @override
  String get show_updates_badge_description => '统计自上次打开“更新”以来发现的章节数。';

  @override
  String get full_screen_player => '使用全屏';

  @override
  String get full_screen_player_info => '播放视频时自动使用全屏。';

  @override
  String episode_progress(Object n) {
    return '进度：$n';
  }

  @override
  String n_episodes(int n) {
    return '$n集';
  }

  @override
  String missing_episodes(Object count) {
    return '缺少 $count 集';
  }

  @override
  String get manga_sources => '漫画来源';

  @override
  String get anime_sources => '动画来源';

  @override
  String get novel_sources => '小说来源';

  @override
  String get anime_extensions => '动画扩展';

  @override
  String get manga_extensions => '漫画扩展';

  @override
  String get novel_extensions => '小说扩展';

  @override
  String get extension_settings => '扩展设置';

  @override
  String get anime => '动画';

  @override
  String get manga => '漫画';

  @override
  String get novel => '小说';

  @override
  String get library_no_category_exist => '你还没有任何类别';

  @override
  String get watching => '观看中';

  @override
  String get plan_to_watch => '计划观看';

  @override
  String get re_watching => '重看';

  @override
  String get episodes => '集';

  @override
  String get download => '下载';

  @override
  String get new_update_available => '有新更新可用';

  @override
  String app_version(Object v) {
    return '应用版本：v$v';
  }

  @override
  String get searching_for_updates => '正在搜索更新...';

  @override
  String get no_new_updates_available => '没有新的更新可用';

  @override
  String get uninstall => '卸载';

  @override
  String uninstall_extension(Object ext) {
    return '卸载 $ext 扩展？';
  }

  @override
  String double_tap_search_hint(Object type) {
    return '双击以搜索全部 $type';
  }

  @override
  String get show_nav_double_tap_tooltip => '显示双击搜索提示';

  @override
  String get show_nav_double_tap_tooltip_subtitle =>
      '在漫画/动画/小说导航栏上显示提示，说明双击可打开全局搜索。';

  @override
  String already_in_library(Object source, Object title) {
    return '\"$title\" 已通过 $source 添加到您的书架中。';
  }

  @override
  String get add_anyway => '仍然添加';

  @override
  String get langauage => '语言';

  @override
  String get extension_detail => '扩展详情';

  @override
  String get scale_type => '缩放类型';

  @override
  String get scale_type_fit_screen => '适合屏幕';

  @override
  String get scale_type_stretch => '拉伸';

  @override
  String get scale_type_fit_width => '适合宽度';

  @override
  String get scale_type_fit_height => '适合高度';

  @override
  String get scale_type_original_size => '原始大小';

  @override
  String get scale_type_smart_fit => '智能适配';

  @override
  String get page_preload_amount => '页面预加载量';

  @override
  String get page_preload_amount_subtitle =>
      '阅读时预加载的页面数量。更高的值将导致更顺畅的阅读体验，但会增加缓存和网络使用。';

  @override
  String get image_loading_error => '无法加载此图片';

  @override
  String get add_episodes => '添加集数';

  @override
  String get video_quality => '质量';

  @override
  String get video_subtitle => '字幕';

  @override
  String get check_for_extension_updates => '检查扩展更新';

  @override
  String get auto_extensions_updates => '自动扩展更新';

  @override
  String get auto_extensions_updates_subtitle => '当有新版本可用时，将自动更新扩展。';

  @override
  String get check_for_app_updates => '启动时检查应用更新';

  @override
  String get reading_mode => '阅读模式';

  @override
  String get custom_filter => '自定义筛选';

  @override
  String get background_color => '背景颜色';

  @override
  String get white => '白色';

  @override
  String get black => '黑色';

  @override
  String get grey => '灰色';

  @override
  String get automaic => '自动';

  @override
  String get preferred_domain => '首选域';

  @override
  String get load_more => '加载更多';

  @override
  String get cancel_all_for_this_series => '为此系列取消所有';

  @override
  String get login => '登录';

  @override
  String login_into(Object tracker) {
    return '登录到 $tracker';
  }

  @override
  String get email_adress => '电子邮件地址';

  @override
  String get password => '密码';

  @override
  String log_out_from(Object tracker) {
    return '从 $tracker 注销？';
  }

  @override
  String get log_out => '注销';

  @override
  String get update_pending => '更新待定';

  @override
  String get update_all => '更新全部';

  @override
  String get backup_and_restore => '备份和恢复';

  @override
  String get create_backup => '创建备份';

  @override
  String get create_backup_dialog_title => '你想要备份什么？';

  @override
  String get create_backup_subtitle => '可用于恢复当前图书馆';

  @override
  String get restore_backup => '恢复备份';

  @override
  String get encrypt_backups => '加密备份';

  @override
  String get encrypt_backups_info => '使用 AES 加密和密码保护备份文件';

  @override
  String get no_secure_storage => '未找到安全存储';

  @override
  String get no_keyring_warning => '当前系统没有密钥环服务，无法安全存储密码。\n\n是否以明文形式存储在本地数据库中？';

  @override
  String get enter_backup_password => '输入备份密码';

  @override
  String get incorrect_password_try_again => '密码错误，请重试。';

  @override
  String get set_backup_password => '设置备份密码';

  @override
  String get confirm_password => '确认密码';

  @override
  String get passwords_do_not_match => '密码不匹配';

  @override
  String get password_required_to_restore => '需要密码才能恢复此备份。';

  @override
  String get restore_backup_subtitle => '从备份文件恢复图书馆';

  @override
  String get automatic_backups => '自动备份';

  @override
  String get backup_frequency => '备份频率';

  @override
  String get backup_location => '备份位置';

  @override
  String get backup_options => '备份选项';

  @override
  String get backup_options_dialog_title => '你想要备份什么？';

  @override
  String get backup_options_subtitle => '包含在备份文件中的信息';

  @override
  String get backup_and_restore_warning_info => '你应该在其他地方保存备份副本';

  @override
  String get library_entries => '图书馆条目';

  @override
  String get chapters_and_episode => '章节和集数';

  @override
  String get every_6_hours => '每6小时';

  @override
  String get every_12_hours => '每12小时';

  @override
  String get daily => '每日';

  @override
  String get every_2_days => '每2天';

  @override
  String get weekly => '每周';

  @override
  String get restore_backup_warning_title => '恢复备份将覆盖所有现有数据。\n\n继续恢复？';

  @override
  String get restore_sync_question_title => '是否同步此次恢复？';

  @override
  String get restore_sync_question_message => '此设备已连接到同步服务器。是否立即将恢复的数据上传？';

  @override
  String get restore_sync_question_confirm => '是，进行同步';

  @override
  String get restore_sync_question_deny => '否，禁用同步';

  @override
  String get sync_disabled_after_restore => '同步已禁用。您可以在“设置”中重新开启。';

  @override
  String get restore_sync_disabled_question_title => '同步当前已禁用';

  @override
  String get restore_sync_disabled_question_message =>
      '同步已关闭。是否重新开启并将恢复的数据上传到服务器？';

  @override
  String get restore_sync_question_reenable => '是，重新开启并同步';

  @override
  String get restore_sync_question_keep_disabled => '保持禁用';

  @override
  String get restore_sync_uploading => '正在同步恢复的数据到服务器…';

  @override
  String get restore_sync_upload_success => '恢复的数据已同步到服务器';

  @override
  String get services => '服务';

  @override
  String get tracking_warning_info => '单向同步以更新跟踪服务中的章节进度。从它们的跟踪按钮为个别条目设置跟踪。';

  @override
  String get use_page_tap_zones => '使用页面点击区域';

  @override
  String get manage_trackers => '管理跟踪器';

  @override
  String get restore => '恢复';

  @override
  String get backups => '备份';

  @override
  String get by_scanlator => '按翻译者';

  @override
  String get by_name => '按名称';

  @override
  String get installed => '已安装';

  @override
  String get auto_scroll => '自动滚动';

  @override
  String get video_audio => '音频';

  @override
  String get video_audio_info => '首选语言、音调校正、音频通道';

  @override
  String get player => '播放器';

  @override
  String get markEpisodeAsSeenSetting => '标记剧集为已看的时间点';

  @override
  String get mark_duplicate_chapters_read => '将重复的章节号标记为已读';

  @override
  String get skip_read_chapters => '跳过已读章节';

  @override
  String get skip_read_chapters_subtitle => '切换到下一章或上一章时，跳过已读的章节。';

  @override
  String get skip_filtered_chapters => '跳过被筛选的章节';

  @override
  String get skip_duplicate_chapters => '跳过重复章节';

  @override
  String get skip_duplicate_chapters_subtitle =>
      '每个章节号只阅读一份；如有多个版本，优先选择同一译者的版本。';

  @override
  String get default_skip_intro_length => '默认跳过介绍长度';

  @override
  String get default_playback_speed_length => '默认播放速度长度';

  @override
  String get updateProgressAfterReading => '阅读后更新进度';

  @override
  String get no_sources_installed => '未安装任何来源！';

  @override
  String get show_extensions => '显示扩展';

  @override
  String get default_skip_forward_skip_length => '默认向前跳过长度';

  @override
  String get aniskip_requires_info => 'AniSkip需要跟踪使用MAL或Anilist进行的动漫才能工作。';

  @override
  String get enable_aniskip => '启用AniSkip';

  @override
  String get enable_auto_skip => '启用自动跳过';

  @override
  String get aniskip_button_timeout => '按钮超时';

  @override
  String get skip_opening => '跳过片头';

  @override
  String get skip_ending => '跳过片尾';

  @override
  String get fullscreen => '全屏';

  @override
  String get update_library => '更新库';

  @override
  String updating_library(Object cur, Object failed, Object max) {
    return '正在更新库 ($cur / $max) - 失败: $failed';
  }

  @override
  String get next_chapter => '下一章';

  @override
  String get next_5_chapters => '下5章';

  @override
  String get next_10_chapters => '下10章';

  @override
  String get next_25_chapters => '下25章';

  @override
  String get all_chapters => '所有章节';

  @override
  String get next_episode => '下一集';

  @override
  String get next_5_episodes => '接下来的 5 集';

  @override
  String get next_10_episodes => '接下来的 10 集';

  @override
  String get next_25_episodes => '接下来的 25 集';

  @override
  String get all_episodes => '所有剧集';

  @override
  String get cover_saved => '封面已保存';

  @override
  String get set_as_cover => '设置为封面';

  @override
  String get use_this_as_cover_art => '使用此作为封面？';

  @override
  String get save => '保存';

  @override
  String get picture_saved => '图片已保存';

  @override
  String get cover_updated => '封面已更新';

  @override
  String get include_subtitles => '包含字幕';

  @override
  String get blend_mode_default => '默认';

  @override
  String get blend_mode_multiply => '正片叠底';

  @override
  String get blend_mode_screen => '滤色';

  @override
  String get blend_mode_overlay => '叠加';

  @override
  String get blend_mode_colorDodge => '颜色减淡';

  @override
  String get blend_mode_lighten => '变亮';

  @override
  String get blend_mode_colorBurn => '颜色加深';

  @override
  String get blend_mode_darken => '变暗';

  @override
  String get blend_mode_difference => '差异';

  @override
  String get blend_mode_saturation => '饱和度';

  @override
  String get blend_mode_softLight => '柔光';

  @override
  String get blend_mode_plus => '加';

  @override
  String get blend_mode_exclusion => '排除';

  @override
  String get custom_color_filter => '自定义颜色滤镜';

  @override
  String get color_filter_blend_mode => '颜色滤镜混合模式';

  @override
  String get enable_all => '启用全部';

  @override
  String get disable_all => '禁用全部';

  @override
  String get font => '字体';

  @override
  String get color => '颜色';

  @override
  String get font_size => '字号';

  @override
  String get text => '文本';

  @override
  String get border => '边框';

  @override
  String get background => '背景';

  @override
  String get no_subtite_warning_message => '由于此视频中没有字幕轨道，因此无效。';

  @override
  String get grid_size => '网格大小';

  @override
  String n_per_row(Object n) {
    return '$n 每行';
  }

  @override
  String get horizontal_continious => '水平连续';

  @override
  String get edit_code => '编辑代码';

  @override
  String get subtitles_on_by_default => '开启字幕';

  @override
  String get subtitles_on_by_default_info => '关闭时，剧集开始时没有字幕，直到你选择字幕轨道。';

  @override
  String get use_libass => '启用 libass';

  @override
  String get use_libass_info => '使用基于 libass 的字幕渲染作为本地后端。';

  @override
  String get libass_not_disable_message => '在播放器设置中禁用 `use libass` 以便自定义字幕。';

  @override
  String get override_ass_subtitles => '使用我的字幕样式';

  @override
  String get override_ass_subtitles_info =>
      '将你的大小和颜色应用到所有字幕，包括 ASS。关闭时，字幕使用默认样式';

  @override
  String get torrent_stream => '种子流';

  @override
  String get add_torrent => '添加种子';

  @override
  String get enter_torrent_hint_text => '输入磁力链接或种子文件 URL';

  @override
  String get torrent_url => '种子 URL';

  @override
  String get or => '或';

  @override
  String get advanced => '高级';

  @override
  String get advanced_info => 'mpv 配置';

  @override
  String get use_native_http_client => '使用本地 HTTP 客户端';

  @override
  String get use_native_http_client_info =>
      '它自动支持平台特性，如 VPN，支持更多 HTTP 特性，如 HTTP/3 和自定义重定向处理';

  @override
  String n_hour_ago(Object hour) {
    return '$hour小时前';
  }

  @override
  String n_hours_ago(Object hours) {
    return '$hours小时前';
  }

  @override
  String n_minute_ago(Object minute) {
    return '$minute分钟前';
  }

  @override
  String n_minutes_ago(Object minutes) {
    return '$minutes分钟前';
  }

  @override
  String n_day_ago(Object day) {
    return '$day天前';
  }

  @override
  String get now => '现在';

  @override
  String library_last_updated(Object lastUpdated) {
    return '图书馆最近更新时间：$lastUpdated';
  }

  @override
  String get data_and_storage => '数据与存储';

  @override
  String get download_location_info => '用于章节下载';

  @override
  String get storage => '存储';

  @override
  String get clear_chapter_and_episode_cache => '清除章节和剧集缓存';

  @override
  String get cache_cleared => '缓存已清除';

  @override
  String get clear_chapter_or_episode_cache_on_app_launch => '启动应用时清除章节/剧集缓存';

  @override
  String get app_settings => '应用设置';

  @override
  String get sources_settings => '来源设置';

  @override
  String get include_sensitive_settings => '包含敏感设置（例如追踪器登录令牌）';

  @override
  String get create => '创建';

  @override
  String get downloads_are_limited_to_wifi => '下载仅限于WiFi';

  @override
  String get recommendations => '推荐';

  @override
  String get recommendations_similar => '相似';

  @override
  String get recommendations_weights => '推荐权重';

  @override
  String get recommendations_weights_genre => '类型相似度';

  @override
  String get recommendations_weights_setting => '设定相似度';

  @override
  String get recommendations_weights_synopsis => '故事相似度';

  @override
  String get recommendations_weights_theme => '主题相似度';

  @override
  String get manga_extensions_repo => '漫画扩展库';

  @override
  String get anime_extensions_repo => '动画扩展库';

  @override
  String get novel_extensions_repo => '小说扩展库';

  @override
  String get custom_dns => '自定义 DNS（留空使用系统 DNS）';

  @override
  String get android_proxy_server => 'Android 代理服务器（M-Extension-Server）';

  @override
  String get get_m_extension_server => '获取 M-Extension-Server';

  @override
  String get get_sync_server => '在此获取同步服务器';

  @override
  String get undefined => '未定义';

  @override
  String get empty_extensions_repo => '扩展库为空';

  @override
  String get add_extensions_repo => '添加扩展库';

  @override
  String get remove_extensions_repo => '移除扩展库';

  @override
  String get manage_manga_repo_urls => '管理漫画库URL';

  @override
  String get manage_anime_repo_urls => '管理动画库URL';

  @override
  String get manage_novel_repo_urls => '管理小说库URL';

  @override
  String get url_cannot_be_empty => 'URL不能为空';

  @override
  String get url_must_end_with_dot_json_or_dot_pb => 'URL必须以.json结尾';

  @override
  String get repo_url => '库URL';

  @override
  String get invalid_url_format => '无效的URL格式';

  @override
  String get clear_all_sources => '清除所有来源';

  @override
  String get clear_all_sources_msg => '你确定吗？所有来源将被清除';

  @override
  String get sources_cleared => '来源已清除';

  @override
  String get repo_added => '库已添加';

  @override
  String get repo_already_exists => '软件源仓库已存在！';

  @override
  String get add_repo => '添加库';

  @override
  String get add_repo_sources_to_add => '将添加以下扩展列表：';

  @override
  String get add_repo_warning => '这些仓库中的扩展会在应用内运行。请只添加你信任的仓库。';

  @override
  String get genre_search_library => '按类别搜索图书馆';

  @override
  String get genre_search_source => '按类别搜索来源';

  @override
  String get source_not_added => '来源未添加';

  @override
  String get load_own_subtitles => '加载自定义字幕';

  @override
  String get search_subtitles => '在线搜索字幕...';

  @override
  String extension_notes(Object notes) {
    return '备注：$notes';
  }

  @override
  String get unsupported_repo => '您试图添加不支持的版本库。请查看 discord 服务器以获得支持！';

  @override
  String get end_of_chapter => '章节结束';

  @override
  String get chapter_completed => '章节完成';

  @override
  String get continue_to_next_chapter => '继续滚动阅读下一章';

  @override
  String get no_next_chapter => '没有下一章';

  @override
  String get you_have_finished_reading => '您已读完';

  @override
  String get return_to_the_list_of_chapters => '返回章节列表';

  @override
  String get hwdec => '硬件解码器';

  @override
  String get enable_hardware_accel => '硬件加速';

  @override
  String get enable_hardware_accel_info => '如果遇到错误或崩溃，请打开/关闭';

  @override
  String get track_library_navigate => '转到现有本地条目';

  @override
  String get track_library_add => '添加到本地库';

  @override
  String get track_library_add_confirm => '将跟踪项目添加到本地库';

  @override
  String get track_library_not_logged => '请登录相应的跟踪器以使用此功能！';

  @override
  String get track_library_switch => '切换到另一个跟踪器';

  @override
  String get go_back => '返回';

  @override
  String get merge_library_nav_mobile => '在移动设备上合并库导航';

  @override
  String get enable_discord_rpc => '启用 Discord RPC';

  @override
  String get hide_discord_rpc_incognito => '隐身模式下隐藏 Discord RPC';

  @override
  String get rpc_show_reading_watching_progress => '在 Discord 中显示当前章节（需要重启）';

  @override
  String get rpc_show_title => '在 Discord 中显示当前标题';

  @override
  String get rpc_show_cover_image => '在 Discord 中显示当前封面图片';

  @override
  String get enable_mpv => '启用 mpv 着色器/脚本';

  @override
  String get mpv_info => '支持 mpv/scripts/ 下的 .js 脚本';

  @override
  String get mpv_redownload => '重新下载 mpv 配置文件';

  @override
  String get mpv_redownload_info => '用新配置文件替换旧配置文件！';

  @override
  String get mpv_download => '需要 MPV 配置文件！\n现在下载？';

  @override
  String get custom_buttons => '自定义按钮';

  @override
  String get custom_buttons_info => '使用自定义按钮执行 lua 代码';

  @override
  String get custom_buttons_edit => '编辑自定义按钮';

  @override
  String get custom_buttons_add => '添加自定义按钮';

  @override
  String get custom_buttons_added => '已添加自定义按钮！';

  @override
  String get custom_buttons_delete => '删除自定义按钮';

  @override
  String get custom_buttons_text => '按钮文本';

  @override
  String get custom_buttons_text_req => '按钮文本必填';

  @override
  String get custom_buttons_js_code => 'lua 代码';

  @override
  String get custom_buttons_js_code_req => 'lua 代码必填';

  @override
  String get custom_buttons_js_code_long => 'lua 代码（长按时）';

  @override
  String get custom_buttons_startup => 'lua 代码（启动时）';

  @override
  String get custom_buttons_add_warning =>
      '此按钮会在视频播放器中运行下面的 Lua 代码，这些代码可以访问你的文件并运行程序。只有在你信任此链接的来源时才添加。';

  @override
  String n_days(Object n) {
    return '$n 天';
  }

  @override
  String get decoder => '解码器';

  @override
  String get decoder_info => '硬件解码、像素格式、去色带';

  @override
  String get enable_gpu_next => '启用 gpu-next（仅限 Android）';

  @override
  String get enable_gpu_next_info => '新的视频渲染引擎';

  @override
  String get debanding => '去色带';

  @override
  String get use_yuv420p => '使用 YUV420P 像素格式';

  @override
  String get use_yuv420p_info => '可以修复某些视频编解码器上的黑屏，也可以以质量为代价提高性能';

  @override
  String get audio_preferred_languages => '首选语言';

  @override
  String get audio_preferred_languages_info =>
      '在具有多个音频流的视频上默认选择的音频语言，2/3 字母语言代码（例如：zh、en、ja）。多个值可以用逗号分隔。';

  @override
  String get enable_audio_pitch_correction => '启用音频音调校正';

  @override
  String get enable_audio_pitch_correction_info => '防止音频在较快速度时变高音，在较慢速度时变低音';

  @override
  String get audio_channels => '音频通道';

  @override
  String get volume_boost_cap => '音量增强上限';

  @override
  String get internal_player => '内部播放器';

  @override
  String get internal_player_info => '进度、控制、方向';

  @override
  String get subtitle_delay_text => '字幕延迟';

  @override
  String get subtitle_delay => '延迟（毫秒）';

  @override
  String get audio_delay => '音频延迟（毫秒）';

  @override
  String get audio_delay_subtitle => '让声音比画面延后（正值）或提前（负值）播放。在各集之间保持不变。';

  @override
  String get subtitle_speed => '速度';

  @override
  String get tracks => '轨道';

  @override
  String get playback_speed => '播放速度';

  @override
  String get shaders => '着色器';

  @override
  String get video_fit => '画面适配';

  @override
  String get calendar => '日历';

  @override
  String get calendar_no_data => '暂无数据。';

  @override
  String get calendar_info => '日历只能根据旧的上传预测下一章的上传。某些数据可能不是 100% 准确！';

  @override
  String in_n_day(Object days) {
    return '$days 天后';
  }

  @override
  String in_n_days(Object days) {
    return '$days 天后';
  }

  @override
  String get clear_library => '清空库';

  @override
  String get clear_library_desc => '选择清除所有漫画、动画和/或小说条目';

  @override
  String get clear_library_input =>
      '输入 \'manga\'、\'anime\' 和/或 \'novel\'（用逗号分隔）以删除所有相关条目';

  @override
  String get watch_order => '观看顺序';

  @override
  String get watch_order_role_current => '当前';

  @override
  String get watch_order_role_previous => '上一部';

  @override
  String get watch_order_role_next => '下一部';

  @override
  String get watch_order_source_release_order => '上映顺序';

  @override
  String watch_order_source_community_list(String name, String author) {
    return '$author 的 $name';
  }

  @override
  String watch_order_source_official_collection(String name) {
    return 'Trakt 官方合集：$name';
  }

  @override
  String watch_order_source_trakt_collection(String name) {
    return 'Trakt 合集：$name';
  }

  @override
  String watch_order_source_seasons(String title) {
    return '$title 的各季';
  }

  @override
  String get watch_order_select_source => '顺序来源';

  @override
  String watch_order_season(int number) {
    return '第 $number 季';
  }

  @override
  String watch_order_episode(int number) {
    return '第 $number 集';
  }

  @override
  String get sequels => '续集';

  @override
  String get recommendations_similarity => '相似度：';

  @override
  String recommendation_rating_accessibility(String rating) {
    return '评分 $rating';
  }

  @override
  String get local_folder_structure => '本地文件夹结构';

  @override
  String get local_folder => '本地文件夹';

  @override
  String get add_local_folder => '添加本地文件夹';

  @override
  String get rescan_local_folder => '立即重新扫描所有本地文件夹';

  @override
  String get default_download_destination => '默认下载位置';

  @override
  String get ask_download_destination => '每次下载前询问位置';

  @override
  String get ask_download_destination_desc => '每次开始下载时选择本地文件夹。';

  @override
  String get select_download_destination => '选择下载位置';

  @override
  String get clear_local_library => '清空本地书库';

  @override
  String get clear_local_library_desc => '从书库中移除本地文件夹和压缩包条目。';

  @override
  String get clear_local_library_msg => '这将从书库中移除本地条目，不会删除磁盘上的文件。';

  @override
  String get custom => '自定义';

  @override
  String get no_local_folder_available_for_downloads => '没有可用于下载的本地文件夹';

  @override
  String failed_to_create_cbz(Object error) {
    return '创建 CBZ 失败：$error';
  }

  @override
  String error_reading_cover_image(Object error) {
    return '读取封面出错：$error';
  }

  @override
  String error_reading_metadata(Object error) {
    return '读取元数据出错：$error';
  }

  @override
  String error_saving_chapter_episode_to_library(Object error) {
    return '保存到书库时出错：$error';
  }

  @override
  String error_reading_chapter_cover_image(Object error) {
    return '读取章节封面出错：$error';
  }

  @override
  String error_reading_archive_cover_image(Object error) {
    return '读取归档封面出错：$error';
  }

  @override
  String error_getting_local_library(Object error) {
    return '获取本地书库时出错：$error';
  }

  @override
  String get export_metadata => '导出元数据';

  @override
  String get exported => '已导出';

  @override
  String failed_to_export_metadata(Object error) {
    return '导出元数据失败：$error';
  }

  @override
  String unrecognized_chapter_numbers(Object count) {
    return '有 $count 个章节无法自动编号，可能在阅读器中缺失或顺序错乱。';
  }

  @override
  String get cloudflare_resolution_webview_server_start_failed =>
      '无法启动 Cloudflare 验证 Webview 服务。';

  @override
  String tracker_token_expired(Object tracker) {
    return '$tracker 令牌已过期';
  }

  @override
  String get video_list_empty => '视频列表为空';

  @override
  String playback_speed_multiplier(Object value) {
    return '${value}x';
  }

  @override
  String could_not_launch_url(Object url) {
    return '无法打开 $url';
  }

  @override
  String get text_size => '文字大小：';

  @override
  String get text_align => '文字对齐';

  @override
  String get line_height => '行高';

  @override
  String get show_scroll_percentage => '显示滚动百分比';

  @override
  String get remove_extra_paragraph_spacing => '删除额外的段落间距';

  @override
  String select_label_color(Object label) {
    return '选择 $label 颜色';
  }

  @override
  String get default_user_agent => '默认用户代理';

  @override
  String get forceLandscapeMode => '强制横屏模式';

  @override
  String get forceLandscapeModeSubtitle => '强制播放器使用横屏方向。';

  @override
  String get remember_player_volume => '记住音量';

  @override
  String get remember_player_volume_subtitle => '每集都以上一集结束时的音量开始播放。';

  @override
  String get remember_player_brightness => '记住亮度';

  @override
  String get dns_over_https => 'DNS-over-HTTPS (DoH)';

  @override
  String get dns_provider => 'DNS提供商';

  @override
  String get tracked => '已追踪';

  @override
  String get auth_unlock_msg => '验证以解锁Mangayomi';

  @override
  String get app_locked => 'Mangayomi已锁定';

  @override
  String get auth_to_continue => '验证以继续';

  @override
  String get authenticating => '正在验证...';

  @override
  String get lock => '锁定';

  @override
  String get unlock => '解锁';

  @override
  String get security => '安全';

  @override
  String get auth_to_change_security_setting => '验证以更改安全设置';

  @override
  String get app_lock => '应用锁';

  @override
  String get app_lock_delay => '锁定时机';

  @override
  String get app_lock_delay_immediately => '离开应用时';

  @override
  String app_lock_delay_minutes(int n) {
    return '离开 $n 分钟后';
  }

  @override
  String get app_lock_delay_launch_only => '仅在应用启动时';

  @override
  String get secure_screen => '安全屏幕';

  @override
  String get secure_screen_subtitle => '在应用切换器中隐藏应用；在 Android 上还会禁止截图和录屏。';

  @override
  String get secure_screen_never => '从不';

  @override
  String get secure_screen_incognito => '隐身模式时';

  @override
  String get secure_screen_always => '始终';

  @override
  String get background_work => '后台任务';

  @override
  String get background_work_in_progress => '处理中…';

  @override
  String get background_downloading => '下载中';

  @override
  String get background_updating_library => '正在更新图书馆';

  @override
  String get background_restoring => '正在恢复备份';

  @override
  String get background_syncing => '同步中';

  @override
  String get background_cancel_downloads => '取消下载';

  @override
  String get background_stop_update => '停止更新';

  @override
  String get hide_notification_content => '隐藏通知内容';

  @override
  String get hide_notification_content_subtitle => '通知只说明应用正在执行的操作，不显示作品或章节名称。';

  @override
  String get require_biometric_or_device_credential => '需要生物识别或设备凭证才能打开应用';

  @override
  String get biometric_or_device_credential_not_available => '此设备上没有生物识别';

  @override
  String get app_lock_description => '启用应用锁后，每次打开应用或从后台返回时都会要求您进行身份验证。';

  @override
  String get keep_screen_on => '保持屏幕开启';

  @override
  String get webtoon_side_padding => 'Webtoon侧边填充';

  @override
  String get show_page_gaps => '显示页面间隙';

  @override
  String get invert_colors => '反转颜色';

  @override
  String get grayscale => '灰度';

  @override
  String get brightness => '亮度';

  @override
  String get video_filters => '视频滤镜';

  @override
  String get video_filter_contrast => '对比度';

  @override
  String get video_filter_saturation => '饱和度';

  @override
  String get video_filter_gamma => '伽马';

  @override
  String get video_filter_hue => '色相';

  @override
  String get volume => '音量';

  @override
  String get contrast => '对比度';

  @override
  String get saturation => '饱和度';

  @override
  String get navigation_layout => '导航布局';

  @override
  String get nav_layout_default => '默认';

  @override
  String get nav_layout_l_shaped => 'L形';

  @override
  String get nav_layout_kindle => 'Kindle';

  @override
  String get nav_layout_edge => '边缘';

  @override
  String get nav_layout_right_and_left => '右和左';

  @override
  String get nav_layout_disabled => '已禁用';

  @override
  String get color_enhancements => '色彩增强';

  @override
  String get total => '总计';

  @override
  String get mean_per_title => '单个标题平均';

  @override
  String get completion_rate => '完成率';

  @override
  String get watching_time => '观看时间';

  @override
  String get reading_time => '阅读时间';

  @override
  String average_chapters_per_title(Object title) {
    return '单个标题平均章节数';
  }

  @override
  String get read_percentage => '阅读百分比';

  @override
  String get entries => '条目';

  @override
  String get android_proxy_server_mihon => 'Android 代理服务器（Mihon）';

  @override
  String get android_proxy_server_mihon_description =>
      '下载并配置使用 Mihon 扩展所需的代理服务器。';

  @override
  String get mihon_proxy_server => 'Mihon 代理服务器';

  @override
  String get extension_server_intro_with_jre =>
      '在使用 Mihon 扩展前请先下载代理服务器包。该包内含 JRE 和扩展服务器 JAR。';

  @override
  String get extension_server_intro_ios =>
      '在使用 Mihon 扩展前请先下载代理服务器 JAR。iOS 仅需扩展服务器 JAR。';

  @override
  String get checking_files => '正在检查文件';

  @override
  String get files_installed => '文件已安装';

  @override
  String get files_missing => '文件缺失';

  @override
  String get update_files => '更新文件';

  @override
  String get up_to_date => '已是最新';

  @override
  String get choose_location => '选择路径';

  @override
  String get import_existing_jar => '导入现有 JAR';

  @override
  String get detect_files_in_selected_folder => '在选定文件夹中检测文件';

  @override
  String get preparing_download => '正在准备下载...';

  @override
  String get app_install_location => '应用安装路径';

  @override
  String get install_location => '安装位置';

  @override
  String get jre_executable => 'JRE 可执行文件';

  @override
  String get extension_server_jar => '扩展服务器 JAR';

  @override
  String get installed_version => '当前版本';

  @override
  String get latest_version => '最新版本';

  @override
  String get m_extension_server_description =>
      '当您需要独立的 Android 设备代理时，请使用 M-Extension-Server。在此设置代理地址，并从 GitHub 下载 APK。';

  @override
  String get set_proxy_address => '设置代理地址';

  @override
  String get no_newer_proxy_server_release_available => '没有可用的新代理服务器版本。';

  @override
  String get could_not_check_proxy_server_updates => '无法检查代理服务器更新。';

  @override
  String get no_extension_server_bundle_available_for_this_platform =>
      '当前平台没有可用的扩展服务器包。';

  @override
  String failed_to_download_bundle(Object statusCode) {
    return '下载包失败 ($statusCode)。';
  }

  @override
  String get downloaded_bundle_missing_expected_files => '下载的项目不包含预期文件。';

  @override
  String get extension_server_files_ready => '扩展服务器文件已就绪。';

  @override
  String get ios_extension_server_import_hint =>
      '在 iOS 上，服务器安装在应用沙盒内。请使用“导入现有 JAR”来导入已下载的文件。';

  @override
  String get select_extension_server_folder => '选择扩展服务器文件夹';

  @override
  String get selected_folder_does_not_exist => '选定文件夹不存在。';

  @override
  String get no_extension_server_files_found_in_selected_folder =>
      '在选定文件夹中未找到扩展服务器文件。';

  @override
  String get extension_server_files_linked => '扩展服务器文件已链接。';

  @override
  String get select_extension_server_jar => '选择扩展服务器 JAR';

  @override
  String get selected_file_could_not_be_accessed => '选定文件无法访问。';

  @override
  String get extension_server_jar_imported => '扩展服务器 JAR 已导入。';

  @override
  String get could_not_launch_apk_bridge_page => '无法启动 M-Extension-Server 页面。';

  @override
  String get proxy_server_ip_hint =>
      '服务器 IP（例如 10.0.0.5 或 https://example.com）';

  @override
  String get not_configured => '未配置';

  @override
  String get zero_interpreter => 'Zero 解释器';

  @override
  String get zero_interpreter_description => '自动或手动控制 Zero 解释器服务。';

  @override
  String get start_server_on_launch => '启动时开启服务';

  @override
  String get runtime_status => '运行状态';

  @override
  String get running => '运行中';

  @override
  String get stopped => '已停止';

  @override
  String get start => '启动';

  @override
  String get stop => '停止';

  @override
  String get webview => 'Webview';

  @override
  String get tts => '文字转语音';

  @override
  String get tts_speed => '速度';

  @override
  String get tts_pitch => '音调';

  @override
  String get tts_language => '语言';

  @override
  String get tts_voice => '语音';

  @override
  String get tts_stop => '停止';

  @override
  String get tts_play => '播放';

  @override
  String get tts_pause => '暂停';

  @override
  String get tts_previous => '上一段';

  @override
  String get tts_next => '下一段';

  @override
  String tts_paragraph_progress(Object current, Object total) {
    return '第$current段，共$total段';
  }

  @override
  String get tts_settings => 'TTS设置';

  @override
  String get tts_default => '默认';

  @override
  String get webtoon_disable_zoom_out => 'Webtoon禁用缩小';

  @override
  String get webtoon_double_tap_zoom_enabled => 'Webtoon双击缩放';

  @override
  String get navigate_to_pan => '导航前移动已放大图像';

  @override
  String get navigate_to_pan_subtitle => '翻页前先移动放大的图像';

  @override
  String get split_wide_pages => '拆分双页';

  @override
  String get split_tall_images => '分割长图';

  @override
  String get split_tall_images_subtitle =>
      '条漫：将超高图片分片显示，每次只解码一片，以减少内存占用。不能与「裁剪边框」同时使用。';

  @override
  String get dual_page_invert => '反转拆分的半页';

  @override
  String get dual_page_rotate_to_fit => '旋转以适应';

  @override
  String get dual_page_rotate_to_fit_invert => '反转旋转方向';

  @override
  String get double_page_single_first_page => '首页单页显示';

  @override
  String get double_page_single_first_page_subtitle => '在双页模式下单页显示第一页（封面）';

  @override
  String get double_page_auto => '自动双页';

  @override
  String get double_page_auto_subtitle => '横屏时自动切换到双页模式';

  @override
  String get landscape_zoom => '横屏自动缩放';

  @override
  String get zoom_start_position => '缩放起始位置';

  @override
  String get zoom_start_left => '左';

  @override
  String get zoom_start_right => '右';

  @override
  String get zoom_start_center => '中';

  @override
  String get automatic_background => '自动背景';

  @override
  String get tapping_inversion => '点击反转';

  @override
  String get tapping_inversion_none => '无';

  @override
  String get tapping_inversion_horizontal => '水平';

  @override
  String get tapping_inversion_vertical => '垂直';

  @override
  String get tapping_inversion_both => '两者';

  @override
  String get flash_on_page_change => '翻页时闪烁';

  @override
  String get flash_on_page_change_subtitle => 'AMOLED 防烧屏辅助';

  @override
  String get flash_color => '闪烁颜色';

  @override
  String get flash_color_black => '黑色';

  @override
  String get flash_color_white => '白色';

  @override
  String get flash_color_white_black => '白与黑';

  @override
  String flash_interval(String n) {
    return '闪烁间隔：$n页';
  }

  @override
  String flash_duration(String n) {
    return '闪烁持续时间：$n毫秒';
  }

  @override
  String get show_navigation_overlay_on_start => '启动时显示导航浮层';

  @override
  String get reader_hide_threshold => '隐藏阅读器界面的阈值';

  @override
  String get reader_hide_threshold_highest => '最高 (5 px)';

  @override
  String get reader_hide_threshold_high => '高 (13 px)';

  @override
  String get reader_hide_threshold_low => '低 (31 px)';

  @override
  String get reader_hide_threshold_lowest => '最低 (47 px)';

  @override
  String get error_no_pages_available => '错误：无可用页面';

  @override
  String get app_ui_scale => '界面缩放';

  @override
  String get app_ui_scale_subtitle => '根据你的屏幕和观看距离，使界面更大或更小。';

  @override
  String get allow_concurrent_downloads => '允许并发下载';

  @override
  String get allow_concurrent_downloads_subtitle =>
      '同时从不同来源下载。单个来源仍然一次下载一个章节，因此不会过载。关闭后，可在任何地方一次下载一个。';

  @override
  String get download_delay => '下载延迟';

  @override
  String get download_delay_subtitle => '关闭。在章节之间添加随机抖动的等待，以便更温柔地对待来源。';

  @override
  String get save_search => '保存搜索';

  @override
  String get saved_searches => '已保存的搜索';

  @override
  String get enter_search_to_save_first => '先输入搜索进行保存';

  @override
  String get no_saved_searches => '此来源还没有保存的搜索。\n执行搜索，然后选择\"保存搜索\"。';

  @override
  String get source => '来源';

  @override
  String get something_went_wrong => '出错了';

  @override
  String get startup_failed => 'Mangayomi 无法完成启动';

  @override
  String sources_with_no_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个图源无结果',
    );
    return '$_temp0';
  }

  @override
  String get import_mode_title => '如何导入此备份？';

  @override
  String get import_mode_message => '选择将此备份合并到当前书库，还是完全替换当前书库。';

  @override
  String get import_mode_keep_existing => '合并';

  @override
  String get import_mode_keep_existing_subtitle => '添加新条目并更新匹配条目。不会删除现有内容。';

  @override
  String get import_mode_replace => '替换';

  @override
  String get import_mode_replace_subtitle => '清空当前书库并完全替换为备份内容。';

  @override
  String get replace_summary_title => '准备替换书库';

  @override
  String replace_summary_message(Object currentCount, Object backupCount) {
    return '这将删除当前的所有条目（$currentCount 项），并替换为备份中的 $backupCount 项。';
  }

  @override
  String get replace_summary_confirm => '替换';

  @override
  String replace_result_message(Object count) {
    return '已将书库替换为备份中的 $count 个条目。';
  }

  @override
  String get category_conflict_title => '发现已有分类';

  @override
  String get category_conflict_message => '备份中包含书库中已存在的分类。';

  @override
  String get category_conflict_keep => '保留 — 合并到已有分类';

  @override
  String get category_conflict_delete => '删除 — 归为未分类';

  @override
  String get source_conflict_title => '未找到图源';

  @override
  String get source_conflict_message => '备份中的部分图源未安装相应扩展。';

  @override
  String get source_conflict_keep => '保留原名';

  @override
  String get import_summary_title => '准备导入';

  @override
  String import_summary_message(
    Object newSeries,
    Object updatedSeries,
    Object newChapters,
  ) {
    return '将导入 $newSeries 个新条目，更新 $updatedSeries 个已有条目，并添加 $newChapters 个章节。';
  }

  @override
  String get import_summary_confirm => '导入';

  @override
  String import_result_message(
    Object newSeries,
    Object updatedSeries,
    Object newChapters,
  ) {
    return '已导入 $newSeries 个新条目，更新 $updatedSeries 个条目，添加 $newChapters 个章节。';
  }

  @override
  String get roll_back => '回滚';

  @override
  String get roll_back_confirm_message => '将书库恢复到本次更改前的安全快照。';

  @override
  String get roll_back_done => '已回滚至更改前的快照。';

  @override
  String get restoring_backup => '正在恢复书库…';

  @override
  String get roll_back_last_change => '回滚上次更改';

  @override
  String roll_back_last_change_subtitle(Object date, Object description) {
    return '快照时间：$date — $description';
  }

  @override
  String roll_back_available_count(Object count) {
    return '有 $count 个最近更改可供回滚';
  }

  @override
  String get delete_source_title => '删除图源及其漫画';

  @override
  String get delete_source_subtitle => '从书库中删除指定图源的所有内容（含章节、下载和历史）。';

  @override
  String get delete_source_pick_title => '选择要删除的图源';

  @override
  String get delete_source_empty => '书库中没有找到图源。';

  @override
  String delete_source_confirm_title(Object sourceName) {
    return '删除 $sourceName？';
  }

  @override
  String delete_source_confirm_message(
    Object mangaCount,
    Object chapterCount,
    Object historyCount,
    Object updateCount,
  ) {
    return '将永久删除 $mangaCount 部漫画、$chapterCount 个章节和 $historyCount 条历史记录。';
  }

  @override
  String get delete_source_also_remove_extension => '同时卸载对应扩展';

  @override
  String get delete_source_keep_history => '保留阅读历史';

  @override
  String get delete_source_keep_downloads => '保留下载记录';

  @override
  String get delete_source_button => '删除';

  @override
  String delete_source_result_message(Object mangaCount, Object sourceName) {
    return '已从 $sourceName 中删除 $mangaCount 部漫画。';
  }

  @override
  String get merge_manga_title => '合并重复漫画';

  @override
  String get merge_manga_subtitle => '查找同图源下标题相同的漫画并进行合并。';

  @override
  String get merge_manga_none_found => '未找到重复漫画。';

  @override
  String get merge_manga_pick_title => '可能重复的漫画';

  @override
  String get merge_manga_choose_primary_title => '要合并到哪一部漫画？';

  @override
  String get merge_manga_choose_primary_message => '其他条目的章节、历史和追踪将合并到所选项中。';

  @override
  String merge_manga_chapters_subtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 章节',
    );
    return '$_temp0';
  }

  @override
  String get merge_manga_button => '合并';

  @override
  String merge_manga_result_message(Object count, Object mangaName) {
    return '已将 $count 部重复漫画合并到 $mangaName。';
  }

  @override
  String get merge_preview_title => '确认合并';

  @override
  String merge_manga_preview_message(
    Object totalChapters,
    Object duplicateChapters,
    Object keptChapters,
    Object duplicateTracks,
  ) {
    return '在其他条目中共找到 $totalChapters 个章节。将丢弃 $duplicateChapters 个重复项并添加 $keptChapters 个新章节。';
  }

  @override
  String get memory_overlay => '显示内存占用';

  @override
  String get memory_overlay_subtitle => '实时显示应用占用的内存。可在滚动书架或阅读章节时实时观察设备上的内存变化。';

  @override
  String get beta => 'Beta';

  @override
  String get error_reports => '错误报告';

  @override
  String get error_reports_subtitle => '应用捕获的错误及反馈入口';

  @override
  String get error_reports_empty => '运行正常，无错误记录。';

  @override
  String get error_reports_likely_cause => '可能原因';

  @override
  String get error_reports_report => '在 GitHub 上反馈';

  @override
  String get error_reports_banner => 'Mangayomi 遇到了一个错误';

  @override
  String get error_reports_banner_action => '查看';

  @override
  String get error_reports_copy => '复制';

  @override
  String get error_reports_copied => '已复制到剪贴板';

  @override
  String get error_reports_clear => '清除';

  @override
  String get error_reports_extension_failure =>
      '此错误来自扩展插件，而非 Mangayomi 本身。扩展由插件仓库的维护者编写和维护，因此需要在插件仓库中修复。请向他们提供插件名称和当时正在打开的内容。';

  @override
  String get error_reports_already_reported => '已报告';

  @override
  String get error_reports_expected_failure =>
      '这通常是来源网站或网络问题，而非应用本身的问题（如链接已失效、服务器宕机或网络连接中断）。仅当在其他地方正常工作的来源上持续出现此问题时才有必要报告。';

  @override
  String get share_unavailable_copied => '此平台不支持分享，已复制到剪贴板。';

  @override
  String get onboarding_title => '欢迎使用 Mangayomi';

  @override
  String get onboarding_language_title => '选择语言';

  @override
  String get onboarding_language_body => 'Mangayomi 将以此语言显示。之后可在“外观”中更改。';

  @override
  String get onboarding_nav_grouped_body =>
      '为每个书库保留一个标签页，或将它们合并到一个“书库”标签页，并将“更新”和“历史”合并到一个“动态”标签页。';

  @override
  String get onboarding_nav_grouped => '合并的标签页';

  @override
  String get onboarding_nav_grouped_inside => '每个合并的标签页都在其屏幕顶部切换';

  @override
  String get onboarding_libraries_body => '选择您要阅读和观看的内容类型。';

  @override
  String get onboarding_nav_title => '您的书库';

  @override
  String get onboarding_nav_split => '独立标签页';

  @override
  String get onboarding_next => '下一步';

  @override
  String get onboarding_restore => '恢复备份';

  @override
  String get onboarding_or_local => '或使用现有本地文件';

  @override
  String get onboarding_local_folder => '添加文件夹';

  @override
  String onboarding_local_existing(Object count) {
    return '已设置 $count 个文件夹';
  }

  @override
  String get onboarding_local_any_type => '支持漫画、动漫与轻小说。';

  @override
  String get onboarding_local_scanning => '正在扫描文件夹';

  @override
  String onboarding_local_found(Object count) {
    return '找到 $count 个作品';
  }

  @override
  String get onboarding_local_remove => '移除该文件夹';

  @override
  String get onboarding_local_in_downloads => '这是应用的下载文件夹。';

  @override
  String get onboarding_local_empty => '未找到内容。请选择父级文件夹。';

  @override
  String get onboarding_repo_failed => '无法读取该仓库。';

  @override
  String get onboarding_repo_title => '添加图源';

  @override
  String get onboarding_body => '添加仓库即可浏览和安装丰富的扩展插件。';

  @override
  String get onboarding_add => '添加仓库';

  @override
  String get onboarding_skip => '暂时跳过';

  @override
  String get onboarding_continue => '继续';

  @override
  String get onboarding_later => '您可以稍后在“设置 > 浏览”中添加。';

  @override
  String get onboarding_replay => '显示欢迎界面';

  @override
  String get onboarding_replay_subtitle => '重新打开首次运行的引导设置界面。';

  @override
  String get missing_source_check_title => '检查缺失图源';

  @override
  String get missing_source_check_subtitle => '查找未安装对应扩展的书库条目。';

  @override
  String get missing_source_check_none_found => '书库中所有条目的图源均已安装。';

  @override
  String missing_source_check_result_title(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '缺少 $count 个图源',
    );
    return '$_temp0';
  }

  @override
  String global_search_no_sources(String itemType) {
    return '未安装任何 $itemType 来源。';
  }

  @override
  String get global_search_no_sources_hint => '请在“浏览”中添加仓库并安装相应的扩展插件。';

  @override
  String global_search_only_pinned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个来源',
    );
    return '您有 $_temp0，但仅会搜索已固定的来源。';
  }

  @override
  String get global_search_only_pinned_hint => '请固定某个来源，或在浏览设置中关闭“仅包含固定的来源”。';

  @override
  String get global_search_all_nsfw => '该分类下的所有来源均被标记为 NSFW 并已被隐藏。';

  @override
  String get global_search_all_nsfw_hint => '请在浏览设置中开启 NSFW 来源后再进行搜索。';

  @override
  String get missing_source_check_result_message =>
      '这些条目关联的图源未安装。点击可进行迁移或安装对应扩展。';

  @override
  String get related_titles => '相关作品';

  @override
  String get related_none => '未找到该作品的相关作品。';

  @override
  String get relation_adaptation => '改编';

  @override
  String get relation_sequel => '续作';

  @override
  String get relation_prequel => '前传';

  @override
  String get relation_parent => '原作/主线';

  @override
  String get relation_side_story => '外传';

  @override
  String get relation_spin_off => '衍生作';

  @override
  String get relation_alternative => '平行/替代版本';

  @override
  String get auto_library_update => '书架自动更新';

  @override
  String get auto_library_update_subtitle => '在应用启动时检查书架中所有作品的最新章节。';

  @override
  String get auto_library_update_never => '从不';

  @override
  String get auto_library_update_12_hours => '每 12 小时';

  @override
  String get auto_library_update_daily => '每天';

  @override
  String get auto_library_update_2_days => '每 2 天';

  @override
  String get auto_library_update_weekly => '每周';

  @override
  String get auto_library_update_wifi_only => '仅限 Wi-Fi';

  @override
  String get auto_library_update_wifi_only_subtitle => '使用移动数据时跳过计划更新。';

  @override
  String get library_update_restrictions => '更新时跳过';

  @override
  String get library_update_skip_completed => '已完结的作品';

  @override
  String get library_update_skip_unread => '有未读章节的作品';

  @override
  String get library_update_skip_not_started => '未开始的作品';

  @override
  String get library_update_restrictions_subtitle =>
      '适用于所有图书馆更新。设为跳过更新的类别，在更新整个图书馆时也会被排除。';

  @override
  String get library_update_restrictions_none => '无';

  @override
  String get padding => '内边距';

  @override
  String get page_mode => '翻页模式';

  @override
  String get single_page => '单页';

  @override
  String get double_page => '双页';

  @override
  String get speed => '速度';

  @override
  String get theme_dark => '暗色';

  @override
  String get theme_light => '浅色';

  @override
  String get theme_black => '纯黑';

  @override
  String get theme_sepia => '复古';

  @override
  String get decrease => '减少';

  @override
  String get increase => '增加';

  @override
  String get chapter_swipe_actions => '章节滑动操作';

  @override
  String get chapter_swipe_start => '向右滑动';

  @override
  String get chapter_swipe_end => '向左滑动';

  @override
  String get chapter_swipe_toggle_bookmark => '切换书签';

  @override
  String get chapter_swipe_toggle_read => '切换已读状态';

  @override
  String get chapter_swipe_download => '下载';

  @override
  String get chapter_swipe_disabled => '已禁用';

  @override
  String get update_errors => '更新错误';

  @override
  String get no_update_errors => '没有更新错误';

  @override
  String get clear_all => '全部清除';

  @override
  String get dismiss => '关闭';

  @override
  String get previous_episode => '上一集';

  @override
  String get clear_logs => '清除日志';

  @override
  String get bold => '粗体';

  @override
  String get italic => '斜体';

  @override
  String get color_yellow => '黄色';

  @override
  String get color_cyan => '青色';

  @override
  String get color_green => '绿色';

  @override
  String get color_orange => '橙色';

  @override
  String get continue_watching => '继续观看';

  @override
  String get search_your_anime => '搜索你的动画';

  @override
  String get category => '分类';

  @override
  String get hidden_categories => '隐藏的分类';

  @override
  String get new_category => '新建分类';

  @override
  String get local => '本地';

  @override
  String get tv_home_rows => '行';

  @override
  String get genre_rows => '类型行';

  @override
  String get share_backup_file => '分享 Mangayomi 备份';

  @override
  String get close => '关闭';

  @override
  String get migrate_source => '迁移来源';

  @override
  String get cloudflare_bypass_proxy => 'Cloudflare 绕过代理';

  @override
  String get custom_doh_url => '自定义 DoH 地址';

  @override
  String get custom_doh_url_helper => '必须是 https 的 DoH（JSON）端点';

  @override
  String get anime_only_tv_layout => '仅动画的电视布局';

  @override
  String get anime_only_beta => '仅动画（测试版）';

  @override
  String get tv_home_beta => '电视主页（测试版）';

  @override
  String get tv_player_beta => '电视播放器（测试版）';

  @override
  String get mark_as_read => '标为已读';

  @override
  String get mark_as_unread => '标为未读';

  @override
  String get bookmark => '书签';

  @override
  String get remove_bookmark => '移除书签';

  @override
  String get mark_below_as_read => '将下方标为已读';

  @override
  String get previous_chapter => '上一章';

  @override
  String get pin => '固定';

  @override
  String get go_forward => '前进';

  @override
  String get invert_selection => '反选';

  @override
  String get select_between => '选择之间的内容';

  @override
  String get show_password => '显示密码';

  @override
  String get hide_password => '隐藏密码';

  @override
  String get always_on_top => '窗口置顶';

  @override
  String get mute => '静音';

  @override
  String get unmute => '取消静音';

  @override
  String get exit_fullscreen => '退出全屏';

  @override
  String get play => '播放';

  @override
  String get pause => '暂停';

  @override
  String get switch_tracker => '切换追踪器';

  @override
  String get rename => '重命名';

  @override
  String get show_category => '显示分类';

  @override
  String get hide_category => '隐藏分类';

  @override
  String get update_with_library => '随书库一起更新';

  @override
  String get skip_updates => '更新书库时跳过';

  @override
  String get show_repository => '显示仓库';

  @override
  String get hide_repository => '隐藏仓库';

  @override
  String get set_as_default => '设为默认';

  @override
  String get change_display_mode => '更改显示模式';

  @override
  String get back_to_results => '返回结果';

  @override
  String get activity => '动态';

  @override
  String get group_nav_destinations => '合并导航';

  @override
  String get group_nav_destinations_subtitle =>
      '一个可在漫画、动画和小说之间切换的“书库”标签，以及一个包含更新和历史的“动态”标签';

  @override
  String get search_all_sources => '搜索所有来源';

  @override
  String get continue_reading => '继续';

  @override
  String get show_continue_shelf => '显示正在阅读的作品';

  @override
  String get show_continue_shelf_subtitle => '在书库顶部显示一行进行中的系列';

  @override
  String get excluded => '已排除';

  @override
  String get remove_filter => '移除筛选';

  @override
  String get current_chapter => '当前章节';

  @override
  String get series => '系列';

  @override
  String get chapters_read => '已读章节';

  @override
  String get search_settings => '搜索设置';

  @override
  String get search_settings_hint => '输入设置名称，或其说明中的一个词';

  @override
  String reading_mode_for(String name) {
    return '$name 的阅读模式';
  }

  @override
  String default_is(String name) {
    return '默认：$name';
  }

  @override
  String get use_default => '使用默认';

  @override
  String get is_the_default => '这是你的默认阅读模式';

  @override
  String get page_layout => '页面布局与缩放';

  @override
  String get reader_section_mode_summary => '默认模式、缩放、背景、预加载、全屏';

  @override
  String get reader_section_layout_summary => '宽页面、双页、横屏缩放';

  @override
  String get reader_section_navigation_summary => '点击区域、布局、隐藏菜单、翻页闪烁';

  @override
  String get reader_section_swipe_summary => '在列表中滑动章节时的操作';

  @override
  String get all_reader_settings => '所有阅读器设置';

  @override
  String get undo => '撤销';

  @override
  String get removed_from_history => '已从历史中移除';

  @override
  String n_new_chapters(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个新章节',
      one: '1 个新章节',
    );
    return '$_temp0';
  }

  @override
  String get page_color_white => '白色';

  @override
  String get page_color_black => '黑色';

  @override
  String get page_color_night => '夜间';

  @override
  String get page_color_sepia => '棕褐';

  @override
  String get page_color_coffee => '咖啡';

  @override
  String get page_color_silver => '银色';

  @override
  String get page_color_graphite => '石墨';

  @override
  String get page_color_mist => '薄雾';

  @override
  String get page_color_paper => '纸张';

  @override
  String get page_color_sky => '天空';

  @override
  String get page_color_mint => '薄荷';

  @override
  String get page_color_honey => '蜂蜜';

  @override
  String next_episode_in(int seconds) {
    return '$seconds 秒后播放下一集';
  }

  @override
  String get stay_on_this_episode => '停留在本集';

  @override
  String get got_it => '知道了';

  @override
  String get gesture_brightness => '在左侧上下滑动调节亮度';

  @override
  String get gesture_volume => '在右侧上下滑动调节音量';

  @override
  String get gesture_double_tap_skip => '双击一侧可后退或快进';

  @override
  String get gesture_drag_seek => '左右拖动以调整播放位置';

  @override
  String get gesture_long_press_speed => '长按加速播放';

  @override
  String get tap_to_continue => '点按任意位置继续';

  @override
  String get empty_library_hint => '在“浏览”中找到系列并添加到书库。';

  @override
  String get more_filters => '更多筛选';

  @override
  String get resume_all_downloads => '继续所有下载';

  @override
  String get download_failed => '失败';

  @override
  String get download_all => '全部下载';

  @override
  String n_chapters_queued(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 章已加入队列',
      one: '1 章已加入队列',
    );
    return '$_temp0';
  }

  @override
  String n_selected(int count) {
    return '已选择 $count 项';
  }

  @override
  String get settings_general_summary => '语言、书库更新、网络';

  @override
  String get settings_appearance_summary => '主题、调色板、导航、字体';

  @override
  String get settings_novel_reader_summary => '字体、页面颜色、朗读';

  @override
  String get settings_player_summary => '播放、字幕、音频、解码器';

  @override
  String get settings_downloads_summary => '位置、仅限 Wi-Fi、同时下载';

  @override
  String get settings_tracking_summary => 'MyAnimeList、AniList、Kitsu 等';

  @override
  String get settings_syncing_summary => '在你自己的服务器上同步进度';

  @override
  String get settings_browse_summary => '扩展、仓库、来源';

  @override
  String get settings_security_summary => '应用锁';

  @override
  String get settings_about_summary => '版本、更新、错误报告';

  @override
  String minutes_left(int minutes) {
    return '约剩 $minutes 分钟';
  }

  @override
  String get group_playback => '播放';

  @override
  String get group_subtitles => '字幕';

  @override
  String get group_screen => '屏幕';

  @override
  String get aniskip => 'AniSkip';

  @override
  String seconds_short(int n) {
    return '$n 秒';
  }

  @override
  String unknown_language_codes(String codes) {
    return '未知语言代码：$codes';
  }

  @override
  String get group_network => '网络';

  @override
  String get group_discord => 'Discord';

  @override
  String invalid_url(String scheme) {
    return '请输入以 $scheme 开头的网址';
  }

  @override
  String get group_cleanup => '清理';

  @override
  String remove_entries_confirm(int n) {
    return '要移除 $n 个条目及其历史吗？此操作无法撤销。';
  }

  @override
  String get group_library_maintenance => '书库维护';

  @override
  String get group_diagnostics => '诊断';

  @override
  String get update_no_notes => '没有发行说明。';

  @override
  String update_download_failed(String error) {
    return '下载失败：$error';
  }

  @override
  String get update_network_error => '下载时发生网络错误。';

  @override
  String get update_write_failed => '无法写入 APK 文件。';

  @override
  String get update_later => '稍后';

  @override
  String get update_installed_version => '已安装';

  @override
  String get update_new_version => '新版本';

  @override
  String update_published(String date) {
    return '发布于 $date';
  }

  @override
  String get update_pre_release => '预发布版';

  @override
  String get update_notes_features => '新功能';

  @override
  String get update_notes_fixes => '修复';

  @override
  String get update_notes_other => '改进';

  @override
  String get update_hint_install => '应用会下载更新，然后 Android 会请你确认安装。你的书库不会改变。';

  @override
  String get update_hint_browser => '发布页面将在浏览器中打开：请从那里下载适合你系统的文件，然后安装。';

  @override
  String get update_downloading => '正在下载…';

  @override
  String get update_installing => '正在打开安装程序…';

  @override
  String get update_install_failed => '无法打开安装程序。';

  @override
  String get update_browser_failed => '无法打开浏览器。';

  @override
  String get deselect_all => '取消全选';

  @override
  String update_failed_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个条目无法更新',
      one: '1 个条目无法更新',
    );
    return '$_temp0';
  }

  @override
  String get sort_ascending => '升序';

  @override
  String get sort_descending => '降序';

  @override
  String get not_downloaded => '未下载';

  @override
  String n_tracked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '正在追踪 $count 个条目',
      one: '正在追踪 1 个条目',
      zero: '尚未追踪任何条目',
    );
    return '$_temp0';
  }

  @override
  String get no_tracker_connected => '未连接追踪器';

  @override
  String get no_tracker_connected_message => '在 设置 › 追踪 中登录服务后，其列表会显示在这里。';

  @override
  String get edit_metadata => '编辑元数据';

  @override
  String get group_modes => '模式';

  @override
  String get group_app => '应用';

  @override
  String get group_sources_services => '来源与服务';

  @override
  String n_sources(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个来源',
      one: '1 个来源',
      zero: '没有来源',
    );
    return '$_temp0';
  }

  @override
  String get tv_player_beta_subtitle => '开启：为电视遥控器设计的播放器。关闭：原来的播放器。';

  @override
  String get anime_only_beta_subtitle => '在整个应用中隐藏漫画和小说。关闭即可显示全部。';

  @override
  String download_queue_start_failed(String error) {
    return '无法启动下载队列：$error';
  }

  @override
  String get group_interface => '界面';

  @override
  String get group_navigation => '导航';

  @override
  String get tv_home_beta_subtitle => '按行排列的动画主页（继续观看、新剧集、分类），代替平铺网格';

  @override
  String get cloudflare_bypass_proxy_hint => '可选的 FlareSolverr 或 Byparr 地址';

  @override
  String get cloudflare_bypass_proxy_message =>
      'FlareSolverr 或 Byparr 端点。留空即关闭。';

  @override
  String get group_explore => '探索';

  @override
  String get explore_recommendations_subtitle => '与此类似的作品';

  @override
  String get explore_related_subtitle => '其改编、衍生作品和其他版本';

  @override
  String get explore_watch_order_subtitle => '观看完整故事的顺序';

  @override
  String get explore_sequels_subtitle => '来自追踪器的后续作品';

  @override
  String get tap_zone_menu => '菜单';

  @override
  String get tap_zone_previous => '上一页';

  @override
  String get tap_zone_next => '下一页';

  @override
  String get back_to_series => '返回系列';

  @override
  String get keyboard_shortcuts => '键盘快捷键';

  @override
  String get shortcut_previous_page => '上一页';

  @override
  String get shortcut_next_page => '下一页';

  @override
  String get shortcut_toggle_bars => '显示或隐藏栏';

  @override
  String get shortcut_zoom_in => '放大';

  @override
  String get shortcut_zoom_out => '缩小';

  @override
  String get shortcut_zoom_reset => '适应页面';

  @override
  String get shortcut_wheel_zoom => '用鼠标缩放';

  @override
  String get mouse_wheel => '滚轮';

  @override
  String get shortcut_leave => '退出阅读器';

  @override
  String get shortcut_show => '显示这些快捷键';

  @override
  String get color_red => '红色';

  @override
  String get color_blue => '蓝色';

  @override
  String get color_opacity => '不透明度';

  @override
  String get volume_keys_paging => '用音量键翻页';

  @override
  String get volume_keys_paging_ios => '阅读时音量保持在一半，以便两个按键都能使用，离开时恢复原样。';

  @override
  String get volume_keys_inverted => '反转音量键';

  @override
  String get reader_orientation => '屏幕方向';

  @override
  String get orientation_free => '跟随设备';

  @override
  String get orientation_portrait => '竖屏';

  @override
  String get orientation_landscape => '横屏';

  @override
  String get screen_brightness => '屏幕亮度';

  @override
  String get screen_brightness_system => '跟随系统';

  @override
  String get shortcut_play_pause => '播放或暂停';

  @override
  String shortcut_seek_back(int n) {
    return '后退 $n 秒';
  }

  @override
  String shortcut_seek_forward(int n) {
    return '前进 $n 秒';
  }

  @override
  String get shortcut_volume_up => '调高音量';

  @override
  String get shortcut_volume_down => '调低音量';

  @override
  String get shortcut_mute => '静音或取消静音';

  @override
  String shortcut_skip_intro(int n) {
    return '跳过片头（$n 秒）';
  }

  @override
  String get shortcut_previous_frame => '上一帧';

  @override
  String get shortcut_next_frame => '下一帧';

  @override
  String get shortcut_shaders => 'Anime4K 着色器';

  @override
  String get shortcut_shaders_off => '关闭着色器';

  @override
  String get autoplay_next_on => '自动播放下一集：开';

  @override
  String get autoplay_next_off => '自动播放下一集：关';

  @override
  String get autoplay_next => '自动播放下一集';

  @override
  String get next_episode_short => '下一集';

  @override
  String get subtitle_preview_sample => '旅程仍在继续。';

  @override
  String get text_style => '样式';

  @override
  String get code_editor => '代码编辑器';

  @override
  String get code_view_code => '代码';

  @override
  String get code_view_test => '测试';

  @override
  String get code_view_console => '控制台';

  @override
  String get code_function => '函数';

  @override
  String get code_page => '页码';

  @override
  String get code_query => '查询';

  @override
  String get code_url => 'URL';

  @override
  String get code_html => 'HTML';

  @override
  String get code_execute => '运行';

  @override
  String get code_executing => '正在运行…';

  @override
  String get code_no_result => '暂无结果';

  @override
  String get code_no_result_message => '运行一个函数，查看它返回的内容。';

  @override
  String get code_console => '控制台';

  @override
  String get code_no_logs => '暂无日志';

  @override
  String get tv_empty_anime_library => '你的动画书库是空的';

  @override
  String get tv_empty_anime_library_hint => '从“浏览”添加动画来充实你的主页';

  @override
  String get browse_anime => '浏览动画';

  @override
  String get no_episodes_yet => '暂无剧集';

  @override
  String get filler => '填充集';

  @override
  String get obsolete => '已过时';

  @override
  String every_n_days(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '每 $n 天',
      one: '每天',
    );
    return '$_temp0';
  }

  @override
  String get update_interval_unknown => '无法估计';

  @override
  String get group_reading => '阅读';

  @override
  String get group_reading_watching => '阅读与观看';

  @override
  String get novel_reader => '小说阅读器';

  @override
  String get all_languages => '所有语言';

  @override
  String get custom_dns_title => '自定义 DNS';

  @override
  String get custom_dns_system => '系统 DNS';

  @override
  String get calendar_format_month => '月';

  @override
  String get calendar_format_two_weeks => '两周';

  @override
  String get calendar_format_week => '周';

  @override
  String get read_count => '已读';

  @override
  String get watched_count => '已看';

  @override
  String get source_code_error_title => '此来源的代码未能运行';

  @override
  String source_code_error_failed(String what) {
    return '$what 失败：界面已改用备用值，以便继续使用';
  }

  @override
  String get copy_error => '复制';

  @override
  String get error_copied => '已复制错误';

  @override
  String get no_categories_yet => '还没有分类';

  @override
  String get no_categories_yet_message => '用你自己命名和排序的分类来整理书库。';

  @override
  String get settings_keyboard_shortcuts_summary => '更改阅读器和播放器的按键';

  @override
  String get shortcut_reset_all => '重置所有快捷键';

  @override
  String get shortcut_press_key => '请按一个键…';

  @override
  String shortcut_key_in_use(String action) {
    return '已被占用：$action';
  }

  @override
  String get external_browser => '打开外部链接的方式';

  @override
  String get system_default => '系统默认';

  @override
  String get no_browsers_detected => '未检测到浏览器';

  @override
  String get on_this_device => '在此设备上';

  @override
  String get local_tracking => '在此设备上追踪';

  @override
  String get local_tracking_desc =>
      '无需账号，在此保存每部作品的状态、进度、评分和日期。不会发送任何内容。关闭后，已保存的内容仍会保留。';

  @override
  String get track_add_one => '再加一个';

  @override
  String get track_change_match => '更改匹配';

  @override
  String get track_remove => '停止追踪';

  @override
  String get track_remove_local_msg => '其状态、进度、评分和日期将从此设备删除。';

  @override
  String track_remove_online_msg(String tracker) {
    return '该条目仍保留在 $tracker 上：这里只移除它与此作品的关联。';
  }

  @override
  String update_from_repo(String repo) {
    return '来自 $repo';
  }

  @override
  String get update_from_other_repo => '要从其他存储库更新吗？';

  @override
  String update_from_other_repo_msg(
    String name,
    String origin,
    String version,
    String other,
  ) {
    return '$name 是从 $origin 安装的。版本 $version 来自 $other：安装后，$name 将从 $other 获取更新。请仅在信任该存储库时继续。';
  }

  @override
  String get update_all_foreign => '部分更新来自其他存储库';

  @override
  String get update_all_foreign_msg => '更新后，这些扩展将从新存储库获取更新。请仅在信任它时才包含。';

  @override
  String get update_all_skip_foreign => '仅来自其原有存储库';

  @override
  String get comments => '评论';

  @override
  String get onboarding_nav_body =>
      'Keep a tab for each of them, or put them together behind one Library tab you can switch inside.';

  @override
  String get onboarding_nav_merged => 'One Library tab';

  @override
  String get onboarding_nav_inside => 'Tapping Library swaps the bar for these';

  @override
  String get execute_action => 'Execute';

  @override
  String get adult_content => 'NSFW (18+)';

  @override
  String get source_updated_successfully => 'Source updated successfully';

  @override
  String get all_items => 'All';

  @override
  String get no_hidden_categories => 'No hidden categories';

  @override
  String category_hidden_hint(String name) {
    return 'Hid “$name” · hold OK on “All” to unhide';
  }

  @override
  String get tv_empty_anime_hint => 'Add anime from Browse to fill your home';

  @override
  String get tv_home_layout_description =>
      'Use rows for Continue Watching, New Episodes and categories instead of a flat grid.';

  @override
  String get anime_only_layout_description =>
      'Hide the manga and novel libraries (on by default on TV).';

  @override
  String get anime_only_browse_description =>
      'Hide manga and novels across the app. Turn off to show everything.';

  @override
  String get tv_player_layout_description =>
      'On: dedicated TV player. Off: original desktop player.';

  @override
  String get cloudflare_proxy_helper =>
      'FlareSolverr / Byparr endpoint. Leave empty to disable.';

  @override
  String get resolve_challenge => 'Resolve challenge';

  @override
  String get resolve_cloudflare_challenge => 'Resolve Cloudflare challenge';

  @override
  String get details => 'Details';

  @override
  String skip_seconds(String seconds) {
    return '$seconds seconds';
  }

  @override
  String get subtitle_rating => 'Rating: ';

  @override
  String get subtitle_votes => 'Votes: ';

  @override
  String get subtitle_date => 'Date: ';

  @override
  String get backup_created => 'Backup created!';

  @override
  String backup_failed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get backup_restored => 'Backup restored!';

  @override
  String get backup_unsupported => 'Unsupported or unrecognized backup file.';

  @override
  String restore_sync_upload_failed(String error) {
    return 'Backup restored, but the sync upload failed: $error. The server keeps its previous data until the next successful sync.';
  }

  @override
  String source_delete_failed(String error) {
    return 'Could not delete source: $error';
  }

  @override
  String manga_merge_failed(String error) {
    return 'Could not merge manga: $error';
  }

  @override
  String download_queue_failed(String error) {
    return 'Could not start download queue: $error';
  }

  @override
  String cover_too_large(String size) {
    return 'Cover is larger than 5 MB ($size MB). Skipping cover image.';
  }

  @override
  String library_update_failed(int count) {
    return 'Failed to update $count titles';
  }

  @override
  String get memory_waiting_sample => 'Memory: waiting for a sample';

  @override
  String memory_rss(String value, String peak) {
    return 'RSS $value · peak $peak';
  }

  @override
  String memory_image_cache(String value, String maximum, String peak) {
    return 'Cache $value / $maximum · peak $peak';
  }

  @override
  String memory_cached_items(int count, int maximum, int live, int peak) {
    return 'Items $count / $maximum · live $live · peak $peak';
  }

  @override
  String memory_cache_pressure(String percentage, int samples) {
    return 'Full for $percentage% of $samples samples';
  }

  @override
  String get memory_reset_hint => 'Toggle off and on in settings to reset';

  @override
  String get hide_action => 'Hide';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get library => '書庫';

  @override
  String get updates => '更新';

  @override
  String get history => '歷史紀錄';

  @override
  String get browse => '瀏覽';

  @override
  String get more => '更多';

  @override
  String get open_random_entry => '隨機開啟作品';

  @override
  String get import => '匯入';

  @override
  String get filter => '篩選';

  @override
  String get ignore_filters => '忽略\n篩選';

  @override
  String get downloaded => '已下載';

  @override
  String get unread => '未讀';

  @override
  String get unwatched => '未觀看';

  @override
  String get started => '已開始閱讀';

  @override
  String get bookmarked => '已加書籤';

  @override
  String get sort => '排序';

  @override
  String get alphabetically => '按名稱';

  @override
  String get last_read => '上次閱讀時間';

  @override
  String get last_watched => '上次觀看';

  @override
  String get last_update_check => '上次檢查更新時間';

  @override
  String last_entry_delete_warning(
    num count,
    Object entryType,
    Object entryTypePlural,
    Object mediaType,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '即將從書庫移除此$mediaType的全部 $count 個$entryTypePlural。',
      one: '即將從書庫移除此$mediaType唯一的$entryType。',
    );
    return '$_temp0\n此$mediaType也會一併從書庫移除。\n\n檔案本身不會被刪除。';
  }

  @override
  String get chapter => '章節';

  @override
  String get episode => '集數';

  @override
  String get unread_count => '未讀章節數';

  @override
  String get unwatched_count => '未觀看集數';

  @override
  String get latest_chapter => '最新章節';

  @override
  String get latest_episode => '最新一集';

  @override
  String get date_added => '加入日期';

  @override
  String get display => '顯示';

  @override
  String get display_mode => '顯示模式';

  @override
  String get compact_grid => '緊密格狀';

  @override
  String get compression_level => '壓縮等級';

  @override
  String compression_info(Object level) {
    return '壓縮率越高，備份檔案越小，但需要更多 CPU 運算。預設值：$level';
  }

  @override
  String get comfortable_grid => '寬鬆格狀';

  @override
  String get cover_only_grid => '僅顯示封面';

  @override
  String get list => '清單';

  @override
  String get badges => '徽章';

  @override
  String get downloaded_chapters => '已下載章節';

  @override
  String get downloaded_episodes => '下載的劇集';

  @override
  String get language => '語言';

  @override
  String get local_source => '本機來源';

  @override
  String get tabs => '分頁';

  @override
  String get show_category_tabs => '顯示分類標籤';

  @override
  String get show_numbers_of_items => '顯示作品數量';

  @override
  String get other => '其他';

  @override
  String get show_continue_reading_buttons => '顯示繼續閱讀按鈕';

  @override
  String get show_continue_watching_buttons => '顯示繼續觀看按鈕';

  @override
  String get empty_library => '書庫尚無作品';

  @override
  String get search => '搜尋…';

  @override
  String get no_recent_updates => '最近沒有更新';

  @override
  String get remove_everything => '全部移除';

  @override
  String get remove_everything_msg => '確定要清除所有歷史紀錄嗎？';

  @override
  String get remove_all_update_msg => '你確定嗎？所有更新將被清除';

  @override
  String get ok => '確定';

  @override
  String get cancel => '取消';

  @override
  String get remove => '移除';

  @override
  String get remove_history_msg => '這將移除此章節的閱讀日期。你確定嗎？';

  @override
  String get last_used => '最後使用';

  @override
  String get pinned => '已釘選';

  @override
  String get sources => '來源';

  @override
  String get install => '安裝';

  @override
  String get update => '更新';

  @override
  String get latest => '最新';

  @override
  String get extensions => '擴充套件';

  @override
  String get migrate => '遷移';

  @override
  String get mass_migration_title => '批次遷移';

  @override
  String get mass_migration_preview_items => '預覽作品';

  @override
  String get mass_migration_destination_source => '目標來源';

  @override
  String get mass_migration_no_library_items => '書庫中沒有可供批次遷移的作品。';

  @override
  String get mass_migration_no_destination_sources => '沒有可用的已安裝目標來源。';

  @override
  String get mass_migration_installed => '已安裝';

  @override
  String mass_migration_items_ready_for_review(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 個項目可供確認',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_item_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個項目',
    );
    return '$_temp0';
  }

  @override
  String get mass_migration_select_destination_source => '選擇目標來源';

  @override
  String mass_migration_finding_matches(Object source, Object language) {
    return '正在 $source（$language）尋找相符作品';
  }

  @override
  String mass_migration_processing_item(int current, int total) {
    return '正在處理第 $current / $total 個項目';
  }

  @override
  String get mass_migration_waiting_next_item => '等待 2 秒後處理下一個項目…';

  @override
  String get mass_migration_waiting_next_migration => '等待 2 秒後進行下一項遷移…';

  @override
  String mass_migration_matched_so_far(int count) {
    return '目前找到相符項目：$count';
  }

  @override
  String mass_migration_no_match_count(int count) {
    return '找不到相符項目：$count';
  }

  @override
  String mass_migration_review_matches(Object source) {
    return '確認 $source 的比對結果';
  }

  @override
  String mass_migration_found_matches(int count) {
    return '找到相符項目：$count';
  }

  @override
  String mass_migration_no_matches(int count) {
    return '找不到相符項目：$count';
  }

  @override
  String mass_migration_selected_to_migrate(int count) {
    return '選定遷移: $count';
  }

  @override
  String get mass_migration_finish_review => '完成確認';

  @override
  String mass_migration_migrate_selected(int count) {
    return '遷移選定項目 ($count)';
  }

  @override
  String mass_migration_migrating_selected(Object source) {
    return '正在將選定項目遷移至 $source';
  }

  @override
  String get mass_migration_no_items_selected => '未選定任何遷移項目。';

  @override
  String mass_migration_migrating_item(int current, int total) {
    return '正在遷移第 $current / $total 個項目';
  }

  @override
  String get mass_migration_complete => '批次遷移完成';

  @override
  String get mass_migration_complete_success_message => '所有選定項目均已處理成功。';

  @override
  String get mass_migration_complete_partial_message => '遷移結束，但部分項目仍需手動處理。';

  @override
  String mass_migration_route_summary(Object source, Object destination) {
    return '$source → $destination';
  }

  @override
  String get mass_migration_processed => '已處理';

  @override
  String get mass_migration_matched => '已找到相符項目';

  @override
  String get mass_migration_migrated => '已遷移';

  @override
  String get mass_migration_skipped => '已跳過';

  @override
  String get mass_migration_failed => '失敗';

  @override
  String get mass_migration_failed_items => '失敗項目';

  @override
  String get mass_migration_exit => '退出批次遷移';

  @override
  String get mass_migration_no_destination_match => '找不到相符的目標作品';

  @override
  String mass_migration_query(Object query) {
    return '查詢條件: $query';
  }

  @override
  String get mass_migration_skip => '跳過';

  @override
  String get mass_migration_loading => '正在載入...';

  @override
  String get mass_migration_choose_another_result => '選擇其他結果';

  @override
  String get mass_migration_source_chapters => '原章節';

  @override
  String get mass_migration_destination_chapters => '目標章節';

  @override
  String mass_migration_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個章節',
      one: '1個章節',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_source_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個原章節',
      one: '1個原章節',
    );
    return '$_temp0';
  }

  @override
  String mass_migration_destination_chapter_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個目標章節',
      one: '1個目標章節',
    );
    return '$_temp0';
  }

  @override
  String get mass_migration_no_chapters_found => '未找到章節。';

  @override
  String mass_migration_and_more_chapters(int count) {
    return '以及更多 $count 個...';
  }

  @override
  String get mass_migration_unknown_title => '未知標題';

  @override
  String get mass_migration_unknown_match => '未知的比對結果';

  @override
  String get mass_migration_unknown_source => '未知來源';

  @override
  String get mass_migration_unknown_chapter => '未知章節';

  @override
  String get migrate_confirm => '遷移到另一個來源';

  @override
  String get clean_database => '清理資料庫';

  @override
  String cleaned_database(Object x) {
    return '資料庫已清理！已移除 $x 條目';
  }

  @override
  String get clean_database_desc => '移除所有未加入書庫的項目。';

  @override
  String get incognito_mode => '隱身模式';

  @override
  String get incognito_mode_description => '暫停閱讀歷史紀錄';

  @override
  String get downloaded_only => '僅已下載';

  @override
  String get downloaded_only_description => '只顯示書庫中已下載的作品';

  @override
  String get download_queue => '下載佇列';

  @override
  String get categories => '分類';

  @override
  String get statistics => '統計';

  @override
  String get settings => '設定';

  @override
  String get about => '關於';

  @override
  String get open_source_licenses => '開源許可證';

  @override
  String get open_source_licenses_subtitle => 'Mangayomi 所使用的軟體包及其許可證';

  @override
  String get open_source_licenses_empty => '沒有可用的許可證資訊。';

  @override
  String get help => '說明';

  @override
  String get no_downloads => '無下載';

  @override
  String get edit_categories => '編輯分類';

  @override
  String get edit_categories_description => '你還沒有分類。點選加號按鈕建立一個來組織你的書庫';

  @override
  String get add => '新增';

  @override
  String get add_category => '新增分類';

  @override
  String get name => '名稱';

  @override
  String label_value(Object label, Object value) {
    return '$label：$value';
  }

  @override
  String get url => 'URL';

  @override
  String get category_name_required => '*必填';

  @override
  String get add_category_error_exist => '此名稱的分類已存在！';

  @override
  String get delete_category => '刪除分類';

  @override
  String delete_category_msg(Object name) {
    return '你希望刪除分類 $name 嗎？';
  }

  @override
  String get rename_category => '重新命名分類';

  @override
  String get general => '一般';

  @override
  String get general_subtitle => '介面語言';

  @override
  String get app_language => '介面語言';

  @override
  String get default_subtitle_language => '預設字幕語言';

  @override
  String get appearance => '外觀';

  @override
  String get appearance_subtitle => '主題，日期和時間格式';

  @override
  String get theme => '主題';

  @override
  String get dark_mode => '深色模式';

  @override
  String get follow_system_theme => '跟隨系統主題';

  @override
  String get on => '開啟';

  @override
  String get off => '關閉';

  @override
  String get pure_black_dark_mode => '純黑深色模式';

  @override
  String get tint_surfaces_with_palette => '用調色盤為介面著色';

  @override
  String get tint_surfaces_with_palette_subtitle =>
      '像以前一樣，用所選調色盤為背景、卡片和欄著色。關閉時它們保持中性色，調色盤只用於強調色。';

  @override
  String get timestamp => '日期與時間';

  @override
  String get relative_timestamp => '相對時間';

  @override
  String get relative_timestamp_short => '短（今天，昨天）';

  @override
  String get relative_timestamp_long => '較長格式（例如：幾天前）';

  @override
  String get date_format => '日期格式';

  @override
  String get reader => '閱讀器';

  @override
  String get refresh => '重新整理';

  @override
  String get reader_subtitle => '閱讀模式、顯示與導覽';

  @override
  String get default_reading_mode => '預設閱讀模式';

  @override
  String get reading_mode_vertical => '垂直';

  @override
  String get reading_mode_horizontal => '水平';

  @override
  String get reading_mode_left_to_right => '從左到右';

  @override
  String get reading_mode_right_to_left => '從右到左';

  @override
  String get reading_mode_vertical_continuous => '垂直連續';

  @override
  String get reading_mode_webtoon => '網路漫畫';

  @override
  String get double_tap_animation_speed => '雙擊動畫速度';

  @override
  String get normal => '正常';

  @override
  String get fast => '快';

  @override
  String get no_animation => '無動畫';

  @override
  String get animate_page_transitions => '翻頁動畫';

  @override
  String get crop_borders => '裁剪邊框';

  @override
  String get downloads => '下載';

  @override
  String get downloads_subtitle => '下載設定';

  @override
  String get download_location => '下載位置';

  @override
  String get custom_location => '自訂位置';

  @override
  String get only_on_wifi => '僅限 Wi-Fi';

  @override
  String get save_as_cbz_archive => '儲存為CBZ檔案';

  @override
  String get delete_download_after_reading => '完成閱讀後刪除下載內容';

  @override
  String get delete_after_reading_slot => '刪除哪個章節';

  @override
  String get delete_after_reading_last => '剛讀完的章節';

  @override
  String delete_after_reading_nth(int n) {
    return '往前 $n 個章節';
  }

  @override
  String get delete_after_reading_slot_subtitle => '保留幾個已讀章節，方便離線時回看。';

  @override
  String get delete_bookmarked_after_reading => '同時刪除已書籤的章節';

  @override
  String get auto_download => '自動下載';

  @override
  String get download_new_chapters => '下載新章節';

  @override
  String get download_new_chapters_subtitle => '圖書館更新後，將庫中作品的新未讀章節加入下載佇列。';

  @override
  String get download_new_chapters_included => '僅限這些類別';

  @override
  String get download_new_chapters_excluded => '這些類別除外';

  @override
  String get download_new_chapters_all_categories => '所有類別';

  @override
  String get download_ahead => '閱讀時提前下載';

  @override
  String get download_ahead_subtitle => '閱讀庫中作品的已下載章節時，下載接下來的未讀章節。';

  @override
  String download_ahead_count(int n) {
    return '接下來的 $n 個章節';
  }

  @override
  String get concurrent_downloads => '同時下載數量';

  @override
  String get browse_subtitle => '來源，全域搜尋';

  @override
  String get only_include_pinned_sources => '只包含已釘選的來源';

  @override
  String get nsfw_sources => 'NSFW（18+）來源';

  @override
  String get nsfw_sources_show => '在來源和擴充套件列表中顯示';

  @override
  String get nsfw_sources_info => '這不會阻止非官方或可能被錯誤標記的擴充套件在應用內顯示NSFW（18+）內容';

  @override
  String get version => '版本';

  @override
  String beta_version(Object version) {
    return '測試版 ($version)';
  }

  @override
  String get check_for_update => '檢查更新';

  @override
  String get logs_on => '啟用紀錄';

  @override
  String get share_app_logs => '分享應用紀錄';

  @override
  String get no_app_logs => '沒有可用的 log.txt 檔案！';

  @override
  String get failed => '失敗！';

  @override
  String n_days_ago(Object days) {
    return '$days天前';
  }

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get a_week_ago => '一週前';

  @override
  String get next_week => '下週';

  @override
  String get add_to_library => '新增到書庫';

  @override
  String get completed => '已完成';

  @override
  String get ongoing => '進行中';

  @override
  String get on_hiatus => '暫停';

  @override
  String get canceled => '已取消';

  @override
  String get publishing_finished => '已完結';

  @override
  String get unknown => '未知';

  @override
  String get empty_placeholder => '空';

  @override
  String get error => '錯誤';

  @override
  String error_with_message(Object error) {
    return '錯誤：$error';
  }

  @override
  String get no_pages_available => '錯誤：無可用頁面';

  @override
  String get set_categories => '設定分類';

  @override
  String get edit => '編輯';

  @override
  String get in_library => '已加入書庫';

  @override
  String get filter_scanlator_groups => '篩選翻譯組';

  @override
  String get reset => '重設';

  @override
  String get by_source => '按來源';

  @override
  String get by_chapter_number => '按章節號';

  @override
  String get by_episode_number => '按集數';

  @override
  String get by_upload_date => '按上傳日期';

  @override
  String get source_title => '來源標題';

  @override
  String get create_extension => '建立擴充套件';

  @override
  String get developer_mode => '開發者模式';

  @override
  String get developer_mode_subtitle => '顯示擴充套件開發者工具（建立擴充套件、編輯程式碼）';

  @override
  String get choose_extension_language => '選擇擴充套件語言';

  @override
  String get lang => '語言';

  @override
  String get base_url => '基礎 URL';

  @override
  String get api_url_optional => 'API URL（可選）';

  @override
  String get icon_url => '圖示 URL';

  @override
  String get source_icon_url => '來源圖示網址';

  @override
  String get notes => '備註';

  @override
  String get extension_name_example => '例如：myAnime';

  @override
  String get language_code_example => '例如：zh';

  @override
  String get base_url_example => '例如：https://example.com';

  @override
  String get api_url_example => '例如：https://api.example.com';

  @override
  String get extension_notes_example => '例如：此擴充套件需要登入';

  @override
  String get type => '類型';

  @override
  String get target => '目標';

  @override
  String get source_type_single => '單一';

  @override
  String get source_type_multi => '多來源';

  @override
  String get source_type_torrent => '種子 (Torrent)';

  @override
  String get source_language_dart => 'Dart';

  @override
  String get source_language_javascript => 'JavaScript';

  @override
  String get source_language_lnreader_compiled_js => 'LNReader 編譯 JS';

  @override
  String get source_created_successfully => '來源建立成功';

  @override
  String get source_already_exists => '來源已存在';

  @override
  String get error_when_creating_source => '建立來源時出錯';

  @override
  String get cookies_deleted => 'Cookie 已刪除！';

  @override
  String get delete_all_cookies => '刪除所有 Cookie';

  @override
  String get chapter_number => '章節號';

  @override
  String get episode_number => '集數';

  @override
  String get share => '分享';

  @override
  String n_chapters(Object n) {
    return '$n章';
  }

  @override
  String missing_chapters(Object count) {
    return '缺少 $count 個章節';
  }

  @override
  String get no_description => '無描述';

  @override
  String get resume => '繼續';

  @override
  String get read => '閱讀';

  @override
  String get watch => '觀看';

  @override
  String get popular => '熱門';

  @override
  String get open_in_browser => '在瀏覽器中開啟';

  @override
  String get clear_cookie => '清除Cookie';

  @override
  String get show_page_number => '顯示頁碼';

  @override
  String get from_library => '來自書庫';

  @override
  String get downloaded_chapter => '已下載章節';

  @override
  String page(Object page) {
    return '頁面 $page';
  }

  @override
  String get global_search => '全域搜尋';

  @override
  String get color_blend_level => '顏色混合級別';

  @override
  String current(Object char) {
    return '目前 $char';
  }

  @override
  String finished(Object char) {
    return '完成 $char';
  }

  @override
  String next(Object char) {
    return '下一個 $char';
  }

  @override
  String previous(Object char) {
    return '上一個 $char';
  }

  @override
  String get no_more_chapter => '沒有更多章節';

  @override
  String get no_result => '沒有結果';

  @override
  String get send => '傳送';

  @override
  String get delete => '刪除';

  @override
  String get start_downloading => '立即開始下載';

  @override
  String get retry => '重試';

  @override
  String get add_chapters => '新增章節';

  @override
  String get delete_chapters => '刪除章節？';

  @override
  String get default0 => '預設';

  @override
  String get total_chapters => '總章節數';

  @override
  String get total_episodes => '總集數';

  @override
  String get import_local_file => '匯入本機檔案';

  @override
  String get import_files => '檔案';

  @override
  String get split_epub_chapters => '分章節匯入';

  @override
  String get split_epub_chapters_description => '將 EPUB 的每個章節分別匯入';

  @override
  String get nothing_read_recently => '最近未閱讀';

  @override
  String get status => '狀態';

  @override
  String get not_started => '未開始';

  @override
  String get score => '評分';

  @override
  String get start_date => '開始日期';

  @override
  String get finish_date => '完成日期';

  @override
  String get reading => '閱讀';

  @override
  String get on_hold => '擱置';

  @override
  String get dropped => '已放棄';

  @override
  String get plan_to_read => '計劃閱讀';

  @override
  String get re_reading => '重讀';

  @override
  String get chapters => '章節';

  @override
  String get add_tracker => '新增追蹤';

  @override
  String get one_tracker => '1個追蹤器';

  @override
  String n_tracker(Object n) {
    return '$n個追蹤器';
  }

  @override
  String get tracking => '追蹤';

  @override
  String get syncing => '同步';

  @override
  String get sync_logged => '登入成功';

  @override
  String get syncing_subtitle => '透過自行架設的伺服器，在多個裝置間同步閱讀與觀看進度。詳情請參閱 Discord 社群。';

  @override
  String get last_sync => '上次同步時間：';

  @override
  String get sync_login_browser => '使用瀏覽器登入';

  @override
  String get sync_server => '同步伺服器網址';

  @override
  String get sync_starting => '開始同步...';

  @override
  String get sync_finished => '同步完成';

  @override
  String get sync_failed => '同步失敗';

  @override
  String get sync_restore_in_progress => '正在還原備份，暫不進行同步';

  @override
  String sync_progress_percent(Object percent) {
    return '正在同步… $percent%';
  }

  @override
  String get sync_progress_indeterminate => '正在同步…';

  @override
  String get sync_button_sync => '同步進度';

  @override
  String get sync_button_upload => '僅上傳';

  @override
  String get sync_button_upload_info => '以本機資料完整取代伺服器上的資料。';

  @override
  String get sync_button_download => '僅下載';

  @override
  String get sync_button_download_info => '以伺服器上的資料完整取代本機資料。';

  @override
  String get sync_status_not_configured => '未連線';

  @override
  String get sync_status_checking => '正在檢查連線...';

  @override
  String get sync_status_connected => '已連線';

  @override
  String get sync_status_unauthorized => '登入授權已失效，請重新登入';

  @override
  String get sync_status_unreachable => '無法連線到伺服器';

  @override
  String get sync_section_general => '通用';

  @override
  String get sync_on => '啟用同步';

  @override
  String get sync_auto => '自動同步';

  @override
  String get sync_auto_warning => '自動同步目前是實驗性功能！';

  @override
  String get sync_auto_off => '關閉';

  @override
  String get sync_auto_5_minutes => '每5分鐘';

  @override
  String get sync_auto_10_minutes => '每10分鐘';

  @override
  String get sync_auto_30_minutes => '每30分鐘';

  @override
  String get sync_auto_1_hour => '每1小時';

  @override
  String get sync_auto_3_hours => '每3小時';

  @override
  String get sync_auto_6_hours => '每6小時';

  @override
  String get sync_auto_12_hours => '每12小時';

  @override
  String get server_error => '伺服器錯誤！';

  @override
  String get dialog_confirm => '確認';

  @override
  String get description => '描述';

  @override
  String get reorder_navigation => '自訂導覽';

  @override
  String get reorder_navigation_description => '根據需要重新排序和切換每個導覽。';

  @override
  String get floating_navigation_bar => '浮動導覽列';

  @override
  String get floating_navigation_bar_description => '以浮動膠囊式導覽列取代貼齊邊緣的標準導覽列。';

  @override
  String get show_updates_badge => '在“更新”圖示上顯示角標';

  @override
  String get show_updates_badge_description => '統計自上次開啟“更新”以來發現的章節數。';

  @override
  String get full_screen_player => '全螢幕播放';

  @override
  String get full_screen_player_info => '播放影片時自動切換成全螢幕。';

  @override
  String episode_progress(Object n) {
    return '進度：$n';
  }

  @override
  String n_episodes(int n) {
    return '$n集';
  }

  @override
  String missing_episodes(Object count) {
    return '缺少 $count 集';
  }

  @override
  String get manga_sources => '漫畫來源';

  @override
  String get anime_sources => '動畫來源';

  @override
  String get novel_sources => '小說來源';

  @override
  String get anime_extensions => '動畫擴充套件';

  @override
  String get manga_extensions => '漫畫擴充套件';

  @override
  String get novel_extensions => '小說擴充套件';

  @override
  String get extension_settings => '擴充套件設定';

  @override
  String get anime => '動畫';

  @override
  String get manga => '漫畫';

  @override
  String get novel => '小說';

  @override
  String get library_no_category_exist => '你還沒有任何分類';

  @override
  String get watching => '觀看中';

  @override
  String get plan_to_watch => '計劃觀看';

  @override
  String get re_watching => '重看';

  @override
  String get episodes => '集';

  @override
  String get download => '下載';

  @override
  String get new_update_available => '有新更新可用';

  @override
  String app_version(Object v) {
    return '應用版本：v$v';
  }

  @override
  String get searching_for_updates => '正在搜尋更新...';

  @override
  String get no_new_updates_available => '沒有新的更新可用';

  @override
  String get uninstall => '解除安裝';

  @override
  String uninstall_extension(Object ext) {
    return '解除安裝 $ext 擴充套件？';
  }

  @override
  String double_tap_search_hint(Object type) {
    return '雙擊以搜尋全部 $type';
  }

  @override
  String get show_nav_double_tap_tooltip => '顯示雙擊搜尋提示';

  @override
  String get show_nav_double_tap_tooltip_subtitle =>
      '在漫畫、動畫及小說導覽列顯示提示，說明連點兩下可開啟全域搜尋。';

  @override
  String already_in_library(Object source, Object title) {
    return '\"$title\" 已透過 $source 新增到您的書庫中。';
  }

  @override
  String get add_anyway => '仍然新增';

  @override
  String get langauage => '語言';

  @override
  String get extension_detail => '擴充套件詳情';

  @override
  String get scale_type => '縮放類型';

  @override
  String get scale_type_fit_screen => '適合螢幕';

  @override
  String get scale_type_stretch => '拉伸';

  @override
  String get scale_type_fit_width => '適合寬度';

  @override
  String get scale_type_fit_height => '適合高度';

  @override
  String get scale_type_original_size => '原始大小';

  @override
  String get scale_type_smart_fit => '智慧適配';

  @override
  String get page_preload_amount => '頁面預載入量';

  @override
  String get page_preload_amount_subtitle =>
      '閱讀時預載入的頁面數量。更高的值將導致更順暢的閱讀體驗，但會增加快取和網路使用。';

  @override
  String get image_loading_error => '無法載入此圖片';

  @override
  String get add_episodes => '新增集數';

  @override
  String get video_quality => '畫質';

  @override
  String get video_subtitle => '字幕';

  @override
  String get check_for_extension_updates => '檢查擴充套件更新';

  @override
  String get auto_extensions_updates => '自動擴充套件更新';

  @override
  String get auto_extensions_updates_subtitle => '當有新版本可用時，將自動更新擴充套件。';

  @override
  String get check_for_app_updates => '啟動時檢查 App 更新';

  @override
  String get reading_mode => '閱讀模式';

  @override
  String get custom_filter => '自訂篩選';

  @override
  String get background_color => '背景顏色';

  @override
  String get white => '白色';

  @override
  String get black => '黑色';

  @override
  String get grey => '灰色';

  @override
  String get automaic => '自動';

  @override
  String get preferred_domain => '偏好的網域';

  @override
  String get load_more => '載入更多';

  @override
  String get cancel_all_for_this_series => '取消此作品的全部下載';

  @override
  String get login => '登入';

  @override
  String login_into(Object tracker) {
    return '登入到 $tracker';
  }

  @override
  String get email_adress => '電子郵件地址';

  @override
  String get password => '密碼';

  @override
  String log_out_from(Object tracker) {
    return '從 $tracker 登出？';
  }

  @override
  String get log_out => '登出';

  @override
  String get update_pending => '更新待定';

  @override
  String get update_all => '更新全部';

  @override
  String get backup_and_restore => '備份與還原';

  @override
  String get create_backup => '建立備份';

  @override
  String get create_backup_dialog_title => '你想要備份什麼？';

  @override
  String get create_backup_subtitle => '可用於還原目前書庫';

  @override
  String get restore_backup => '還原備份';

  @override
  String get encrypt_backups => '加密備份';

  @override
  String get encrypt_backups_info => '使用 AES 加密和密碼保護備份檔案';

  @override
  String get no_secure_storage => '未找到安全儲存';

  @override
  String get no_keyring_warning => '目前系統沒有金鑰環服務，無法安全儲存密碼。\n\n是否以明文形式儲存在本機資料庫中？';

  @override
  String get enter_backup_password => '輸入備份密碼';

  @override
  String get incorrect_password_try_again => '密碼錯誤，請重試。';

  @override
  String get set_backup_password => '設定備份密碼';

  @override
  String get confirm_password => '確認密碼';

  @override
  String get passwords_do_not_match => '兩次輸入的密碼不一致';

  @override
  String get password_required_to_restore => '需要密碼才能還原此備份。';

  @override
  String get restore_backup_subtitle => '從備份檔案還原書庫';

  @override
  String get automatic_backups => '自動備份';

  @override
  String get backup_frequency => '備份頻率';

  @override
  String get backup_location => '備份位置';

  @override
  String get backup_options => '備份選項';

  @override
  String get backup_options_dialog_title => '你想要備份什麼？';

  @override
  String get backup_options_subtitle => '包含在備份檔案中的資訊';

  @override
  String get backup_and_restore_warning_info => '你應該在其他地方儲存備份副本';

  @override
  String get library_entries => '書庫條目';

  @override
  String get chapters_and_episode => '章節和集數';

  @override
  String get every_6_hours => '每6小時';

  @override
  String get every_12_hours => '每12小時';

  @override
  String get daily => '每日';

  @override
  String get every_2_days => '每2天';

  @override
  String get weekly => '每週';

  @override
  String get restore_backup_warning_title => '還原備份將覆蓋所有現有資料。\n\n繼續還原？';

  @override
  String get restore_sync_question_title => '是否同步此次還原？';

  @override
  String get restore_sync_question_message => '此裝置已連線到同步伺服器。是否立即將還原的資料上傳？';

  @override
  String get restore_sync_question_confirm => '是，進行同步';

  @override
  String get restore_sync_question_deny => '否，停用同步';

  @override
  String get sync_disabled_after_restore => '同步已停用。您可以在“設定”中重新開啟。';

  @override
  String get restore_sync_disabled_question_title => '同步目前已停用';

  @override
  String get restore_sync_disabled_question_message =>
      '同步已關閉。是否重新開啟並將還原的資料上傳到伺服器？';

  @override
  String get restore_sync_question_reenable => '是，重新開啟並同步';

  @override
  String get restore_sync_question_keep_disabled => '保持停用';

  @override
  String get restore_sync_uploading => '正在同步還原的資料到伺服器…';

  @override
  String get restore_sync_upload_success => '還原的資料已同步到伺服器';

  @override
  String get services => '服務';

  @override
  String get tracking_warning_info => '單向同步以更新跟蹤服務中的章節進度。從它們的跟蹤按鈕為個別條目設定跟蹤。';

  @override
  String get use_page_tap_zones => '使用頁面點選區域';

  @override
  String get manage_trackers => '管理跟蹤器';

  @override
  String get restore => '還原';

  @override
  String get backups => '備份';

  @override
  String get by_scanlator => '按翻譯者';

  @override
  String get by_name => '按名稱';

  @override
  String get installed => '已安裝';

  @override
  String get auto_scroll => '自動捲動';

  @override
  String get video_audio => '音訊';

  @override
  String get video_audio_info => '首選語言、音調校正、音訊通道';

  @override
  String get player => '播放器';

  @override
  String get markEpisodeAsSeenSetting => '將集數標記為已觀看的時機';

  @override
  String get mark_duplicate_chapters_read => '將重複的章節號標記為已讀';

  @override
  String get skip_read_chapters => '跳過已讀章節';

  @override
  String get skip_read_chapters_subtitle => '切換到下一章或上一章時，跳過已讀的章節。';

  @override
  String get skip_filtered_chapters => '跳過被篩選的章節';

  @override
  String get skip_duplicate_chapters => '跳過重複章節';

  @override
  String get skip_duplicate_chapters_subtitle =>
      '每個章節號只閱讀一份；如有多個版本，優先選擇同一譯者的版本。';

  @override
  String get default_skip_intro_length => '預設略過片頭的秒數';

  @override
  String get default_playback_speed_length => '預設播放速度';

  @override
  String get updateProgressAfterReading => '閱讀後更新進度';

  @override
  String get no_sources_installed => '未安裝任何來源！';

  @override
  String get show_extensions => '顯示擴充套件';

  @override
  String get default_skip_forward_skip_length => '預設快轉秒數';

  @override
  String get aniskip_requires_info =>
      '請先將動畫連結至 MyAnimeList 或 AniList，才能使用 AniSkip。';

  @override
  String get enable_aniskip => '啟用AniSkip';

  @override
  String get enable_auto_skip => '啟用自動跳過';

  @override
  String get aniskip_button_timeout => '略過按鈕顯示時間';

  @override
  String get skip_opening => '跳過片頭';

  @override
  String get skip_ending => '跳過片尾';

  @override
  String get fullscreen => '全螢幕';

  @override
  String get update_library => '更新書庫';

  @override
  String updating_library(Object cur, Object failed, Object max) {
    return '正在更新書庫（$cur／$max），失敗：$failed';
  }

  @override
  String get next_chapter => '下一章';

  @override
  String get next_5_chapters => '下5章';

  @override
  String get next_10_chapters => '下10章';

  @override
  String get next_25_chapters => '下25章';

  @override
  String get all_chapters => '所有章節';

  @override
  String get next_episode => '下一集';

  @override
  String get next_5_episodes => '接下來的 5 集';

  @override
  String get next_10_episodes => '接下來的 10 集';

  @override
  String get next_25_episodes => '接下來的 25 集';

  @override
  String get all_episodes => '所有劇集';

  @override
  String get cover_saved => '封面已儲存';

  @override
  String get set_as_cover => '設定為封面';

  @override
  String get use_this_as_cover_art => '使用此作為封面？';

  @override
  String get save => '儲存';

  @override
  String get picture_saved => '圖片已儲存';

  @override
  String get cover_updated => '封面已更新';

  @override
  String get include_subtitles => '包含字幕';

  @override
  String get blend_mode_default => '預設';

  @override
  String get blend_mode_multiply => '正片疊底';

  @override
  String get blend_mode_screen => '濾色';

  @override
  String get blend_mode_overlay => '疊加';

  @override
  String get blend_mode_colorDodge => '顏色減淡';

  @override
  String get blend_mode_lighten => '變亮';

  @override
  String get blend_mode_colorBurn => '顏色加深';

  @override
  String get blend_mode_darken => '變暗';

  @override
  String get blend_mode_difference => '差異';

  @override
  String get blend_mode_saturation => '飽和度';

  @override
  String get blend_mode_softLight => '柔光';

  @override
  String get blend_mode_plus => '加';

  @override
  String get blend_mode_exclusion => '排除';

  @override
  String get custom_color_filter => '自訂顏色濾鏡';

  @override
  String get color_filter_blend_mode => '顏色濾鏡混合模式';

  @override
  String get enable_all => '啟用全部';

  @override
  String get disable_all => '停用全部';

  @override
  String get font => '字型';

  @override
  String get color => '顏色';

  @override
  String get font_size => '字型大小';

  @override
  String get text => '文字';

  @override
  String get border => '邊框';

  @override
  String get background => '背景';

  @override
  String get no_subtite_warning_message => '由於此影片中沒有字幕軌道，因此無效。';

  @override
  String get grid_size => '網格大小';

  @override
  String n_per_row(Object n) {
    return '每列 $n 個';
  }

  @override
  String get horizontal_continious => '水平連續';

  @override
  String get edit_code => '編輯程式碼';

  @override
  String get subtitles_on_by_default => '開啟字幕';

  @override
  String get subtitles_on_by_default_info => '關閉時，劇集開始時沒有字幕，直到你選擇字幕軌道。';

  @override
  String get use_libass => '啟用 libass';

  @override
  String get use_libass_info => '使用基於 libass 的字幕繪製作為本機後端。';

  @override
  String get libass_not_disable_message => '在播放器設定中停用 `use libass` 以便自訂字幕。';

  @override
  String get override_ass_subtitles => '覆蓋 ASS 字幕樣式';

  @override
  String get override_ass_subtitles_info => '將自訂樣式應用到 ASS/SSA 字幕';

  @override
  String get torrent_stream => 'Torrent 串流';

  @override
  String get add_torrent => '新增種子';

  @override
  String get enter_torrent_hint_text => '輸入磁力連結或種子檔案 URL';

  @override
  String get torrent_url => '種子 URL';

  @override
  String get or => '或';

  @override
  String get advanced => '進階';

  @override
  String get advanced_info => 'mpv 設定';

  @override
  String get use_native_http_client => '使用本機 HTTP 客戶端';

  @override
  String get use_native_http_client_info =>
      '它自動支援平臺特性，如 VPN，支援更多 HTTP 特性，如 HTTP/3 和自訂重新導向處理';

  @override
  String n_hour_ago(Object hour) {
    return '$hour小時前';
  }

  @override
  String n_hours_ago(Object hours) {
    return '$hours小時前';
  }

  @override
  String n_minute_ago(Object minute) {
    return '$minute分鐘前';
  }

  @override
  String n_minutes_ago(Object minutes) {
    return '$minutes分鐘前';
  }

  @override
  String n_day_ago(Object day) {
    return '$day天前';
  }

  @override
  String get now => '現在';

  @override
  String library_last_updated(Object lastUpdated) {
    return '書庫最近更新時間：$lastUpdated';
  }

  @override
  String get data_and_storage => '資料與儲存';

  @override
  String get download_location_info => '用於章節下載';

  @override
  String get storage => '儲存';

  @override
  String get clear_chapter_and_episode_cache => '清除章節和劇集快取';

  @override
  String get cache_cleared => '快取已清除';

  @override
  String get clear_chapter_or_episode_cache_on_app_launch => '啟動應用時清除章節/劇集快取';

  @override
  String get app_settings => 'App 設定';

  @override
  String get sources_settings => '來源設定';

  @override
  String get include_sensitive_settings => '包含敏感設定（例如追蹤服務的登入權杖）';

  @override
  String get create => '建立';

  @override
  String get downloads_are_limited_to_wifi => '下載僅限於WiFi';

  @override
  String get recommendations => '推薦';

  @override
  String get recommendations_similar => '相似';

  @override
  String get recommendations_weights => '推薦權重';

  @override
  String get recommendations_weights_genre => '作品類型相似度';

  @override
  String get recommendations_weights_setting => '故事背景相似度';

  @override
  String get recommendations_weights_synopsis => '劇情相似度';

  @override
  String get recommendations_weights_theme => '主題相似度';

  @override
  String get manga_extensions_repo => '漫畫擴充套件庫';

  @override
  String get anime_extensions_repo => '動畫擴充套件庫';

  @override
  String get novel_extensions_repo => '小說擴充套件庫';

  @override
  String get custom_dns => '自訂 DNS（留空使用系統 DNS）';

  @override
  String get android_proxy_server => 'Android 代理伺服器（M-Extension-Server）';

  @override
  String get get_m_extension_server => '獲取 M-Extension-Server';

  @override
  String get get_sync_server => '在此獲取同步伺服器';

  @override
  String get undefined => '未定義';

  @override
  String get empty_extensions_repo => '擴充套件庫為空';

  @override
  String get add_extensions_repo => '新增擴充套件庫';

  @override
  String get remove_extensions_repo => '移除擴充套件庫';

  @override
  String get manage_manga_repo_urls => '管理漫畫套件庫網址';

  @override
  String get manage_anime_repo_urls => '管理動畫套件庫網址';

  @override
  String get manage_novel_repo_urls => '管理小說套件庫網址';

  @override
  String get url_cannot_be_empty => '網址不能留空';

  @override
  String get url_must_end_with_dot_json_or_dot_pb => '網址必須以 .json 結尾';

  @override
  String get repo_url => '套件庫網址';

  @override
  String get invalid_url_format => '網址格式不正確';

  @override
  String get clear_all_sources => '清除所有來源';

  @override
  String get clear_all_sources_msg => '你確定嗎？所有來源將被清除';

  @override
  String get sources_cleared => '來源已清除';

  @override
  String get repo_added => '已加入套件庫';

  @override
  String get repo_already_exists => '此套件庫已存在！';

  @override
  String get add_repo => '新增套件庫';

  @override
  String get add_repo_sources_to_add => '將加入下列擴充套件清單：';

  @override
  String get add_repo_warning => '這些套件庫提供的擴充套件會在 App 內執行。請只加入你信任的套件庫。';

  @override
  String get genre_search_library => '按分類搜尋書庫';

  @override
  String get genre_search_source => '按分類搜尋來源';

  @override
  String get source_not_added => '來源未新增';

  @override
  String get load_own_subtitles => '載入自訂字幕';

  @override
  String get search_subtitles => '線上搜尋字幕...';

  @override
  String extension_notes(Object notes) {
    return '備註：$notes';
  }

  @override
  String get unsupported_repo => '不支援此套件庫格式。請至 Discord 社群查詢支援資訊。';

  @override
  String get end_of_chapter => '章節結束';

  @override
  String get chapter_completed => '章節完成';

  @override
  String get continue_to_next_chapter => '繼續捲動閱讀下一章';

  @override
  String get no_next_chapter => '沒有下一章';

  @override
  String get you_have_finished_reading => '您已讀完';

  @override
  String get return_to_the_list_of_chapters => '返回章節列表';

  @override
  String get hwdec => '硬體解碼器';

  @override
  String get enable_hardware_accel => '硬體加速';

  @override
  String get enable_hardware_accel_info => '如果遇到錯誤或崩潰，請開啟/關閉';

  @override
  String get track_library_navigate => '轉到現有本機條目';

  @override
  String get track_library_add => '新增到本機庫';

  @override
  String get track_library_add_confirm => '將跟蹤項目新增到本機庫';

  @override
  String get track_library_not_logged => '請登入相應的跟蹤器以使用此功能！';

  @override
  String get track_library_switch => '切換到另一個跟蹤器';

  @override
  String get go_back => '返回';

  @override
  String get merge_library_nav_mobile => '在行動裝置上合併書庫分頁';

  @override
  String get enable_discord_rpc => '啟用 Discord RPC';

  @override
  String get hide_discord_rpc_incognito => '隱身模式下隱藏 Discord RPC';

  @override
  String get rpc_show_reading_watching_progress => '在 Discord 中顯示目前章節（需要重啟）';

  @override
  String get rpc_show_title => '在 Discord 中顯示目前標題';

  @override
  String get rpc_show_cover_image => '在 Discord 中顯示目前封面圖片';

  @override
  String get enable_mpv => '啟用 mpv 著色器/指令碼';

  @override
  String get mpv_info => '支援 mpv/scripts/ 下的 .js 指令碼';

  @override
  String get mpv_redownload => '重新下載 mpv 設定檔案';

  @override
  String get mpv_redownload_info => '用新設定檔案替換舊設定檔案！';

  @override
  String get mpv_download => '需要 MPV 設定檔案！\n現在下載？';

  @override
  String get custom_buttons => '自訂按鈕';

  @override
  String get custom_buttons_info => '使用自訂按鈕執行 lua 程式碼';

  @override
  String get custom_buttons_edit => '編輯自訂按鈕';

  @override
  String get custom_buttons_add => '新增自訂按鈕';

  @override
  String get custom_buttons_added => '已新增自訂按鈕！';

  @override
  String get custom_buttons_delete => '刪除自訂按鈕';

  @override
  String get custom_buttons_text => '按鈕文字';

  @override
  String get custom_buttons_text_req => '按鈕文字必填';

  @override
  String get custom_buttons_js_code => 'lua 程式碼';

  @override
  String get custom_buttons_js_code_req => 'lua 程式碼必填';

  @override
  String get custom_buttons_js_code_long => 'lua 程式碼（長按時）';

  @override
  String get custom_buttons_startup => 'lua 程式碼（啟動時）';

  @override
  String get custom_buttons_add_warning =>
      '此按鈕會在影片播放器中執行下方的 Lua 程式碼，能存取檔案及執行程式。請確認你信任此連結的來源後再加入。';

  @override
  String n_days(Object n) {
    return '$n 天';
  }

  @override
  String get decoder => '解碼器';

  @override
  String get decoder_info => '硬體解碼、像素格式及色帶修正';

  @override
  String get enable_gpu_next => '啟用 gpu-next（僅限 Android）';

  @override
  String get enable_gpu_next_info => '新的影片繪製引擎';

  @override
  String get debanding => '去色帶';

  @override
  String get use_yuv420p => '使用 YUV420P 像素格式';

  @override
  String get use_yuv420p_info => '可以修復某些影片編解碼器上的黑畫面，也可以以品質為代價提高效能';

  @override
  String get audio_preferred_languages => '首選語言';

  @override
  String get audio_preferred_languages_info =>
      '在具有多個音訊流的影片上預設選擇的音訊語言，2/3 字母語言程式碼（例如：zh、en、ja）。多個值可以用逗號分隔。';

  @override
  String get enable_audio_pitch_correction => '啟用音訊音調校正';

  @override
  String get enable_audio_pitch_correction_info => '防止音訊在較快速度時變高音，在較慢速度時變低音';

  @override
  String get audio_channels => '音訊通道';

  @override
  String get volume_boost_cap => '音量增強上限';

  @override
  String get internal_player => '內部播放器';

  @override
  String get internal_player_info => '進度、控制、方向';

  @override
  String get subtitle_delay_text => '字幕延遲';

  @override
  String get subtitle_delay => '延遲（毫秒）';

  @override
  String get audio_delay => '音訊延遲（毫秒）';

  @override
  String get audio_delay_subtitle => '讓聲音比畫面延後（正值）或提前（負值）播放。在各集之間保持不變。';

  @override
  String get subtitle_speed => '速度';

  @override
  String get tracks => '軌道';

  @override
  String get playback_speed => '播放速度';

  @override
  String get shaders => '著色器';

  @override
  String get video_fit => '畫面適配';

  @override
  String get calendar => '日曆';

  @override
  String get calendar_no_data => '暫無資料。';

  @override
  String get calendar_info => '日曆會根據過往上傳時間預估下一章的日期，實際更新時間可能不同。';

  @override
  String in_n_day(Object days) {
    return '$days 天后';
  }

  @override
  String in_n_days(Object days) {
    return '$days 天后';
  }

  @override
  String get clear_library => '清空書庫';

  @override
  String get clear_library_desc => '選擇清除所有漫畫、動畫和/或小說條目';

  @override
  String get clear_library_input =>
      '輸入 \'manga\'、\'anime\' 和/或 \'novel\'（用逗號分隔）以刪除所有相關條目';

  @override
  String get watch_order => '觀看順序';

  @override
  String get watch_order_role_current => '目前';

  @override
  String get watch_order_role_previous => '上一部';

  @override
  String get watch_order_role_next => '下一部';

  @override
  String get watch_order_source_release_order => '發行順序';

  @override
  String watch_order_source_community_list(String name, String author) {
    return '$name（由 $author 建立）';
  }

  @override
  String watch_order_source_official_collection(String name) {
    return 'Trakt 官方合輯：$name';
  }

  @override
  String watch_order_source_trakt_collection(String name) {
    return 'Trakt 合輯：$name';
  }

  @override
  String watch_order_source_seasons(String title) {
    return '《$title》的各季';
  }

  @override
  String get watch_order_select_source => '觀看順序來源';

  @override
  String watch_order_season(int number) {
    return '第 $number 季';
  }

  @override
  String watch_order_episode(int number) {
    return '第 $number 集';
  }

  @override
  String get sequels => '續集';

  @override
  String get recommendations_similarity => '相似度：';

  @override
  String recommendation_rating_accessibility(String rating) {
    return '評分 $rating';
  }

  @override
  String get local_folder_structure => '本機資料夾結構';

  @override
  String get local_folder => '本機資料夾';

  @override
  String get add_local_folder => '新增本機資料夾';

  @override
  String get rescan_local_folder => '立即重新掃描所有本機資料夾';

  @override
  String get default_download_destination => '預設下載位置';

  @override
  String get ask_download_destination => '每次下載前詢問位置';

  @override
  String get ask_download_destination_desc => '每次開始下載時選擇本機資料夾。';

  @override
  String get select_download_destination => '選擇下載位置';

  @override
  String get clear_local_library => '清空本機書庫';

  @override
  String get clear_local_library_desc => '從書庫中移除本機資料夾和壓縮包條目。';

  @override
  String get clear_local_library_msg => '這將從書庫中移除本機條目，不會刪除磁碟上的檔案。';

  @override
  String get custom => '自訂';

  @override
  String get no_local_folder_available_for_downloads => '沒有可用於下載的本機資料夾';

  @override
  String failed_to_create_cbz(Object error) {
    return '建立 CBZ 失敗：$error';
  }

  @override
  String error_reading_cover_image(Object error) {
    return '讀取封面出錯：$error';
  }

  @override
  String error_reading_metadata(Object error) {
    return '讀取中繼資料時發生錯誤：$error';
  }

  @override
  String error_saving_chapter_episode_to_library(Object error) {
    return '儲存到書庫時出錯：$error';
  }

  @override
  String error_reading_chapter_cover_image(Object error) {
    return '讀取章節封面出錯：$error';
  }

  @override
  String error_reading_archive_cover_image(Object error) {
    return '讀取壓縮檔封面出錯：$error';
  }

  @override
  String error_getting_local_library(Object error) {
    return '獲取本機書庫時出錯：$error';
  }

  @override
  String get export_metadata => '匯出中繼資料';

  @override
  String get exported => '已匯出';

  @override
  String failed_to_export_metadata(Object error) {
    return '無法匯出中繼資料：$error';
  }

  @override
  String unrecognized_chapter_numbers(Object count) {
    return '有 $count 個章節無法自動編號，可能在閱讀器中缺失或順序錯亂。';
  }

  @override
  String get cloudflare_resolution_webview_server_start_failed =>
      '無法啟動 Cloudflare 驗證用的內建網頁服務。';

  @override
  String tracker_token_expired(Object tracker) {
    return '$tracker 權杖已過期';
  }

  @override
  String get video_list_empty => '影片列表為空';

  @override
  String playback_speed_multiplier(Object value) {
    return '${value}x';
  }

  @override
  String could_not_launch_url(Object url) {
    return '無法開啟 $url';
  }

  @override
  String get text_size => '文字大小：';

  @override
  String get text_align => '文字對齊';

  @override
  String get line_height => '行高';

  @override
  String get show_scroll_percentage => '顯示捲動百分比';

  @override
  String get remove_extra_paragraph_spacing => '刪除額外的段落間距';

  @override
  String select_label_color(Object label) {
    return '選擇 $label 顏色';
  }

  @override
  String get default_user_agent => '預設使用者代理';

  @override
  String get forceLandscapeMode => '強制橫向模式';

  @override
  String get forceLandscapeModeSubtitle => '強制播放器使用橫向顯示。';

  @override
  String get remember_player_volume => '記住音量';

  @override
  String get remember_player_volume_subtitle => '每集都以上一集結束時的音量開始播放。';

  @override
  String get remember_player_brightness => '記住亮度';

  @override
  String get dns_over_https => 'DNS-over-HTTPS (DoH)';

  @override
  String get dns_provider => 'DNS服務供應商';

  @override
  String get tracked => '已追蹤';

  @override
  String get auth_unlock_msg => '驗證以解鎖Mangayomi';

  @override
  String get app_locked => 'Mangayomi已鎖定';

  @override
  String get auth_to_continue => '驗證以繼續';

  @override
  String get authenticating => '正在驗證...';

  @override
  String get lock => '鎖定';

  @override
  String get unlock => '解鎖';

  @override
  String get security => '安全';

  @override
  String get auth_to_change_security_setting => '驗證以更改安全設定';

  @override
  String get app_lock => 'App 鎖定';

  @override
  String get app_lock_delay => '鎖定時機';

  @override
  String get app_lock_delay_immediately => '離開應用時';

  @override
  String app_lock_delay_minutes(int n) {
    return '離開 $n 分鐘後';
  }

  @override
  String get app_lock_delay_launch_only => '僅在應用啟動時';

  @override
  String get secure_screen => '安全螢幕';

  @override
  String get secure_screen_subtitle => '在應用切換器中隱藏應用；在 Android 上還會禁止截圖和錄屏。';

  @override
  String get secure_screen_never => '從不';

  @override
  String get secure_screen_incognito => '隱身模式時';

  @override
  String get secure_screen_always => '始終';

  @override
  String get background_work => '後臺任務';

  @override
  String get background_work_in_progress => '處理中…';

  @override
  String get background_downloading => '下載中';

  @override
  String get background_updating_library => '正在更新圖書館';

  @override
  String get background_restoring => '正在恢復備份';

  @override
  String get background_syncing => '同步中';

  @override
  String get background_cancel_downloads => '取消下載';

  @override
  String get background_stop_update => '停止更新';

  @override
  String get hide_notification_content => '隱藏通知內容';

  @override
  String get hide_notification_content_subtitle => '通知只說明應用正在執行的操作，不顯示作品或章節名稱。';

  @override
  String get require_biometric_or_device_credential => '需要生物識別或裝置憑證才能開啟應用';

  @override
  String get biometric_or_device_credential_not_available => '此裝置上沒有生物識別';

  @override
  String get app_lock_description => '啟用後，每次開啟 App 或從背景返回時，都需要驗證身分。';

  @override
  String get keep_screen_on => '保持螢幕開啟';

  @override
  String get webtoon_side_padding => '長條漫畫的左右留白';

  @override
  String get show_page_gaps => '顯示頁面間隙';

  @override
  String get invert_colors => '反轉顏色';

  @override
  String get grayscale => '灰階';

  @override
  String get brightness => '亮度';

  @override
  String get video_filters => '影片濾鏡';

  @override
  String get video_filter_contrast => '對比度';

  @override
  String get video_filter_saturation => '飽和度';

  @override
  String get video_filter_gamma => '伽馬';

  @override
  String get video_filter_hue => '色相';

  @override
  String get volume => '音量';

  @override
  String get contrast => '對比度';

  @override
  String get saturation => '飽和度';

  @override
  String get navigation_layout => '導覽佈局';

  @override
  String get nav_layout_default => '預設';

  @override
  String get nav_layout_l_shaped => 'L形';

  @override
  String get nav_layout_kindle => 'Kindle';

  @override
  String get nav_layout_edge => '邊緣';

  @override
  String get nav_layout_right_and_left => '右和左';

  @override
  String get nav_layout_disabled => '已停用';

  @override
  String get color_enhancements => '色彩增強';

  @override
  String get total => '總計';

  @override
  String get mean_per_title => '每部作品平均';

  @override
  String get completion_rate => '完成率';

  @override
  String get watching_time => '觀看時間';

  @override
  String get reading_time => '閱讀時間';

  @override
  String average_chapters_per_title(Object title) {
    return '每部作品平均章節數';
  }

  @override
  String get read_percentage => '閱讀百分比';

  @override
  String get entries => '條目';

  @override
  String get android_proxy_server_mihon => 'Android 代理伺服器（Mihon）';

  @override
  String get android_proxy_server_mihon_description =>
      '下載並設定使用 Mihon 擴充套件所需的代理伺服器。';

  @override
  String get mihon_proxy_server => 'Mihon 代理伺服器';

  @override
  String get extension_server_intro_with_jre =>
      '使用 Mihon 擴充套件前，請先下載包含 JRE 與伺服器 JAR 的代理伺服器套裝。';

  @override
  String get extension_server_intro_ios =>
      '使用 Mihon 擴充套件前，請先下載伺服器 JAR。iOS 不需要另外下載 JRE。';

  @override
  String get checking_files => '正在檢查檔案';

  @override
  String get files_installed => '檔案已安裝';

  @override
  String get files_missing => '檔案缺失';

  @override
  String get update_files => '更新檔案';

  @override
  String get up_to_date => '已是最新';

  @override
  String get choose_location => '選擇路徑';

  @override
  String get import_existing_jar => '匯入現有 JAR';

  @override
  String get detect_files_in_selected_folder => '在選定資料夾中檢測檔案';

  @override
  String get preparing_download => '正在準備下載...';

  @override
  String get app_install_location => '應用安裝路徑';

  @override
  String get install_location => '安裝位置';

  @override
  String get jre_executable => 'JRE 可執行檔案';

  @override
  String get extension_server_jar => '擴充套件伺服器 JAR';

  @override
  String get installed_version => '目前版本';

  @override
  String get latest_version => '最新版本';

  @override
  String get m_extension_server_description =>
      '當您需要獨立的 Android 裝置代理時，請使用 M-Extension-Server。在此設定代理地址，並從 GitHub 下載 APK。';

  @override
  String get set_proxy_address => '設定代理地址';

  @override
  String get no_newer_proxy_server_release_available => '沒有可用的新代理伺服器版本。';

  @override
  String get could_not_check_proxy_server_updates => '無法檢查代理伺服器更新。';

  @override
  String get no_extension_server_bundle_available_for_this_platform =>
      '目前平臺沒有可用的擴充套件伺服器包。';

  @override
  String failed_to_download_bundle(Object statusCode) {
    return '下載包失敗 ($statusCode)。';
  }

  @override
  String get downloaded_bundle_missing_expected_files => '下載的項目不包含預期檔案。';

  @override
  String get extension_server_files_ready => '擴充套件伺服器檔案已就緒。';

  @override
  String get ios_extension_server_import_hint =>
      '在 iOS 上，伺服器安裝在應用沙盒內。請使用“匯入現有 JAR”來匯入已下載的檔案。';

  @override
  String get select_extension_server_folder => '選擇擴充套件伺服器資料夾';

  @override
  String get selected_folder_does_not_exist => '選定資料夾不存在。';

  @override
  String get no_extension_server_files_found_in_selected_folder =>
      '在選定資料夾中未找到擴充套件伺服器檔案。';

  @override
  String get extension_server_files_linked => '擴充套件伺服器檔案已連結。';

  @override
  String get select_extension_server_jar => '選擇擴充套件伺服器 JAR';

  @override
  String get selected_file_could_not_be_accessed => '選定檔案無法存取。';

  @override
  String get extension_server_jar_imported => '擴充套件伺服器 JAR 已匯入。';

  @override
  String get could_not_launch_apk_bridge_page => '無法啟動 M-Extension-Server 頁面。';

  @override
  String get proxy_server_ip_hint =>
      '伺服器 IP（例如 10.0.0.5 或 https://example.com）';

  @override
  String get not_configured => '尚未設定';

  @override
  String get zero_interpreter => 'Zero 直譯器';

  @override
  String get zero_interpreter_description => '自動或手動控制 Zero 直譯器服務。';

  @override
  String get start_server_on_launch => '啟動時開啟服務';

  @override
  String get runtime_status => '執行狀態';

  @override
  String get running => '執行中';

  @override
  String get stopped => '已停止';

  @override
  String get start => '啟動';

  @override
  String get stop => '停止';

  @override
  String get webview => '內建網頁';

  @override
  String get tts => '文字轉語音';

  @override
  String get tts_speed => '速度';

  @override
  String get tts_pitch => '音調';

  @override
  String get tts_language => '語言';

  @override
  String get tts_voice => '語音';

  @override
  String get tts_stop => '停止';

  @override
  String get tts_play => '播放';

  @override
  String get tts_pause => '暫停';

  @override
  String get tts_previous => '上一段';

  @override
  String get tts_next => '下一段';

  @override
  String tts_paragraph_progress(Object current, Object total) {
    return '第$current段，共$total段';
  }

  @override
  String get tts_settings => '朗讀設定';

  @override
  String get tts_default => '預設';

  @override
  String get webtoon_disable_zoom_out => 'Webtoon停用縮小';

  @override
  String get webtoon_double_tap_zoom_enabled => 'Webtoon雙擊縮放';

  @override
  String get navigate_to_pan => '導覽前移動已放大影象';

  @override
  String get navigate_to_pan_subtitle => '翻頁前先移動放大的影象';

  @override
  String get split_wide_pages => '拆分雙頁';

  @override
  String get split_tall_images => '分割長圖';

  @override
  String get split_tall_images_subtitle =>
      '條漫：將超高圖片分片顯示，每次只解碼一片，以減少記憶體佔用。不能與「裁剪邊框」同時使用。';

  @override
  String get dual_page_invert => '反轉拆分的半頁';

  @override
  String get dual_page_rotate_to_fit => '旋轉以適應';

  @override
  String get dual_page_rotate_to_fit_invert => '反轉旋轉方向';

  @override
  String get double_page_single_first_page => '首頁單頁顯示';

  @override
  String get double_page_single_first_page_subtitle => '在雙頁模式下單頁顯示第一頁（封面）';

  @override
  String get double_page_auto => '自動雙頁';

  @override
  String get double_page_auto_subtitle => '橫向時自動切換到雙頁模式';

  @override
  String get landscape_zoom => '橫向自動縮放';

  @override
  String get zoom_start_position => '縮放起始位置';

  @override
  String get zoom_start_left => '左';

  @override
  String get zoom_start_right => '右';

  @override
  String get zoom_start_center => '中';

  @override
  String get automatic_background => '自動背景';

  @override
  String get tapping_inversion => '點選反轉';

  @override
  String get tapping_inversion_none => '無';

  @override
  String get tapping_inversion_horizontal => '水平';

  @override
  String get tapping_inversion_vertical => '垂直';

  @override
  String get tapping_inversion_both => '兩者';

  @override
  String get flash_on_page_change => '翻頁時閃爍';

  @override
  String get flash_on_page_change_subtitle => 'AMOLED 防燒屏輔助';

  @override
  String get flash_color => '閃爍顏色';

  @override
  String get flash_color_black => '黑色';

  @override
  String get flash_color_white => '白色';

  @override
  String get flash_color_white_black => '白與黑';

  @override
  String flash_interval(String n) {
    return '閃爍間隔：$n頁';
  }

  @override
  String flash_duration(String n) {
    return '閃爍持續時間：$n毫秒';
  }

  @override
  String get show_navigation_overlay_on_start => '啟動時顯示導覽浮層';

  @override
  String get reader_hide_threshold => '隱藏閱讀器介面的閾值';

  @override
  String get reader_hide_threshold_highest => '最高 (5 px)';

  @override
  String get reader_hide_threshold_high => '高 (13 px)';

  @override
  String get reader_hide_threshold_low => '低 (31 px)';

  @override
  String get reader_hide_threshold_lowest => '最低 (47 px)';

  @override
  String get error_no_pages_available => '錯誤：無可用頁面';

  @override
  String get app_ui_scale => '介面縮放';

  @override
  String get app_ui_scale_subtitle => '根據你的螢幕和觀看距離，使介面更大或更小。';

  @override
  String get allow_concurrent_downloads => '允許同時下載';

  @override
  String get allow_concurrent_downloads_subtitle =>
      '同時從不同來源下載。單個來源仍然一次下載一個章節，因此不會過載。關閉後，可在任何地方一次下載一個。';

  @override
  String get download_delay => '下載延遲';

  @override
  String get download_delay_subtitle => '在章節下載之間加入隨機等待時間，以降低來源網站的負擔。';

  @override
  String get save_search => '儲存搜尋';

  @override
  String get saved_searches => '已儲存的搜尋';

  @override
  String get enter_search_to_save_first => '先輸入搜尋進行儲存';

  @override
  String get no_saved_searches => '此來源還沒有儲存的搜尋。\n執行搜尋，然後選擇\"儲存搜尋\"。';

  @override
  String get source => '來源';

  @override
  String get something_went_wrong => '出錯了';

  @override
  String get startup_failed => 'Mangayomi 無法完成啟動';

  @override
  String sources_with_no_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 個來源沒有搜尋結果',
    );
    return '$_temp0';
  }

  @override
  String get import_mode_title => '如何匯入此備份？';

  @override
  String get import_mode_message => '選擇將此備份合併到目前書庫，還是完全替換目前書庫。';

  @override
  String get import_mode_keep_existing => '合併';

  @override
  String get import_mode_keep_existing_subtitle => '新增新條目並更新匹配條目。不會刪除現有內容。';

  @override
  String get import_mode_replace => '取代';

  @override
  String get import_mode_replace_subtitle => '清空目前書庫並完全替換為備份內容。';

  @override
  String get replace_summary_title => '準備替換書庫';

  @override
  String replace_summary_message(Object currentCount, Object backupCount) {
    return '這將刪除目前的所有條目（$currentCount 項），並替換為備份中的 $backupCount 項。';
  }

  @override
  String get replace_summary_confirm => '取代';

  @override
  String replace_result_message(Object count) {
    return '已將書庫替換為備份中的 $count 個條目。';
  }

  @override
  String get category_conflict_title => '發現已有分類';

  @override
  String get category_conflict_message => '備份中包含書庫中已存在的分類。';

  @override
  String get category_conflict_keep => '保留 — 合併到已有分類';

  @override
  String get category_conflict_delete => '刪除 — 歸為未分類';

  @override
  String get source_conflict_title => '未找到來源';

  @override
  String get source_conflict_message => '備份中的部分來源未安裝相應擴充套件。';

  @override
  String get source_conflict_keep => '保留原名';

  @override
  String get import_summary_title => '準備匯入';

  @override
  String import_summary_message(
    Object newSeries,
    Object updatedSeries,
    Object newChapters,
  ) {
    return '將匯入 $newSeries 個新條目，更新 $updatedSeries 個已有條目，並新增 $newChapters 個章節。';
  }

  @override
  String get import_summary_confirm => '匯入';

  @override
  String import_result_message(
    Object newSeries,
    Object updatedSeries,
    Object newChapters,
  ) {
    return '已匯入 $newSeries 個新條目，更新 $updatedSeries 個條目，新增 $newChapters 個章節。';
  }

  @override
  String get roll_back => '復原';

  @override
  String get roll_back_confirm_message => '將書庫還原至本次變更前的安全快照。';

  @override
  String get roll_back_done => '已還原至變更前的快照。';

  @override
  String get restoring_backup => '正在還原書庫…';

  @override
  String get roll_back_last_change => '復原上次變更';

  @override
  String roll_back_last_change_subtitle(Object date, Object description) {
    return '快照時間：$date — $description';
  }

  @override
  String roll_back_available_count(Object count) {
    return '可復原最近 $count 次變更';
  }

  @override
  String get delete_source_title => '刪除來源及其漫畫';

  @override
  String get delete_source_subtitle => '從書庫中刪除指定來源的所有內容（含章節、下載和歷史紀錄）。';

  @override
  String get delete_source_pick_title => '選擇要刪除的來源';

  @override
  String get delete_source_empty => '書庫中沒有找到來源。';

  @override
  String delete_source_confirm_title(Object sourceName) {
    return '刪除 $sourceName？';
  }

  @override
  String delete_source_confirm_message(
    Object mangaCount,
    Object chapterCount,
    Object historyCount,
    Object updateCount,
  ) {
    return '將永久刪除 $mangaCount 部漫畫、$chapterCount 個章節、$historyCount 筆歷史紀錄及 $updateCount 筆更新紀錄，並保留追蹤連結。完成後只能透過復原功能還原。';
  }

  @override
  String get delete_source_also_remove_extension => '同時解除安裝對應擴充套件';

  @override
  String get delete_source_keep_history => '保留閱讀歷史紀錄';

  @override
  String get delete_source_keep_downloads => '保留下載記錄';

  @override
  String get delete_source_button => '刪除';

  @override
  String delete_source_result_message(Object mangaCount, Object sourceName) {
    return '已從 $sourceName 中刪除 $mangaCount 部漫畫。';
  }

  @override
  String get merge_manga_title => '合併重複漫畫';

  @override
  String get merge_manga_subtitle => '查詢同來源下標題相同的漫畫並進行合併。';

  @override
  String get merge_manga_none_found => '未找到重複漫畫。';

  @override
  String get merge_manga_pick_title => '可能重複的漫畫';

  @override
  String get merge_manga_choose_primary_title => '要合併到哪一部漫畫？';

  @override
  String get merge_manga_choose_primary_message => '其他條目的章節、歷史紀錄和追蹤將合併到所選項中。';

  @override
  String merge_manga_chapters_subtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 章節',
    );
    return '$_temp0';
  }

  @override
  String get merge_manga_button => '合併';

  @override
  String merge_manga_result_message(Object count, Object mangaName) {
    return '已將 $count 部重複漫畫合併到 $mangaName。';
  }

  @override
  String get merge_preview_title => '確認合併';

  @override
  String merge_manga_preview_message(
    Object totalChapters,
    Object duplicateChapters,
    Object keptChapters,
    Object duplicateTracks,
  ) {
    return '其他作品共有 $totalChapters 個章節，其中 $duplicateChapters 個重複章節會保留已有閱讀進度的版本，另新增 $keptChapters 個章節，並移除 $duplicateTracks 個重複的追蹤連結。';
  }

  @override
  String get memory_overlay => '顯示記憶體佔用';

  @override
  String get memory_overlay_subtitle =>
      '即時顯示應用佔用的記憶體。可在捲動書庫或閱讀章節時即時觀察裝置上的記憶體變化。';

  @override
  String get beta => '測試版';

  @override
  String get error_reports => '錯誤報告';

  @override
  String get error_reports_subtitle => '應用捕獲的錯誤及回報入口';

  @override
  String get error_reports_empty => '執行正常，無錯誤記錄。';

  @override
  String get error_reports_likely_cause => '可能原因';

  @override
  String get error_reports_report => '在 GitHub 上回報';

  @override
  String get error_reports_banner => 'Mangayomi 遇到了一個錯誤';

  @override
  String get error_reports_banner_action => '檢視';

  @override
  String get error_reports_copy => '複製';

  @override
  String get error_reports_copied => '已複製到剪貼簿';

  @override
  String get error_reports_clear => '清除';

  @override
  String get error_reports_extension_failure =>
      '此錯誤來自來源擴充套件。請向該套件庫的維護者回報，並附上套件名稱與發生問題的作品資訊。';

  @override
  String get error_reports_already_reported => '已報告';

  @override
  String get error_reports_expected_failure =>
      '這通常與來源網站或網路有關，例如連結失效、伺服器停止服務或連線中斷。如果同一來源在其他地方正常，卻在這裡持續出錯，請回報問題。';

  @override
  String get share_unavailable_copied => '此平臺不支援分享，已複製到剪貼簿。';

  @override
  String get onboarding_title => '歡迎使用 Mangayomi';

  @override
  String get onboarding_language_title => '選擇語言';

  @override
  String get onboarding_language_body => 'Mangayomi 將以此語言顯示。之後可在“外觀”中更改。';

  @override
  String get onboarding_nav_grouped_body =>
      '為每個書庫保留一個標籤頁，或將它們合併到一個“書庫”標籤頁，並將“更新”和“歷史”合併到一個“動態”標籤頁。';

  @override
  String get onboarding_nav_grouped => '合併的標籤頁';

  @override
  String get onboarding_nav_grouped_inside => '每個合併的標籤頁都在其螢幕頂部切換';

  @override
  String get onboarding_libraries_body => '選擇您要閱讀和觀看的內容類型。';

  @override
  String get onboarding_nav_title => '您的書庫';

  @override
  String get onboarding_nav_split => '獨立標籤頁';

  @override
  String get onboarding_next => '下一步';

  @override
  String get onboarding_restore => '還原備份';

  @override
  String get onboarding_or_local => '或使用現有本機檔案';

  @override
  String get onboarding_local_folder => '新增資料夾';

  @override
  String onboarding_local_existing(Object count) {
    return '已設定 $count 個資料夾';
  }

  @override
  String get onboarding_local_any_type => '支援漫畫、動畫及輕小說。';

  @override
  String get onboarding_local_scanning => '正在掃描資料夾';

  @override
  String onboarding_local_found(Object count) {
    return '找到 $count 個作品';
  }

  @override
  String get onboarding_local_remove => '移除該資料夾';

  @override
  String get onboarding_local_in_downloads => '這是應用的下載資料夾。';

  @override
  String get onboarding_local_empty => '找不到內容，請選擇上一層資料夾。';

  @override
  String get onboarding_repo_failed => '無法讀取該套件庫。';

  @override
  String get onboarding_repo_title => '新增來源';

  @override
  String get onboarding_body => '加入套件庫後，即可瀏覽與安裝來源擴充套件。';

  @override
  String get onboarding_add => '新增套件庫';

  @override
  String get onboarding_skip => '暫時跳過';

  @override
  String get onboarding_continue => '繼續';

  @override
  String get onboarding_later => '您可以稍後在“設定 > 瀏覽”中新增。';

  @override
  String get onboarding_replay => '顯示歡迎介面';

  @override
  String get onboarding_replay_subtitle => '重新開啟首次執行的引導設定介面。';

  @override
  String get missing_source_check_title => '檢查缺失來源';

  @override
  String get missing_source_check_subtitle => '找出尚未安裝對應來源套件的書庫作品。';

  @override
  String get missing_source_check_none_found => '書庫中所有條目的來源均已安裝。';

  @override
  String missing_source_check_result_title(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '缺少 $count 個來源',
    );
    return '$_temp0';
  }

  @override
  String global_search_no_sources(String itemType) {
    return '未安裝任何 $itemType 來源。';
  }

  @override
  String get global_search_no_sources_hint => '請在“瀏覽”中新增套件庫並安裝相應的擴充套件。';

  @override
  String global_search_only_pinned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個來源',
    );
    return '您有 $_temp0，但僅會搜尋已固定的來源。';
  }

  @override
  String get global_search_only_pinned_hint => '請固定某個來源，或在瀏覽設定中關閉“僅包含固定的來源”。';

  @override
  String get global_search_all_nsfw => '該分類下的所有來源均被標記為 NSFW 並已被隱藏。';

  @override
  String get global_search_all_nsfw_hint => '請在瀏覽設定中開啟 NSFW 來源後再進行搜尋。';

  @override
  String get missing_source_check_result_message =>
      '這些條目關聯的來源未安裝。點選可進行遷移或安裝對應擴充套件。';

  @override
  String get related_titles => '相關作品';

  @override
  String get related_none => '未找到該作品的相關作品。';

  @override
  String get relation_adaptation => '改編';

  @override
  String get relation_sequel => '續作';

  @override
  String get relation_prequel => '前傳';

  @override
  String get relation_parent => '原作/主線';

  @override
  String get relation_side_story => '外傳';

  @override
  String get relation_spin_off => '衍生作';

  @override
  String get relation_alternative => '平行/替代版本';

  @override
  String get auto_library_update => '書庫自動更新';

  @override
  String get auto_library_update_subtitle => '啟動 App 時，依設定的間隔檢查書庫作品的最新章節。';

  @override
  String get auto_library_update_never => '從不';

  @override
  String get auto_library_update_12_hours => '每 12 小時';

  @override
  String get auto_library_update_daily => '每天';

  @override
  String get auto_library_update_2_days => '每 2 天';

  @override
  String get auto_library_update_weekly => '每週';

  @override
  String get auto_library_update_wifi_only => '僅限 Wi-Fi';

  @override
  String get auto_library_update_wifi_only_subtitle => '使用行動數據時略過排定的更新。';

  @override
  String get library_update_restrictions => '更新時跳過';

  @override
  String get library_update_skip_completed => '已完結的作品';

  @override
  String get library_update_skip_unread => '有未讀章節的作品';

  @override
  String get library_update_skip_not_started => '未開始的作品';

  @override
  String get library_update_restrictions_subtitle =>
      '適用於所有圖書館更新。設為跳過更新的類別，在更新整個圖書館時也會被排除。';

  @override
  String get library_update_restrictions_none => '無';

  @override
  String get padding => '頁面留白';

  @override
  String get page_mode => '翻頁模式';

  @override
  String get single_page => '單頁';

  @override
  String get double_page => '雙頁';

  @override
  String get speed => '速度';

  @override
  String get theme_dark => '深色';

  @override
  String get theme_light => '淺色';

  @override
  String get theme_black => '純黑';

  @override
  String get theme_sepia => '復古';

  @override
  String get decrease => '減少';

  @override
  String get increase => '增加';

  @override
  String get chapter_swipe_actions => '章節滑動操作';

  @override
  String get chapter_swipe_start => '向右滑動';

  @override
  String get chapter_swipe_end => '向左滑動';

  @override
  String get chapter_swipe_toggle_bookmark => '切換書籤';

  @override
  String get chapter_swipe_toggle_read => '切換已讀狀態';

  @override
  String get chapter_swipe_download => '下載';

  @override
  String get chapter_swipe_disabled => '已停用';

  @override
  String get update_errors => '更新錯誤';

  @override
  String get no_update_errors => '沒有更新錯誤';

  @override
  String get clear_all => '全部清除';

  @override
  String get dismiss => '關閉';

  @override
  String get previous_episode => '上一集';

  @override
  String get clear_logs => '清除紀錄';

  @override
  String get bold => '粗體';

  @override
  String get italic => '斜體';

  @override
  String get color_yellow => '黃色';

  @override
  String get color_cyan => '青色';

  @override
  String get color_green => '綠色';

  @override
  String get color_orange => '橘色';

  @override
  String get continue_watching => '繼續觀看';

  @override
  String get search_your_anime => '搜尋你的動畫';

  @override
  String get category => '分類';

  @override
  String get hidden_categories => '已隱藏的分類';

  @override
  String get new_category => '新增分類';

  @override
  String get local => '本機';

  @override
  String get tv_home_rows => '首頁列';

  @override
  String get genre_rows => '依類型顯示的列';

  @override
  String get share_backup_file => '分享 Mangayomi 備份檔案';

  @override
  String get close => '關閉';

  @override
  String get migrate_source => '遷移來源';

  @override
  String get cloudflare_bypass_proxy => 'Cloudflare 驗證代理伺服器';

  @override
  String get custom_doh_url => '自訂 DoH 網址';

  @override
  String get custom_doh_url_helper => '必須是使用 HTTPS、回傳 JSON 格式的 DoH 端點';

  @override
  String get anime_only_tv_layout => '電視介面僅顯示動畫';

  @override
  String get anime_only_beta => '僅動畫（測試版）';

  @override
  String get tv_home_beta => '電視首頁（測試版）';

  @override
  String get tv_player_beta => '電視播放器（測試版）';

  @override
  String get mark_as_read => '標為已讀';

  @override
  String get mark_as_unread => '標為未讀';

  @override
  String get bookmark => '書籤';

  @override
  String get remove_bookmark => '移除書籤';

  @override
  String get mark_below_as_read => '將下方標為已讀';

  @override
  String get previous_chapter => '上一章';

  @override
  String get pin => '固定';

  @override
  String get go_forward => '前進';

  @override
  String get invert_selection => '反選';

  @override
  String get select_between => '選擇之間的內容';

  @override
  String get show_password => '顯示密碼';

  @override
  String get hide_password => '隱藏密碼';

  @override
  String get always_on_top => '視窗置頂';

  @override
  String get mute => '靜音';

  @override
  String get unmute => '取消靜音';

  @override
  String get exit_fullscreen => '退出全屏';

  @override
  String get play => '播放';

  @override
  String get pause => '暫停';

  @override
  String get switch_tracker => '切換追蹤器';

  @override
  String get rename => '重新命名';

  @override
  String get show_category => '顯示分類';

  @override
  String get hide_category => '隱藏分類';

  @override
  String get update_with_library => '隨書庫一起更新';

  @override
  String get skip_updates => '更新書庫時跳過';

  @override
  String get show_repository => '顯示倉庫';

  @override
  String get hide_repository => '隱藏倉庫';

  @override
  String get set_as_default => '設為預設';

  @override
  String get change_display_mode => '更改顯示模式';

  @override
  String get back_to_results => '返回結果';

  @override
  String get activity => '動態';

  @override
  String get group_nav_destinations => '合併導航';

  @override
  String get group_nav_destinations_subtitle =>
      '一個可在漫畫、動畫和小說之間切換的“書庫”標籤，以及一個包含更新和歷史的“動態”標籤';

  @override
  String get search_all_sources => '搜尋所有來源';

  @override
  String get continue_reading => '繼續';

  @override
  String get show_continue_shelf => '顯示正在閱讀的作品';

  @override
  String get show_continue_shelf_subtitle => '在書庫頂部顯示一行進行中的系列';

  @override
  String get excluded => '已排除';

  @override
  String get remove_filter => '移除篩選';

  @override
  String get current_chapter => '當前章節';

  @override
  String get series => '系列';

  @override
  String get chapters_read => '已讀章節';

  @override
  String get search_settings => '搜尋設定';

  @override
  String get search_settings_hint => '輸入設定名稱，或其說明中的一個詞';

  @override
  String reading_mode_for(String name) {
    return '$name 的閱讀模式';
  }

  @override
  String default_is(String name) {
    return '預設：$name';
  }

  @override
  String get use_default => '使用預設';

  @override
  String get is_the_default => '這是你的預設閱讀模式';

  @override
  String get page_layout => '頁面佈局與縮放';

  @override
  String get reader_section_mode_summary => '預設模式、縮放、背景、預載入、全屏';

  @override
  String get reader_section_layout_summary => '寬頁面、雙頁、橫屏縮放';

  @override
  String get reader_section_navigation_summary => '點選區域、佈局、隱藏選單、翻頁閃爍';

  @override
  String get reader_section_swipe_summary => '在列表中滑動章節時的操作';

  @override
  String get all_reader_settings => '所有閱讀器設定';

  @override
  String get undo => '撤銷';

  @override
  String get removed_from_history => '已從歷史中移除';

  @override
  String n_new_chapters(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個新章節',
      one: '1 個新章節',
    );
    return '$_temp0';
  }

  @override
  String get page_color_white => '白色';

  @override
  String get page_color_black => '黑色';

  @override
  String get page_color_night => '夜間';

  @override
  String get page_color_sepia => '棕褐';

  @override
  String get page_color_coffee => '咖啡';

  @override
  String get page_color_silver => '銀色';

  @override
  String get page_color_graphite => '石墨';

  @override
  String get page_color_mist => '薄霧';

  @override
  String get page_color_paper => '紙張';

  @override
  String get page_color_sky => '天空';

  @override
  String get page_color_mint => '薄荷';

  @override
  String get page_color_honey => '蜂蜜';

  @override
  String next_episode_in(int seconds) {
    return '$seconds 秒後播放下一集';
  }

  @override
  String get stay_on_this_episode => '停留在本集';

  @override
  String get got_it => '知道了';

  @override
  String get gesture_brightness => '在左側上下滑動調節亮度';

  @override
  String get gesture_volume => '在右側上下滑動調節音量';

  @override
  String get gesture_double_tap_skip => '雙擊一側可後退或快進';

  @override
  String get gesture_drag_seek => '左右拖動以調整播放位置';

  @override
  String get gesture_long_press_speed => '長按加速播放';

  @override
  String get tap_to_continue => '點按任意位置繼續';

  @override
  String get empty_library_hint => '在“瀏覽”中找到系列並新增到書庫。';

  @override
  String get more_filters => '更多篩選';

  @override
  String get resume_all_downloads => '繼續所有下載';

  @override
  String get download_failed => '下載失敗';

  @override
  String get download_all => '全部下載';

  @override
  String n_chapters_queued(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 章已加入佇列',
      one: '1 章已加入佇列',
    );
    return '$_temp0';
  }

  @override
  String n_selected(int count) {
    return '已選擇 $count 項';
  }

  @override
  String get settings_general_summary => '語言、書庫更新、網路';

  @override
  String get settings_appearance_summary => '主題、調色盤、導航、字型';

  @override
  String get settings_novel_reader_summary => '字型、頁面顏色、朗讀';

  @override
  String get settings_player_summary => '播放、字幕、音訊、解碼器';

  @override
  String get settings_downloads_summary => '位置、僅限 Wi-Fi、同時下載';

  @override
  String get settings_tracking_summary => 'MyAnimeList、AniList、Kitsu 等';

  @override
  String get settings_syncing_summary => '在你自己的伺服器上同步進度';

  @override
  String get settings_browse_summary => '擴充套件、倉庫、來源';

  @override
  String get settings_security_summary => '應用鎖';

  @override
  String get settings_about_summary => '版本、更新、錯誤報告';

  @override
  String minutes_left(int minutes) {
    return '約剩 $minutes 分鐘';
  }

  @override
  String get group_playback => '播放';

  @override
  String get group_subtitles => '字幕';

  @override
  String get group_screen => '螢幕';

  @override
  String get aniskip => 'AniSkip';

  @override
  String seconds_short(int n) {
    return '$n 秒';
  }

  @override
  String unknown_language_codes(String codes) {
    return '未知語言程式碼：$codes';
  }

  @override
  String get group_network => '網路';

  @override
  String get group_discord => 'Discord';

  @override
  String invalid_url(String scheme) {
    return '請輸入以 $scheme 開頭的網址';
  }

  @override
  String get group_cleanup => '清理';

  @override
  String remove_entries_confirm(int n) {
    return '要移除 $n 個條目及其歷史嗎？此操作無法撤銷。';
  }

  @override
  String get group_library_maintenance => '書庫維護';

  @override
  String get group_diagnostics => '診斷';

  @override
  String get update_no_notes => '沒有發行說明。';

  @override
  String update_download_failed(String error) {
    return '下載失敗：$error';
  }

  @override
  String get update_network_error => '下載時發生網路錯誤。';

  @override
  String get update_write_failed => '無法寫入 APK 檔案。';

  @override
  String get update_later => '稍後';

  @override
  String get update_installed_version => '已安裝';

  @override
  String get update_new_version => '新版本';

  @override
  String update_published(String date) {
    return '釋出於 $date';
  }

  @override
  String get update_pre_release => '預釋出版';

  @override
  String get update_notes_features => '新功能';

  @override
  String get update_notes_fixes => '修復';

  @override
  String get update_notes_other => '改進';

  @override
  String get update_hint_install => '應用會下載更新，然後 Android 會請你確認安裝。你的書庫不會改變。';

  @override
  String get update_hint_browser => '釋出頁面將在瀏覽器中開啟：請從那裡下載適合你係統的檔案，然後安裝。';

  @override
  String get update_downloading => '正在下載…';

  @override
  String get update_installing => '正在開啟安裝程式…';

  @override
  String get update_install_failed => '無法開啟安裝程式。';

  @override
  String get update_browser_failed => '無法開啟瀏覽器。';

  @override
  String get deselect_all => '取消全選';

  @override
  String update_failed_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個條目無法更新',
      one: '1 個條目無法更新',
    );
    return '$_temp0';
  }

  @override
  String get sort_ascending => '升序';

  @override
  String get sort_descending => '降序';

  @override
  String get not_downloaded => '未下載';

  @override
  String n_tracked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '正在追蹤 $count 個條目',
      one: '正在追蹤 1 個條目',
      zero: '尚未追蹤任何條目',
    );
    return '$_temp0';
  }

  @override
  String get no_tracker_connected => '未連線追蹤器';

  @override
  String get no_tracker_connected_message => '在 設定 › 追蹤 中登入服務後，其列表會顯示在這裡。';

  @override
  String get edit_metadata => '編輯後設資料';

  @override
  String get group_modes => '模式';

  @override
  String get group_app => '應用';

  @override
  String get group_sources_services => '來源與服務';

  @override
  String n_sources(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個來源',
      one: '1 個來源',
      zero: '沒有來源',
    );
    return '$_temp0';
  }

  @override
  String get tv_player_beta_subtitle => '開啟：為電視遙控器設計的播放器。關閉：原來的播放器。';

  @override
  String get anime_only_beta_subtitle => '在整個應用中隱藏漫畫和小說。關閉即可顯示全部。';

  @override
  String download_queue_start_failed(String error) {
    return '無法啟動下載佇列：$error';
  }

  @override
  String get group_interface => '介面';

  @override
  String get group_navigation => '導航';

  @override
  String get tv_home_beta_subtitle => '按行排列的動畫主頁（繼續觀看、新劇集、分類），代替平鋪網格';

  @override
  String get cloudflare_bypass_proxy_hint => '可選的 FlareSolverr 或 Byparr 地址';

  @override
  String get cloudflare_bypass_proxy_message =>
      'FlareSolverr 或 Byparr 端點。留空即關閉。';

  @override
  String get group_explore => '探索';

  @override
  String get explore_recommendations_subtitle => '與此類似的作品';

  @override
  String get explore_related_subtitle => '其改編、衍生作品和其他版本';

  @override
  String get explore_watch_order_subtitle => '觀看完整故事的順序';

  @override
  String get explore_sequels_subtitle => '來自追蹤器的後續作品';

  @override
  String get tap_zone_menu => '選單';

  @override
  String get tap_zone_previous => '上一頁';

  @override
  String get tap_zone_next => '下一頁';

  @override
  String get back_to_series => '返回系列';

  @override
  String get keyboard_shortcuts => '鍵盤快捷鍵';

  @override
  String get shortcut_previous_page => '上一頁';

  @override
  String get shortcut_next_page => '下一頁';

  @override
  String get shortcut_toggle_bars => '顯示或隱藏欄';

  @override
  String get shortcut_zoom_in => '放大';

  @override
  String get shortcut_zoom_out => '縮小';

  @override
  String get shortcut_zoom_reset => '適應頁面';

  @override
  String get shortcut_wheel_zoom => '用滑鼠縮放';

  @override
  String get mouse_wheel => '滾輪';

  @override
  String get shortcut_leave => '退出閱讀器';

  @override
  String get shortcut_show => '顯示這些快捷鍵';

  @override
  String get color_red => '紅色';

  @override
  String get color_blue => '藍色';

  @override
  String get color_opacity => '不透明度';

  @override
  String get volume_keys_paging => '用音量鍵翻頁';

  @override
  String get volume_keys_paging_ios => '閱讀時音量保持在一半，以便兩個按鍵都能使用，離開時恢復原樣。';

  @override
  String get volume_keys_inverted => '反轉音量鍵';

  @override
  String get reader_orientation => '螢幕方向';

  @override
  String get orientation_free => '跟隨裝置';

  @override
  String get orientation_portrait => '豎屏';

  @override
  String get orientation_landscape => '橫屏';

  @override
  String get screen_brightness => '螢幕亮度';

  @override
  String get screen_brightness_system => '跟隨系統';

  @override
  String get shortcut_play_pause => '播放或暫停';

  @override
  String shortcut_seek_back(int n) {
    return '後退 $n 秒';
  }

  @override
  String shortcut_seek_forward(int n) {
    return '前進 $n 秒';
  }

  @override
  String get shortcut_volume_up => '調高音量';

  @override
  String get shortcut_volume_down => '調低音量';

  @override
  String get shortcut_mute => '靜音或取消靜音';

  @override
  String shortcut_skip_intro(int n) {
    return '跳過片頭（$n 秒）';
  }

  @override
  String get shortcut_previous_frame => '上一幀';

  @override
  String get shortcut_next_frame => '下一幀';

  @override
  String get shortcut_shaders => 'Anime4K 著色器';

  @override
  String get shortcut_shaders_off => '關閉著色器';

  @override
  String get autoplay_next_on => '自動播放下一集：開';

  @override
  String get autoplay_next_off => '自動播放下一集：關';

  @override
  String get autoplay_next => '自動播放下一集';

  @override
  String get next_episode_short => '下一集';

  @override
  String get subtitle_preview_sample => '旅程仍在繼續。';

  @override
  String get text_style => '樣式';

  @override
  String get code_editor => '程式碼編輯器';

  @override
  String get code_view_code => '程式碼';

  @override
  String get code_view_test => '測試';

  @override
  String get code_view_console => '控制檯';

  @override
  String get code_function => '函式';

  @override
  String get code_page => '頁碼';

  @override
  String get code_query => '查詢';

  @override
  String get code_url => 'URL';

  @override
  String get code_html => 'HTML';

  @override
  String get code_execute => '執行';

  @override
  String get code_executing => '正在執行…';

  @override
  String get code_no_result => '暫無結果';

  @override
  String get code_no_result_message => '執行一個函式，檢視它返回的內容。';

  @override
  String get code_console => '控制檯';

  @override
  String get code_no_logs => '暫無日誌';

  @override
  String get tv_empty_anime_library => '動畫書庫尚無作品';

  @override
  String get tv_empty_anime_library_hint => '從“瀏覽”新增動畫來充實你的主頁';

  @override
  String get browse_anime => '瀏覽動畫';

  @override
  String get no_episodes_yet => '暫無劇集';

  @override
  String get filler => '填充集';

  @override
  String get obsolete => '已過時';

  @override
  String every_n_days(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '每 $n 天',
      one: '每天',
    );
    return '$_temp0';
  }

  @override
  String get update_interval_unknown => '無法估計';

  @override
  String get group_reading => '閱讀';

  @override
  String get group_reading_watching => '閱讀與觀看';

  @override
  String get novel_reader => '小說閱讀器';

  @override
  String get all_languages => '所有語言';

  @override
  String get custom_dns_title => '自定義 DNS';

  @override
  String get custom_dns_system => '系統 DNS';

  @override
  String get calendar_format_month => '月';

  @override
  String get calendar_format_two_weeks => '兩週';

  @override
  String get calendar_format_week => '周';

  @override
  String get read_count => '已讀';

  @override
  String get watched_count => '已看';

  @override
  String get source_code_error_title => '此來源的程式碼未能執行';

  @override
  String source_code_error_failed(String what) {
    return '$what 失敗：介面已改用備用值，以便繼續使用';
  }

  @override
  String get copy_error => '複製';

  @override
  String get error_copied => '已複製錯誤';

  @override
  String get no_categories_yet => '還沒有分類';

  @override
  String get no_categories_yet_message => '用你自己命名和排序的分類來整理書庫。';

  @override
  String get settings_keyboard_shortcuts_summary => '更改閱讀器和播放器的按鍵';

  @override
  String get shortcut_reset_all => '重置所有快捷鍵';

  @override
  String get shortcut_press_key => '請按一個鍵…';

  @override
  String shortcut_key_in_use(String action) {
    return '已被佔用：$action';
  }

  @override
  String get external_browser => '開啟外部連結的方式';

  @override
  String get system_default => '系統預設';

  @override
  String get no_browsers_detected => '未檢測到瀏覽器';

  @override
  String get on_this_device => '在此裝置上';

  @override
  String get local_tracking => '在此裝置上追蹤';

  @override
  String get local_tracking_desc =>
      '無需賬號，在此儲存每部作品的狀態、進度、評分和日期。不會傳送任何內容。關閉後，已儲存的內容仍會保留。';

  @override
  String get track_add_one => '再加一個';

  @override
  String get track_change_match => '更改匹配';

  @override
  String get track_remove => '停止追蹤';

  @override
  String get track_remove_local_msg => '其狀態、進度、評分和日期將從此裝置刪除。';

  @override
  String track_remove_online_msg(String tracker) {
    return '該條目仍保留在 $tracker 上：這裡只移除它與此作品的關聯。';
  }

  @override
  String update_from_repo(String repo) {
    return '來自 $repo';
  }

  @override
  String get update_from_other_repo => '要從其他儲存庫更新嗎？';

  @override
  String update_from_other_repo_msg(
    String name,
    String origin,
    String version,
    String other,
  ) {
    return '$name 是從 $origin 安裝的。版本 $version 來自 $other：安裝後，$name 將從 $other 獲取更新。請僅在信任該儲存庫時繼續。';
  }

  @override
  String get update_all_foreign => '部分更新來自其他儲存庫';

  @override
  String get update_all_foreign_msg => '更新後，這些擴充套件將從新儲存庫獲取更新。請僅在信任它時才包含。';

  @override
  String get update_all_skip_foreign => '僅來自其原有儲存庫';

  @override
  String get comments => '評論';

  @override
  String get onboarding_nav_body => '可以為每種類型設定獨立標籤頁，或合併在一個“書庫”標籤頁中。';

  @override
  String get onboarding_nav_merged => '統一書庫標籤頁';

  @override
  String get onboarding_nav_inside => '點選“書庫”可在各類型間切換';

  @override
  String get execute_action => '執行';

  @override
  String get adult_content => '成人內容（18+）';

  @override
  String get source_updated_successfully => '來源已更新';

  @override
  String get all_items => '全部';

  @override
  String get no_hidden_categories => '沒有已隱藏的分類';

  @override
  String category_hidden_hint(String name) {
    return '已隱藏「$name」。在「全部」上長按確認鍵可取消隱藏。';
  }

  @override
  String get tv_empty_anime_hint => '到「瀏覽」加入動畫，即可顯示於首頁。';

  @override
  String get tv_home_layout_description => '以分列方式顯示繼續觀看、最新集數及分類。';

  @override
  String get anime_only_layout_description => '隱藏漫畫與小說書庫（電視介面預設啟用）。';

  @override
  String get anime_only_browse_description => '隱藏 App 中的漫畫與小說內容，關閉即可顯示全部。';

  @override
  String get tv_player_layout_description => '開啟時使用電視播放器，關閉時使用原本的桌面播放器。';

  @override
  String get cloudflare_proxy_helper => 'FlareSolverr／Byparr 端點，留空即可停用。';

  @override
  String get resolve_challenge => '完成驗證';

  @override
  String get resolve_cloudflare_challenge => '完成 Cloudflare 驗證';

  @override
  String get details => '詳細資訊';

  @override
  String skip_seconds(String seconds) {
    return '$seconds 秒';
  }

  @override
  String get subtitle_rating => '評分：';

  @override
  String get subtitle_votes => '投票數：';

  @override
  String get subtitle_date => '日期：';

  @override
  String get backup_created => '備份已建立！';

  @override
  String backup_failed(String error) {
    return '備份失敗：$error';
  }

  @override
  String get backup_restored => '備份已還原！';

  @override
  String get backup_unsupported => '不支援或無法辨識此備份檔案。';

  @override
  String restore_sync_upload_failed(String error) {
    return '備份已還原，但上傳至同步伺服器失敗：$error。伺服器仍保留上次成功同步的資料。';
  }

  @override
  String source_delete_failed(String error) {
    return '無法刪除來源：$error';
  }

  @override
  String manga_merge_failed(String error) {
    return '無法合併漫畫：$error';
  }

  @override
  String download_queue_failed(String error) {
    return '無法啟動下載佇列：$error';
  }

  @override
  String cover_too_large(String size) {
    return '封面超過 5 MB（$size MB），已略過此封面。';
  }

  @override
  String library_update_failed(int count) {
    return '有 $count 部作品更新失敗';
  }

  @override
  String get memory_waiting_sample => '記憶體：等待取樣';

  @override
  String memory_rss(String value, String peak) {
    return '使用量 $value・峰值 $peak';
  }

  @override
  String memory_image_cache(String value, String maximum, String peak) {
    return '圖片快取 $value／$maximum・峰值 $peak';
  }

  @override
  String memory_cached_items(int count, int maximum, int live, int peak) {
    return '圖片數 $count／$maximum・使用中 $live・峰值 $peak';
  }

  @override
  String memory_cache_pressure(String percentage, int samples) {
    return '$samples 次取樣中，快取已滿佔 $percentage%';
  }

  @override
  String get memory_reset_hint => '在設定中關閉後重新開啟，即可重設';

  @override
  String get hide_action => '隱藏';
}
