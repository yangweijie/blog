<?php
return array(
	'article_status'=>array(
		'title'=>'是否文章详情页启用',
		'type'=>'select',
		'options'=>array(
			'1' => '启用',
			'0' => '不启用',
		),
		'value'=>'1',
	),
	'width'=>array(
		'title'=>'默认宽',
		'type'=>'text',
		'value'=>'200',
	),
	'height'=>array(
		'title'=>'默认高',
		'type'=>'text',
		'value'=>'200',
	),
	'typeNumber'=>array(
		'title'=>'计算模式:',
		'type'=>'select',
		'options'=>array(
			'-1'=>'-1',
			'0'=>'0',
			'1'=>'1',
			'2'=>'2',
			'3'=>'3',
			'4'=>'4',
			'5'=>'5',
			'6'=>'6',
		),
		'value'=>'-1',
	),'correctLevel'=>array(
		'title'=>'纠错等级',
		'type'=>'select',
		'options'=>array(
			'1' => 'L',
			'0' => 'M',
			'3' => 'Q',
			'2' => 'H'
		),
		'value'=>'2',
	),'background'=>array(
		'title'=>'背景颜色',
		'type'=>'text',
		'value'=>'#ffffff',
	),'foreground'=>array(
		'title'=>'前景颜色',
		'type'=>'text',
		'value'=>'#000000',
	),

);

