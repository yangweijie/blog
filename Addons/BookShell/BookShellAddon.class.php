<?php

namespace Addons\BookShell;
use Common\Controller\Addon;

/**
 * 书架插件
 * @author yangweijie
 */

    class BookShellAddon extends Addon{

        public $info = array(
            'name'=>'BookShell',
            'title'=>'书架',
            'description'=>'专门展示文档书籍的',
            'status'=>0,
            'author'=>'yangweijie',
            'version'=>'0.1'
        );

        public $admin_list = array(
            'p'=>'10',
        );

        public $custom_adminlist = 'adminlist.html';

        public function install(){
            $sql = file_get_contents($this->addon_path . 'bookshell.sql');
            $db_prefix = C('DB_PREFIX');
            $sql = str_replace('onethink_', $db_prefix, $sql);
            D()->execute($sql);
            $table_name = $db_prefix.'bookshell';
            if(count(M()->query("SHOW TABLES LIKE '{$table_name}'")) != 1){
                session('addons_install_error', ',bookshell表未创建成功，请手动检查插件中的sql，修复后重新安装');
                return false;
            }
            return true;
        }

        public function uninstall(){
            $db_prefix = C('DB_PREFIX');
            $sql = "DROP TABLE IF EXISTS `{$db_prefix}bookshell`;";
            D()->execute($sql);
            return true;
        }

        //实现的single钩子方法
        public function single($param){
            if($param['name'] = 'BookShell')
                $this->display('single');
        }

    }
