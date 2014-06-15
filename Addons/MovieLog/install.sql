CREATE TABLE IF NOT EXISTS `onethink_movie` (
  `id` bigint(255) unsigned NOT NULL COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '中文名 ',
  `original_title` varchar(255) DEFAULT NULL COMMENT '原文名',
  `alt` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '条目URL',
  `images` text COMMENT '图片',
  `rating` text COMMENT '评分',
  `year` varchar(255) DEFAULT NULL COMMENT '年代',
  `subtype` varchar(255) DEFAULT 'movie' COMMENT '条目分类，movie或者tv',
  `ctime` int(11) unsigned DEFAULT NULL COMMENT '创建时间',
  `is_del` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  `is_published` tinyint(4) unsigned DEFAULT '0' COMMENT '是否发布人人 1-是 0-不是',
  `summary` text COMMENT '简介',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
