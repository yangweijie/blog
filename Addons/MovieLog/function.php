<?php

	if(!function_exists('movie_cover')){
		function movie_cover($name){
			$config = get_addon_config('MovieLog');
			$path = array(
				__ROOT__. ltrim(ONETHINK_ADDON_PATH.'MovieLog/Upload/', '.'),
				$config['bucket'],
			);
			if(is_file(".{$path[0]}{$name}"))
				return "{$path[0]}{$name}";
			else
				return "http://{$path[1]}.b0.upaiyun.com/{$name}";
		}
	}else{
		throw_exception('函数重复了:movie_cover');
	}

	function movie_cover_img($id){
		$name = "s_{$id}.jpg";
		$config = get_addon_config('MovieLog');
		$path = array(
			__ROOT__. ltrim(ONETHINK_ADDON_PATH.'MovieLog/Upload/', '.'),
			$config['bucket'],
		);
		if(is_file(".{$path[0]}{$name}"))
			return "<img src='{$path[0]}{$name}' movie_id='{$id}'>";
		else
			return "<img src='http://{$path[1]}.b0.upaiyun.com/{$name}' movie_id='{$id}'>";
	}

	//后台电影状态链接
	function movie_status($id){
		static $model;
		$model = D('Addons://MovieLog/Movie');
		$status = $model->getFieldById($id, 'is_published');
		if($status)
			return '<a href="'.addons_url("MovieLog://MovieLog/toggleStatus?id={$id}&status=0").'" class="ajax-get">已看</a>';
		else
			return '<a href="'.addons_url("MovieLog://MovieLog/toggleStatus?id={$id}&status=1").'" class="ajax-get">未看</a>';
	}

	function default_cover(){
		return __ROOT__.ltrim(ONETHINK_ADDON_PATH.'MovieLog/static/','.').'movie-default-medium.gif';
	}
