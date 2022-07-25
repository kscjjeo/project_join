<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="css/softphone.css" />
<script type="text/javascript" src="./js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="./js/reset.js"></script>
<script type="text/javascript" src="./js/array.js"></script>
<script>
var win; /* map 팝업창 초기화 */
$(function() {
	$("#first").click(function() {
		$('.hide1').show();
		$('.hide2').hide();
		$("#search").focus();
		$("#first").addClass('tab_menu_list_on');
		$("#first").removeClass('tab_menu_list');

		$("#second").addClass('tab_menu_list');
		$("#second").removeClass('tab_menu_list_on');
		
	});
	$("#second").click(function() {
		
		
		$('.hide1').hide();
		$('.hide2').show();
		$("#phone_s2").focus();
		$("#first").addClass('tab_menu_list');
		$("#first").removeClass('tab_menu_list_on');
		
		$("#second").addClass('tab_menu_list_on');
		$("#second").removeClass('tab_menu_list');
		
	});
});
	function removespace(sth){
				sth = sth.replace(/(\s*)/g, "");
				return sth;
	}
	 function submitcheck() {
		var name = document.getElementById("search").value;
		var phone_val =document.getElementById("phone").value;
		document.getElementById("phone_s").value=phone_val;
		removename = removespace(name);// 공백제거 
		if (removename == "" || removename == null) {
			alert('검색 할 단어를 입력 해주세요.');
			return false;
		}else{
			document.getElementById("search").value= removename;
			return true;
		}
	}
	function urlcheck(code,name,agentid,db_url ) {
		/* if($("input:radio[name='url']").is(":checked")==false){
			alert('체크 선택을 해주세요.');
			return false;
		} */
		/* var code = $("#code").val(); */
		$("#url").val(db_url);    //db에서 url 가져옴
		$("#smstext").val(name);
		$("#code").val(code);
		$("#agentid").val(agentid);
		
		
		var phone_val = document.getElementById("phone").value;
		var r_phone = removespace(phone_val);/* 공백제거 */
		if ($("#phone").val() != "") {
			
			var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
			var strValue = $("#phone").val();
			var chkFlg = rgEx.test(strValue);
			if (!chkFlg) {
				alert("올바른 휴대폰번호가 아닙니다.");
				$("#phone").focus();
				return false;
			}
		}
		if (r_phone == "" || r_phone == null) {/* 번호입력창 빈값 일 경우 */
			alert('번호를 입력해주세요');
			document.getElementById("phone").focus();
			return false;
		} else {
			document.getElementById("phone").value = r_phone;
			dmskey();
			$("#dmskey").val(dmskey);
			$("#st_popup").css("display", "none");
			$(".send").css("display", "");			
			document.getElementById("urlsubmit").submit();
		}
		
		
		win.close();
		return true;

	}
	url = "";
	phone = "";
	smstext = "";
	$(document).ready(function() {
		$("#search").focus();
		$("#st_popup").css("display", "");
		$(".send").css("display", "none");
		
		if($("#view").val()==1){/* 상담방문예약 탭 보여줌 */
			$(".hide1").hide();
			$(".hide2").show();
			$("#phone_s2").focus();
			$("#first").addClass('tab_menu_list');
			$("#first").removeClass('tab_menu_list_on');
			$("#second").addClass('tab_menu_list_on');
			$("#second").removeClass('tab_menu_list');
			
		}else{/* 기관검색 탭 보여줌 */
			$(".hide1").show();
			$(".hide2").hide();
			$("#search").focus();
			$("#first").addClass('tab_menu_list_on');
			$("#first").removeClass('tab_menu_list');
			$("#second").addClass('tab_menu_list');
			$("#second").removeClass('tab_menu_list_on');
			
		}
		 var po_innerHTML = "";
			for ( var i = 0; i < t_reservelist.length; i++ ) {
				
				po_innerHTML += "<li class='DB_list'>";
				po_innerHTML += "<span>"+t_reservelist[i]+"</span>";
				po_innerHTML += "<input type='hidden'  id='url1' name='url1' value='"+n_reservelist[i]+"' >";
				po_innerHTML += "<input type='hidden'  id='smstext1' name='smstext1' value='"+t_reservelist[i]+"' >";
				po_innerHTML +="<input type='button' class='search_btn' style='width:40px; margin:0px 2px;' onclick='reservesubmit(this)' value='전송'>";
				if(t_reservelist[i] == "방문 상담 예약"){
					po_innerHTML +="<input type='button' class='kakao_btn' style='width:55px; background-color:darkgray' onclick='kakao_reservesubmit(this)' value='카카오톡'>";
				}
				
		      }
			reserve.innerHTML =po_innerHTML;
			
		
		/*  $('input[name="url"]').click(function(){
				if($(this).prop('checked')){
					urlid = $(this).attr('id'); 
					 $("input[name=smstext]").attr("disabled",true); 
					 $("input[name=smstext][class="+urlid+"]").attr("disabled",false); 
					 smstext = $("input[name=smstext][class="+urlid+"]").val(); 
				}
			}) 
		  radio 체크 시 약도 팝업 창 생성 
		 //dmskey();
		 //$("#dmskey").val(dmskey);
		//url =$("input[type=radio][name=url]:checked").val();
		//phone=$("#phone").val();
		//dmskey = $("#dmskey").val();
		 $("input:radio[name=url]").click(function() {
		org_code =$("input:radio[name=url]:checked").val();
		window.open("map?org_code="+org_code,"map","width=800,height=800,scrollbar=yes");
		  window.open("http://www.klac.or.kr/helper/orgPopOffice.do?org_code="+org_code&url=url,"child","width=500,height=300,scrollbar=yes");
		 })  */
	});
	function reservesubmit(self) {  //방문상담예약 전송
		var idx = $(self).index('.search_btn');
		var phone_val = document.getElementById("phone_s2").value;
		var r_phone = removespace(phone_val);/* 공백제거 */
		if (r_phone == "" || r_phone == null) {/* 번호입력창 빈값 일 경우 */
			alert('번호를 입력해주세요.');
			document.getElementById("phone_s2").focus();
			return false;
		} else {
			document.getElementById("phone_s2").value = r_phone;
		}
		if (r_phone != "") {
			
			var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
			var strValue = r_phone;
			var chkFlg = rgEx.test(strValue);
			if (!chkFlg) {
				alert("올바른 휴대폰번호가 아닙니다.");
				$("#phone_s2").focus();
				return false;
			}
		}
		var submiturl = "";
		//var code = $("#code").val();
		//$("#url").val(v_url+t_code);
		dmskey();
		var d_dmskey = dmskey;
		var d_phone = $("#phone_s2").val();
		var d_key = "2";
		var d_url = $('.DB_list > #url1').eq(idx-1).val(); 
		var d_smstext = $("#smstext1").val();  
		/* var submiturl = "urlsubmit?dmskey="+dmskey+"&phone="+phone+"&url="+url+"&smstext="+smstext; */
		$("#st_popup").css("display", "none");
		$(".send").css("display", "");
		$.ajax({
			type : "POST",
			url : "urlsubmit",
			data : {
				phone : d_phone,
				smstext : d_smstext,
				dmskey : d_dmskey,
				url : d_url,
				key : d_key
			},
			success : function(data) {
				window.close();
			},
			error : function(data) {
				alert("스마트DMS전송실패!");
				window.close();
			}
		});
	}	
	function kakao_reservesubmit(self) {  //방문상담예약 전송
		var idx = $(self).index('.kakao_btn');
		var phone_val = document.getElementById("phone_s2").value;
		var r_phone = removespace(phone_val);/* 공백제거 */
		
		if (r_phone == "" || r_phone == null) {/* 번호입력창 빈값 일 경우 */
			alert('번호를 입력해주세요.');
			document.getElementById("phone_s2").focus();
			return false;
		} else {
			document.getElementById("phone_s2").value = r_phone;
		}
		if (r_phone != "") {
			
			var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
			var strValue = r_phone;
			var chkFlg = rgEx.test(strValue);
			if (!chkFlg) {
				alert("올바른 휴대폰번호가 아닙니다.");
				$("#phone_s2").focus();
				return false;
			}
		}
		
		//console.log("대표번호 : "+${comp_tenr}) /* 대표번호 확인 */
		console.log("고객번호 : " + r_phone)	/* 고객번호 확인 */
		
		
		$.ajax({
			type : "POST",
			url : "kakao_submit",
			data : {
				RCV_PHN_ID : r_phone
				//, comp_tenr : ${comp_tenr}
			},
			success : function(data) {
				alert(data.result);
			},
			error : function(data) {
				alert("카카오톡 전송 실패!");
				window.close();
			}
		});
		
	}	
	
	function preview(t_code,t_smstext,db_url) {
		//var code = $("#code").val();
		$("#t_smstext").val(t_smstext);  //smstext 저장용
		$("#t_url").val(db_url);   //url저장용
		org_code = $("#t_url").val();
		win = window.open("map?org_code=" + org_code, "map","width=1000,height=1000,scrollbar=yes");
	}
	function mapsubmit() {
		var phone_val = document.getElementById("phone").value;
		var r_phone = removespace(phone_val);/* 공백제거 */
		if (r_phone == "" || r_phone == null) {/* 번호입력창 빈값 일 경우 */
			alert('번호를 입력해주세요.');
			document.getElementById("phone").focus();
			return false;
		} else {
			document.getElementById("phone").value = r_phone;
			dmskey();
		}
		if (r_phone != "") {
			
			var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
			var strValue = r_phone;
			var chkFlg = rgEx.test(strValue);
			if (!chkFlg) {
				alert("올바른 휴대폰번호가 아닙니다.");
				$("#phone").focus();
				return false;
			}
		}
		var submiturl = "";
		//var code = $("#code").val();
		//$("#url").val(v_url+t_code);
		var d_dmskey = dmskey;
		var d_phone = $("#phone").val();
		var d_key = "2";
		var d_url = $("#t_url").val();  //preview 에서 저장한걸 이용
		var d_smstext = $("#t_smstext").val();  //preview 에서 저장한걸 이용
		/* var submiturl = "urlsubmit?dmskey="+dmskey+"&phone="+phone+"&url="+url+"&smstext="+smstext; */
		$("#st_popup").css("display", "none");
		$(".send").css("display", "");
		$.ajax({
			type : "POST",
			url : "urlsubmit",
			data : {
				phone : d_phone,
				smstext : d_smstext,
				dmskey : d_dmskey,
				url : d_url,
				key : d_key
			},
			success : function(data) {
				window.close();
			},
			error : function(data) {
				alert("스마트DMS전송실패");
				window.close();
			}
		});
	}
	function getTimeStamp() {
		var d = new Date();
		var s = leadingZeros(d.getFullYear(), 4)
				+ leadingZeros(d.getMonth() + 1, 2)
				+ leadingZeros(d.getDate(), 2) +

				leadingZeros(d.getHours(), 2) + leadingZeros(d.getMinutes(), 2)
				+ leadingZeros(d.getSeconds(), 2);

		return s;
	}

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}
	var dmskey;
	function dmskey() {
		dmskey = getTimeStamp() + $("#agentid").val();
	}
	function InpuOnlyNumber(obj) {
		$(obj).keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>스마트DMS</title>
</head>
<body>
<div id="st_popup" style="width:500px;height:440px; display:;">
		<ul style="overflow: hidden;">
			<li class="tab_menu">
				<a href="#" id="first" class="tab_menu_list_on">찾아오시는길 전송</a>
			</li>
			<li class="tab_menu" style="border-left: 0;">
				<a href="#" id="second" class="tab_menu_list">예약화면 전송</a>
			</li>
		</ul>
		<div class="hide1">
	<div class="call-transfer">
	<form method="post" name="frm" action="namelist" onSubmit="return submitcheck()">
		<p style="padding-left:15px;">
			<span class="popup_search_tit">기관검색</span>
			<input type="text" class="search_form" id="search" style="ime-mode:active" name="search">
			<input type="hidden" id="agentid" name="AgentID"value="${agentid }">
			<input type="hidden" class="search_form" id="phone_s" name="dest" value="${dest }" onkeydown="InpuOnlyNumber(this)"/>
			<input type="hidden" id="view" name="view" value="${dmstype }">
			<input type="submit" class="search_btn" value="검색">
		</p>
	</form>
	<form method="post" action="urlsubmit"id="urlsubmit">
			<p style="padding-left:15px;">
				<span class="popup_search_tit">전송번호</span>
				<input type="text" class="search_form" id="phone" name="phone" value="${dest }" onkeydown="InpuOnlyNumber(this)"/><br>
				<input type="hidden" id="agentid" name="AgentID" value="${agentid }">
				<input type="hidden" id="dmskey" name="dmskey">
				<input type="hidden" name="key" value="0">
			</p>
			<div class="DB_list_form">
				<ul style="margin-top:5px;">
					<c:forEach items="${namelist}" var="namelist" varStatus="status">
						<li class="DB_list">
							<span>${namelist.dept_name }</span>
							<input type="hidden" id="t_smstext" name="t_smstext">
							<input type="hidden" id="t_url" name="t_url">
							<input type="hidden"  id="code" name="code">
							<input type="hidden"  id="url" name="url" >
							<input type="hidden"  id="smstext" name="smstext" >
							<input type="button" class="search_btn" style="cursor:pointer;" onclick="urlcheck('${namelist.dept_code }','${namelist.dept_name}','${agentid }','${namelist.url }')"value="전송">
							<input type="button" class="search_btn" style="background-color:#3B62C5;cursor:pointer;" value="보기" onclick="preview('${namelist.dept_code }','${namelist.dept_name}','${namelist.url }')">
						</li>
					</c:forEach>
					<c:if test="${count eq '0'}">
						<span>검색된 내용이 없습니다.</span>
					</c:if>
					<!-- <li class="DB_list">
							<span>서울중앙지부</span>
							<input type="radio" class="list_check"  name="url" value="http://www.klac.or.kr/helper/orgPopOffice.do?org_code=20200">
							<input type="hidden" id="smstext"  class="url"name="smstext" value="홍길동입니다.">
							<input type="hidden" id="code" name="code" value="11122">
							<input type="hidden" id="url" name="url" >
							<input type="hidden" id="smstext" name="smstext" value="서울">
							<input type="submit" class="search_btn" style="width:30px;" value="전송">
					</li> -->
				</ul>
			</div>
		</form>
	<div class="sdms_txt">"연동 app 미설치 휴대폰인 경우 문자로 전송됩니다." <br>"Network 사정상 전송이 늦어질 수 있습니다."</div>
	</div>	
	</div>
	<div class="hide2">
	<div class="call-transfer">
		<form method="post" name="frm" action="namelist" onSubmit="return submitcheck()">
		<p style="padding-left:15px;margin-top:32px;">
			<span class="popup_search_tit">전화번호</span>
			<input type="hidden" id="agentid" name="AgentID"value="${agentid }">
			<input type="text" class="search_form" id="phone_s2" name="dest" value="${dest }" onkeydown="InpuOnlyNumber(this)"/>
		</p>
		<div class="DB_list_form">
				<ul style="margin-top:5px;">
					<li class="DB_list">
							
								<span id="reserve"></span>
						</li>
				</ul>
			</div>
	</form>
	<div class="sdms_txt">"연동 app 미설치 휴대폰인 경우 문자로 전송됩니다." <br>"Network 사정상 전송이 늦어질 수 있습니다."</div>
	</div><!-- 방문상담예약 End-->
	</div>
</div>
	<div id="st_popup" class="send" style="width:500px;height:440px; display:none;">
		<div class="popup_in" style="width:494px;height:434px;border-color:#749924;">
		<div class="popup_tit" style="width:484px;background-color:#8CC22E;">
			<h3>전 송 중</h3>
		</div>
		<div style="overflow:hidden;margin:90px 50px 0;">
			<img class="call_send_img" src="images/popup_img00.png" alt="" />
			<img class="call_send_arrow" src="images/arrow.gif" alt="" />
			<img class="call_send_dms" src="images/popup_img01.png" alt="" />			
		</div>
	</div>

	</div>
</body>
</html>