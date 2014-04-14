# blog文档

## 用途

基于ot二次开发的一个仿typecho 单用户博客系统，多用户也应该支持，但是权限需重新分配
方便喜欢thinkphp的人员开发自己的博客

## 改动
* 使用时 url_model 2 .htaccess文件加入了部分url的优化
* 替换了后台的皮肤写了个 typecho_color.css文件
* 为了导航 重写了admin 的 base文件
* common中DOCUMENT_MODEL_TYPE的类型改为文档和独立页面
* 修改了文档中分类的判断
* 重写了前台模板，未用到导航
* 新增了ping插件
* 更换了系统的编辑器，支持全屏实时预览，当时typecho的wmd定制版未能成功集成
* url优化了省略前台Home的输入，index.php的隐藏
* 默认开启调试模式
* rss实现，但是没针对评论或者提供分类的rss，有需要者可以继续开发

## 安装注意
1. 默认开启的开发者模式，有些无用的菜单请手动关闭开发者模式可隐藏。
2. 文件管理在编辑器以后调整后能上传图片时候再做。目前用的独立模型实现。
3. 后台登录页在火狐下样式有问题，希望前端高手能帮我调整下。
4. 本项目仅花了20多天，一定存在bug，希望大家踊跃安装测试，提交改进，欢迎加入
5. 下载地址在[https://github.com/yangweijie/blog/releases/tag/v1.0beta](https://github.com/yangweijie/blog/releases/tag/v1.0beta)

## 计划
做在线升级
