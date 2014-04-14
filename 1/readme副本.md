# 前台主题（皮肤）开发指南

## 皮肤的构成
├─Home Home 前台模块
      └─View 模块视图文件目录
         ├─default default 主题目录
         │  ├─Public 前台资源目录
         │  │  ├─css css目录
         │  │  ├─images 图片目录
         │  │  └─js js目录
         │  ├─Index 首页
         │  ├─Common widget目录或w者公共包含模板目录
         │  ├─screenshot.png 主题截屏
         │  └─theme.ini 主题记录
         └─red red主题目录


## 资源的放置

经过我的努力将前台放置的公共资源目录终于解析到了主题对应的模板以内，方便大家以后直接丢到View就能新增模板而不用去改Public中资源目录
在模板中公共资源用`__STATIC__`、系统插件里的资源可以用`__ADDONS__`、前台图片目录用`__IMG__` 、STYLE层叠样式条路径用`__CSS__`、JS脚本用`__JS__`去获取。路径对应上面皮肤构成显示的结构。

## 主题信息
theme.ini 保存主题的信息后台列表里会读取此文件

    ; 主题信息

    desc = 这是 Typecho 0.9 系统的一套默认皮肤
    package = Typecho Replica Theme
    author = Typecho Team
    version = 1.2
    link = http://typecho.org

上面desc 的行往后各行分别代表了 描述、名称、作者、版本、作者主页

## 可参考的地方

typecho、zblog、点点、lofter、wordpress 等各大博客站的各种皮肤