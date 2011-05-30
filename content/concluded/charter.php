<?php
if (preg_match("/^((as|cf|dtn|hip|icc|nm|p2p|r|sam|tm|vn)rg|mobopts)$/i", $_GET["group"])) {
	$tgt = strtolower($_GET["group"]);
} elseif ($_GET["group"] == "hip") {	
        $tgt = "hiprg";
} elseif ($_GET["group"] == "p2pr") {	
        $tgt = "p2prg";
} elseif ($_GET["group"] == "cfr") {	
        $tgt = "cfrg";
} else {
	$tgt = "concluded/" . strtolower($_GET["group"]);
}
header("Location: http://" . $_SERVER["HTTP_HOST"] . "/" . $tgt, true, 301);
?>
