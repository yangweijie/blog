# Ping插件

## 功能

在发布文档时主动ping百度和谷歌  

## 使用注意

要使用 必须使用curl扩展
启用前配置好站点名称、站点地址、文章显示url、文章RSS列表
文章url格式如 `Article/index@www.baidu.com`, 方法里会自动传上id参数
使用时候看自己ot里的documentSaveComplete 后台里是否传了id 没有手动加下
文章feed格式如 `feed@www.baidu.com`

>>> 本插件功能实现参考了 [ThinkPHP 上用 Google/Baidu Ping服务快速收录](http://www.thinkphp.cn/topic/2628.html)

## 待完成功能

1. ping结果列表
2. 更多ping引擎、并可手动选择ping哪些