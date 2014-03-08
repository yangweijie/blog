<?php

namespace Addons\Ping;
use Common\Controller\Addon;

/**
 * 文章发布ping插件插件
 * @author yangweijie
 */

    class PingAddon extends Addon{

        public $info = array(
            'name'=>'Ping',
            'title'=>'文章发布ping插件',
            'description'=>'用于发布文档后的主动ping，主动增加收录',
            'status'=>0,
            'author'=>'yangweijie',
            'version'=>'0.1'
        );

        public function install(){
            if(!extension_loaded('curl')){
                session('addons_install_error', 'PHP的CURL扩展未开启');
                return false;
            }
            return true;
        }

        public function uninstall(){
            return true;
        }

        //实现的documentSaveComplete钩子方法
        public function documentSaveComplete($param){
            list($id, $model_id) = $param;
            $config = $this->getConfig();
            $ping = new Ping();
            $ping->method(
                $config['site_name'],
                $config['site_url'],
                U($config['update_url'], array('id'=>$id)),
                U($config['update_rss'])
            );
            $ping->baidu();
            $ping->google();
        }

    }
