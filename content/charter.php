<?php
if (preg_match("/^((as|cf|dtn|hip|icc|nm|p2p|r|sam|tm|vn)rg|mobopts)$/i", $_GET["group"])) {
	$tgt = strtolower($_GET["group"]);
} else {
	$tgt = "concluded/" . strtolower($_GET["group"]);
}
header("Location: http://" . $_SERVER["HTTP_HOST"] . "/" . $tgt, true, 301);
?>
