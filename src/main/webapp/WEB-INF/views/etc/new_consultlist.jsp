<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/softphone.css" />
<script type="text/javascript" src="./js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="./js/array.js"></script>
<script>
var b_number;
var c_number;
	$(document).ready(function() {
		/* JS에서 가져옴 */
		$("#c_search").focus(); /* 이름입력 포커스*/
		var p_innerHTML = "";
		for ( var i = 0; i < t_arslist.length; i++ ) {
			p_innerHTML +="<li class='call-transfer_list'  style='border-bottom:1px solid #dedede;'>";
			p_innerHTML +="<input style='margin-top:10px;' type='radio' name='list3'value="+n_arslist[i]+">";
			p_innerHTML +="<span>"+t_arslist[i]+" </span></a>";
			p_innerHTML +="</li>";
	      }
		call_ars.innerHTML =p_innerHTML;
	
		if($("#view").val()==1){
			$(".hide1").hide();
			$(".hide2").show();
			$(".hide3").hide();
			$("#first").addClass('tab_menu_list');
			$("#first").removeClass('tab_menu_list_on');
			$("#second").addClass('tab_menu_list_on');
			$("#third").addClass('tab_menu_list');
		}else{
			$(".hide1").show();
			$(".hide2").hide();
			$(".hide3").hide();  
			$("#first").addClass('tab_menu_list_on');
			$("#second").addClass('tab_menu_list');
			$("#third").addClass('tab_menu_list');
		}
		$("#reconnect").hide();
		$("#transfer").hide(); 
		$("input:radio[name=list]").click(function() {
			$("#number").val($('input:radio[name="list"]:checked').val());

			})
		$("input:radio[name=list2]").click(function() {
			$("#number2").val($('input:radio[name="list2"]:checked').val());

			})
		$("input:radio[name=list3]").click(function() {
			$("#number3").val($('input:radio[name="list3"]:checked').val());

			})
		});
	function removespace(sth){
		sth = sth.replace(/(\s*)/g, "");
		return sth;
	}
	$(function() {
		$("#first").click(function() {
			
			$('.hide1').show();
			$('.hide2').hide();
			$('.hide3').hide();
			$("#c_search").focus();
			$("#first").addClass('tab_menu_list_on');
			$("#first").removeClass('tab_menu_list');

			$("#second").addClass('tab_menu_list');
			$("#second").removeClass('tab_menu_list_on');
			
			$("#third").addClass('tab_menu_list');
			$("#third").removeClass('tab_menu_list_on');
		});
		$("#second").click(function() {
			
			$('.hide1').hide();
			$('.hide2').show();
			$('.hide3').hide();
			$("#c_search2").focus();
			$("#first").addClass('tab_menu_list');
			$("#first").removeClass('tab_menu_list_on');
			
			$("#second").addClass('tab_menu_list_on');
			$("#second").removeClass('tab_menu_list');
			
			$("#third").addClass('tab_menu_list');
			$("#third").removeClass('tab_menu_list_on');
		});
		$("#third").click(function() {
			$('.hide1').hide();
			$('.hide2').hide();
			$('.hide3').show();
			
			$("#first").addClass('tab_menu_list');
			$("#first").removeClass('tab_menu_list_on');
			
			$("#second").addClass('tab_menu_list');
			$("#second").removeClass('tab_menu_list_on');
			
			$("#third").addClass('tab_menu_list_on');
			$("#third").removeClass('tab_menu_list');
		});
	});
	function consultation() {
		var number_val = document.getElementById("number").value;
		//var number_val = "3978";
		var r_number = removespace(number_val);/* 공백제거 */
		if (r_number == null || r_number == "") {/* 번호입력창 빈값 일 경우 */
			alert('선택된 값이 없습니다.');
			return false;
		} else {
			document.getElementById("number").value = r_number;
		}
		var c_number = $("#number").val();
		opener.ct_consultation(c_number);
		$("#consultation").hide();
		$("#reconnect").show();
		$("#transfer").show();

	}
	function BlindTransfer(division) {/* 호전환 -외부전문기관,ARS */
		if(division==1){
			var number_val = document.getElementById("number2").value;
			//number_val = "3978";
			var r_number = removespace(number_val);/* 공백제거 */
			if (r_number == null || r_number == "") {/* 번호입력창 빈값 일 경우 */
				alert('선택된 값이 없습니다.');
				return false;
			} else {
				document.getElementById("number2").value = r_number;
			}
		}else {
			var number_val = document.getElementById("number3").value;
			//number_val ="3978";
			var r_number = removespace(number_val);/* 공백제거 */
			if (r_number == null || r_number == "") {/* 번호입력창 빈값 일 경우 */
				alert('선택된 값이 없습니다.');
				return false;
			} else {
				document.getElementById("number3").value = r_number;
			}
		}
		b_number=r_number.replace(/[^0-9]/g,'');
		opener.ct_blind_transfer(b_number);
		window.close();
	}
	function reconnect() {/* 호전환 - 복귀 */
		opener.ct_reconnect();
		$("#consultation").show();
		$("#reconnect").hide();
		$("#transfer").hide();
	}

	function transfer() {/* 호전환-호전환 */
		opener.ct_transfer();
		window.close();
		
	}
	function InpuOnlyNumber(obj) {
		$(obj).keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
	}
	function c_check(){/*호전환 협의   */
		var name = document.getElementById("c_search").value;
		removename = removespace(name);/* 공백제거 */
		if (removename == "" || removename == null) {
			alert('검색 할 단어를 입력 해주세요.');
			return false;
		}else{
			document.getElementById("c_search").value= removename;
			return true;
		}
	}
	function c_check2(){/* 호전환-외부전문기관  */
		var name = document.getElementById("c_search2").value;
		$("#view").val('1');
		removename = removespace(name);/* 공백제거 */
		if (removename == "" || removename == null) {
			alert('검색 할 단어를 입력 해주세요.');
			return false;
		}else{
			document.getElementById("c_search2").value= removename;
			return true;
		}
	}
	
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>호전환</title>
</head>
<body>
	<div id="st_popup" style="width:670px;height:400px;">
		<div style="width:664px;height:394px;">
			<ul style="overflow:hidden;">
				<li class="tab_menu">
				<a href="#" id="first" class="tab_menu_list_on">직원연결</a>
				</li>
				<li class="tab_menu" style="border-left:0;">
				<a href="#" id="second" class="tab_menu_list">외부전문기관</a>
				</li>
				<li class="tab_menu" style="border-left:0;">
				<a href="#" id="third"class="tab_menu_list">ARS</a>
				</li>
			</ul>
			<div class="hide1">
				<div class="call-transfer">
						<div class="call-transfer_in" style="float:left;" >
							<p>
								<input type="hidden" class="transfer_form" id="number" onkeydown="InpuOnlyNumber(this)" placeholder="번호입력" />
							</p>
							<p style="margin-top:10px;">
								<form action="new_c_check" name="c_frm" method="post" onSubmit="return c_check()">
								<input type="text" class="transfer_form" style="width:80px; ime-mode:active" placeholder="이름입력" id="c_search"name="c_search">
								<input type="submit" class="transfer_off_btn" style="width:45px;margin-top:1px;cursor:pointer;"value="조회">
								</form>	
							</p>
							<span>
								<button class="transfer_on_btn" id="consultation" onClick="consultation()">연 결</button>
							</span>
							<div class="tooltip" style="margin-top:50px;">
								<span class="tooltiptext">연결 중이였던 직원과의 통화를 종료하고 다시 고객과의 통화 연결됨</span>
								<button class="transfer_off_btn" id="reconnect"	onClick="reconnect()">협의복귀</button>
							</div>
							<div class="tooltip">
								<span class="tooltiptext" style="top:160px;">연결 중이었던 직원과 고객간 통화연결 되고, 상담원과 고객간 통화는 종료됨</span>
								<button class="transfer_btn" id="transfer" onClick="transfer()">호전환</button>
							</div>
						</div>
					<div style="float:right;" class="hide1">
						<div class="call-transfer_in" style="width:436px;height:305px;padding-top:10px;">
							<table width="100%">
							<tr style="border-bottom:double 3px #3B62C5;">
								<td style="line-height:30px;"></td>
								<td style="line-height:30px;width:60px;font-weight:900;padding-right:30px;">이름</td>
								<td style="line-height:30px;width:50px;font-weight:900;">내선번호</td>
								<td style="line-height:30px;width:100px;font-weight:900;">직통번호</td>
								<td style="line-height:30px;width:180px;font-weight:900;">부서이름</td>
							</tr>
							<c:forEach items="${list3}" var="list3">
							<tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list"value="${list3.work_tenr }">
								</td>
								<td class="call-transfer_list" style="width:60px;">${list3.empl_name }</td>
								<td class="call-transfer_list" style="width:50px;">${list3.work_tenr }</td>
								<td class="call-transfer_list" style="width:100px;">${list3.comp_tenr }</td>
								<td class="call-transfer_list" style="width:100px;">${list3.dept_name }</td>
							</tr>
							</c:forEach>
							<%-- <tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list"value="1170">
								</td>
								<td class="call-transfer_list" style="width:60px;">손창우</td>
								<td class="call-transfer_list" style="width:50px;">1160</td>
								<td class="call-transfer_list" style="width:100px;"></td>
								<td class="call-transfer_list" style="width:100px;">경영정보팀</td>
							</tr>
							<tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list"value="${list3.work_tenr }">
								</td>
								<td class="call-transfer_list" style="width:60px;">손창우</td>
								<td class="call-transfer_list" style="width:50px;">1160</td>
								<td class="call-transfer_list" style="width:100px;">054-810-4444</td>
								<td class="call-transfer_list" style="width:100px;"></td>
							</tr>
							<tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list"value="${list3.work_tenr }">
								</td>
								<td class="call-transfer_list" style="width:60px;">손창우</td>
								<td class="call-transfer_list" style="width:50px;"></td>
								<td class="call-transfer_list" style="width:100px;">054-810-4444</td>
								<td class="call-transfer_list" style="width:100px;">대한법률공단 서울중앙지부</td>
							</tr> --%>
							<tr>
								<td style="width:100%;" colspan=5>
								<c:if test="${count eq '0'}">
										<span class="call-transfer_list">검색된 내용이 없습니다.</span>
									</c:if>
								</td>
							</tr>
						</table>
						</div>
					</div>
				</div>
			</div>
			<div class="hide2">
				<div class="call-transfer">				
				<div class="call-transfer_in" style="float:left;" >
					<p>
						<input type="hidden" class="transfer_form" id="number2" onkeydown="InpuOnlyNumber(this)" placeholder="번호입력" />
					</p>
					<p style="margin-top:10px;">
						<form action="new_c_check2" name="c_frm" method="post" onSubmit="return c_check2()">
						<input type="text" class="transfer_form" style="width:80px; ime-mode:active"  placeholder="기관명" id="c_search2"name="c_search2">
						<input type="hidden" id="view" name="view" value="${view }"><!-- view가 1이면 외부전문기관 창이 바로 보여짐 -->
						<input type="submit" class="transfer_off_btn" style="width:45px;margin-top:1px;"value="조회">
						</form>	
					</p>
					<div class="tooltip" style="margin-top:40px;">
						<span class="tooltiptext" style="top:160px;">연결 중이었던 직원과 고객간 통화연결 되고, 상담원과 고객간 통화는 종료됨</span>
						<button class="transfer_btn" id="transfer" onClick="BlindTransfer('1')">바로전환</button>
					</div>
					</div>
					<div style="float:right;">
					<div class="call-transfer_in" style="width:436px;height:305px;padding-top:10px;">
					<table width="100%">
							<tr style="border-bottom:double 3px #3B62C5;">
								<td style="line-height:30px;"></td>
								<td class="call-transfer_list" style="width:150px;font-weight:900;padding-left:25px;">기관명</td>
								<td class="call-transfer_list" style="width:160px;font-weight:900;padding-left:25px;">직통번호</td>
							</tr>
							<!-- <tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list2"value="054-810-1114">
								</td>
								<td class="call-transfer_list" style="width:150px;">서울중앙지부</td>
								<td class="call-transfer_list" style="width:160px;">054-810-1114</td>
							</tr>
							<tr>
								<td class="call-transfer_list" style="padding-top:8px;">
								<input type="radio" name="list2"value="2222">
								</td>
								<td class="call-transfer_list" style="width:150px;">대한법률공단 서울중앙지부</td>
								<td class="call-transfer_list" style="width:160px;">054-810-1114</td>
							</tr> -->
							<c:forEach items="${list}" var="list">
								<tr>
									<td class="call-transfer_list" style="padding-top:8px;">
										<input type="radio" name="list2"value="${list.tele_numb}">
									</td>
									<td class="call-transfer_list" style="width:150px;">${list.dept_name}</td>
									<td class="call-transfer_list" style="width:160px;">${list.tele_numb}</td>
								</tr>
							</c:forEach>
							<tr>
								<td style="width:100%;" colspan=5>
								<c:if test="${count eq '0'}">
										<span class="call-transfer_list">검색된 내용이 없습니다.</span>
									</c:if>
								</td>
							</tr>
						</table>
						</div>
					</div><!-- 외부전문기관 내용-->
				</div><!-- 외부전문기관 End-->
			</div>
			<div class="hide3">
				<div class="call-transfer">
				<div class="call-transfer_in" style="float:left;" >
					<p>
						<input type="hidden" class="transfer_form" id="number3"  onkeydown="InpuOnlyNumber(this)" placeholder="번호입력" />
					</p>				
						<div class="tooltip" style="margin-top:79px;">
							<span class="tooltiptext" style="top:160px;">연결 중이었던 직원과 고객간 통화연결 되고, 상담원과 고객간 통화는 종료됨</span>
							<button class="transfer_btn" id="transfer" onClick="BlindTransfer('2')">바로전환</button>
						</div>		
						<div  style="opacity:0.4;margin-top:40px;">
							<img src="images/popup_img03.png" width="120" alt="" />
						</div>
					</div> 
					<div style="float:right;">
						<ul class="call-transfer_in" id="call_ars" style="width:436px;height:305px;padding-top:10px;">
						</ul>
					</div><!-- ARS 내용-->
				</div><!-- ARS END-->
			</div>
		</div>
	</div>
</body>
</html>