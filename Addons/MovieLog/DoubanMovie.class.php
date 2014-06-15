<?php

	class DoubanMovie{

		public function __construct(){
			include_once './Addons/MovieLog/QueryList.class.php';
		}

		//搜索电影
		public function search($name , $json = false){
			$url = "http://movie.douban.com/subject_search?search_text={$name}";
			$reg = array(
				'title'=>array('a', 'text'),
				'alt'=>array('a', 'href'),
				'images'=>array('a img', 'src'),
				'rating'=>array('span.rating_nums', 'text'),
			);
			$rang = '#content .article table tr.item';
			$cj = new QueryList($url, $reg, $rang,'curl');
			$ret = $cj->jsonArr;
			foreach ($ret as &$value) {
				$titles = split('\/', $value['title']);
				$value['title'] = trim($titles[0]);
				unset($titles[0]);
				$value['original_title'] = join('/', $titles);
				$name = strstr($value['alt'],'subject/');
		        $name = ltrim($name,'subject/');
		        $name = trim($name,'/');
		        $images = array(
		        	'small'=>$value['images'],
		        	'medium'=>str_replace('ipst', 'spst', $value['images']),
		        	'large'=>str_replace('ipst', 'lpst', $value['images']),
	        	);
	        	$value['id'] = $name;
		        $value['images'] = $images;
			}
			$ret = count($ret)? array('total'=>count($ret), 'subjects'=>$ret): null;
			return $json? json_encode($ret) : $ret;
		}

		//电影详情
		public function subject($id, $json = false){
			$url = "http://movie.douban.com/subject/{$id}";
			$reg = array(
				'title'=>array('#content h1 span:eq(0)', 'text'),
				'year'=>array('#content h1 span:eq(1)', 'text'),
				'summary'=>array("span[property=v:summary]", 'text'),
				'summary_all'=>array("#link-report .all.hidden", 'text'),
				'season'=>array('#season','text'),
			);
			$cj = new QueryList($url, $reg);
			$ret = $cj->jsonArr[0];
			if($ret){
				$ret['year'] = trim($ret['year'], '()');
				$ret['type'] = $ret['season']? 'tv':'movie';
				if($ret['summary_all'])
					$ret['summary'] = $ret['summary_all'];
			}
			return $json? json_encode($ret) : $ret;
		}
	}
