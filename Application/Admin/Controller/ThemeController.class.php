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

    public function path(){
        if(!defined('DEFAULT_MODULE'))
            define('DEFAULT_MODULE', 'Home');
        if(!defined('FRONT_THEME_PATH')){
            if(C('VIEW_PATH')){ // 视图目录
                define('FRONT_THEME_PATH',   C('VIEW_PATH').DEFAULT_MODULE.'/');
            }else{ // 模块视图
                define('FRONT_THEME_PATH',   APP_PATH.DEFAULT_MODULE.'/'.C('DEFAULT_V_LAYER').'/');
            }
        }
    }

    /**
     * 主题首页
     * @author yangweijie <yangweijiester@gmail.com>
     */
    public function index(){
        $this->path();
        $themes = glob(FRONT_THEME_PATH . '*');
        if ($themes) {
            $activated = 0;
            $result = array();
            foreach ($themes as $key => $theme) {
                $themeFile = $theme . '/theme.ini';
                if(file_exists($themeFile)){
                    $info = parse_ini_file($themeFile);
                    $info['name'] = basename($theme);
                    if ($info['activated'] = (C('FRONT_THEME') == $info['name'])) {
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
    public function edit($name='',$file = ''){
        $this->assign('theme', $name);
        if(!defined('DEFAULT_MODULE'))
            define('DEFAULT_MODULE', 'Home');
        if(!defined('FRONT_THEME_PATH')){
            if(C('VIEW_PATH')){ // 视图目录
                define('FRONT_THEME_PATH',   C('VIEW_PATH').DEFAULT_MODULE.'/');
            }else{ // 模块视图
                define('FRONT_THEME_PATH',   APP_PATH.DEFAULT_MODULE.'/'.C('DEFAULT_V_LAYER').'/');
            }
        }
        $files = glob(FRONT_THEME_PATH.C('FRONT_THEME').'/*/*.html');
        foreach ($files as $key => $value) {
            $files[$key] = str_replace(FRONT_THEME_PATH.C('FRONT_THEME').'/', '', $value);
        }
        $this->assign('list', $files);
        if($file){
            $content = file_get_contents(FRONT_THEME_PATH.C('FRONT_THEME').'/'.base64_decode($file));
            $this->assign('content', $content);
            $this->assign('file', $file);
        }else{
            $file = array_pop($files);
            $content = file_get_contents(FRONT_THEME_PATH.C('FRONT_THEME').'/'.$file);
            $this->assign('content', $content);
            $this->assign('file', base64_encode($file));
        }
        $this->display();
    }

    /**
     * 启用主题
     */
    public function active($name){
        $res = M('Config')->where("name = 'FRONT_THEME'")->setField('value', $name);
        if($res !== false){
            S('DB_CONFIG_DATA',null);
            $this->success('启用成功');
        }else{
            $this->error('启用失败');
        }
    }

    public function save($file){
        $this->path();
        $file = base64_decode($file);
        $file = FRONT_THEME_PATH.C('FRONT_THEME').'/' . $file;
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
