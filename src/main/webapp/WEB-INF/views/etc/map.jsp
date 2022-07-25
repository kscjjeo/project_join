<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/softphone.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function mapbtn(){
	opener.mapsubmit();
	window.close();/* 전송버튼 누를 시 URL창닫기 */
}
</script>
</head>
<body>
<div align="right"><input type="button" class="transfer_off_btn" style="width:45px;margin-top:5px;margin-right:10px;" value="전송" onclick="mapbtn()"></div>
<%-- <iframe id="framemap" src="http://www.klac.or.kr/helper/orgPopOffice.do?org_code=${org_code}"width="850px" height="850px" frameborder="0" scrolling="no"marginwidth="0" marginheight="0"></iframe> --%>
<iframe id="framemap" src="${org_code }"width="850px" height="850px" frameborder="0" scrolling="yes" marginwidth="0" marginheight="0"></iframe>
</body>
</html>