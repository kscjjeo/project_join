<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  	<head>
  	<link rel="shortcut icon" href="#">
		<title>PROJECT</title>
		<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
		<script>
		function passInformation(){
			location.href="passInformation";
		}	
		function enterkey() {
	        if (window.event.keyCode == 13) {
	             // 엔터키가 눌렸을 때 실행할 내용
	             memberLogin();
	        }
		}
		function passInformationCheck(){
			var id = $("#user_id").val();
			var name = $("#user_name").val();
			var birth = $("#user_birth").val();
			var phone = $("#user_phone").val();
			
			
			if(id == null || id == ''){
				alert("아이디를 입력해주세요.");
				$("#user_id").focus();
				return;
			} else if(name == null || name== ''){
				alert("이름을 입력해주세요.");
				$("#user_name").focus();
				return;
			} else if (birth == null || birth == ''){
				alert("생년월일을 입력해주세요.");
				$("#user_birth").focus();
				return;
			} else if(phone == null || phone == ''){
				alert("전화번호를 입력 해주세요.");
				$("#user_phone").focus();
				return;
			} else {
				$.ajax({
					type:"POST"
					,url:"passInformationAction"
					,data:{
						user_id:id,
						user_name:name,
						user_birth:birth,
						user_phone:phone

						}
					,success:function(data){
// 						alert(JSON.stringify(data))
						alert(data.msg);
						if (data.result == "suc"){
							location.href="passChange";
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
					<td>생년월일 입력</td>
					<td><input type="text" name="user_birth" id="user_birth" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>전화번호 입력</td>
					<td><input type="text" name="user_phone" id="user_phone" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
			</table>
		</form>
		<div id="resultSet">
			
		</div>
		<input type="button" value="비밀번호 변경하기" onclick="passInformationCheck()">
	</body>
</html>