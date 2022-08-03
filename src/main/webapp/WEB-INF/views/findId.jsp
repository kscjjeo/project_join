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
							location.href="findIdCheckResult?user_id="+data.user_id+"&result="+data.result;
						}else{
							location.href="findIdCheckResult?user_id="+data.user_id+"&result="+data.result;
						}
					}
					,error:function(data){
						alert("기입한 정보의 아이디를 찾을 수 없습니다.");
					}
				});
			} 
		}
		
		function fnTest(){
			$.ajax({
				type:"POST"
				,url:"test"
				,data:{}
				,success:function(data){
					fnSuc(data);
				}
				,error:function(data){
					alert("에러:"+data);
				}
			});
		}
		function fnSuc(request){
			var jsonData = request;
			
			console.log(jsonData.oneList);
			console.log(jsonData.list);
			
			var tableStr='<table border=1>';
			var tableEtr='</table>';
			
			var tbodb ='';
			var tbodb2='';
			tbodb +='<tr>';
			tbodb +='<th>아이디</th>'
			tbodb +='<th>비밀번호</th>'
			tbodb +='<th>성명</th>'
			tbodb +='<th>생년월일</th>'
			tbodb +='<th>핸드폰번호</th>'
			tbodb +='</tr>';
			
			tbodb2 = tbodb;
			
			if(jsonData.list.length > 0){
				for(t=0; t<jsonData.list.length; t++){
					tbodb+='<tr>';
					tbodb+='<td>'+jsonData.list[t].userId+'</td>';
					tbodb+='<td>'+jsonData.list[t].userPass+'</td>';
					tbodb+='<td>'+jsonData.list[t].userName+'</td>';
					tbodb+='<td>'+jsonData.list[t].userBirth+'</td>';
					tbodb+='<td>'+jsonData.list[t].userPhone+'</td>';
					tbodb+='</tr>';
				}
			}else{
				
				tbodb+='<tr>';
				tbodb+='<td colspan="5">조회된 데이터가 없습니다.</td>';
				tbodb+='</tr>';
			}
			if(jsonData.oneList){
				tbodb2+='<tr>';
				tbodb2+='<td>'+jsonData.oneList.userId+'</td>';
				tbodb2+='<td>'+jsonData.oneList.userPass+'</td>';
				tbodb2+='<td>'+jsonData.oneList.userName+'</td>';
				tbodb2+='<td>'+jsonData.oneList.userBirth+'</td>';
				tbodb2+='<td>'+jsonData.oneList.userPhone+'</td>';
				tbodb2+='</tr>';
			}else{
				
				tbodb2+='<tr>';
				tbodb2+='<td colspan="5">조회된 데이터가 없습니다.</td>';
				tbodb2+='</tr>';
			}
			
			
			document.getElementById("resultSet").innerHTML= tableStr + tbodb + tableEtr + tableStr + tbodb2 + tableEtr;  
			
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
		<div id="resultSet">
			
		</div>
		<input type="button" value="ID찾기" onclick="findIdCheck()">
		<input type="button" value="test" onclick="fnTest()">
	</body>
</html>