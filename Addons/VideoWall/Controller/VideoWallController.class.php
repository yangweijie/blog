<?php

namespace Addons\VideoWall\Controller;
use Home\Controller\AddonsController;
use Think\Model;

class VideoWallController extends AddonsController{

	public function _initialize(){
		/* 读取数据库中的配置 */
        $config = S('DB_CONFIG_DATA');
        if(!$config){
            $config = api('Config/lists');
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置
	}

	public function parse(){
		require ONETHINK_ADDON_PATH.'VideoWall/urlParse.php';
		$urlParse = new \urlParse();
		$url = i('post.url');
		$return = $urlParse->setvideo($url,'');
		if($return['error'])
			$this->error($return['error']);
		else{
			$return['video_id'] = 0;
			$return['video_url'] = $return['id']? $return['id'] : $return['pid'];
			unset($return['id']);
			$this->assign($return);
			$return['tpl'] = $this->fetch(ONETHINK_ADDON_PATH.'VideoWall/publish_form.html');
			$this->success('','', $return);
		}
	}

	public function uploader(){
		$this->display(ONETHINK_ADDON_PATH.'VideoWall/publish_upload_form.html');
	}

	public function uploadPicture(){

        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');

        /* 调用文件上传组件上传文件 */
        $Picture = D('Addons://VideoWall/Picture');
        $pic_driver = C('PICTURE_UPLOAD_DRIVER');
        $upload_config = C('PICTURE_UPLOAD');
        $upload_config['rootPath'] = ONETHINK_ADDON_PATH.'VideoWall/Upload/Cover/';
        $info = $Picture->upload(
            $_FILES,
            $upload_config,
            C('PICTURE_UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器

        /* 记录图片信息 */
        if($info){
            $return['status'] = 1;
            $return = array_merge($info['cover_upload'], $return);
        } else {
            $return['status'] = 0;
            $return['info']   = $Picture->getError();
        }

        /* 返回JSON数据 */
        $this->ajaxReturn($return);
	}

	public function uploadVideo(){

        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');

        /* 调用文件上传组件上传文件 */
        $fileModel = D('Addons://VideoWall/File');
        $upload_config = C('PICTURE_UPLOAD');
        $upload_config['maxSize'] = '0';
        $upload_config['rootPath'] = ONETHINK_ADDON_PATH.'VideoWall/Upload/Video/';
        $upload_config['exts'] = 'mp4';
        $pic_driver = C('PICTURE_UPLOAD_DRIVER');
        $info = $fileModel->upload(
            $_FILES,
            $upload_config,
            C('PICTURE_UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        );

        /* 记录图片信息 */
        if($info){
            $return['status'] = 1;
            $return = array_merge($info['video_upload'], $return);
        } else {
            $return['status'] = 0;
            $return['info']   = $fileModel->getError();
        }

        /* 返回JSON数据 */
        $this->ajaxReturn($return);
	}

	public function add(){
		$model = D('Addons://VideoWall/Video');
		$data = $model->create($_POST, Model::MODEL_INSERT);
		if($data){
			if($model->add($data)){
				$this->success('添加成功');
			}else{
				$this->error($model->getError());
			}
		}else{
			$this->error($model->getError());
		}
	}

	public function edit(){
		$id = $_GET['id'];
		$this->assign(D('Addons://VideoWall/Video')->find($id));
		$this->display(ONETHINK_ADDON_PATH.'VideoWall/edit_form.html');
	}

	public function update(){
		$model = D('Addons://VideoWall/Video');
		$_POST['auto'] = (int)$_POST['auto'];
		$_POST['circle'] = (int)$_POST['circle'];
		$_POST['preload'] = (int)$_POST['preload'];
		$data = $model->create($_POST, Model::MODEL_UPDATE);
		if($data){
			if($model->save($data)){
				$this->success('更新成功');
			}else{
				$this->error($model->getError());
			}
		}else{
			$this->error($model->getError());
		}
	}

	public function del($id){
		$model = D('Addons://VideoWall/Video');
		$rec = $model->find($id);
		$model->delete($id);
		if($rec['video_id']){
			@unlink(".{$rec['video_url']}");
		}
		$this->success('删除成功');
	}
}
