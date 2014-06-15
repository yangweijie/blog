CREATE TABLE IF NOT EXISTS `onethink_video` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `desp` varchar(255) NOT NULL COMMENT '描述',
  `cover` varchar(255) DEFAULT NULL COMMENT '封面地址',
  `video_id` int(10) unsigned DEFAULT '0' COMMENT 'file表id',
  `video_url` varchar(255) NOT NULL COMMENT '视频地址',
  `width` int(6) unsigned DEFAULT '640' COMMENT '视频宽度',
  `height` int(6) unsigned DEFAULT '480' COMMENT '视频高度',
  `auto` tinyint(1) unsigned DEFAULT '0' COMMENT '是否自动播放 1-是 0-不是',
  `preload` tinyint(1) unsigned DEFAULT '1' COMMENT '是否预加载 1-是 0-不是',
  `circle` tinyint(1) unsigned DEFAULT '0' COMMENT '循环播放 1-是 0-不是',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;
