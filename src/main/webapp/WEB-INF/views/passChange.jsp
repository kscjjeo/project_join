<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  	<head>
  	<link rel="shortcut icon" href="#">
		<title>PROJECT</title>
		<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
		<script>
		function passChange(){
			location.href="passChange";
		}	
		function enterkey() {
	        if (window.event.keyCode == 13) {
	             // 엔터키가 눌렸을 때 실행할 내용
	             memberLogin();
	        }
		}
		function passCheck(){
			var id = $("#user_id").val();
			var name = $("#user_name").val();
			var pwd = $("#user_pass").val();
			var pwd2 = $("#user_pass2").val();
			var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;	//비밀번호 정규식체크
			
			if(id == null || id == ''){
				alert("아이디를 입력해주세요.");
				$("#user_id").focus();
				return;
			} else if(name == null || name== ''){
				alert("이름을 입력해주세요.");
				$("#user_name").focus();
				return;
			} else if 
			(pwd == null || pwd == ''){
				alert("패스워드를 입력해주세요.");
				$("#user_pass").focus();
				return;
			} else if(!regExp.test(pwd)){
			    alert("8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합해야합니다.");
			    $("#user_pass").focus();
			    return false;
			} else if(pwd2 == null || pwd2 == ''){
				alert("패스워드를 확인 입력해주세요.");
				$("#user_pass2").focus();
				return;
			} else if(pwd != pwd2 ){
				alert("패스워드가 다릅니다.");
				$("#user_pass2").focus();
				return;
			} else {
				$.ajax({
					type:"POST"
					,url:"passChangeAction"
					,data:{
						user_id:id,
						user_name:name,
						user_pass:pwd 

						}
					,success:function(data){
// 						alert(JSON.stringify(data))
						if (data.result == "suc"){
							alert("비밀번호가 변경되었습니다.");
							
						}
					}
						,error:function(data){
							alert("실패!@!@!");
				/* alert("비밀번호가 변경되었습니다.");
				$("#frmMember").submit(); */
						}
					}				
				);
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
					<td>이름</td>
					<td><input type="text" name="user_name" id="user_name" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>비밀번호 입력</td>
					<td><input type="text" name="user_pass" id="user_pass" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>비밀번호 재입력</td>
					<td><input type="password" name="user_pass2" id="user_pass2" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
			</table>
		</form>
		<div id="resultSet">
			
		</div>
		<input type="button" value="비밀번호 변경하기" onclick="passCheck()">
	</body>
</html>