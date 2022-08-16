<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  	<head>
  	<link rel="shortcut icon" href="#">
		<title>PROJECT</title>
		<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
		<script>
			function findId(){
				location.href="findId";
			}
			function memberNew(){
				location.href="memberNew";
			}

			function enterkey() {
		        if (window.event.keyCode == 13) {
		             // 엔터키가 눌렸을 때 실행할 내용
		             memberLogin();
		        }
			}
			function memberLogin(){
				
				var user_id = $("#user_id").val();
				var user_pass = $("#user_pass").val();
				
				if(user_id == null || user_id == ''){
					alert("아이디를 입력해주세요.");
					$("#user_id").focus();
					return;
				} else if(user_pass == null || user_pass == ''){
					alert("비밀번호를 입력해주세요..");
					$("#user_pass").focus();
					return;
				} else {
					$.ajax({
						type:"POST"
						,url:"loginAction"
						,data:{
							user_id:user_id,
							user_pass:user_pass
						}
						,success:function(data){
// 							alert(JSON.stringify(data))
							alert(data.msg);
							if(data.result == "suc"){
								location.href="main";	
							}
						}
						,error:function(data){
							alert("실패");
						}
					});
				} 
			}
		</script>		
	</head>
	<body>
		<form name="frmMemeber" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="user_id" id="user_id" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td><input type="password" name="user_pass" id="user_pass" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
			</table>
			<input type="button" value="회원가입입니당" onclick="memberNew()">
			<input type="button" value="로그인입니당" onclick="memberLogin()"><br>
			<input type="button" value="아이디찾기" onclick="findId()">
			<input type="button" value="비밀번호찾기" onclick="location.href='passInformation'">
		</form>
		
	</body>
</html>