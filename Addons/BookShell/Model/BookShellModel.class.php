<?php

namespace Addons\BookShell\Model;
use Think\Model;

/**
 * BookShell模型
 */
class BookShellModel extends Model{
	protected $_auto = array (
		array('update_time','time',3,'function'), // 对create_time字段在更新的时候写入当前时间戳
	);

	protected $_validate = array(
		array('title','require','书名'), //默认情况下用正则进行验证
		array('title','','书名！',0,'unique',1), // 在新增的时候验证name字段是否唯一
	);

	protected $model = array(
		'title'=>'书架',
		'template_add'=>'',
		'template_edit'=>'',
		'search_key'=>'',
	);



	protected $fields = array(
		array(
			'name'=>'id',
			'title'=>'ID',
			'type'=>'num',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
		),
		array(
			'name'=>'title',
			'title'=>'书名',
			'type'=>'string',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
			'is_must'=>1,
		),
		array(
			'name'=>'description',
			'title'=>'描述',
			'type'=>'textarea',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
			'is_must'=>1,
		),
		array(
			'name'=>'link_id',
			'title'=>'外链',
			'type'=>'string',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
			'is_must'=>0,
		),
		array(
			'name'=>'cover_id',
			'title'=>'外链',
			'type'=>'picture',
			'remark'=>'',
			'is_show'=>2,
			'value'=>0,
			'is_must'=>0,
		),
	);

}
