/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : onethink

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2014-02-17 16:28:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for onethink_action
-- ----------------------------
DROP TABLE IF EXISTS `onethink_action`;
CREATE TABLE `onethink_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of onethink_action
-- ----------------------------
INSERT INTO `onethink_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `onethink_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `onethink_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `onethink_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `onethink_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '1', '1383285551');
INSERT INTO `onethink_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `onethink_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `onethink_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `onethink_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '0', '1383296301');
INSERT INTO `onethink_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `onethink_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '0', '1383296765');

-- ----------------------------
-- Table structure for onethink_action_log
-- ----------------------------
DROP TABLE IF EXISTS `onethink_action_log`;
CREATE TABLE `onethink_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of onethink_action_log
-- ----------------------------
INSERT INTO `onethink_action_log` VALUES ('140', '1', '1', '2130706433', 'member', '1', 'admin在2014-02-12 19:52登录了后台', '1', '1392205950');
INSERT INTO `onethink_action_log` VALUES ('141', '6', '1', '2130706433', 'config', '13', '操作url：/Admin/Config/edit', '1', '1392212877');
INSERT INTO `onethink_action_log` VALUES ('142', '1', '1', '2130706433', 'member', '1', 'admin在2014-02-15 11:57登录了后台', '1', '1392436663');
INSERT INTO `onethink_action_log` VALUES ('143', '1', '1', '2130706433', 'member', '1', 'admin在2014-02-16 00:18登录了后台', '1', '1392481089');

-- ----------------------------
-- Table structure for onethink_addons
-- ----------------------------
DROP TABLE IF EXISTS `onethink_addons`;
CREATE TABLE `onethink_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of onethink_addons
-- ----------------------------
INSERT INTO `onethink_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"2\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `onethink_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `onethink_addons` VALUES ('22', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1390978417', '0');
INSERT INTO `onethink_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `onethink_addons` VALUES ('24', 'Comment', '评论', '用于各种类型文档评论', '1', 'null', 'Wolixli', '0.1', '1391092185', '1');
INSERT INTO `onethink_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `onethink_addons` VALUES ('21', 'QiuBai', '糗事百科', '读别人的糗事，娱乐自己', '1', '{\"title\":\"\\u7cd7\\u4e8b\\u767e\\u79d1\",\"width\":\"2\",\"display\":\"1\",\"cache_time\":\"60\",\"mulimages\":\"1\"}', 'thinkphp', '0.1', '1390529296', '0');
INSERT INTO `onethink_addons` VALUES ('25', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '0', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"90040\",\"mulimages\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_form_pos_duoshuo\":\"buttom\",\"comment_data_list_duoshuo\":\"10\",\"comment_data_order_duoshuo\":\"asc\"}', 'thinkphp', '0.1', '1391765001', '0');
INSERT INTO `onethink_addons` VALUES ('26', 'Ping', '文章发布ping插件', '用于发布文档后的主动ping，主动增加收录', '0', '{\"site_name\":\"\\u535a\\u5ba2\",\"site_url\":\"blog.cn\",\"update_url\":\"Archive\\/@blog.cn\",\"update_rss\":\"feed@blog.cn\"}', 'yangweijie', '0.1', '1392009365', '0');
INSERT INTO `onethink_addons` VALUES ('27', 'ReturnTop', '返回顶部', '回到顶部美化，随机或指定显示，100款样式，每天一种换，天天都用新样式', '1', '{\"random\":\"0\",\"current\":\"2\"}', 'thinkphp', '0.1', '1392009776', '0');
INSERT INTO `onethink_addons` VALUES ('30', 'Timeline', '工作时间轴', '个人工作经历时间轴展示', '1', '{\"random\":\"1\"}', 'yangweijie', '0.1', '1392554843', '1');
INSERT INTO `onethink_addons` VALUES ('31', 'Bookshell', '书架', '专门展示文档书籍的', '1', '{\"random\":\"1\"}', 'yangweijie', '0.1', '1392561469', '1');

-- ----------------------------
-- Table structure for onethink_attachment
-- ----------------------------
DROP TABLE IF EXISTS `onethink_attachment`;
CREATE TABLE `onethink_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of onethink_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_attribute
-- ----------------------------
DROP TABLE IF EXISTS `onethink_attribute`;
CREATE TABLE `onethink_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of onethink_attribute
-- ----------------------------
INSERT INTO `onethink_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1390968266', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '1', '', '1', '1:文章\r\n2:单独页面', '1', '0', '1', '1391047439', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '0', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1390968172', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('33', 'tags', '标签', 'text NOT NULL', 'textarea', '', '', '0', '', '2', '0', '1', '1391000945', '1391000945', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `onethink_attribute` VALUES ('34', 'title', '标题', 'varchar(200) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1391049624', '1391049096', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('35', 'name', '缩略名', 'varchar(200) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1391049611', '1391049096', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('36', 'description', '描述', 'varchar(200) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1391049592', '1391049096', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('37', 'count', '数量', 'int(10) unsigned NULL ', 'string', '0', '文章关联的数量', '1', '', '4', '0', '1', '1391049580', '1391049096', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('38', 'order', '排序', 'int(10) unsigned NULL ', 'string', '0', '', '1', '', '4', '0', '1', '1391049554', '1391049096', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('39', 'name', '原始文件名', 'char(30) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('40', 'savename', '保存名称', 'char(20) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('41', 'savepath', '文件保存路径', 'char(30) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('42', 'ext', '文件后缀', 'char(5) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('43', 'mime', '文件mime类型', 'char(40) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('44', 'size', '文件大小', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('45', 'md5', '文件md5', 'char(32) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('46', 'sha1', '文件 sha1编码', 'char(40) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('47', 'location', '文件保存位置', 'tinyint(3) unsigned NOT NULL ', 'string', '0', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('48', 'create_time', '上传时间', 'int(10) unsigned NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1391133228', '1391133228', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for onethink_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `onethink_auth_extend`;
CREATE TABLE `onethink_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of onethink_auth_extend
-- ----------------------------
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for onethink_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `onethink_auth_group`;
CREATE TABLE `onethink_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_auth_group
-- ----------------------------
INSERT INTO `onethink_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `onethink_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- ----------------------------
-- Table structure for onethink_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `onethink_auth_group_access`;
CREATE TABLE `onethink_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `onethink_auth_rule`;
CREATE TABLE `onethink_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`module`,`name`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_auth_rule
-- ----------------------------
INSERT INTO `onethink_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('6', 'admin', '1', 'Admin/Index/index', '首页', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');

-- ----------------------------
-- Table structure for onethink_bookshell
-- ----------------------------
DROP TABLE IF EXISTS `onethink_bookshell`;
CREATE TABLE `onethink_bookshell` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL COMMENT '标题',
  `author` char(20) NOT NULL COMMENT '作者',
  `description` char(140) NOT NULL COMMENT '描述',
  `link_id` int(10) unsigned NOT NULL COMMENT '外链id',
  `cover_id` int(10) NOT NULL COMMENT '封面',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_bookshell
-- ----------------------------
INSERT INTO `onethink_bookshell` VALUES ('1', 'git - 简易指南', '罗杰·杜德勒', '帮助你快速使用git的指南，包含多国语言', '3', '26', '1392604675');

-- ----------------------------
-- Table structure for onethink_category
-- ----------------------------
DROP TABLE IF EXISTS `onethink_category`;
CREATE TABLE `onethink_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of onethink_category
-- ----------------------------
INSERT INTO `onethink_category` VALUES ('1', 'blog', '默认分类', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1391043811', '1', '0');
INSERT INTO `onethink_category` VALUES ('2', 'default_blog', '博客', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1391043816', '1', '31');

-- ----------------------------
-- Table structure for onethink_channel
-- ----------------------------
DROP TABLE IF EXISTS `onethink_channel`;
CREATE TABLE `onethink_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_channel
-- ----------------------------
INSERT INTO `onethink_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `onethink_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `onethink_channel` VALUES ('3', '0', '官网', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for onethink_comment
-- ----------------------------
DROP TABLE IF EXISTS `onethink_comment`;
CREATE TABLE `onethink_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0',
  `model_id` int(11) unsigned NOT NULL DEFAULT '0',
  `cid` int(11) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  `digg` int(11) unsigned NOT NULL DEFAULT '0',
  `com_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '评论IP',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `uid` int(10) unsigned DEFAULT NULL,
  `uname` varchar(200) DEFAULT NULL,
  `uemail` varchar(200) DEFAULT NULL,
  `uurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `model_id` (`model_id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_comment
-- ----------------------------
INSERT INTO `onethink_comment` VALUES ('1', '0', '2', '2', 'qweqwe', '1', '2130706433', '1391604570', '1', '0', '123', '917647288@qq.com', '');

-- ----------------------------
-- Table structure for onethink_config
-- ----------------------------
DROP TABLE IF EXISTS `onethink_config`;
CREATE TABLE `onethink_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` longtext NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_config
-- ----------------------------
INSERT INTO `onethink_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'OneThink内容管理框架', '1');
INSERT INTO `onethink_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'OneThink内容管理框架', '2');
INSERT INTO `onethink_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP,OneThink', '3');
INSERT INTO `onethink_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '5');
INSERT INTO `onethink_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '10');
INSERT INTO `onethink_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '10');
INSERT INTO `onethink_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '6');
INSERT INTO `onethink_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '7');
INSERT INTO `onethink_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'typecho_color:仿typecho', '后台颜色风格', '1379122533', '1392212877', '1', 'typecho_color', '10');
INSERT INTO `onethink_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:评论\r\n3:阅读\r\n4:站点框架\r\n5:个人设置', '8');
INSERT INTO `onethink_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '9');
INSERT INTO `onethink_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '5');
INSERT INTO `onethink_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '7');
INSERT INTO `onethink_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '5', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1392017874', '1', '60', '10');
INSERT INTO `onethink_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '5', '', '后台数据每页显示记录数', '1379503896', '1392017862', '1', '10', '10');
INSERT INTO `onethink_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '4');
INSERT INTO `onethink_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '1', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1390906341', '1', 'ambiance', '6');
INSERT INTO `onethink_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `onethink_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '4');
INSERT INTO `onethink_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '8');
INSERT INTO `onethink_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `onethink_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `onethink_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '9');
INSERT INTO `onethink_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '4');
INSERT INTO `onethink_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '10');
INSERT INTO `onethink_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `onethink_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1390274668', '1', '1', '10');
INSERT INTO `onethink_config` VALUES ('38', 'VERIFY', '4', '开启验证码', '1', '0:关闭,1:开启', '', '1390611680', '1391997526', '1', '0', '5');
INSERT INTO `onethink_config` VALUES ('41', 'FRONT_THEME', '1', '前台主题', '0', '', '前台主题配置，覆盖系统文件', '1392108077', '1392108077', '1', 'default', '0');
INSERT INTO `onethink_config` VALUES ('40', 'FEEDFULLTEXT', '4', '聚合全文输出', '3', '0:仅输出摘要,1:全文输出', '如果你不希望在聚合中输出文章全文,请使用仅输出摘要选项.\r\n摘要的文字来自description字段，此字段无内容就截取前200个字符.', '1391997436', '1391997436', '1', '1', '0');

-- ----------------------------
-- Table structure for onethink_contents
-- ----------------------------
DROP TABLE IF EXISTS `onethink_contents`;
CREATE TABLE `onethink_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `modified` int(10) unsigned DEFAULT '0',
  `text` text,
  `order` int(10) unsigned DEFAULT '0',
  `authorId` int(10) unsigned DEFAULT '0',
  `template` varchar(32) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'post',
  `status` varchar(16) DEFAULT 'publish',
  `password` varchar(32) DEFAULT NULL,
  `commentsNum` int(10) unsigned DEFAULT '0',
  `allowComment` char(1) DEFAULT '0',
  `allowPing` char(1) DEFAULT '0',
  `allowFeed` char(1) DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  `cid` int(10) unsigned DEFAULT '0' COMMENT '分类id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created` (`created`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of onethink_contents
