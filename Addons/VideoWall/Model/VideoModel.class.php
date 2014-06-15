<?php

namespace Addons\VideoWall\Model;
use Think\Model;

/**
 * Video模型
 */
class VideoModel extends Model{
    protected $_auto = array (
        array('create_time','datetime',1,'callback'),
        array('update_time','datetime',2,'callback'),
    );

    protected $_validate = array(
        array('desp','require','描述必须！'), //默认情况下用正则进行验证
        array('title','','标题重复',0,'unique',1), // 在新增的时候验证name字段是否唯一
    );

    public function datetime(){
        return @date("Y-m-d H:i:s", strtotime( 'now' ));
    }

    protected function _after_find(&$result,$options) {
        $result['create_time'] = strtotime($result['create_time']);
    }

    protected function _after_select(&$result,$options){
        foreach ($result as $key => &$value) {
            $this->_after_find($value, $options);
        }
    }

    public $model = array(
        'title'=>'',//新增[title]、编辑[title]、删除[title]的提示
        'template_add'=>'',//自定义新增模板自定义html edit.html 会读取插件根目录的模板
        'template_edit'=>'',//自定义编辑模板html
        'search_key'=>'',// 搜索的字段名，默认是title
        'extend'=>1,
    );

    public $_fields = array(
        'id'=>array(
            'name'=>'id',//字段名
            'title'=>'ID',//显示标题
            'type'=>'num',//字段类型
            'remark'=>'',// 备注，相当于配置里的tip
            'is_show'=>3,// 1-始终显示 2-新增显示 3-编辑显示 0-不显示
            'value'=>0,//默认值
        ),
        'title'=>array(
            'name'=>'title',
            'title'=>'书名',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>1,
            'value'=>0,
            'is_must'=>1,
        ),
    );
}
