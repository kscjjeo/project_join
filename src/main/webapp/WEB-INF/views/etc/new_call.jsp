<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/softphone.css" />
<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"      src="./js/btncontrol.js"></script>
<script>
function call(){
	
	opener.ct_answer();
	self.close();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body >
<div id="st_popup">
	<div class="popup_in">
		<div class="popup_tit">
			<h3>전화가 왔습니다.</h3>
		</div>
		<div style="overflow:hidden;">
			<img class="call_button_img" src="images/popup_img.png" alt="" />
			<div style="float:left;margin-top:30px;">
				<p class="caller_num">${phone }</p>
				<button class="call_button" onClick="call()">전화받기</button>
			</div>
		</div>
	</div>
</div><!-- softphone_wrap End-->
</body>
</html>