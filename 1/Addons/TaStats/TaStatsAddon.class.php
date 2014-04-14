<?php

namespace Addons\TaStats;
use Common\Controller\Addon;

/**
 * 腾讯分析插件
 * @author yangweijie
 */

    class TaStatsAddon extends Addon{

        public $info = array(
            'name'=>'TaStats',
            'title'=>'腾讯分析',
            'description'=>'接入腾讯统计，需要自己去腾讯分析后台查看',
            'status'=>0,
            'author'=>'yangweijie',
            'version'=>'0.1'
        );

        public $custom_adminlist = 'admin.html';

        public $admin_list = array(
            'p'=>'',
        );

        public function install(){
            return true;
        }

        public function uninstall(){
            return true;
        }

        //实现的pageFooter钩子方法
        public function pageFooter($param){
            $config = $this->getConfig();
            echo $config['code'];
        }

    }