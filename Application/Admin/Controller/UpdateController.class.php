<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: yangweijie <yangweijiester@gmail.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 升级控制器
 * @author yangweijie <yangweijiester@gmail.com>
 */
class UpdateController extends AdminController {

	protected $domain = 'http://jaylabs.sinaapp.com';
	protected $check_url = '/Admin/Update/checkVersion';
	protected $update_list_url = '/Admin/Update/getUpdateList';
	protected $update_path = './Update/';

	//在线升级首页
	public function index(){
		if(extension_loaded('curl')){
			$data = self::curl_post("{$this->domain}{$this->check_url}", array('version'=>ONETHINK_VERSION));
        }

        if(!empty($data) && strlen($data)<400 ){
            $config['new_version'] = $data;
        }

        $this->assign('config', $config);
		$this->display();
	}

	//自动升级
	public function autoUpdate($verison, $step = 0){
		switch ($step) {
			case 0:
				//关闭站点

				break;
			case 1:
				$list = $this->getUpdateList($verison);
				break;
		}
	}

	//手动升级
	public function manual($verison){

	}

	//获取升级文件列表
	public function getUpdateList($version){
		#服务器端
		if(U('/') == $this->domain){
			$list_file = $this->update_path.$version.'update.php';
			if(is_file($list_file) && $content = include $list_file){
				$this->ajaxReturn(array('data'=>$content),'',1);
			}else{
				$this->ajaxReturn(null,'',0);
			}
		}else{
		#客户端
			$data = self::curl_post($this->domain.$this->update_list_url, array('version'=>$version));
			$data = json_decode($data, 1);
			if($data['status'])
				return $data['data'];
			else
				return false;
		}
	}

	//获取最新版本
	public function checkVersion($verison){
		#服务器端
		if(U('/') == $this->domain){
			$updates = glob("{$this->update_path}*", GLOB_ONLYDIR);
			$new_version = '';
			if($updates){
				sort($updates);
				foreach ($updates as $key => $value) {
					if(version_compare($verison, $value) >0){
						$new_version = $value;
						break;
					}
				}
				if($new_version)
					return $new_version;
				else
					return 0;
			}else{
				return 0;
			}
		}
	}

	static function curl_post($url, $params){
		$url = $this->domain.$this->check_url;
        $vars = http_build_query($params);
        $opts = array(
            CURLOPT_TIMEOUT        => 5,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL            => $url,
            CURLOPT_POST           => 1,
            CURLOPT_POSTFIELDS     => $vars,
            CURLOPT_USERAGENT      => $_SERVER['HTTP_USER_AGENT'],
        );

        /* 初始化并执行curl请求 */
        $ch = curl_init();
        curl_setopt_array($ch, $opts);
        $data  = curl_exec($ch);
        $error = curl_error($ch);
        curl_close($ch);
	}
}