-- ----------------------------
INSERT INTO `onethink_contents` VALUES ('1', '欢迎使用 Typecho', 'start', '1390574404', '1390574404', '<!--markdown-->如果您看到这篇文章,表示您的 blog 已经安装成功.', '0', '1', '', 'post', 'publish', '', '1', '1', '1', '1', '0', '0');
INSERT INTO `onethink_contents` VALUES ('2', '关于', 'start-page', '1390574404', '1390574404', '<!--markdown-->本页面由 Typecho 创建, 这只是个测试页面.', '0', '1', '', 'page', 'publish', '', '0', '1', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for onethink_document
-- ----------------------------
DROP TABLE IF EXISTS `onethink_document`;
CREATE TABLE `onethink_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`type`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of onethink_document
-- ----------------------------
INSERT INTO `onethink_document` VALUES ('1', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '1', '0', '0', '1', '1', '0', '0', '32', '0', '0', '0', '1387260660', '1390638860', '1');
INSERT INTO `onethink_document` VALUES ('2', '1', 'document_center', '文档中心', '1', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '61', '0', '0', '0', '1391043840', '1392447774', '1');
INSERT INTO `onethink_document` VALUES ('3', '1', '', '123123', '1', '', '0', '0', '2', '1', '0', '0', '0', '1', '0', '0', '5', '0', '0', '0', '1391045400', '1392009535', '1');
INSERT INTO `onethink_document` VALUES ('4', '1', 'experienc', '个人经历', '1', '个人经历的展示', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '12', '0', '0', '0', '1392549480', '1392549662', '1');

-- ----------------------------
-- Table structure for onethink_document_article
-- ----------------------------
DROP TABLE IF EXISTS `onethink_document_article`;
CREATE TABLE `onethink_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `tags` text NOT NULL COMMENT '标签',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of onethink_document_article
-- ----------------------------
INSERT INTO `onethink_document_article` VALUES ('1', '0', '<img src=\"/Uploads/Editor/2014-01-24/52e1d78da828b.jpg\" alt=\"\" />\r\n<h1>\r\n  OneThink1.0正式版发布 \r\n</h1>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n <strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。 </strong> \r\n</p>\r\n<h2>\r\n  主要特性：\r\n</h2>\r\n<p>\r\n 1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n  2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。 \r\n</p>\r\n<p>\r\n  3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n  4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。 \r\n</p>\r\n<p>\r\n 5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n 6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n 7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n 8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。 \r\n</p>\r\n<p>\r\n  9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。 \r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n <strong> OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。 </strong> \r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h2>\r\n  后台主要功能：\r\n</h2>\r\n<p>\r\n 1. 用户Passport系统\r\n</p>\r\n<p>\r\n  2. 配置管理系统 \r\n</p>\r\n<p>\r\n 3. 权限控制系统\r\n</p>\r\n<p>\r\n  4. 后台建模系统 \r\n</p>\r\n<p>\r\n 5. 多级分类系统 \r\n</p>\r\n<p>\r\n 6. 用户行为系统 \r\n</p>\r\n<p>\r\n 7. 钩子和插件系统\r\n</p>\r\n<p>\r\n 8. 系统日志系统 \r\n</p>\r\n<p>\r\n 9. 数据备份和还原\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n  [ 官方下载： <a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>  开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a> ] \r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n <strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0', '');
INSERT INTO `onethink_document_article` VALUES ('2', '2', '# 测试内容', 'Single/shell', '0', '');
INSERT INTO `onethink_document_article` VALUES ('3', '2', '# 测试分类', '', '0', '测试分类,今天');
INSERT INTO `onethink_document_article` VALUES ('4', '2', '#', 'Single/timeline', '0', '');

-- ----------------------------
-- Table structure for onethink_document_download
-- ----------------------------
DROP TABLE IF EXISTS `onethink_document_download`;
CREATE TABLE `onethink_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of onethink_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_fields
-- ----------------------------
DROP TABLE IF EXISTS `onethink_fields`;
CREATE TABLE `onethink_fields` (
  `cid` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` varchar(8) DEFAULT 'str',
  `str_value` text,
  `int_value` int(10) DEFAULT '0',
  `float_value` float DEFAULT '0',
  PRIMARY KEY (`cid`,`name`),
  KEY `int_value` (`int_value`),
  KEY `float_value` (`float_value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of onethink_fields
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_file
-- ----------------------------
DROP TABLE IF EXISTS `onethink_file`;
CREATE TABLE `onethink_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of onethink_file
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_hooks
-- ----------------------------
DROP TABLE IF EXISTS `onethink_hooks`;
CREATE TABLE `onethink_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `搜索索引` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_hooks
-- ----------------------------
INSERT INTO `onethink_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `onethink_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `onethink_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `onethink_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,Comment,SocialComment');
INSERT INTO `onethink_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `onethink_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment,Ping');
INSERT INTO `onethink_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', '');
INSERT INTO `onethink_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `onethink_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1392170084', 'SiteStat,SystemInfo,DevTeam,QiuBai');
INSERT INTO `onethink_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', '');
INSERT INTO `onethink_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');
INSERT INTO `onethink_hooks` VALUES ('17', 'sidebar', '前台首页侧边栏', '1', '1391602065', 'Comment');
INSERT INTO `onethink_hooks` VALUES ('18', 'single', '单页面专门用的钩子', '1', '1392448821', 'Timeline,Bookshell');

-- ----------------------------
-- Table structure for onethink_member
-- ----------------------------
DROP TABLE IF EXISTS `onethink_member`;
CREATE TABLE `onethink_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of onethink_member
-- ----------------------------
INSERT INTO `onethink_member` VALUES ('1', 'admin', '0', '0000-00-00', '', '20', '4', '0', '1392205938', '2130706433', '1392481089', '1');

-- ----------------------------
-- Table structure for onethink_menu
-- ----------------------------
DROP TABLE IF EXISTS `onethink_menu`;
CREATE TABLE `onethink_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_menu
-- ----------------------------
INSERT INTO `onethink_menu` VALUES ('1', '控制台', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('3', '文档列表', '2', '0', 'Article/index', '1', '', '内容', '0');
INSERT INTO `onethink_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('13', '回收站', '128', '0', 'Article/recycle', '1', '', '内容', '0');
INSERT INTO `onethink_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('16', '用户', '0', '6', 'User/index', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('17', '用户', '128', '6', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `onethink_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `onethink_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `onethink_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `onethink_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `onethink_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `onethink_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `onethink_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `onethink_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `onethink_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `onethink_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `onethink_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('44', '插件', '1', '2', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `onethink_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `onethink_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `onethink_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `onethink_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `onethink_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `onethink_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `onethink_menu` VALUES ('57', '钩子', '1', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `onethink_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '1');
INSERT INTO `onethink_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `onethink_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('68', '系统', '0', '7', 'Config/group', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '1');
INSERT INTO `onethink_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '1');
INSERT INTO `onethink_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('80', '分类', '128', '7', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `onethink_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `onethink_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `onethink_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `onethink_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `onethink_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `onethink_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `onethink_menu` VALUES ('93', '其他', '0', '8', 'other', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `onethink_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('122', '概要', '1', '0', 'Index/Index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('123', '个人设置', '1', '1', 'Config/group?id=5', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('124', '外观', '1', '3', 'Theme/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('125', '撰写', '0', '2', 'Article/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('126', '撰写文章', '125', '0', 'Article/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('127', '创建页面', '125', '0', 'Article/add?type=2', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('128', '管理', '0', '3', 'Article/index?type=1', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('129', '文章', '128', '0', 'Article/index?type=1', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('134', '配置', '0', '4', 'Config/group?id=1', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('130', '独立页面', '128', '0', 'Article/index?type=2', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('131', '评论', '128', '0', 'Addons/adminList?name=Comment', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('132', '标签', '128', '0', 'Think/lists?model=tags', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('133', '文件', '128', '0', 'Think/lists?model=file', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('135', '基本', '134', '0', 'Config/group?id=1', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('136', '评论', '134', '0', 'Config/group?id=2', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('137', '阅读', '134', '0', 'Config/group?id=3', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('138', '站点', '134', '0', 'Config/group?id=4', '0', '', '', '0');

-- ----------------------------
-- Table structure for onethink_model
-- ----------------------------
DROP TABLE IF EXISTS `onethink_model`;
CREATE TABLE `onethink_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of onethink_model
-- ----------------------------
INSERT INTO `onethink_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"2\",\"3\",\"5\",\"9\",\"11\",\"12\",\"13\",\"14\",\"16\",\"17\",\"19\",\"20\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\ncategory_id|get_category_title:分类\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1391163759', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"2\",\"24\",\"5\",\"9\"],\"2\":[\"20\",\"13\",\"19\",\"10\",\"12\",\"14\",\"11\",\"25\"],\"3\":[\"17\",\"26\",\"16\"]}', '1:基础,2:选项,3:统计', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1390968122', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('4', 'tags', 'tags', '0', '', '1', '{\"1\":[\"34\",\"35\",\"36\",\"37\",\"38\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题\r\nname:缩略名\r\ndescription:描述\r\ncount:文章数量\r\norder:优先级\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', '', '', '1391049096', '1391049440', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('5', 'file', 'file', '0', '', '1', '{\"1\":[\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\"]}', '1:基础', '', '', '', '', 'id:编号\r\nsavepath:保存路径\r\nsavename:保存文件名\r\next:文件后缀\r\nmime:MIME\r\nsize:大小\r\nmd5:MD5\r\nsha1:SHA1\r\nlocation:保存位置\r\ncreate_time:上传时间', '10', '', '', '1391133228', '1391135686', '1', 'MyISAM');

-- ----------------------------
-- Table structure for onethink_picture
-- ----------------------------
DROP TABLE IF EXISTS `onethink_picture`;
CREATE TABLE `onethink_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_picture
-- ----------------------------
INSERT INTO `onethink_picture` VALUES ('1', '/Uploads/Picture/2014-01-24/52e1c8bae4dc2.jpg', '', '2fa4364f4b35b84275497ddbc10d269d', '29f6857891f76cbc6528d4549efa2c6b33a0c002', '1', '1390528698');
INSERT INTO `onethink_picture` VALUES ('2', '/Uploads/Picture/2014-02-16/53002b383e5de.jpg', '', 'd4c864d6c3d7039effbe49f4668956e2', '4f2d6533de912cb76014faa62f8d086f4af4e0b5', '1', '1392519992');
INSERT INTO `onethink_picture` VALUES ('3', '/Uploads/Picture/2014-02-16/5300c9e20b7d8.jpg', '', '169485472e65122a4633f9a21e7ff8c1', '5ae6279e73abe108cb61117e2390df3744a922e3', '1', '1392560609');
INSERT INTO `onethink_picture` VALUES ('4', '/Uploads/Picture/2014-02-16/5300d59772dae.png', '', 'dcfca47753cf7778428501da91ae543d', 'e7ef1e7e20b0bcf399402a5511d5a8146af442ad', '1', '1392563607');
INSERT INTO `onethink_picture` VALUES ('5', '/Uploads/Picture/2014-02-16/5300d6eccdefb.jpg', '', '19fabec6d5715e2bba828c706da92140', '7fc72016e32116b4ed2fb9d83553b3d702ece0da', '1', '1392563948');
INSERT INTO `onethink_picture` VALUES ('6', '/Uploads/Picture/2014-02-16/5300d788b572a.jpg', '', 'a2e8476d5c8a28639806c4c7f3985e98', '1474016cfaa8a9ab91049f1b6a788af11cd0bded', '1', '1392564104');
INSERT INTO `onethink_picture` VALUES ('7', '/Uploads/Picture/2014-02-17/5301695205145.jpg', '', 'bf5b723db3b43ae82abce4d660adc3e8', '086b01faa76110a5afbe14e5a7a08741704165be', '1', '1392601425');
INSERT INTO `onethink_picture` VALUES ('8', '/Uploads/Picture/2014-02-17/53016b33b6250.PNG', '', '8c8ff7101d81b861ed05c709b6952eb1', '13e511d92035cd95baada5f685052a23fb5bfc94', '1', '1392601907');
INSERT INTO `onethink_picture` VALUES ('9', '/Uploads/Picture/2014-02-17/53016b8416e03.jpg', '', '1832a3a511f5dd1b16796e3dbd9eed19', '996d35911794ef0d070e49702a2ece71bc9ef198', '1', '1392601988');
INSERT INTO `onethink_picture` VALUES ('10', '/Uploads/Picture/2014-02-17/53016b9b3f493.png', '', '87db87518429246a343711a1a0b8f42e', '4e67247dc77774559d832a24c1b7c73e5b09aa4d', '1', '1392602011');
INSERT INTO `onethink_picture` VALUES ('11', '/Uploads/Picture/2014-02-17/53016c099081c.jpg', '', '26a45eb8b4520fb3ffaad1a11d70825d', '90fd60878e8cc6c12afada4e046a379663d7c5c8', '1', '1392602121');
INSERT INTO `onethink_picture` VALUES ('12', '/Uploads/Picture/2014-02-17/53016c26b1ee4.png', '', '5db972a5faabcce4cb5a9dc94d26203b', 'd91c84cab3c554b77900b8985bf3978d1a914cbf', '1', '1392602150');
INSERT INTO `onethink_picture` VALUES ('13', '/Uploads/Picture/2014-02-17/53016c7057744.jpg', '', '360cb0c0c1aeffd4bc3a3022dd7d165e', 'fe1d1a7f3a85972b40b440407f98abe95f965ed8', '1', '1392602224');
INSERT INTO `onethink_picture` VALUES ('14', '/Uploads/Picture/2014-02-17/53016c8e75aad.png', '', '3e16a3dd10a839ebcc2d067c542df88b', '75cac4f6000585e995a3f0b3cb3361b71cd75fda', '1', '1392602254');
INSERT INTO `onethink_picture` VALUES ('15', '/Uploads/Picture/2014-02-17/53016cafe2b6e.jpg', '', 'cfdf88a624cc232a928256a4f97d34aa', '401dc5c676526b56382f1e9f582984efefa1b5be', '1', '1392602287');
INSERT INTO `onethink_picture` VALUES ('16', '/Uploads/Picture/2014-02-17/53016cfcf1b8a.jpg', '', 'fad52564690fecdf4d7545e3d935a557', 'dc510f4c6578c2614c7d28268683bcd15178a8f6', '1', '1392602364');
INSERT INTO `onethink_picture` VALUES ('17', '/Uploads/Picture/2014-02-17/53016d2091c55.png', '', '4597d33e32fa9ced80209812d53194d6', '7b77dbe5ad5f027a8d123bb6b000de0cf94a8a4f', '1', '1392602400');
INSERT INTO `onethink_picture` VALUES ('18', '/Uploads/Picture/2014-02-17/53016d5ed01a8.jpg', '', '43744362c6dbb05594c1712007b3b777', 'b1920997fb19c5c580da279f0f68fd49dbe70967', '1', '1392602462');
INSERT INTO `onethink_picture` VALUES ('19', '/Uploads/Picture/2014-02-17/53016d81d1505.jpg', '', '0a0f68dde5745d269e4e10dcfd7b558b', '1508148023724b472bbcc00a1ae4b10f34bafcdf', '1', '1392602497');
INSERT INTO `onethink_picture` VALUES ('20', '/Uploads/Picture/2014-02-17/53016da144835.png', '', '30a16dd5940e1243344560fb85a5e77e', 'c19774d5e8abf4a413155c603b416712dcde5763', '1', '1392602529');
INSERT INTO `onethink_picture` VALUES ('21', '/Uploads/Picture/2014-02-17/53016e8398765.jpg', '', '60c61467d2b0c840097f4fb040666774', '9022bc645cb82493c53611560160704424bcffd1', '1', '1392602755');
INSERT INTO `onethink_picture` VALUES ('22', '/Uploads/Picture/2014-02-17/53016ea2177cb.jpg', '', '82043eb5664d16b7cf778c6747abde20', '6d0a70b14be9358fbab64088db8fc20009ccd59f', '1', '1392602786');
INSERT INTO `onethink_picture` VALUES ('23', '/Uploads/Picture/2014-02-17/53016ecd28b0a.jpg', '', '5881f50ce2e89b007cb05da487098a6d', 'f9e7b6d5c52b59cb522586f85b56c54bccc48835', '1', '1392602829');
INSERT INTO `onethink_picture` VALUES ('24', '/Uploads/Picture/2014-02-17/53016ee8217fb.jpg', '', '673d9f6eebdade275603601724c9f43b', '94d01b09201f944b7bba1e906cad64112bb47389', '1', '1392602856');
INSERT INTO `onethink_picture` VALUES ('25', '/Uploads/Picture/2014-02-17/53016f07859d3.jpg', '', '592c9bf51eba2ec75e1f00be774ffcd1', 'feed8eb21f091159954b1e526618acbfa3bbec3f', '1', '1392602887');
INSERT INTO `onethink_picture` VALUES ('26', '/Uploads/Picture/2014-02-17/5301760269d18.png', '', '584030e6164e66b2e630e8ecfd5a13b1', '7ce27eb63e82a40888da94a9119bc58561c0dd67', '1', '1392604674');

-- ----------------------------
-- Table structure for onethink_relationships
-- ----------------------------
DROP TABLE IF EXISTS `onethink_relationships`;
CREATE TABLE `onethink_relationships` (
  `cid` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cid`,`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of onethink_relationships
-- ----------------------------
INSERT INTO `onethink_relationships` VALUES ('1', '1');

-- ----------------------------
-- Table structure for onethink_tags
-- ----------------------------
DROP TABLE IF EXISTS `onethink_tags`;
CREATE TABLE `onethink_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `name` varchar(200) DEFAULT NULL COMMENT '缩略名',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `count` int(10) unsigned DEFAULT '0' COMMENT '数量',
  `order` int(10) unsigned DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `slug` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of onethink_tags
-- ----------------------------
INSERT INTO `onethink_tags` VALUES ('1', '默认分类', 'default', '只是一个默认分类', '1', '1');
INSERT INTO `onethink_tags` VALUES ('3', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('4', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('5', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('6', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('7', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('8', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('9', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('10', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('11', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('12', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('13', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('14', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('15', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('16', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('17', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('18', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('19', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('20', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('21', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('22', '', null, null, '1', '0');
INSERT INTO `onethink_tags` VALUES ('23', '', null, null, '1', '0');

-- ----------------------------
-- Table structure for onethink_timeline
-- ----------------------------
DROP TABLE IF EXISTS `onethink_timeline`;
CREATE TABLE `onethink_timeline` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `startDate` varchar(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `endDate` varchar(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '媒体图片',
  `author` varchar(40) NOT NULL DEFAULT 'Jay' COMMENT '媒体作者',
  `media_title` char(40) NOT NULL DEFAULT '' COMMENT '媒体标题',
  `text` text COMMENT '事件内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_timeline
-- ----------------------------
INSERT INTO `onethink_timeline` VALUES ('1', '那天，我毕业了', '2011,5,30', '2011,5,30', '3', 'Jay', '', '六月季，毕业季，离别季，伤感季');
INSERT INTO `onethink_timeline` VALUES ('2', '加入上海顶想', '2011,8,4', '2011,8,4', '4', 'Jay', '', '<p><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">在罗飞的介绍下来到</span><a href=\"http://jaylabs.duapp.com/index.php/admin/timeline/edit/id/www.thinkphp.cn\" style=\"color: rgb(45, 114, 0); text-decoration: none; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;上海顶想&nbsp;</a><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">ThinkPHP框架的官方公司</span></p>');
INSERT INTO `onethink_timeline` VALUES ('3', 'ThinkPHP2.1的\"自定义调试工具条\"', '2011,8,25', '2011,8,25', '0', 'Jay', '', '<p><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">独立移植了Symfony的调试显示功能做了</span><a href=\"http://bbs.thinkphp.cn/forum.php?mod=viewthread&amp;tid=38586\" style=\"color: rgb(45, 114, 0); text-decoration: none; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">ThinkPHP2.1的&quot;自定义调试工具条&quot;</a><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">至今下载近2千次。</span></p>');
INSERT INTO `onethink_timeline` VALUES ('4', '娱乐王国项目完成', '2011,10,20', '2011,10,20', '5', '', '', '<p><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">在这个项目中负责用户中心和专辑发布的事项。很不错的设计。</span></p>');
INSERT INTO `onethink_timeline` VALUES ('5', '发布ThinkPHP3.0的\"自定义调试工具条\"', '2012,1,31', '2012,1,31', '6', '', '', '<p><a href=\"http://bbs.thinkphp.cn/forum.php?mod=viewthread&amp;tid=38586\" style=\"color: rgb(45, 114, 0); text-decoration: none; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">ThinkPHP2.1的&quot;自定义调试工具条&quot;</a><span style=\"color: rgb(64, 64, 64); line-height: 24px;  background-color: rgb(255, 255, 255);\">升级到3.0版。</span></p>');
INSERT INTO `onethink_timeline` VALUES ('6', 'ThinkSNS首届开发大赛获得二等奖', '2012,4,23', '2012,5,20', '7', 'Jay', 'yangweijie', '<p><a href=\"http://www.thinksns.com/special/development/\">ThinkSNS首届开发大赛</a>里开发的<a href=\"http://t.thinksns.com/index.php?app=develop&amp;mod=index&amp;act=detail&amp;id=34\">插件生成器</a>获得二等奖。</p>');
INSERT INTO `onethink_timeline` VALUES ('7', '完成Sublime Text2的', '2012,7,26', '2012,7,26', '8', 'Jay', '', '<p>完成<a href=\"https://github.com/yangweijie/ThinkPHP-Snippets\">ThinkPHP Snippet</a>插件并通过官方Package Control审核。</p>');
INSERT INTO `onethink_timeline` VALUES ('8', '完成Sublime Text2的官方文档中文翻译', '2012,8,16', '2012,8,16', '9', 'Jay', 'yangweijie', '<p>完成完成Sublime Text2的官方文档中文翻译，并放入sae中，可以在线看<a href=\"http://saelabs.sinaapp.com/Sublime/\">Sublime Text 2 文档</a></p>');
INSERT INTO `onethink_timeline` VALUES ('9', '用css3实现了一个tp的logo，不是100%像', '2012,10,25', '2012,10,25', '10', 'Jay', 'yangweijie', '<p>用css3实现了一个tp的logo，不是100%像，并发到了官网中，可以去官网看<a href=\"http://www.thinkphp.cn/code/48.html\">用css3实现了一个tp的logo，不是100%像</a></p>');
INSERT INTO `onethink_timeline` VALUES ('10', 'Thinkphp Sublime text2插件', '2012,11,18', '2012,11,18', '11', 'Jay', 'yangweijie', '<p>发布了Thinkphp Sublime text2插件，并发到了官网中，可以去<a href=\"http://www.thinkphp.cn/extend/257.html\" target=\"_self\" title=\"\">官网</a>看一下简介</p>');
INSERT INTO `onethink_timeline` VALUES ('11', 'jQuery思维导图-《锋利的jQuery》学后总览', '2012,11,26', '2012,11,26', '12', 'Jay', '', '<p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">公司买了本《锋利的jQuery》第二版</span></p><p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\"><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">周末看了下 画了此图。xmind可以打开</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">方便以后回忆用</span></span><img src=\"http://www.thinkphp.cn/Public/Images/extension/common.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"附件\" align=\"absmiddle\" style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 1.5; margin: 10px 0px; padding: 0px; max-width: 688px;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 1.5;\">&nbsp;</span><a href=\"http://www.thinkphp.cn/topic/download/id/154.html\" title=\"下载\" style=\"font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 1.5; color: rgb(114, 185, 57);\">锋利的jQuery.zip</a><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 1.5;\">&nbsp;</span><span class=\"date\" style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 1.5; opacity: 0.4; margin-right: 18px;\">( 54.19 KB 下载：348 次 )</span></p><p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\"></span><br/></p>');
INSERT INTO `onethink_timeline` VALUES ('12', 'osx 上dash程序员文档利器加入ThinkPHP', '2013,3,10', '2013,3,10', '13', 'Jay', '', '<p><a href=\"http://www.thinkphp.cn/Uploads/editor/2013-03-10/513c0e20892b6.png\" target=\"_blank\" style=\"color: rgb(114, 185, 57); text-decoration: underline; font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"><img src=\"http://www.thinkphp.cn/Uploads/editor/2013-03-10/513c0e20892b6.png\" style=\"margin: 10px 0px; padding: 0px; max-width: 688px;\"/></a><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">如图，在程序Preference里的Downloads里添加</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">http://baelabs.duapp.com/ThinkPHP.xml 这个源就可以添加ThinkPHP最新手册了</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">以后也可以自动更新的。</span></p>');
INSERT INTO `onethink_timeline` VALUES ('13', 'ThinkPHP环境探针', '2013,4,02', '2013,4,02', '14', 'Jay', '', '<p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">改自nette框架的环境检测</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">写了几个我认为要检测的，大家觉得有其他需要的可以更改checker.php中的数组。</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">效果如下图：</span></p><p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\"><img src=\"http://www.thinkphp.cn/Public/Images/extension/common.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"附件\" align=\"absmiddle\" style=\"margin: 10px 0px; padding: 0px; max-width: 688px; color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;;\">&nbsp;</span><a href=\"http://www.thinkphp.cn/code/download/id/158.html\" title=\"下载\" style=\"color: rgb(114, 185, 57); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; white-space: normal;\">Requirements-Checker.zip</a><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;;\">&nbsp;</span><span class=\"date\" style=\"opacity: 0.4; margin-right: 18px; color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;;\">( 23.83 KB 下载：333 次 )</span></span></p>');
INSERT INTO `onethink_timeline` VALUES ('14', '《姐妹街》项目结束', '2013,5,15', '2013,5,15', '15', 'Jay', '', '<p>本人负责专辑和个人中心的开发，后期组长调到其他项目里了，自己带其他人，终于结束了，不容易。</p>');
INSERT INTO `onethink_timeline` VALUES ('15', 'ThinkPHP Sublime text2插件添加数据库查询功能', '2013,5,25', '2013,5,25', '16', 'Jay', '', '<pre data-initialized=\"true\" data-gclp-id=\"0\">添加了查询mysql数据库功能，\r\n删除了php生成手册功能\r\n修复以前查询字段时密码为空不能查询的bug\r\n修复以前调用php命令引号传&#39;命令行无法执行的bug</pre><p><br/></p>');
INSERT INTO `onethink_timeline` VALUES ('16', 'ThinkPHP Sublime text插件再次更新', '2013,6,14', '2013,6,14', '17', 'Jay', '', '<p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">这次支持3了，添加cli结果显示</span></p>');
INSERT INTO `onethink_timeline` VALUES ('17', 'Sublime Text新手入门', '2013,7,02', '2013,7,02', '18', 'Jay', '', '<p><span style=\"color: rgb(99, 112, 125); font-family: Lato, Arial, sans-serif; font-size: 12px; line-height: 15px;  background-color: rgb(236, 240, 241);\">深入浅出地介绍编辑神器-Sublime Text</span></p>');
INSERT INTO `onethink_timeline` VALUES ('18', '《瑞德》项目完工', '2013,7,29', '2013,7,29', '19', 'Jay', '', '<p>RED4S赋码管理系统V5 改版的系统近一个月完成。</p>');
INSERT INTO `onethink_timeline` VALUES ('19', 'ThinkPHP Sublime text 插件 再次更新', '2013,8,04', '2013,8,04', '20', 'Jay', '', '<p>修复跳转函数定义快捷键导致ctrl多选冲突的问题，显示函数定义更友好，查询数据库库结果显示优化</p>');
INSERT INTO `onethink_timeline` VALUES ('20', '编写可读代码艺术 读书笔记', '2013,8,15', '2013,8,15', '21', 'Jay', '', '<p><span style=\"color: rgb(99, 112, 125); font-family: Lato, Arial, sans-serif; font-size: 12px; line-height: 15px;  background-color: rgb(236, 240, 241);\">编写可读代码的艺术笔记</span></p>');
INSERT INTO `onethink_timeline` VALUES ('21', '响应式Web设计:HTML5和CSS3实战》读书笔记', '2013,9,05', '2013,9,05', '22', 'Jay', '', '<p><span style=\"color: rgb(99, 112, 125); font-family: Lato, Arial, sans-serif; font-size: 12px; line-height: 15px;  background-color: rgb(236, 240, 241);\">响应式设计已经成为web开发所不可或缺的技能</span></p>');
INSERT INTO `onethink_timeline` VALUES ('22', '短信 tpcrm系统', '2013,9,13', '2013,9,13', '23', 'Jay', '', '<p>公司的短信crm系统，需求不是很明确，有人接着开发第二办了</p>');
INSERT INTO `onethink_timeline` VALUES ('23', 'onethink内容管理框架beta版发布', '2013,9,25', '2013,9,25', '24', 'Jay', '', '<p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">随着移动互联网浪潮席卷全球，不断催生企业及个人用户积极投入建站的行列，在互联网中展示自己。但建设一个多元化、个人性化的网站需要投入大量的人力和物力成本，让不少人望而却步。为了让WEB应用开发变的更简单，顶想即将推出新的力作OneThink，致力于成为国内领先的内容管理框架。产品缘自顶想公司多年的沉淀和积累，基于最新的ThinkPHP框架和灵活的架构设计，采用了动态化和层次化的文档模型设计理念，是顶想公司厚积薄发之作，无论是博客、门户还是社区，从简单到复杂，WEB应用从此得心应手。</span><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><br style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px; white-space: normal;\"/><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">OneThink以其便捷的建站、丰富的扩展、灵活的二次开发，以及云服务的支持，为广大个人和企业建站带来新的契机和机遇，即将成为互联网新的弄潮儿。</span></p><p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\"><br/></span></p><p><span style=\"color: rgb(50, 50, 50); font-family: &#39;Century Gothic&#39;, &#39;Microsoft yahei&#39;; line-height: 28px;\">本人负责插件机制的实现。</span></p>');
INSERT INTO `onethink_timeline` VALUES ('24', 'jay\'s实验室 博客用ot重新开发完成', '2013,10,16', '2013,10,16', '25', 'Jay', '', '<p>国庆，用onethink重构了原来博客。</p>');

-- ----------------------------
-- Table structure for onethink_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_admin`;
CREATE TABLE `onethink_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of onethink_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_ucenter_app
-- ----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_app`;
CREATE TABLE `onethink_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of onethink_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_member`;
CREATE TABLE `onethink_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of onethink_ucenter_member
-- ----------------------------
INSERT INTO `onethink_ucenter_member` VALUES ('1', 'admin', '1f5bfd93891c766f8c0e1234b77e3e47', '917647288@qq.com', '', '1392205938', '2130706433', '1392481089', '2130706433', '1392205938', '1');

-- ----------------------------
-- Table structure for onethink_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_setting`;
CREATE TABLE `onethink_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of onethink_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for onethink_url
-- ----------------------------
DROP TABLE IF EXISTS `onethink_url`;
CREATE TABLE `onethink_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of onethink_url
-- ----------------------------
INSERT INTO `onethink_url` VALUES ('1', 'http://baidu.com', '', '1', '1392483382');
INSERT INTO `onethink_url` VALUES ('2', 'http://qq.com', '', '1', '1392518958');
INSERT INTO `onethink_url` VALUES ('3', 'http://rogerdudler.github.com/git-guide/index.zh.html', '', '1', '1392604675');

-- ----------------------------
-- Table structure for onethink_userdata
-- ----------------------------
DROP TABLE IF EXISTS `onethink_userdata`;
CREATE TABLE `onethink_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onethink_userdata
-- ----------------------------
