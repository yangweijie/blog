<?php

namespace Addons\MovieLog;
use Common\Controller\Addon;

/**
 * 电影记忆插件
 * @author yangweijie
 */

    class MovieLogAddon extends Addon{

        public $info = array(
            'name'=>'MovieLog',
            'title'=>'电影记忆',
            'description'=>'用于搜索记忆自己看过的电影、电视剧、动画片',
            'status'=>1,
            'author'=>'yangweijie',
            'version'=>'0.1'
        );

        public $admin_list = array(
            'model'=>'Movie',       //要查的表
            'fields'=>'*',          //要查的字段
            'map'=>'',              //查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
            'order'=>'ctime desc',      //排序,
            'list_grid'=>array(         //这里定义的是除了id序号外的表格里字段显示的表头名和模型一样支持函数和链接
                // 'id|:豆瓣电影id',
                'title:电影名',
                'id|movie_cover_img:海报',
                'ctime|time_format:观看时间',
                'id|movie_status:状态',
                'id:操作:[EDIT]|编辑,[DELETE]|删除'
            ),
        );

        public $custom_adminlist = 'adminlist.html';

        public function install(){
            if(!extension_loaded('curl')){
                session('addons_install_error', 'PHP的CURL扩展未开启');
                return false;
            }
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
                if(!$hookModel->where('name = "single"')->find())
                    session('addons_install_error', 'single钩子创建失败');
            }
            $sql = file_get_contents($this->addon_path . 'install.sql');
            $db_prefix = C('DB_PREFIX');
            $sql = str_replace('onethink_', $db_prefix, $sql);
            D()->execute($sql);
            $table_name = $db_prefix.'movie';
            if(count(M()->query("SHOW TABLES LIKE '{$table_name}'")) != 1){
                session('addons_install_error', ',movie表未创建成功，请手动检查插件中的sql，修复后重新安装');
                return false;
            }
            return true;
        }

        public function uninstall(){
            $db_prefix = C('DB_PREFIX');
            $sql = "DROP TABLE IF EXISTS `{$db_prefix}movie`;";
            D()->execute($sql);
            return true;
        }

        //实现的single钩子方法
        public function single($param){
            if($param['name'] == 'MovieLog'){
                include_once ONETHINK_ADDON_PATH.'MovieLog/function.php';
                $model = D('Addons://MovieLog/Movie');
                $list = $model->where('is_published = 1')->field('original_title,alt', true)->order('ctime desc, sort asc')->select();
                $months = $this->_dates($list);
                $this->assign('months', $months);
                $list = $this->_createObj($list);
                $config = get_addon_config('MovieLog');
                $this->assign('is_login', is_login());
                $this->assign('config', $config);
                $this->assign('list', $list);
                $this->display('single');
            }
        }

        //获取日期
        private function _dates($data) {
            $times = array();
            foreach ($data as $value) {
                $times[] = date('Ym', $value['ctime']);
            }
            $times = array_unique($times);
            $years = array();
            foreach ($data as $value) {
                $years[] = date('Y', $value['ctime']);
            }
            $years = array_unique($years);
            $data = array();
            foreach ($times as $value) {
                foreach ($years as $y) {
                    if(strpos($value, $y) !== false){
                        $data[$y][] = $value;
                        break;
                    }
                }
            }
            return $data;
        }

        //创建更适合使用的数据格式
        private function _createObj($arr) {
            $events = array();
            foreach ($arr as $event) {
                $day = date('Ym', $event['ctime']);
                $events[$day][] = $event;
            }
            return $events;
        }
    }
