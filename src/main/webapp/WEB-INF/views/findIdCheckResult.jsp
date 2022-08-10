<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>아이디찾기</title>
<script  type="text/javascript" src="./js/jquery-1.11.3.min.js"></script>
	<script>
	/* function findIdCheckResult(){
		var abc = "123";
		console.log("1234ㅏㄴ첟 ");
		alert(abc);
	} */
	
<%-- 
	
	1.request.getParameter는 Java언어임 jsp에서 Java 언어 쓰려면 <% %> 안에 써야함 
	2.script는 자바스크립트(js) 언어용으로 사용해야함 , js는 String 이런게 없음 보통 var나 const 이렇게씀 ex) var user_id = "ididid";
	 eq / ==
	 ne / !=
	--%>
	</script>
</head>
<body>
	<form name="findIdInformationCheck" method="post">
		<c:choose>
			<c:when	test="${userResult eq 'suc'}">
				<div class="container">
					<div class="found-success">
						<h4> 회원님의 아이디는 </h4>
							<c:out value="${userId}" />
						<h4> 입니다.</h4>
					</div>
					<div class="found-login">
						<input type="button" id="memberlogin" value="로그인화면" onClick="location.href='login'">
						<input type="button" name="check" value="비밀번호변경" onClick="location.href='passInformation'">
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="container">
					<div class="found-fail">
						<h4> 기입한 정보의 아이디를 찾을 수 없습니다. </h4>
					</div>
					<div class="found-login">
						<input type="button" name="다시찾기화면" value="다시찾기" onClick="history.back()">
						<input type="button" name="회원가입화면" value="회원가입" onClick="location.href='memberNew'">
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</form>
<!-- 	<a href="login">메인페이지로</a>  -->
</body>
</html>