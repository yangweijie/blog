<?php

namespace Addons\Bookshell\Model;
use Think\Model;

/**
 * BookShell模型
 */
class BookshellModel extends Model{
	protected $_auto = array (
		array('update_time','time',3,'function'), // 对create_time字段在更新的时候写入当前时间戳
		array('link_id', 'getLink', self::MODEL_BOTH, 'callback'),
	);

	protected function _after_find(&$result,$options) {
		$result['link_id'] = get_link($result['link_id']);
	}

	protected function _after_select(&$result,$options){
		foreach($result as &$record){
			$this->_after_find($record,$options);
		}
	}
	protected $_validate = array(
		array('title','require','书名'), //默认情况下用正则进行验证
		array('title','','书名！',0,'unique',1), // 在新增的时候验证name字段是否唯一
	);

	public $model = array(
		'title'=>'书架',
		'template_add'=>'',
		'template_edit'=>'',
		'search_key'=>'',
		'extend'=>1,
	);

    /**
     * 获取链接id
     * @return int 链接对应的id
     * @author huajie <banhuajie@163.com>
     */
    protected function getLink(){
        $link = I('post.link_id');
        if(empty($link)){
            return 0;
        } else if(is_numeric($link)){
            return $link;
        }
        $res = D('Url')->update(array('url'=>$link));
        return $res['id'];
    }

	public $_fields = array(
		'id'=>array(
			'name'=>'id',
			'title'=>'ID',
			'type'=>'num',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
		),
		'title'=>array(
			'name'=>'title',
			'title'=>'书名',
			'type'=>'string',
			'remark'=>'',
			'is_show'=>3,
			'value'=>0,
			'is_must'=>1,
		),
		'author'=>array(
			'name'=>'author',
			'title'=>'作者',
			'type'=>'string',
			'remark'=>'',
			'is_show'=>3,
			'value'=>0,
			'is_must'=>1,
		),'description'=>array(
			'name'=>'description',
			'title'=>'描述',
			'type'=>'textarea',
			'remark'=>'',
			'is_show'=>3,
			'value'=>0,
			'is_must'=>1,
		),'link_id'=>array(
			'name'=>'link_id',
			'title'=>'外链',
			'type'=>'string',
			'remark'=>'',
			'is_show'=>3,
			'value'=>0,
			'is_must'=>0,
		),
		'cover_id'=>array(
			'name'=>'cover_id',
			'title'=>'封面',
			'type'=>'picture',
			'remark'=>'',
			'is_show'=>3,
			'value'=>0,
			'is_must'=>0,
		),
	);

}
