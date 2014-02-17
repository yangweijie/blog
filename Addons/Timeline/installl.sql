CREATE TABLE IF NOT EXISTS `onethink_timeline` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '媒体图片',
  `author` char(40) NOT NULL DEFAULT '' COMMENT '媒体作者',
  `media_title` char(40) NOT NULL DEFAULT '' COMMENT '媒体标题',
  `text` text COMMENT '事件内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
