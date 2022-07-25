<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./js/jquery-1.11.3.min.js"></script>
<script>
$(document).ready(function(){
	$.ajax({
		type:"POST"
		,url:"schedule"
		,data:{}
		,success:function(data){
			window.open('about:blank','_self').close(); 
		    window.opener=self;
		    self.close(); 
		}
		,error:function(data){
			alert("로그아웃 안된 계정초기화 실패");
		}
	});
});
</script>
<title>Insert title here</title>
</head>
<body>

</body>
</html>