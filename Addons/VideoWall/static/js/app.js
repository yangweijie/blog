function checkFlashVersion(){
    var flash_html = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=need_version" width="0" height="0" data="player_uri"><param name="src" value="player_uri" /></object>';
    flash_html = flash_html.replace(/player_uri/g, config.flash.player_uri);
    flash_html = flash_html.replace(/need_version/g, config.flash.need_version);
    var div_element = document.createElement('div');
    div_element.style.width = '0';
    div_element.style.height = '0';
    div_element.innerHTML = flash_html;
    document.body.appendChild(div_element);
}
function isVideoCanPlay(video_type){
    var video_element = document.createElement('video');
    if (typeof (video_element.canPlayType) === 'undefined'){
        return false;
    }
    var result = video_element.canPlayType(video_type);
    if ((result === 'probably') || (result === 'maybe')){
        return true;
    }
    return false;
}

function addFlashVideoPlayer(){
    var source_nodes = document.getElementsByTagName('source');
    for (var i = 0, l = source_nodes.length; i < l; i++){
        if (source_nodes[i].type.indexOf(config.video.type) !== -1){
            if (source_nodes[i].parentNode.tagName.toLowerCase() === 'video'){
                var video_element = source_nodes[i].parentNode;
                var video_element_container = video_element.parentNode;
                var autoplay = video_element.autoplay;
            }else{
                //IE876
                var div_element = source_nodes[i].parentNode;
                var video_element = div_element.getElementsByTagName('video')[0];
                var video_element_container = div_element;
                var autoplay = typeof (video_element.autoplay) === 'undefined' ? false : true;
            }

            var params = {
                "flashvars": "config={&quot;playerId&quot;:&quot;player&quot;,&quot;clip&quot;:{&quot;url&quot;:&quot;video_file_url&quot;},&quot;playlist&quot;:[&quot;poster_file_url&quot;,{&quot;url&quot;:&quot;video_file_url&quot;,&quot;scaling&quot;:&quot;fit&quot;,&quot;autoPlay&quot;:autoPlay_value,&quot;autoBuffering&quot;:autoBuffering_value}]}",
                "src": config.flash.player_uri
            };
            params.flashvars = params.flashvars.replace(/video_file_url/g, source_nodes[i].src);
            params.flashvars = params.flashvars.replace(/poster_file_url/g, video_element.poster);
            params.flashvars = params.flashvars.replace(/autoPlay_value/g, autoplay);
            params.flashvars = params.flashvars.replace(/autoBuffering_value/g, config.flash.autoBuffering);

            var width = video_element.width;
            var height = video_element.height;
            var attributes = {
                "data": config.flash.player_uri,
                "width": width,
                "height": height
            };
            var flash_html = createFlashObjectHTML(attributes, params);
            var div_element = document.createElement('div');
            div_element.style.width = width;
            div_element.style.height = height;
            div_element.innerHTML = flash_html;
            video_element_container.insertBefore(div_element, video_element);
            video_element.style.display = "none";
        }
    }
}
function createFlashObjectHTML(attributes, params){
    var flash_html = '<object height="attribute_height" width="attribute_width" type="application/x-shockwave-flash" data="attribute_data"><param name="flashvars" value="param_flashvars" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="quality" value="high" /><param name="cachebusting" value="false" /><param name="bgcolor" value="#000000" /><param name="src" value="param_src" />html_when_no_flash</object>';
    flash_html = flash_html.replace(/attribute_height/g, attributes.height);
    flash_html = flash_html.replace(/attribute_width/g, attributes.width);
    flash_html = flash_html.replace(/attribute_data/g, attributes.data);
    flash_html = flash_html.replace(/param_flashvars/g, params.flashvars);
    flash_html = flash_html.replace(/param_src/g, params.src);
    flash_html = flash_html.replace(/html_when_no_flash/g, config.flash.html_when_no_flash);
    return flash_html;
            }

//解析
$('#search_form').submit(function() {
    if(!is_login){
        alert('请先登录');
        return false;
    }

    var url = $(this).attr('action');
    var $search = $(this).find('[name=url]');
    var search = $search.val();
    search = $.trim(search);
    if (search == '')
        return false;
    $('#myModal').html($('#loading_tpl').html());
    var bar = $('#myModal .progress .bar');
    var process = setInterval(function() {
        bar.width(function(n, c) {
            return c + 10;
        });
    }, 1000);
    var $btn = $(this).find(':submit');
    $btn.button('loading');
    $('#myModal').modal('show');
    $.ajax({
        url: url,
        type: 'post',
        data: {url: search},
        success: function(data) {
            clearInterval(process);
            bar.width('670');
            if(data.status)
                $('#myModal').html(data.tpl);
            else
                $('#myModal .modal-body').html(data.info);

        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            $('#myModal .modal-body').html('网络出错了');
        },
        complete: function(XMLHttpRequest, textStatus) {
            $btn.button('reset');
        }
    });
    return false;
});

