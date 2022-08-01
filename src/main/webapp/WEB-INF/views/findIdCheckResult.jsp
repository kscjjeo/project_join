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
	<%-- 
	
	1.request.getParameter는 Java언어임 jsp에서 Java 언어 쓰려면 <% %> 안에 써야함 
	2.script는 자바스크립트(js) 언어용으로 사용해야함 , js는 String 이런게 없음 보통 var나 const 이렇게씀 ex) var user_id = "ididid";
	 
	--%>
	</script>
	</form>
	<form name="frmMemeber" method="post">
 <script> 	if (user_id !=null) { </script>
		<div class ="container">
			<div class="found-success">
				<h4> 회원님의 아이디는 </h4>
					 <c:out value="${userId}" />
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