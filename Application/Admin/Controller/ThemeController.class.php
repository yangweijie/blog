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
        if(!defined('THEME_PATH')){
            if(C('VIEW_PATH')){ // 视图目录
                define('THEME_PATH',   C('VIEW_PATH').DEFAULT_MODULE.'/');
            }else{ // 模块视图
                define('THEME_PATH',   APP_PATH.DEFAULT_MODULE.'/'.C('DEFAULT_V_LAYER').'/');

            }
        }
        $themes = glob(THEME_PATH . '/*');

        if ($themes) {
            $activated  = 0;
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
                    $info['screen'] = Typecho_Common::url(trim(__TYPECHO_THEME_DIR__, '/') .
                    '/' . $info['name'] . '/' . basename(current($screen)), $siteUrl);
                } else {
                    $info['screen'] = Typecho_Common::url('/img/noscreen.png', $adminUrl);
                }

                $result[$key] = $info;
            }
        }
    }

    /**
     * 编辑主题
     */
    public function edit($name){

    }

    /**
     * 启用主题
     */
    public function active($name){

    }

}
