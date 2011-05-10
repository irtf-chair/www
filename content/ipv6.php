<?php
header("Expires: 0"); 
header("Cache-Control: no-cache"); 
?>

<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8>
<title></title>
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
if(strpos($_SERVER['REMOTE_ADDR'],":")){echo "<p>Thank you for using IPv6.</p>";}
?>
</body>
</html>