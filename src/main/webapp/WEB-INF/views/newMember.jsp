<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function newMemberCheck(){
		var id = $("#user_id").val();
		var pwd = $("#user_pass").val();
		var pwd2 = $("#user_pass2").val();
		var name = $("#user_name").val();
			
		var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;	//비밀번호 정규식체크
		
		var idConfirm = $("#idConfirm").val();
		var idSuc = $("#idSuc").val();
		if(id == null || id == ''){
			alert("아이디를 입력해주세요.");
			$("#user_id").focus();
			return;
		} else if (idConfirm != "suc" || id != idSuc) {
			alert("아이디 중복확인을 해주세요.");
			return;
		} else if(pwd == null || pwd == ''){
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
			alert("회원가입이 완료되었습니다.");
			$("#frmMemeber").submit();
		} 
	}
	function idCheck(){
		var user_id = $("#user_id").val();
		if(user_id == null || user_id == ''){
			alert("아이디를 입력해주세요.");
			$("#user_id").focus();
			return;
		}
		$.ajax({
			type:"POST"
			,url:"idCheck"
			,data:{
				user_id:user_id
			}
			,success:function(data){
				alert(data.msg);
				if(data.result == "suc"){
					$("#idConfirm").val("suc");
					$("#idSuc").val(user_id);
				} else {
					$("#idConfirm").val("");
				}
			}
			,error:function(data){
				alert("실패");
			}
		});
		
	}
</script>
</head>
<body>
	<form id="frmMemeber" method="post" action="newMemberAction">
		<table border="1">
			<tr>
				<td>* 아이디 :</td>
				<td><input type="text" name="user_id" id="user_id" /> <input type="button" value="ID중복확인" onclick="idCheck()"/>
					<input type="hidden" name="idConfirm" id="idConfirm" value="">
					<input type="hidden" name="idSuc" id="idSuc" value="">
				</td>
			</tr>
			<tr>
				<td>* 패스워드</td>
				<td><input type="text" name="user_pass" id="user_pass" style="width:97%"/></td>
			</tr>
			<tr>
				<td>* 패스워드 확인</td>
				<td><input type="password" name="user_pass2" id="user_pass2" style="width:97%"/></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="user_name" id="user_name" style="width:97%"/></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
					<select name="user_birth_y" style="width:99px;">
						<c:forEach var="name" begin="1950" end="2022" varStatus="status">
						<option value="${name}">${name}년</option>
						</c:forEach>
						
					</select> 
					<select name="user_birth_m" style="width:99px;">
						<c:forEach var="name" begin="1" end="12" varStatus="status">
						<option value="${name}">${name}월</option>
						</c:forEach>
					</select> 
					<select name="user_birth_d" style="width:99px;">
						<c:forEach var="name" begin="1" end="31" varStatus="status">
						<option value="${name}">${name}일</option>
						</c:forEach>
					</select> 
				</td>
			</tr>
			<tr>
				<td>휴대폰 번호</td>
				<td>
					<input type="text" name="user_phone_1" id="user_phone_1" style="width:81px;"/> -
					<input type="text" name="user_phone_2" id="user_phone_2" style="width:81px;"/> -
					<input type="text" name="user_phone_3" id="user_phone_3" style="width:81px;"/>
				</td>
			</tr>
		</table>
	</form>
	<input type="button" value="회원가입" onclick="newMemberCheck()">
</body>
</html>