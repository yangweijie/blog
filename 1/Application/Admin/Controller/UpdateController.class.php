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

	/**
     * 后台控制器初始化
     */
    protected function _initialize(){

        /* 读取数据库中的配置 */
        $config = S('DB_CONFIG_DATA');
        if(!$config){
            $config = api('Config/lists');
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置

        header('content:html/text;charset:utf-8');
        // 是否是超级管理员
        define('IS_ROOT',   1);
        $this->assign('domain', $this->domain);
        $this->assign('__MENU__', $this->getMenus());
    }

	//在线升级首页
	public function index(){
		self::openSite();
		if(extension_loaded('curl')){
			$version = C('VERSION');
			$data = self::curl_post("{$this->domain}{$this->check_url}", array('version'=>$version));
        }
        $config = array('version'=>$version);
        if(!empty($data) && strlen($data)<400 ){
            $data = json_decode($data, 1);
            if($data['status'])
	            $config['new_version'] = $data['version'];
        }
        $this->assign('config', $config);
		$this->display();
	}

	//自动升级
	public function autoUpdate($version, $step = 0){
		$this->assign('step', $step);
		$this->assign('version', $version);
		switch ($step) {
			case 0:
				//关闭站点
				self::closeSite();
				$this->redirect('autoUpdate',array('version'=>$version,'step'=>1), 1,'正在关闭前台站点访问...,完成后自动转入下一步');
				$this->display();
				break;
			case 1:
				$list = $this->getUpdateList($version);
				if($list){
					$list = $this->diff($list);
					if($list){
						$this->assign('list', $list);
						$this->display();
					}else{
						self::openSite();
						$this->error('获取对比列表失败！');
					}
				}else{
					self::openSite();
					$this->error('获取更新列表失败！');
				}
				break;
			case 2:
				// 下载文件（缓冲输出）
				$this->display();
				$list = $this->getUpdateList($version);
				ob_end_clean(); //清除输出缓存并且关闭缓存
				echo str_pad(' ',256);//输出256字节空格（在ie浏览器下要接受大于256个字节才会输出显示
				foreach ($list as $key => $value) {
					create_dir_or_files($value['path']);
					$remote = file_get_contents("{$this->domain}/Update/{$version}/{$value['filename']}");
					$i = $key+1;
					if($remote &&
						is_file("{$this->update_path}{$version}/{$value['filename']}") &&
						@file_put_contents("{$this->update_path}{$version}/{$value['filename']}", $remote))
						$result = "<td class='success'>　　√</td></tr>";
					else
						$result = "<td class='error'>　　X</td></tr>";
					$msg = "<tr><td>{$i}</td><td>{$this->update_path}{$version}/{$value['filename']}</td>{$result}";
					echo "<script type=\"text/javascript\">showmsg(\"{$msg}\");</script>";
					flush();
					ob_flush();
					usleep(500000);
				}
				flush();
				ob_flush();
				usleep(500000);
				exit("<script type=\"text/javascript\">showmsg(1);</script>");
			case 3:
				// 处理更新
				$this->display();
				$list = $this->getUpdateList($version);
				$count = count($list);
				ob_end_clean(); //清除输出缓存并且关闭缓存
				echo str_pad(' ',256);//输出256字节空格（在ie浏览器下要接受大于256个字节才会输出显示
				foreach ($list as $key => $value) {
					$flag = false;
					$target_file = "./{$value['filename']}";
					$update_file = "{$this->update_path}{$version}/{$value['filename']}";
					switch ($value['opt']) {
						case 'add': case 'modify':
						if(file_put_contents($target_file, file_get_contents($update_file)))
							$flag = true;
							break;
						case 'del':
							if(substr($target_file, -1) == '/'){
								if(rmdir($target_file))
									$flag = true;
							}else{
								if(unlink($target_file))
									$flag = true;
							}
							break;
						case 'sql':
							if(M()->execute(file_get_contents($update_file)))
								$flag = true;
							break;
					}
					$i = $key+1;
					if($flag)
						$result = "<td class='success'>　　√</td></tr>";
					else
						$result = "<td class='error'>　　X</td></tr>";
						$opts = array(
							'add'=>'新增',
							'modify'=>'修改',
							'del'=>'删除',
							'sql'=>'更新数据库'
						);
					$msg = "<tr><td>{$i}</td><td>{$target_file}</td><td>{$opts[$value['opt']]}</td>{$result}";
					echo "<script type=\"text/javascript\">showmsg(\"{$msg}\");</script>";
					flush();
					ob_flush();
					usleep(500000);
				}
				flush();
				ob_flush();
				usleep(500000);
				exit("<script type=\"text/javascript\">showmsg(1);</script>");
			case 4:
				M('Config')->where("name='VERSION'")->save(array('value'=>$version));
				self::openSite();
				$this->success("更新{$version}版成功！",U('Admin/Update/index') );
				break;
		}
	}

	//手动升级
	public function manual($version){

	}

	/**
	 * 获取升级文件列表
	 * @param $version 版本号
	 * @example array(
	 * 0=>array('filename'=>'aa','md5'=>'123','opt'=>'add','todo'=>-1)
	 *
	 * )
	 */
	public function getUpdateList($version){
		#服务器端
		if(self::is_server()){
			C('SHOW_PAGE_TRACE', false);
			$list_file = $this->update_path.$version.'/update.php';
			if(is_file($list_file) && $content = include $list_file){
				$this->ajaxReturn(array('data'=>$content,'status'=>1));
			}else{
				$this->ajaxReturn(array('status'=>0));
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
	public function checkVersion($version){
		C('SHOW_PAGE_TRACE', false);
		#服务器端
		if(self::is_server()){
			$updates = glob("{$this->update_path}*", GLOB_ONLYDIR);
			$new_version = '';
			if($updates){
				sort($updates);
				foreach ($updates as $key => $value) {
                    $value = strrchr($value, '/');
                    $value = ltrim($value, '/');
					if(version_compare($version, $value) <0){
						$new_version = $value;
						break;
					}
				}
				if($new_version)
                	$this->ajaxReturn(array('status'=>1,'version'=>$new_version));
				else
					$this->ajaxReturn(array('status'=>0));
			}else{
				$this->ajaxReturn(array('status'=>0));
			}
        }

	}

	//预览远程文件
	public function preview($file){
		exit(file_get_contents($file));
	}

	static function is_server(){
		return ("http://{$_SERVER['HTTP_HOST']}" == 'http://jaylabs.sinaapp.com')? 1 : 0;
	}

	static function closeSite(){
		M('Config')->where("name = 'WEB_SITE_CLOSE'")->save(array('value'=>0));
		S('DB_CONFIG_DATA',null);
	}

	static function openSite(){
		M('Config')->where("name = 'WEB_SITE_CLOSE'")->save(array('value'=>1));
		S('DB_CONFIG_DATA',null);
	}

	static function diff($list){
		if($list && is_array($list)){
			foreach ($list as $key => $value) {
				$orignal_file = './'.$value['filename'];
				$list[$key]['diff'] = ($value['opt'] == 'modify')? 1 : 0;
				if($value['opt'] == 'modify')
					$list[$key]['changed'] = ($value['md5'] == md5_file($orignal_file))? 0:1;
				else
					$list[$key]['changed'] = 0;
			}
			return $list;
		}else{
			return false;
		}
	}

	static function curl_post($url, $params){
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
        $info = curl_getinfo($ch);
        $error = curl_error($ch);
        curl_close($ch);
        return $data;
	}
}
