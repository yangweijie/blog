<?php
/**
 * Onethink 评论插件，功能演示版本
 * @copyright
 * @author      Wolix Li <wolixli@gmail.com>
 * @link
 * 各位叔叔大爷、婶婶大娘、哥哥姐姐、弟弟妹妹们行行好，如果哪位走在网路上可怜我四十几岁的小乞丐，可顺便给我打点零花钱，
 * 半年在家呆着没挣着钱，快过年了，没钱给小孩子们包红包、没钱给老人们孝敬槽子糕，也没钱给我那可怜的老婆买新衣服。
 * 一块两块不嫌少，10万八万的不嫌多，美元、日元都可以，最欢迎人民币，我的支付宝账号和 paypal的账号都是： wolix@139.com
 * 专业组团定制互联网php产品，联系QQ: 4118814
 * 现在做雷锋也留名，请不要再叫我雷锋了，叫我“老李”就行了！
 * 2014/1/14
 **/
namespace Addons\Comment;
use Common\Controller\Addon;

/**
 * 评论功能插件
 * @author Wolixli
 */

    class CommentAddon extends Addon{

        public $info = array(
            'name'=>'Comment',
            'title'=>'评论',
            'description'=>'用于各种类型文档评论',
            'status'=>1,
            'author'=>'Wolixli',
            'version'=>'0.1'
        );

        public $admin_list = array(
            'model'=>'Comment',		//要查的表
			'fields'=>'*',			//要查的字段
			'map'=>'',				//查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
			'order'=>'id desc',		//排序,
			'list_grid'=>array( 		//这里定义的是除了id序号外的表格里字段显示的表头名
				'uid:登录用户ID',
				'uname:用户名',
				'uemail:用户邮箱',
				'comment:内容',
				'create_time_text:时间',
				'ip:IP',
			),
        );

        public function install(){
        	$sql = file_get_contents($this->addon_path . 'comment.sql');
        	$db_prefix = C('DB_PREFIX');
        	$sql = str_replace('onethink_', $db_prefix, $sql);
        	D()->execute($sql);
        	$table_name = $db_prefix.'comment';
            if(count(M()->query("SHOW TABLES LIKE '{$table_name}'")) != 1){
                session('addons_install_error', ',comment表未创建成功，请手动检查插件中的sql，修复后重新安装');
                return false;
            }
            return true;
        }

        public function uninstall(){
        	$db_prefix = C('DB_PREFIX');
            $sql = "DROP TABLE IF EXISTS `{$db_prefix}comment`;";
            D()->execute($sql);
            return true;
        }

        //实现的documentDetailAfter钩子方法
        public function documentDetailAfter($info = array()){
			if(empty($info) || empty($info['id']) ||  empty($info['model_id'])){ //数据不正确
				return ;
			}

			/* 获取当评论 */
			$commentDao = D('Addons://Comment/Comment');
			$map = array('model_id' => $info['model_id'],'cid' => $info['id'], 'status' => 1);

			$allcomments = $commentDao->where($map)->order('create_time DESC, id DESC')->select();
			$comments = list_to_tree($allcomments, 'id', 'pid', 'reply', 0);
			$comments_number = $commentDao->where($map)->order('create_time DESC, id DESC')->count();
			$this->assign('comments',   $comments);
			$this->assign('comments_number', $comments_number);
			$this->display($this->addon_path.'View/default/Content/comment.html');
        }

        //实现sidebar方法
        public function sidebar(){
            $list = D('Addons://Comment/Comment')->where("status = 1")->order('create_time DESC, id DESC')->limit(3)->select();
            $this->assign('addon_comment', $list);
            $this->display($this->addon_path.'View/default/Content/sidebar.html');
        }

    }
