<?php

namespace Addons\LREditor;
use Common\Controller\Addon;

/**
 * 左右Markdown编辑器插件
 * @author yangweijie
 */

    class LREditorAddon extends Addon{

        public $info = array(
            'name'=>'LREditor',
            'title'=>'左右Markdown编辑器',
            'description'=>'一个可以编写时同步预览的markdown 极简编辑器',
            'status'=>1,
            'author'=>'yangweijie',
            'version'=>'0.2'
        );

        public function install(){
            return true;
        }

        public function uninstall(){
            return true;
        }

        public function adminArticleEdit($data){
            $this->assign('addons_data', $data);
            $this->assign('addons_config', $this->getConfig());
            $this->display('content');
        }

        //实现的documentEditFormContent钩子方法
        public function documentEditFormContent($data){
            $this->assign('addons_data', $data);
            $this->assign('addons_config', $this->getConfig());
            $this->display('content');
        }

    }