$('#myModal').on('shown.bs.modal', function (e) {
    $(this).find('form').submit(function(){
        $(':submit', $(this)).button('loading');
        var form = $(this);
        $.ajax({
            type: "POST",
            url: form.attr('action'),
            data: form.serialize(),
            async: false,
            dataType:'json',
            success: function(data) {
                if(data.status){
                    $(this).modal('hide');
                    window.setTimeout(function(){
                        location.reload(true);
                    }, 1000);
                }else{
                    alert(data.info);
                }
                return false;
            }
        });
        return false;
    })
}).on('hidden.bs.modal',function(e){
    $(this).removeData('bs.modal');
});

// 播放视频
function play(id){
	var tpl = '';
    var $player = $('#player');
	if(all_videos[id] != undefined){
		var video = all_videos[id];
		if(video.video_id == 0 && video.video_url.indexOf('bili') == -1){//通用swf
			tpl=
            '<div class="modal-dialog">'+
                '<div class="modal-content">'+
                '    <div class="modal-header">'+
                '		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
                '		<h4 class="modal-title" id="myModalLabel"></h4>'+
                '	 </div>'+
                '    <div class="modal-body" style="width:'+video.width+'px">'+
                '		<div class="video">'+
        		'			<embed autostart="true" src="'+video.video_url+'" wmode="transparent" allowfullscreen="true" type="application/x-shockwave-flash" width="'+video.width+'" height="'+video.height+'"></embed>'+
        		'	 	</div>'+
                '    </div>'+
                '</div>'+
            '</div>';
		}else{
            var autoplay = video.auto? 'autoplay="autoplay" ' : '';
            var loop = video.circle? 'loop="loop" ':'';
            var preload = video.preload? 'preload="preload" ':'';
            tpl=
            '<div class="modal-dialog">'+
                '<div class="modal-content">'+
                '    <div class="modal-header">'+
                '       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
                '       <h4 class="modal-title" id="myModalLabel"></h4>'+
                '    </div>'+
                '    <div class="modal-body" style="width:'+video.width+'px">'+
                '       <div><!--每个video都需要有一个单独的parentNode，即每个video外面都有个div或者p等等。为了兼容IE876-->'+
                '           <video controls="controls" width="'+video.width+'" height="'+video.height+'" poster="'+video.cover+'"'+ autoplay + loop + preload + '>'+
                '               <source src='+video.video_url+' type="video/mp4" />'+
                '           </video>'+
                '       </div>'+
                '    </div>'+
                '</div>'+
            '</div>';
		}
	}else{
		tpl =
            '<div class="modal-dialog">'+
                '<div class="modal-content">'+
                '    <div class="modal-header">'+
                '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
                '        <h4 class="modal-title" id="myModalLabel">出错了：</h4>'+
                '    </div>'+
                '    <div class="modal-body">'+
                '        <div calss="alert alert-info">错误的数据对象</div>'+
                '    </div>'+
                '</div>'+
            '</div>';
	}

    $player.on('hidden.bs.modal',function(e){
        var now_video = $(this).find('video')[0];
        if(now_video != undefined){
            now_video.currentTime = 0;
            now_video.pause();
        }
        $(this).removeData('bs.modal');
    });

    $player.html(tpl);
    $player.width($('.modal-body', $player).outerWidth());
    $player.find('.modal-body').css('max-height','none');
	// $player.html(tpl).width($('.modal-body', $player).outerWidth());
	$player.modal('show');
    if ( video.id && isVideoCanPlay(config.video.type ) === false){
        checkFlashVersion();
        addFlashVideoPlayer();
    }
}

$('#J_MegaTimelinePosts').scroll(function(){
    $('#J_MegaTimeLineSelector ul').removeClass('selected');
    $('#J_MegaTimeLineSelector ul li.active').parent().addClass('selected');
}).trigger('scroll');
$('#J_MegaTimeLineSelector ul:first').addClass('selected').find('li:eq(1)').addClass('active');

$('.edit').click(function(){
    $('#myModal').load(this.href);
    $('#myModal').modal('show');
    return false;
});

$('.media-object').error(function(){
    this.src = no_pic;
});


