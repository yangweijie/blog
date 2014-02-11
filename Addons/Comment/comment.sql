CREATE TABLE IF NOT EXISTS `onethink_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0',#回复别人评论的。

  `model_id` int(11) unsigned NOT NULL DEFAULT '0',#是哪个文档模型的
  `cid` int(11) unsigned NOT NULL DEFAULT '0',#内容id,name和cid来定位是哪个内容的


  `comment` text DEFAULT NULL,#评论内容
  `digg` int(11) unsigned NOT NULL DEFAULT '0',#内容id,name和cid来定位是哪个内容的


  `com_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '评论IP',#其他的都是整型存储，这里也用
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',#添加时间
  `status` tinyint(1) NOT NULL DEFAULT '0',#是否被删除

  `uid` int(10) unsigned NULL,#是哪位大仙回复的,0为非网站用户
  `uname` varchar(200) NULL,#非网站用户使用的名称
  `uemail` varchar(200) NULL,#非网站用户使用的邮箱
  `uurl` varchar(200) NULL,#非网站用户使用网站地址

  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `model_id` (`model_id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
