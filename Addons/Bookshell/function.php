<?php

if(!function_exists('preview_pic')){

	function preview_pic($cover_id, $height=50){
	    $src = get_cover($cover_id,'path');
	    if($src == __ROOT__)
	    	$src = ltrim(ONETHINK_ADDON_PATH.'Bookshell/static/images/cover.jpg','.');
	    return <<<str
<div class="upload-img-box">
	<div class="upload-pre-item">
		<img src="{$src}"/>
	</div>
</div>
str;
	}

}

function get_book_cover($cover_id){
 	$src = get_cover($cover_id,'path');
	    if($src == __ROOT__)
	    	$src = ltrim(ONETHINK_ADDON_PATH.'Bookshell/static/images/cover.jpg','.');
	return $src;
}
