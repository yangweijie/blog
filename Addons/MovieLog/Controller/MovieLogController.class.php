<?php

namespace Addons\MovieLog\Controller;
use Home\Controller\AddonsController;
use Addons\MovieLog\Upyun;

class MovieLogController extends AddonsController{

	public function search(){
		C('SHOW_PAGE_TRACE',0);
		$key = $_GET['title'];
		$movie = D('Addons://MovieLog/Movie');
		include_once ONETHINK_ADDON_PATH.'MovieLog/DoubanMovie.class.php';
		$obj = new \DoubanMovie();
        $result = $obj->search($key);
        $this->assign('key', $key);
		$list = array();
		if($result && isset($result['total'])){
			$to_add = array();
			foreach ($result['subjects'] as $value) {
				$detail = $obj->subject($value['id']);
				if($detail){
					$value['type'] = $detail['type'];
					$value['original_title'] = $detail['original_title'];
					$value['summary'] = $detail['summary'];
					$value['year'] = $detail['year'];
				}

				if(!$film = $movie->find($value['id'])){
					$value['is_published'] = 0;
					$value['ctime'] = NOW_TIME;
					$addData = $movie->create($value, 1);
					$addData['images'] = json_encode(null);
					$to_add[] = $addData;
				}else{
					$value['is_published'] = $film['is_published'];
					$value['ctime'] = $film['ctime'];
				}
				$list[] = $value;
			}
			trace($to_add);
			if($to_add)
				$movie->addAll($to_add);
			session_write_close();
			$this->assign('list', $list);
		}
		$this->success('查找成功', '', array(
			'tpl'=>$this->fetch(ONETHINK_ADDON_PATH.'MovieLog/search_list.html')
		));

	}

    //批量更新简介
    public function update_batch(){
		$id = I('id', 0);
        include_once ONETHINK_ADDON_PATH.'MovieLog/DoubanMovie.class.php';
        $obj = new \DoubanMovie();
        if($id == 0){
            $movie = D('Addons://MovieLog/Movie');
            $list = $movie->where("(summary is null OR summary = '') AND is_published = 1")->getField('id,id,title');
            $record = array_pop($list);
            $id = $record['id'];
        }else{
        	$list = session('batch_list');
            $record = $list[$id];
            unset($list[$id]);
        }
        $msg = "<tr><td>{$record['id']}</td><td>{$record['title']}</td><td class='success'>　√</td></tr>";

  		$detail = $obj->subject($id);
        $movie = D('Addons://MovieLog/Movie');
        if($detail['summary'] && $movie->save(array('id'=>$id, 'summary'=>$detail['summary'])) !== false)
            $result = "<td class='success'>　√</td>";
        else
            $result = "<td class='error'>　X</td>";
        $msg = "<tr><td>{$record['id']}</td><td>{$record['title']}</td>{$result}</tr>";
        if(count($list)){
            $new = array_slice($list, 0 ,1);
            echo "process({$new[0]['id']}, \"{$msg}\");";
            session('batch_list', $list);
        }else{
            session('batch_list', null);
            exit("process(0,'');");
        }
    }

	//更新数据
	public function update(){
		$data = I('post.');
		$model = D('Addons://MovieLog/Movie');
		$detail = $this->request("http://api.douban.com/v2/movie/subject/{$data['id']}");
		$detail = json_decode($detail, 1);
		$record = $model->find($data['id']);
		$record['images'] = $detail['images'];
		$record['is_published'] = 1;
		$record['ctime'] = $data['ctime'];
		$model = D('Addons://MovieLog/Movie');
		session_write_close();
		if($model->save($model->create($record, 5)) !== false){
			$this->success('');
		}else{
			$this->error('');
		}
	}

	//同步图片到本地
	public function syncImg(){
		$id = I('get.id');
		$detail = $this->request("http://api.douban.com/v2/movie/subject/{$id}");
		$detail = json_decode($detail, 1);
		$images = $detail['images'];
		$dir = ONETHINK_ADDON_PATH.'MovieLog/Upload/';
        if(!is_dir($dir))
            @mkdir($dir);
        $model = D('Addons://MovieLog/Movie');
        $model->curl_download($images['small'],"{$dir}s_{$id}.jpg");
        $model->curl_download($images['medium'],"{$dir}m_{$id}.jpg");
        $model->curl_download($images['large'],"{$dir}l_{$id}.jpg");
        $path = __ROOT__. ltrim(ONETHINK_ADDON_PATH.'MovieLog/Upload/', '.');
        $this->success('','', array('src'=>"{$path}{$dir}s_{$id}.jpg"));
	}

	//后台更新状态用
	public function toggleStatus(){
		$id = I('get.id');
		$model = D('Addons://MovieLog/Movie');
		$status = I('get.status');
		$data = array('id'=>$id, 'is_published'=> $status);
		if($model->save($data) !== false)
			$this->success('更新成功');
		else
			$this->error('更新失败');
 	}

	//刷新网盘图片
	public function refreshImg($file){
		$UpyunConfig = get_addon_config('MovieLog');
        $uploader = new Upyun('/', $UpyunConfig);
        $res = $uploader->refreshCache($file);
        if($res)
        	$this->success('');
        else
        	$this->error('');
	}

	//又拍云文件管理
	public function file(){
		$UpyunConfig = get_addon_config('MovieLog');
		$this->assign('upyunconfig', $UpyunConfig);
        $uploader = new Upyun('/', $UpyunConfig);
        $list = trace($uploader->getList());
        $this->display(ONETHINK_ADDON_PATH.'MovieLog/file.html');
	}

	public function request($url,$post_data = null, $method="get", $referer='', $header = null){

        if(is_array($post_data)){
            $post_data = http_build_query($post_data);
        }

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true );
        if($referer){
        	curl_setopt($ch, CURLOPT_REFERER, $referer);
        }
        if($method == 'post' && $post_data){
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        }
        // if ( defined( 'CURLOPT_IPRESOLVE' ) && defined(' CURL_IPRESOLVE_V4')) {
        //     curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        // }

        curl_setopt($ch, CURLOPT_HEADER, 0);
        if($header && is_array($header)){
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        }
        if($method == 'get' && $post_data)
        	$url .= $post_data;
        curl_setopt($ch, CURLOPT_URL,$url);
        // trace(curl_getinfo($ch));
        $result = curl_exec($ch);
        if(curl_errno($ch)){
            trace( 'Curl error: ' . curl_error($ch));
        }

        curl_close($ch);
        return $result;
    }
}
