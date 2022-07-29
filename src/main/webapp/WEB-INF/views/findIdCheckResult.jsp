<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function 
</script>
</head>
<body>
	
	<form name="findIdInformationCheck" method="post">
<!-- String user_name = request.getParameter("user_name");
String user_birth = request.getParameter("user_birth");
String user_phone = request.getParameter("user_phone");

userDAO dao = new userDAO();
String user_id = dao.findId(user_name, user_birth, user_phone);

		if (user_id !=null) {

		 -->
		<div class ="container">
			<div class="found-success">
				<h4> 회원님의 아이디는 </h4>
					${ user_id}
				<h4> 입니다.</h4>
				</div>
				<div class="found-login">
					<input type="button" id="btnLogin" value="로그인" onClick="login()"/>
			</div>
		</div>

		} else { 

			<div class="container">
			<div class="found-fail">
				<h4> 등록된 정보가 없습니다. </h4>
			</div>
			<div class="found-login">
				<input type="button" id="btnback" value="다시찾기" onClick="history.back()"/>
				<input type="button" id="btnjoin" value="회원가입" onClick="newMember()"/>
			</div>
			</div>
	

		}

	</form>

<a href="login">메인페이지로</a> 
</body>
</html>