<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 杨维杰 <917647288.qq.com>
// +----------------------------------------------------------------------

namespace Home\Widget;
use Think\Action;

/**
 * 分类widget
 * 用于动态调用分类信息
 */

class CommonWidget extends Action{

	/**
	 * 获取单页的列表
	 */
	public function single(){
		$list = D('Document')->where('type=2')->field(true)->order('`create_time` DESC,`id` DESC')->select();
		$this->assign('single', $list);
		$this->display('Common/single');
	}

	/**
	 * 最新文章
	 */
	public function new_article(){
		$list = D('Document')->lists(NULL, '`create_time` DESC,`id` DESC', 1, true, 3);
		$this->assign('new_article', $list);
		$this->display('Common/new_article');
	}

	/* 显示指定分类的同级分类或子分类列表 */
	public function cates(){
		$field = 'id,name,pid,title,link_id';
		$category = M('Category')->where('status = 1')->order('sort asc')->select();
		$count = M('Document')->where('type = 1')->group('category_id')->getField('category_id, count(*) as num');
		foreach ($category as $key => $value) {
			$category[$key]['article_num'] = (int)$count[$value['id']];
		}
        $this->assign('category', D('Category')->toFormatTree($category));
		$this->display('Common/lists');
	}

	/**
	 * 归档显示
	 */
	public function archive(){
		$list = D('Document')->lists(NULL, '`create_time` DESC,`id` DESC', 1, true);
		$date = $time = array();
		foreach ($list as $key => $value) {
			if($value['create_time'])
				$time[] = date('F Y', $value['create_time']);
		}

		$time = array_unique($time);

		foreach ($time as $key => $value) {
			$date[] = array(
				'text'=> $value,
				'link'=> date('Y/m', strtotime($value))
			);
		}

		$this->assign('archive', $date);
		$this->display('Common/archive');
	}

	public function tags(){
		$tags = M('Tags')->getField('title',true);
		$this->assign('tags',$tags);
		$this->display('Common/tags');
	}

}
