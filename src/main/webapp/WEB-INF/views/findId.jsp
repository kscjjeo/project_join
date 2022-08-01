<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  	<head>
  	<link rel="shortcut icon" href="#">
		<title>PROJECT</title>
		<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
		<script>
		function memberNew(){
			location.href="memberNew";
		}	
		function enterkey() {
	        if (window.event.keyCode == 13) {
	             // 엔터키가 눌렸을 때 실행할 내용
	             memberLogin();
	        }
		}
		function findIdCheck(){
			var name = $("#user_name").val();
			var birth = $("#user_birth").val();
			var phone = $("#user_phone").val();
			
			if(name == null || name == ''){
				alert("이름을 입력해주세요.");
				$("#user_name").focus();
				return;
			} else if(birth == null || birth == ''){
				alert("생년월일을 8자리로 입력해주세요.");
				$("#user_birth").focus();
				return;
			} else if(phone == null || phone == ''){
				alert("전화번호를 입력해주세요.");
				$("#user_phone").focus();
				return;
			} else {
				$.ajax({
					type:"POST"
					,url:"findIdAction"
					,data:{
						user_name:name,
						user_birth:birth,
						user_phone:phone
					}
					,success:function(data){
// 						alert(JSON.stringify(data))
						alert(data.msg);
						if(data.result == "suc"){
							location.href="findIdCheckResult?user_id="+data.user_id;
						}
					}
					,error:function(data){
						alert("기입한 정보의 아이디를 찾을 수 없습니다.");
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
					<td>이름</td>
					<td><input type="text" name="user_name" id="user_name" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="user_birth" id="user_birth" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="user_phone" id="user_phone" autocomplete="off" onkeyup="enterkey();"/></td>
				</tr>
			</table>
		</form>
		<input type="button" value="ID찾기" onclick="findIdCheck()">
	</body>
</html>