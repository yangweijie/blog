CREATE TABLE IF NOT EXISTS `onethink_bookshell` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL COMMENT '标题',
  `description` char(140) NOT NULL COMMENT '描述',
  `link_id` int(10) unsigned NOT NULL COMMENT '外链id',
  `cover_id` int(10) NOT NULL COMMENT '封面',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
