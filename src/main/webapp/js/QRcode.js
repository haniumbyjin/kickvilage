
	function QRcodeScanner() {
		app.QRcodeScanner();
		return false;
	}
	/* 
	    Call the 'showToast' method when the form gets 
	    submitted (by pressing button or return key on keyboard). 
	 */
	window.onload = function() {
		var form = document.getElementById("qrcode");
		form.onsubmit = QRcodeScanner;
	}
