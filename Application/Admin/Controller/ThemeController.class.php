<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: yangweijie <yangweijiester@gmail.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台首页控制器
 * @author yangweijie <yangweijiester@gmail.com>
 */
class ThemeController extends AdminController {

    /**
     * 主题首页
     * @author yangweijie <yangweijiester@gmail.com>
     */
    public function index(){
        if(!defined('DEFAULT_MODULE'))
            define('DEFAULT_MODULE', 'Home');
        if(!defined('FRONT_THEME_PATH')){
            if(C('VIEW_PATH')){ // 视图目录
                define('FRONT_THEME_PATH',   C('VIEW_PATH').DEFAULT_MODULE.'/');
            }else{ // 模块视图
                define('FRONT_THEME_PATH',   APP_PATH.DEFAULT_MODULE.'/'.C('DEFAULT_V_LAYER').'/');
            }
        }
        $themes = glob(FRONT_THEME_PATH . '*');
        if ($themes) {
            $activated = 0;
            $result = array();
            foreach ($themes as $key => $theme) {
                $themeFile = $theme . '/theme.ini';
                if(file_exists($themeFile)){
                    $info = parse_ini_file($themeFile);
                    $info['name'] = basename($theme);
                    if ($info['activated'] = (C('DEFAULT_THEME') == $info['name'])) {
                        $activated = $key;
                    }
                }
                $screen = glob($theme . '/screen*.{jpg,png,gif,bmp,jpeg,JPG,PNG,GIF,BMG,JPEG}', GLOB_BRACE);
                if ($screen) {
                    $info['screen'] = U(ltrim(FRONT_THEME_PATH,'.').$info['name'].'/'.basename(current($screen)) , '', false);
                } else {
                    $info['screen'] = '__CSS__/images/noscreen.png';
                }
                $result[$key] = $info;
            }
            $this->assign('activated', $activated);
            $this->assign('list', $result);
        }

        $this->display();
    }

    /**
     * 编辑主题
     */
    public function edit($name=''){
        $this->assign('theme', $name);
        $this->display();
    }

    /**
     * 启用主题
     */
    public function active($name){
        $res = M('Config')->where("name = 'FRONT_THEME'")->save(array('value', $name));
        if($res !== false)
            $this->success('启用成功');
        else
            $this->error('启用失败');
    }

    public function save($file){
        $file = rawurldecode($file);
        $file = '.' . $file;
        $content = I('post.content');
        if(!file_exists($file))
            $this->error('错误的文件');
        if(!is_writable($file))
            $this->error('文件不可写');
        if(file_put_contents($file, $content))
            $this->success('保存成功');
        else
            $this->error('保存失败');
    }

}
