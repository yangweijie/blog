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
namespace Addons\Comment\Controller;
use Home\Controller\AddonsController;

class CommentController extends AddonsController{

	public $uploader = null;
	public function savedata(){
		$theuser = session('user_auth');
		if($theuser){
			$_POST['uname'] = $theuser['username'];
		}else{
			$_POST['uid'] = 0;
			$_POST['uurl'] = '';
			$uname = I('post.uname','');
			if(empty($uname)){
				$this->error('匿名用户必须填写一个称呼！');
				exit;
			}
			$uemail = I('post.uemail','');
			if(!$this->checkemail($uemail)){
				$this->error('邮箱没有填写或填写错啦！');
				exit;
			}
		}

		$Comment = D('Addons://Comment/comment');
		$Comment->create();
		$id = $Comment->add();
		if($id){
			$this->success('评论发表成功！', '', array('id' => $id));
		} else {
			$this->error('评论发表失败！'.$Comment->getError());
		}


	}
	public function checkemail($email){
		$preg = '/^(\w{1,25})@(\w{1,16})(\.(\w{1,4})){1,3}$/'; 
		return (preg_match($preg, $email));
	}

	public function diggit(){
		$return['status'] = 0;
		$return['info']   = '';
		$id = I('post.id',0);
		if(empty($id)){
			$return['info']   = '顶失败失败！不必到顶什么！';
			/* 返回JSON数据 */
			$this->ajaxReturn($return);
			exit;
		}

		if(session('lasttime_'.get_client_ip(1)) && ((time() - session('lasttime_'.get_client_ip(1))) <10)){
			$return['info']   = '顶的太快了，一个IP最快10秒一次！';
			/* 返回JSON数据 */
			$this->ajaxReturn($return);
			exit;
		}
		$Comment = D('Addons://Comment/comment');
		$rt = $Comment->diggit($id);
		if($rt){
			session('lasttime_'.get_client_ip(1),time());
			$return['status'] = 1;
			$return['info']   = '顶好了！';
		} else {
			$return['info']   = '顶坏了！'.$Comment->getError();
		}
			/* 返回JSON数据 */
		$this->ajaxReturn($return);

	}

}
