<?php
if($_GET["gtype"]=="old-rg"){
$tgt="Location: http://".$_SERVER["HTTP_HOST"]."/concluded/".$_GET["group"];
} else {
$tgt="Location: http://".$_SERVER["HTTP_HOST"]."/".$_GET["group"];
}
header($tgt);
?>
