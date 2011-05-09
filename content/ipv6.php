<?php
header("Expires: 0"); 
header("Cache-Control: no-cache"); 
?>

<html>
<head>
<style type="text/css">
p {
	text-align: right;
	font-size: 12px;
	font-family: Georgia, Palatino, Times, 'Times New Roman', serif;
	line-height: 27px;
	margin: 0;
	padding: 0;
}
body {
	height: 30px;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>

<?php

if (strpos($txt, ":")) {
	echo "<p>Thank you for using IPv6.</p>";
}

?>
</body>
</html>