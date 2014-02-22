<?php

namespace Addons\Bookshell;
use Common\Controller\Addon;

/**
 * 书架插件
 * @author yangweijie
 */

    class BookshellAddon extends Addon{

        public function __construct(){
           parent::__construct();
           include_once $this->addon_path.'function.php';

        }

        public $info = array(
            'name'=>'Bookshell',
            'title'=>'书架',
            'description'=>'专门展示文档书籍的',
            'status'=>0,
            'author'=>'yangweijie',
            'version'=>'0.1'
        );

        public $admin_list = array(
            'model'=>'Bookshell',      //要查的表
            'fields'=>'*',          //要查的字段
            'map'=>'',              //查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
            'order'=>'id desc',     //排序,
            'list_grid'=>array(
                'cover_id|preview_pic:封面',
                'title:书名',
                'description:描述',
                'link_id|get_link:外链',
                'update_time|time_format:更新时间',
                'id:操作:[EDIT]|编辑,[DELETE]|删除'
            )
        );

        // public $custom_adminlist = 'adminlist.html';

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
            if($param['name'] == 'Bookshell'){
                $list = D('Addons://Bookshell/Bookshell')->select();
                $this->assign('addon_config', $this->getConfig());
                $this->assign('list', $list);
                $this->display('single');
            }
        }

    }
