<?php

namespace Addons\VideoWall;
use Common\Controller\Addon;

/**
 * 视频墙插件
 * @author yangweijie
 */

    class VideoWallAddon extends Addon{

        public $info = array(
            'name'=>'VideoWall',
            'title'=>'视频墙',
            'description'=>'用于记录网上看的视频和自己上传的视频',
            'status'=>1,
            'author'=>'yangweijie',
            'version'=>'0.2'
        );

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
            $table_name = $db_prefix.'video';
            if(count(M()->query("SHOW TABLES LIKE '{$table_name}'")) != 1){
                session('addons_install_error', ',video表未创建成功，请手动检查插件中的sql，修复后重新安装');
                return false;
            }
            return true;
        }

        public function uninstall(){
            $db_prefix = C('DB_PREFIX');
            $sql = "DROP TABLE IF EXISTS `{$db_prefix}video`;";
            D()->execute($sql);
            return true;
        }

        //实现的single钩子方法
        public function single($param){
            if($param['name'] == 'VideoWall'){
                include_once ONETHINK_ADDON_PATH.'VideoWall/function.php';
                $model = D('Addons://VideoWall/Video');
                $list = $model->order('create_time desc, update_time desc')->select();
                $months = $this->_dates($list);
                $this->assign('months', $months);
                $list = $this->_createObj($list);
                // $config = get_addon_config('VideoWall');
                $this->assign('is_login', is_login());
                // $this->assign('config', $config);
                $this->assign('list', $list);
                trace($model->getField('id,title,desp,cover,video_id,video_url,width,height,auto,preload,circle,create_time,update_time'));
                $this->assign('all_videos', json_encode($model->getField('id,title,desp,cover,video_id,video_url,width,height,auto,preload,circle,create_time,update_time')));
                $this->display('single');
            }
        }

        //获取日期
        private function _dates($data) {
            $times = array();
            foreach ($data as $value) {
                $times[] = date('Ym', $value['create_time']);
            }
            $times = array_unique($times);
            $years = array();
            foreach ($data as $value) {
                $years[] = date('Y', $value['create_time']);
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
                $day = date('Ym', $event['create_time']);
                $events[$day][] = $event;
            }
            return $events;
        }

    }
