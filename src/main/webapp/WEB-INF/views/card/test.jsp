<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function QRcodeScanner() {
		app.QRcodeScanner();
		return false;
	}
	/* 
	    Call the 'showToast' method when the form gets 
	    submitted (by pressing button or return key on keyboard). 
	 */
	window.onload = function() {
		var form = document.getElementById("form");
		form.onsubmit = QRcodeScanner;
	}
</script>
</head>
<body>

	<form id="form">
		Message: <input id="message" name="message" type="text"></input><br />
		Long: <input id="length" name="length" type="checkbox"></input><br />
		<input type="submit" value="Make Toast"></input>
	</form>
</body>
</html>