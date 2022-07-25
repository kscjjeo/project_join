<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript"  src="./js/jquery-1.11.3.min.js"></script>
<script>
	/* function search(){
		var option=$("select[name=option]").val();
		var h_name=$("#h_name").val();
		var year =$("select[name=year]").val();
		var month =$("select[name=month]").val();
		var day =$("select[name=day]").val();
		var year2 =$("select[name=year2]").val();
		var month2 =$("select[name=month2]").val();
		var day2 =$("select[name=day2]").val();
	
		$.ajax({
			type:"POST"
			,url:"history"
			,data:{year:year,month:month,day:day,year2:year2,month2:month2,day2:day2,h_name:h_name,option:option}
			,success:function(data){
			}
			,error:function(data){
				alert("스마트DMS전송실패");
			}
		});
	} */
</script>
<title>로그인이력</title>
</head>
<body>
	<div id="st_popup" style="width:670px;height:400px;">
		<div  class="call-transfer">
			<div style="margin:10px 10px 5px;">
			<form name="history" action="history" method="post">
				<select name="year" style="width:80px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=2018; i<2020; i++){ %>
					<option value="<%=i%>"><%=i %>년</option>
					<%} %>
				</select>
				<select name="month"   style="width:60px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=1; i<13; i++){ 
						if(i<10){
					%>
					<option value="0<%=i%>"><%=i %>월</option>					
					<%}else{%>
					<option value="<%=i%>"><%=i %>월</option>
						<% } 
					}%>
				</select>
				<select name="day"   style="width:60px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=1; i<32; i++){ 
						if(i<10){
					%>
					<option value="0<%=i%>"><%=i %>일</option>
					<%}else{%>
					<option value="<%=i%>"><%=i %>일</option>
						<% }
					}%>
				</select> 
				<span style="line-height:28px;font-weight:900;padding:5px;">~</span>
				<select name="year2"  style="width:80px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=2018; i<2020; i++){ %>
					<option value="<%=i%>"><%=i %>년</option>
					<%} %>
				</select>
				<select name="month2"  style="width:60px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=1; i<13; i++){ 
						if(i<10){
					%>
					<option value="0<%=i%>"><%=i %>월</option>					
					<%}else{%>
					<option value="<%=i%>"><%=i %>월</option>
						<% } 
					}%>
				</select>
				<select name="day2"   style="width:60px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;">
					<% for(int i=1; i<32; i++){ 
						if(i<10){
					%>
					<option value="0<%=i%>"><%=i %>일</option>
					<%}else{%>
					<option value="<%=i%>"><%=i %>일</option>
						<% }
					}%>
				</select>
				<br/><br/>
				<select  style="width:100px;height:28px;font-size:12px;font-weight:600;border:2px solid #dedede;" id="option" name="option">
				    <option value="ab_station">내선번호</option>
				    <option value="ab_agent">아이디</option>
				</select>
				<input type="text" id="h_name" name="h_name" class="search_form" style="font-size:12px;"> 
				<input type="submit" value="검색"  class="transfer_off_btn" style="width:45px;margin-top:1px;cursor:pointer;">
			</form>
			</div>
			<div class="call-transfer_in" style="width:620px;height:280px;padding-top:10px;">
				<table width="100%">
				<c:forEach items="${list2}" var="list2" varStatus="status">
					<c:if test="${status.count eq 1}">
						<tr style="border-bottom:4px double #3A5ECC;">
							<td style="width:70px;font-weight:600;line-height:30px;">Agent아이디</td>
							<td style="width:70px;font-weight:600;line-height:30px;">내선번호</td>
							<td style="width:70px;font-weight:600;line-height:30px;">emp아이디</td>
							<td style="width:150px;font-weight:600;line-height:30px;">시간</td>
							<td style="width:60px;font-weight:600;line-height:30px;">접속유무</td>
						</tr>
					</c:if>
					<tr style="border-bottom:1px dotted #999;">
						<td class="call-transfer_list">${list2.ab_agent}</td>
						<td style="line-height:30px;">${list2.ab_station}</td>
						<td style="line-height:30px;">${list2.ab_empid}</td>
						<td style="line-height:30px;">${list2.ab_date}</td>
						<td style="line-height:30px;">${list2.ab_onoff}</td>
					</tr>
				</c:forEach>
				<c:if test="${count eq '0'}">
					<span>검색된 내용이 없습니다.</span>
				</c:if>
			</table>
			</div>
		</div>
	</div>
</body>
</html>