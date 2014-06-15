<?php

namespace Addons\MovieLog\Model;
use Think\Model;
use Addons\MovieLog\Upyun;
/**
 * MovieLog模型
 */
class MovieModel extends Model{

    protected $_auto = array (
        array('ctime','strtotime',3,'function'), // 对ctime字段在更新的时候写入当前时间戳
        array('images','save_img',5,'callback')
    );

    protected function _after_find(&$result,$options) {
      $result['images'] = $result['images'] ? unserialize($result['images']): $result['images'];
      return $result;
    }

    protected function _after_select(&$result,$options){
        foreach($result as &$record){
            $this->_after_find($record,$options);
        }
    }

    public function save_img($images){
        include_once ONETHINK_ADDON_PATH.'MovieLog/function.php';
        $dir = ONETHINK_ADDON_PATH.'MovieLog/Upload/';
        if(APP_MODE == 'sae')
            $dir = SAE_TMP_PATH;
        $UpyunConfig = get_addon_config('MovieLog');
        $uploader = new Upyun('/', $UpyunConfig);
        $name = strstr($this->data['alt'],'subject/');
        $name = ltrim($name,'subject/');
        $name = trim($name,'/');
        if(!is_dir($dir))
            @mkdir($dir);
        $images = array(
            's'=>$this->curl_download($images['small'],"{$dir}s_{$name}.jpg"),
            'm'=>$this->curl_download($images['medium'],"{$dir}m_{$name}.jpg"),
            'l'=>$this->curl_download($images['large'],"{$dir}l_{$name}.jpg")
        );
        foreach ($images as $key => $value) {
            $file = array(
                'name'   =>"{$key}_{$name}.jpg",
                'savepath'=>'',
                'savename'=>"{$key}_{$name}.jpg",
                'type'   =>"image/jpeg",
                'size'   =>filesize($value),
                'tmp_name' =>$value,
                'md5'=>md5_file($value),
                'error' =>0,
            );
            $info = $uploader->save($file);
            if($info)
                @unlink($value);
        }
        $refresh = array();
        $return = array('small'=>"s_{$name}.jpg",'medium'=>"m_{$name}.jpg",'large'=>"l_{$name}.jpg");
        foreach($return as $r){
        	$refresh[] = movie_cover($r);
        }
        
        $uploader->refreshCache(join('\n', $refresh));
        return serialize($return);
    }

    public $model = array(
        'title'=>'电影',//新增[title]、编辑[title]、删除[title]的提示
        'template_add'=>'',//自定义新增模板自定义html edit.html 会读取插件根目录的模板
        'template_edit'=>'',//自定义编辑模板html
        'search_key'=>'',// 搜索的字段名，默认是title
        'extend'=>0,
    );

    public function curl_download($remote,$local){
        $cp = curl_init($remote);
        //if(APP_MODE == 'sae')
        //$local = str_replace('./', '/', "saekv:/{$local}");
        $fp = fopen($local,"w");
        curl_setopt($cp, CURLOPT_FILE, $fp);
        curl_setopt($cp, CURLOPT_HEADER, 0);
        curl_exec($cp);
        curl_close($cp);
        fclose($fp);
        return $local;
    }

    public $_fields = array(
        'id'=>array(
            'name'=>'id',//字段名
            'title'=>'ID',//显示标题
            'type'=>'num',//字段类型
            'remark'=>'',// 备注，相当于配置里的tip
            'is_show'=>2,// 1-始终显示 2-新增显示 3-编辑显示 0-不显示
            'value'=>0,//默认值
        ),
        'title'=>array(
            'name'=>'title',
            'title'=>'名称',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>1,
            'value'=>'',
        ),
        'is_published'=>array(
            'name'=>'is_published',
            'title'=>'状态',
            'type'=>'bool',
            'remark'=>'',
            'extra'=>'0:未看
1:已看',
            'is_show'=>3,
            'value'=>0,
        ),
        'ctime'=>array(
            'name'=>'ctime',
            'title'=>'观看时间',
            'type'=>'datetime',
            'remark'=>'',
            'is_show'=>3,
            'value'=>0,
        ),
        'original_title'=>array(
            'name'=>'original_title',
            'title'=>'原始标题',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>3,
            'value'=>'',
        ),
        'rating'=>array(
            'name'=>'rating',
            'title'=>'评分',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>3,
            'value'=>5.5,
        ),
        'year'=>array(
            'name'=>'year',
            'title'=>'年代',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>3,
            'value'=>2000,
        ),
        'rating'=>array(
            'name'=>'rating',
            'title'=>'原始标题',
            'type'=>'string',
            'remark'=>'',
            'is_show'=>3,
            'value'=>'',
        ),
        'summary'=>array(
            'name'=>'summary',
            'title'=>'简介',
            'type'=>'textarea',
            'remark'=>'',
            'is_show'=>3,
            'value'=>0,
        ),
        'subtype'=>array(
            'name'=>'subtype',
            'title'=>'类型',
            'type'=>'select',
            'remark'=>'',
            'extra'=>'tv:电视剧
movie:电影',
            'is_show'=>3,
            'value'=>'movie',
        ),
    );
}
