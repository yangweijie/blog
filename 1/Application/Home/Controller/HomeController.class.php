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
use OT\Feed;

/**
 * 前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class HomeController extends Controller {

	/* 空操作，用于输出404页面 */
	public function _empty(){
		switch (CONTROLLER_NAME) {
                                        case 'archive':
                                                $Index = new IndexController();
                                                $Index->detail(ACTION_NAME);
                                                break;
                                        case 'category':
                                                $Index = new IndexController();
                                                $Index->category(ACTION_NAME);
                                                break;
			case 'search':
                                                        $_GET['kw']=ACTION_NAME;
				$Index = new IndexController();
				$Index->search(ACTION_NAME);
				break;
			case 'feed':
				$type = I('get.type');
				$this->feed($type);
				break;
			default:
                                                $Index = new IndexController();
                                                if (is_numeric(CONTROLLER_NAME) && is_numeric(ACTION_NAME)) {
                                                        // $_GET['year']=CONTROLLER_NAME;
                                                        // $_GET['month']=ACTION_NAME;
                                                        $Index->archive(CONTROLLER_NAME,ACTION_NAME);
                                                }else{
                                                        $Index->single(CONTROLLER_NAME);
                                                }
			     break;
		}

	}


	protected function _initialize(){
		/* 读取站点配置 */
		$config = api('Config/lists');
        C($config); //添加配置
        C('DEFAULT_THEME', C('FRONT_THEME'));
        $TMPL_PARSE_STRING = C('TMPL_PARSE_STRING');
        foreach ($TMPL_PARSE_STRING as $key => $value) {
            $TMPL_PARSE_STRING[$key] = str_replace('__THEME__', C('DEFAULT_THEME'), $value);
        }
        C('TMPL_PARSE_STRING', $TMPL_PARSE_STRING);
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

		$cate_id = I('get.cate_id', 0);
		if($cate_id)
			$map['category_id'] = $cate_id;
		$cate_id = $cate_id? $cate_id : NULL;
        $tags = I('get.tag');
        if($tags){
            $ids = M('DocumentArticle')->where("tags like '{$tags}'")->getField('id', true);
            $map = array('id'=>array('in',$ids));
        }
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
		return $list;
	}

	//RSS
    public function feed($type ='RSS2'){
        $this->_currentFeedUrl = '';

        /** 判断聚合类型 */
        switch ($type) {
            case 'rss':
                /** 如果是RSS1标准 */
                $this->_feedType = Feed::RSS1;
                $this->_currentFeedUrl = $this->options->feedRssUrl;
                $this->_feedContentType = 'application/rdf+xml';
                break;
            case 'atom':
                /** 如果是ATOM标准 */
                $this->_feedType = Feed::ATOM1;
                $this->_currentFeedUrl = $this->options->feedAtomUrl;
                $this->_feedContentType = 'application/atom+xml';
                break;
            default:
                $this->_feedType = Feed::RSS2;
                $this->_currentFeedUrl = $this->options->feedUrl;
                $this->_feedContentType = 'application/rss+xml';
                break;
        }

        $feedQuery = 'article';

        $this->_feed = new Feed(ONETHINK_VERSION, $this->_feedType, 'UTF-8', 'zh-CN');

        $list_rows = 10;

        $this->_feed->setSubTitle(C('WEB_SITE_DESCRIPTION'));
        $this->_feed->setFeedUrl($this->_currentFeedUrl);

        $this->_feed->setBaseUrl(U('/', '', false, true));


        $this->_feed->setTitle(C('WEB_SITE_TITLE') .'-文章');
        $Document = D('Document');
        $list = $this->lists(1);

        foreach ($list as $key => $value) {
            $extend_value = $Document->detail($value['id']);
            $value = array_merge($value, $extend_value);
            $feedUrl = '';
            if (Feed::RSS2 == $this->_feedType) {
                $feedUrl = U('/feed', '', false, true);
            } else if (Feed::RSS1 == $this->_feedType) {
                $feedUrl = U('/feed/rss', '', false, true);
            } else if (Feed::ATOM1 == $this->_feedType) {
                $feedUrl = U('/feed/atom', '', false, true);
            }
            $count = D('Addons://Comment/comment')->group('cid')->getField('cid','count(*) as num');

            $this->_feed->addItem(array(
                'title'     =>  $value['title'],
                'content'   =>  C('FEEDFULLTEXT') ? $value['content'] : ($value['description']?$value['description']:msubstr($value['content'], 0 ,200, "utf-8", false)),
                'date'      =>  $value['create_time'],
                'link'      =>  U('archive/'.$value['id'].'.html', '', false, true),
                'author'    =>  get_username($value['uid']),
                'excerpt'   =>  $value['description'],
                'comments'  =>  (int)$count[$value['id']],
                'commentsFeedUrl' => $feedUrl,
                'suffix'    =>  NULL
            ));
        }

        header('Content-Type: ' . $this->_feedContentType . '; charset=utf-8', true);
        echo $this->_feed->__toString();
        exit;

    }

}
