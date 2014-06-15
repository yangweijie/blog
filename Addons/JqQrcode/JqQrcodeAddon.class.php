<?php

namespace Addons\JqQrcode;
use Common\Controller\Addon;

/**
 * jQuery二维码插件
 * @author yangweijie
 */

    class JqQrcodeAddon extends Addon{

        public $info = array(
            'name'=>'JqQrcode',
            'title'=>'jQuery二维码',
            'description'=>'用jQuery 生成站点内所需要的二维码',
            'status'=>1,
            'author'=>'yangweijie',
            'version'=>'0.2'
        );

        public function install(){
            $hookModel = M('Hooks');
            if(!$hookModel->where('name = "single"')->find()){
                $hookModel->add(array(
                    'name'=>'single',
                    'description'=>'单页面专门用的钩子',
                    'type'=>1,
                    'update_time'=>time()
                    )
                );
                S('hooks', null);
                if(!$hookModel->where('name = "single"')->find()){
                    session('addons_install_error', 'single钩子创建失败');
                    return false;
                }
            }
            return true;
        }

        public function uninstall(){
            return true;
        }

        //实现的single钩子方法
        //param必须有自己的text参数
        public function single($param){
            if($param['name'] == 'JqQrcode'){
                static $count = 1;
                if(isset($param['text'])){
                    $config = $this->getConfig();
                    $config = array_merge($param, $config);
                    $config['count'] = $count;
                    $this->assign('addons_config', $config);
                    $count ++;
                    $this->display('qrcode_single');
                }else{
                    trace("JqQrcode插件第{$count}次调用text参数没有传",'','ERR');
                }
            }
        }

        //实现的documentDetailAfter钩子方法
        public function documentDetailAfter($param){
            $config = $this->getConfig();
            if($config['article_status']){
                $config = array_merge($param, $config);
                $config['text'] = U('Article/detail?id='.$param['id'], '', true, true);
                $this->assign('addons_config', $config);
                $this->display('qrcode');
            }
        }

    }
