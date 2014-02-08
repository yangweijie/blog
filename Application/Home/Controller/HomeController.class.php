<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use Think\Controller;

/**
 * 前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class HomeController extends Controller {

	/* 空操作，用于输出404页面 */
	public function _empty(){
		if(CONTROLLER_NAME == 'search'){
			$Index = new IndexController();
			// echo ACTION_NAME;die;
			$_GET['kw'] = ACTION_NAME;
			$Index->search();
			api('Home/Index/search',array('kw'=>ACTION_NAME));
		}else{
			$this->error('对不起，你找的页面不存在');
		}

	}


	protected function _initialize(){
		/* 读取站点配置 */
		$config = api('Config/lists');
        C($config); //添加配置
        if(!C('WEB_SITE_CLOSE')){
        	$this->error('站点已经关闭，请稍后访问~');
        }
    }

    /* 用户登录检测 */
    protected function login(){
    	/* 用户登录检测 */
    	is_login() || $this->error('您还没有登录，请先登录！', U('User/login'));
    }


    /* 文档模型列表页 */
    public function lists($page = 1){

		/* 获取当前分类列表 */
		$Document = D('Document');
		$list_row = I('r')? I('r') : 10;
		$map = array();

		$cate_id = I('get.cate_id');
		if($cate_id)
			$map['category_id'] = $cate_id;
		$cate_id = $cate_id? $cate_id : NULL;
		$list = $Document->page($page, $list_row)->lists($cate_id);

		/* 分页 */
		$total = $Document->where($map)->count();

		$page = new \Think\Page($total, $list_row);
		if($total > $list_row){
			$page->rollPage = 5;
			$page->setConfig('prev','上一页');
			$page->setConfig('next','下一页');
			$page->setConfig('first','首页');
			$page->setConfig('last','尾页');
			$page->setConfig('theme','%FIRST%%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%%END%<span class="count">共 %TOTAL_PAGE% 页 / %TOTAL_ROW% 条记录</span>');
		}

		$p = $page->show();
		$this->assign('_page', $p? $p: '');
		$this->assign('list', $list);
	}

}
