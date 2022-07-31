<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cti.user.model.userDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script  src="./js/jquery-1.11.3.min.js"></script>
</head>
<body>
	<form name="findIdInformationCheck" method="post">
	<script>
	userDAO dao = new userDAO();
	String user_id = dao.findId(user_name, user_birth, user_phone);	
	String user_name = request.getParameter("user_name");
	String user_birth = request.getParameter("user_birth");
	String user_phone = request.getParameter("user_phone");
	</script>
	</form>
	<form name="frmMemeber" method="post">
 <script> 	if (user_id !=null) { </script>
		<div class ="container">
			<div class="found-success">
				<h4> 회원님의 아이디는 </h4>
					 <script> ${user_id}</script>
				<h4> 입니다.</h4>
				</div>
				<div class="found-login">
					<input type="button" id="memberlogin" value="로그인" onClick="memberLogin()">
			</div>
		</div>

 <script>		} else { </script>

			<div class="container">
			<div class="found-fail">
				<h4> 등록된 정보가 없습니다. </h4>
			</div>
			<div class="found-login">
				<input type="button" value="다시찾기" onClick="history.back()">
				<input type="button" value="회원가입" onClick="memberNew()">
			</div>
			</div>
	

 <script>		} </script>

	</form>

<a href="login">메인페이지로</a> 
</body>
</html>