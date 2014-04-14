<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use Michelf\MarkdownExtra;

/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class IndexController extends HomeController {

	//首页
    public function index(){
        $Document = D('Document');
        // if (is_numeric(I('get.p')) && I('get.p')>0) {
            $this->lists(I('get.p',1));
        // }else{
        // $this->lists();
        // }
        $this->display();
    }

    //详情
    public function detail($id){
        /* 标识正确性检测 */
        if(!($id && is_numeric($id))){
            $this->error('文档ID错误！');
        }

        /* 获取详细信息 */
        $Document = D('Document');
        $info = $Document->detail($id);
        if(!$info){
            $this->error($Document->getError());
        }
        if($info['parse'] == 2){
            $markdown = new MarkdownExtra;
            $info['content'] = $markdown->transform($info['content']);
        }

        /* 获取模板 */
        if(!empty($info['template'])){//已定制模板
            $tmpl = $info['template'];
        } else { //使用默认模板
            $tmpl = 'Index/detail';
        }

        /* 更新浏览数 */
        $map = array('id' => $id);
        $Document->where($map)->setInc('view');

        /* 模板赋值并渲染模板 */
        $this->assign('info', $info);
        $this->display($tmpl);
    }

    //单页
    public function single($name){

        $id = D('Document')->getFieldByName($name, 'id');
        if(!$id)
            $this->error('对不起，你找的页面不存在');
        else
            $this->detail($id);
    }

    //分类
    public function category($name){
        $category = D('Category')->getByName($name);
        if(!$category)
            $this->error('错误的分类');
        $this->assign('category', $category);
        $_GET['cate_id'] = $category['id'];
        $this->lists(I('get.p',1));
        $this->display("Index/category");
    }

    //归档
    public function archive($year, $month){
        $_GET['month'] = $month;
        $_GET['year'] = $year;
        $this->assign('year', $year);
        $this->assign('month', $month);
        $this->lists(I('get.p', 1));
        $this->display('Index/archive');
    }

    //搜索
    public function search($kw){
        if(!$kw)
            $this->error('请输入关键字');
        $this->assign('kw', $kw);
        $this->lists(I('get.p', 1));
        $this->display('Index/search');
    }

}
