<?php
$mysql = new SaeMysql();
$sql = "INSERT  INTO `onethink_auth_group_access` ( `uid`, `group_id`) VALUES ('2','1') ";
$mysql->runSql($sql);
?>