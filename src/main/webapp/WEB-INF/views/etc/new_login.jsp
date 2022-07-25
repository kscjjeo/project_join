<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*,java.text.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<!--  도메인이 다를 때 쿠키 적용하기 위함 --> 
    <% response.setHeader("P3P","CP='IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT'");%>
  	<HEAD>
  	<!--  도메인이 다를 때 쿠키 적용하기 위함 --> 
  	<meta http-equiv ="p3p"content = 'CP="CAO DSP AND SO " policyref="/w3c/p3p.xml"' >
	    
  	<!-- CTI ToolBar Design -->
  	<link rel="stylesheet" type="text/css" href="css/softphone.css" />
  	<!-- Jquery 사용 -->
  	<script type="text/javascript"      src="./js/jquery-1.11.3.min.js"></script>
  	<!-- CTI Button 활성화/비활성화 script -->
  	<script type="text/javascript"      src="./js/btncontrol.js"></script>
  	<!-- 변수 초기화 -->
  	<script type="text/javascript"      src="./js/reset.js"></script>
    <!-- CTI Client Script -->
    
    
  		<TITLE>CTI</TITLE>
	</HEAD>
<script language="javascript">
var v_acw=0;
var r_desk = ""; //발신번호
var recoad = 1;/* 녹취 실행 상태  0 :실행, 1 : 비실행*/
var rec_ani =""; /* 녹취 대상 번호 */
var IO=""; /* INBOUND/OUTBOUNT 구분  초기화 */
var new_c_ip="";/* CTI IP 초기화*/
var new_c_port=""; /* CTI PORT 초기화 */
var r_ip=""; /* 녹취 IP 초기화*/
var r_port=""; /* 녹취PORT  초기화*/
var end = ""; /* 이력저장 유무 0했음 , 1안했음 */
var objcallpop; objcallpop=null; /* 전화왔습니다 팝업 obj 초기화 */
var objPopup; objPopup=null;// 호전환 팝업 obj 초기화

//srcript에 해당 event를 추가 한다. 
//receiveMessage는 이벤트 응답에 대한 function name이다.
$(document).ready(function(){
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie('cti_station');
    $("input[name='Station']").val(userInputId);
    $("#softphone_wrap").css("display", "none");// 소프트폰 숨기기
});
/* 쿠키 생성 */
function setCookie(cookieName, value, exdays){/*쿠키 이름 , 쿠키 값 , 쿠키생존일수  */
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
/* 쿠키 삭제 */
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
/* 생성 쿠키를 가져옴 */
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
	if(window.addEventListener) {
		window.addEventListener ("message", receiveMessage, false);
    }else{
       if(window.attachEvent) {  /* postMessage실행 시 자식이 받음 */
          window.attachEvent("onmessage", receiveMessage);
       }
    }
	function receiveMessage(event){
		msg = JSON.parse(event.data);
		if(msg.type == '6'){  //수신 타입 체크 ,상담앱에서 이력 저장 시 
			 /* document.getElementById("t4").value = msg.data_key; */ //휴식중이 아닐때 대기로 변경 해야함
			if(p_call!=0){/* 통화중이 아닐 때, 0=통화중 */
				 if(p_status!=0){       // 휴식이 아닐 때 ,0=휴식중 
					ct_ready();
				 }else{
					$("#ready_on").show();
					$("#ready_off").hide();
				 }          //79~84 전화끊으면 자동대기 넘어가기하기위함으로바뀜
			 }/* else{
					end=0;
			 } */
		} if(msg.type=='7'){
			var d_phone =msg.phone;
			var d_smstext =msg.smstext;
			var d_dmskey =msg.dmskey;
			var d_url =msg.url;
			//var popurl ="";
			var d_key = "1";/* 상담앱에서 sdms 요청 할 시 = 1 */
			$.ajax({
				type:"POST"
				,url:"urlsubmit"
				,data:{phone:d_phone,smstext:d_smstext,dmskey:d_dmskey,url:d_url,key:d_key}
				,success:function(data){
				}
				,error:function(data){
					alert("스마트DMS전송실패");
				}
			});
			/* var popurl = "urlsubmit?phone="+d_phone+"&smstext="+d_smstext+"&dmskey="+d_dmskey+"&url="+d_url+"&svrcode="+d_svrcode; */
//			popurl = "urlsubmit?phone="+d_phone+"&smstext="+d_smstext+"&dmskey="+d_dmskey+"&url='"+d_url+"'&svrcode="+d_svrcode+"&key=1";/* key=1 :  팝업창생성 후 sdms전송 후 자동 팝업창 종료, key =0 : histroy.go(-1)*/
//			popurl = encodeURI(popurl);
//			window.open(popurl,"popurl","width=510,height=410,scrollbar=yes");
			
		} 
		  /* var t1value = event.data;
		  document.getElementById("t4").value = t1value; */
	}
	
	function getDataMain(type){
		//select 1(전화번호) 2(녹취키)
		var json;
		if(type == '1'){
		json = {'type': type ,'data_key': sANI };
			
		}else if(type == '2'){
		json = {'type': type ,'data_key': key };
			
		}else if(type == '3'){ // 콜 시작 시
		json = {'type': type ,'data_key': sANI };
			
		}else if(type == '4'){	//콜 종료 시
		json = {'type': type ,'data_key': sANI };
			
		}
		//alert(JSON.stringify(json));
		window.parent.postMessage(JSON.stringify(json),"*");
	}
	
  </script>
  
<SCRIPT	language="javascript">
	var p_status=1;/* 0 휴식 , 1 else  */
	var p_call=1;/* 0 통화중일때 , 1 else  */
	var v_login = 0; /* 로그인 유무 0 : 비로그인  , 1 : 로그인 */
	var key;/* 녹취용 Key 초기화 */
	var consultationflag = "N";/* 호전환 협의 성공 시 Y */
	var sendnum=null; /* I/O 구분 하여 번호를 전송하기 위함 */
	function reckey(){/* 녹취용 키 값 생성 */
		key = getTimeStamp()+SoftPhoneForm.AgentID.value;
		/* 키 = 현재시간+AgentId */
	}
	function cmd_ctSDMS(){ /* SDMS버튼 동작 시 */
		var empId=$("#empId").val();
		var url  = "sdms?agentid="+SoftPhoneForm.AgentID.value+"&dest="+SoftPhoneForm.Dest.value+"&dmstype=0&empId="+empId";
		 window.open(url,"SDMS","width=520,height=460,scrollbar=yes")
		/* SDMS팝업창 생성 */
	}

	function cmd_ctLogin(){
		var empId=$("#empId").val();
		SoftPhoneForm.AgentID.value= SoftPhoneForm.l_agentid.value+SoftPhoneForm.Station.value;
		var l_agentid =SoftPhoneForm.AgentID.value;
		var l_station =SoftPhoneForm.Station.value;
		var	rc;
		if(l_station=="1164"){
			alert('내선번호를 확인해주세요.');
			return false;
		}
		 $.ajax({
			type:"POST"
			,url:"loginA"
			,dataType:'json'
			,async:false
			,data:{empId:empId,l_station:l_station}
			,success:function(data){
				 /* if(data.result=="success"){
						$.ajax({
							type:"POST"
							,url:"l_history"
							,data:{l_agentid:l_agentid,l_station:l_station,empId:empId}
							,success:function(data){
							}
							,error:function(data){
								alert("로그인이력실패");
							}
						});
						setCookie('cti_station',SoftPhoneForm.Station.value,180);
						$("#loginForm").css("display", "none");// 로그인창 숨기기 
						$("#softphone_wrap").css("display", "");// 소프트폰 보여주기
						btncontrol(1,0,0,0,0,0,0,0,0,0,0);
						cmd_ctNotReady('1');//로그인 성공 시 자동 휴식상태  
				}else{
					alert(data.result);
				}  */
				if(data.result=="success"){
					rc= BridgeX.ctLogin(SoftPhoneForm.Station.value, SoftPhoneForm.AgentID.value);
					if(rc==0){		// rc = 0 : 로그인성공 , else : 실패  
						v_login=1;
						$.ajax({
							type:"POST"
							,url:"l_history"
							,data:{l_agentid:l_agentid,l_station:l_station,empId:empId}
							,success:function(data){
								
							}
							,error:function(data){
								alert("로그인이력실패");
							}
						});
						setCookie('cti_station',SoftPhoneForm.Station.value,180);
						$("#loginForm").css("display", "none");// 로그인창 숨기기 
						$("#softphone_wrap").css("display", "");// 소프트폰 보여주기 
						btncontrol(1,0,0,0,0,0,0,0,0,0,0);
						cmd_ctNotReady('1');//로그인 성공 시 자동 휴식상태
						$("#Srecoading_on").hide();// 녹취시작 활성화버튼 숨기기 
						$("#Srecoading_off").show();// 녹취시작 비활성화버튼 보여주기 
						$("#Erecoading_on").hide();// 녹취종료 활성화버튼 숨기기 
						$("#Erecoading_off").show();// 녹취종료 비활성화버튼 보여주기 
					}else{// 로그인 실패 시 
						$("#loginForm").css("display", "");
						$("#softphone_wrap").css("display", "none");
						btncontrol(0,0,0,0,0,0,0,0,0,0,0);
						if(rc=="20000"){
							alert('로그인실패\n'+"실패코드 : "+rc+"\n잘못된 Agent ID로 로그인을 시도한 경우입니다.");
						}else if(rc=="20010"){
							alert('로그인실패\n'+"실패코드 : "+rc+"\n이미 로그인된 내선번호로 로그인을 시도한 경우입니다.");
						}else if(rc=="20330"){
							alert('로그인실패\n'+"실패코드 : "+rc+"\n통화중인 상태에서 기능을 요구한 경우입니다.");
						}else if(rc=="90001"){
							alert('로그인실패\n'+"실패코드 : "+rc+"\n내선번호, AgentID가 필수 파라미터 인데 이 파라미터가 없는 경우 발생되는 에러 코드 입니다.");
						}else if(rc=="90002"){
							alert("로그인실패\n"+"실패코드 : "+rc+"\n서버로 접속이 안될 경우 (CTI서버가 Down되었을 경우 혹은 네트웍 문제로 인해 소켓 접속이 안되는 경우)입니다.")
						}else{
							alert('로그인실패\n'+"실패코드 : "+rc);
						}
					}
				}else{
					alert(data.result);
				}
			}
			,error:function(data){
				alert("로그인체크실패");
			}
		}); 
	}
	function cmd_ctLogout(){
		var empId=$("#empId").val();
		var l_agentid =SoftPhoneForm.AgentID.value;
		var l_station =SoftPhoneForm.Station.value;
		var	rc;
		rc = BridgeX.ctLogout(SoftPhoneForm.Station.value, SoftPhoneForm.AgentID.value);
		if(rc==0){
			$.ajax({
				type:"POST"
				,url:"o_history"
				,data:{l_agentid:l_agentid,l_station:l_station,empId:empId}
				,success:function(data){
				}
				,error:function(data){
					alert("로그아웃이력실패");
				}
			});
			$("#loginForm").css("display", "");
			$("#softphone_wrap").css("display", "none");
			alert('로그아웃');
			SoftPhoneForm.Dest.value="";
			btncontrol(0,0,0,0,0,0,0,0,0,0,0);
			TimerStop();
			//TimerStop2();
			v_login=0; 
		}else{
			if(v_login==1){
				alert("로그아웃실패\n"+"실패코드 : "+rc);
			}
		}
	}
	function cmd_ctACW(){/* 내 전화가 끊어지면 실행 (협의 일 시 x) 후처리 */
		var	rc;
		
		rc = BridgeX.ctACW(SoftPhoneForm.Station.value, SoftPhoneForm.AgentID.value);
		if(rc==0){
			v_acw=1;
			btncontrol(1,1,0,1,0,1,0,0,0,0,1);
			$("#Srecoading_on").hide();
			$("#Srecoading_off").show();
			$("#Erecoading_on").hide();
			$("#Erecoading_off").show();
			SoftPhoneForm.status.value="후처리";
			$("#status").removeClass('rest_color');
			$("#status").addClass('work_color');
			$("#status").removeClass('call_color');
			TimerStop();
			//TimerStop2();
			p_status = 1;
			if(end==0){
				/* btncontrol(1,0,0,1,0,1,0,0,0,0,1); */
			}
		}else{
			alert("후처리실패\n"+"실패코드 : "+rc);
		}
	}
	function cmd_ctReady(){
		var	rc=0;
		rc = BridgeX.ctReady(SoftPhoneForm.Station.value, SoftPhoneForm.AgentID.value,0);//Auto In(자동대기) 설정, 1: Auto In, 0: Manual In
		if(rc==0){
			btncontrol(1,0,0,1,0,1,0,0,0,0,1);
			SoftPhoneForm.status.value="대기";
			v_acw=0;
			$("#status").removeClass('rest_color');
			$("#status").removeClass('work_color');
			$("#status").removeClass('call_color');
			//TimerStart2();
			TimerStop();
			p_status = 1;
		}else{
			alert("대기실패\n"+"실패코드 : "+rc);
		}
	}
	function cmd_ctNotReady(code){
		var	rc;
		btncontrol(1,1,0,0,0,1,0,0,0,0,1);
		 rc = BridgeX.ctNotReady(SoftPhoneForm.Station.value, SoftPhoneForm.AgentID.value, code);
		if(rc==0){
			TimerStart();
			//TimerStop2();
			if(code==1){
				SoftPhoneForm.status.value="휴식";
				btncontrol(1,1,0,0,0,1,0,0,0,0,1);
				
				//TimerStop2();
			}else if(code==2){
				SoftPhoneForm.status.value="업무";
				btncontrol(1,1,0,1,0,1,0,0,0,0,0);
				//TimerStop2();
			}
			$("#status").addClass('rest_color');
			$("#status").removeClass('work_color');
			$("#status").removeClass('call_color');
			
			//로그아웃 대기 전화걸기 후처리
			
			
			p_status =0;
		}else{
			alert("휴식실패\n"+"실패코드 : "+rc);
		}
	}
	function cmd_ctAnswer(){
		var	rc;
		rc = BridgeX.ctAnswer(SoftPhoneForm.Station.value);
	}
	function cmd_ctClear(){
		var	rc;
		rc = BridgeX.ctClear(SoftPhoneForm.Station.value);
		if(rc==0){
			
		}else{
			alert("전화끊기 실패 \n+ 실패코드 : "+rc);
		}
	}
	function cmd_ctHold(){
		var	rc;
		rc = BridgeX.ctHold(SoftPhoneForm.Station.value);
		if(rc==0){
			
		}else{
			alert("보류실패\n"+"실패코드 : "+rc);
		}
	}
	function cmd_ctRetrieve(){
		var	rc;
		rc = BridgeX.ctRetrieve(SoftPhoneForm.Station.value);
		if(rc==0){
		}else{
			alert("보류해제실패\n"+"실패코드 : "+rc);
		}
	}
	function cmd_ctConsultation(c_number){
		var	rc;
		rc = 
			BridgeX.ctConsultation(SoftPhoneForm.Station.value,c_number,sANI,sUCID,sInboundData,sConsultData);
		
		if(rc==0){
			consultationflag="Y";
			
			btncontrol(0,0,1,0,0,0,0,1,0,0,0);
			
		}else{
			consultationflag="N";
			alert("호전환-협의실패\n"+"실패코드 : "+rc);
			closePopup();
		}
		

	}
	function cmd_ctConsultationUUI() {
		var rc;
		rc = BridgeX.ctConsultationUUI(SoftPhoneForm.Station.value,
				SoftPhoneForm.Dest.Value, SoftPhoneForm.ANI.Value,
				SoftPhoneForm.UCID.Value, SoftPhoneForm.UUIData.Value);

	}
	function cmd_ctReconnect() {
		var rc;
		rc = BridgeX.ctReconnect(SoftPhoneForm.Station.value);
		if(rc==0){
			child();
		}else{
			alert("호전환-협의복귀실패\n"+"실패코드 : "+rc);
		}
	}

	function cmd_ctTransfer() {
		var rc;
		rc = BridgeX.ctTransfer(SoftPhoneForm.Station.value);
		if(rc==0){
			 cmd_ctACW(); 
			/* cmd_ctNotReady('2'); */
			closePopup();
		 }else{
			 alert("호전환-호전환실패\n"+"실패코드 : "+rc);
		 }
	}
	function cmd_ctConference() {
		var rc;
		rc = BridgeX.ctConference(SoftPhoneForm.Station.value);

	}
	function cmd_ctMake() {
		var rc;
		r_desk = removespace(SoftPhoneForm.Dest.value);
		if(r_desk==""||r_desk==null){
			alert('번호를 입력해주세요.');
			SoftPhoneForm.Dest.focus();
			return false;
		}
		rc = BridgeX.ctMake(SoftPhoneForm.Station.value,
				SoftPhoneForm.Dest.value);
		
		if(rc==0){
		//TimerStop2();
		TimerStop();
		SoftPhoneForm.Dest.value=r_desk;
		}else{
			alert("전화걸기실패\n"+"실패코드 : "+rc);
		}
	}

	function cmd_AskPassword() {
		var rc;
		rc = BridgeX.ctAskPassword(SoftPhoneForm.Station.value, "",
				SoftPhoneForm.PassType.value, "7775");

	}
	function cmd_CancelPassword() {
		var rc;
		rc = BridgeX.ctCancelPassword(SoftPhoneForm.Station.value);

	}
	function cmd_ctServerReconnect() {
		var rc;
		rc = BridgeX.ctServerReconnect(0);
	}
	function cmd_RequestInfoPush() {
		var rc;
		rc = BridgeX.ctRequestInfoPush(SoftPhoneForm.Station.value,
				SoftPhoneForm.mdn.value, SoftPhoneForm.boundType.value,
				SoftPhoneForm.prolCode.value, SoftPhoneForm.epilCode.value,
				SoftPhoneForm.prolURL.value, SoftPhoneForm.epilURL.value);
	}
	function cmd_ctBlindTransfer(b_number){
		var rc;
		if(sCallType==05){ 
			sendnum=sDNIS;
		}else if(sCallType==03){
			sendnum=sANI;
		}
		/* alert("blind :"+sendnum +" calltype :"+sCallType); */
		rc = BridgeX.ctBlindTransfer(SoftPhoneForm.Station.value,
				b_number,sendnum,
				sUCID,"1","1");
		if(rc==0){			
			
		}else{
			alert("호전환-바로호전환실패\n"+"실패코드 : "+rc);
		}
	}
</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventSvcInitiated(strPopupData)" language="javascript">
		SoftPhoneForm.status.value ="통화연결중";
		$("#status").removeClass('rest_color');
		$("#status").removeClass('work_color');
		$("#status").addClass('call_color');
		TimerStop();
		//TimerStop2();
		if(consultationflag=="Y"){
			btncontrol(0,0,0,0,1,0,0,0,0,1,0);
			
		}else{
			if(strPopupData.length==89){
				ex1(strPopupData);
			}else if(strPopupData.length==458){
				ex2(strPopupData);
			}else if(strPopupData.length==200){
				ex3(strPopupData);
			}
			key=null;
			reckey();/* 녹취 키 생성  */
			btncontrol(0,0,0,0,1,0,0,0,0,0,0);
		}
		/* $("#Srecoading").show(); */
		/*수화기시작 */
	</SCRIPT>	

	<SCRIPT	for="BridgeX"	event="OnEventDelivered(strPopupData)" language="javascript">
		SoftPhoneForm.status.value = "통화연결중";
		$("#status").removeClass('rest_color');
		$("#status").removeClass('work_color');
		$("#status").addClass('call_color');
		if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
		if(v_acw==0){//후처리일때를 제외하고 전화번호를 상담앱에 넘기고 toolbar 화면표시x
			SoftPhoneForm.Dest.value=sANI;
			getDataMain(1);
		}
		$.ajax({
			type:"POST"
			,url:"call_add"
			,dataType:'json'
			,async:false
			,data:{ab_station:SoftPhoneForm.Station.value,ab_tel:sANI,ab_type:"1"}
			,success:function(data){
			}
			,error:function(data){
			}
		}); 
		
		objcallpop =window.open("call?phone="+sANI,"전화왔습니다","width=410,height=310");
		objcallpop.focus();
		key=null;
		reckey();/* 녹취 키 생성  */
		/* 벨울리는 상태*/
	</SCRIPT>	

	<SCRIPT	for="BridgeX"	event="OnEventFailed(strPopupData)" language="javascript">
	</SCRIPT>
	
	<SCRIPT	for="BridgeX"	event="OnEventEstablished(strPopupData)" language="javascript">
		$.ajax({
			type:"POST"
			,url:"call_add"
			,dataType:'json'
			,async:false
			,data:{ab_station:SoftPhoneForm.Station.value,ab_tel:sANI,ab_type:"2"}
			,success:function(data){
			}
			,error:function(data){
			}
		});
		getDataMain(3);
		SoftPhoneForm.status.value = "통화중";
		$("#status").removeClass('rest_color');
		$("#status").removeClass('work_color');
		$("#status").addClass('call_color');
		if(consultationflag=="Y"){
			btncontrol(0,0,1,0,1,0,0,1,0,0,0);	
		}else{
			btncontrol(0,0,1,0,1,0,1,0,1,0,0);
		}
		if(recoad!=0){
			$("#Srecoading_on").show();
			$("#Srecoading_off").hide();
		}
		if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
			
		}if(sCallType==05){/* 아웃바운드 일 때 고객전화번호 가져오기*/
			if(consultationflag=="N"){
				
				SoftPhoneForm.Dest.value=sDNIS;
			}
		/* alert("sDNIS :"+sDNIS+ "sANI : "+sANI); */
		}if(sCallType==03){/* 인바운드 일때 수화기 들면 전화받기 팝업창 사라짐 */
			closecallPopup();
		}
		end=1;
		p_call=0;
		//TimerStop2();
		/* 전화받기(통화중) */
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventCallCleared(strPopupData)" language="javascript">
		$.ajax({
			type:"POST"
			,url:"call_add"
			,dataType:'json'
			,async:false
			,data:{ab_station:SoftPhoneForm.Station.value,ab_tel:sANI,ab_type:"3"}
			,success:function(data){
			}
			,error:function(data){
			}
		});
		getDataMain(4);
	   	SoftPhoneForm.status.value = "통화종료";
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		} 
	   	/* alert("recoad :"+recoad); */
	   	
	   	if(recoad==0){/* 녹취 중 일때 녹취 종료하기 */
	   		Erecoad();
	   	}
	   	reset();
	   	closePopup();
	   	/* cmd_ctNotReady('2'); */
	   	 cmd_ctACW(); 
	   	p_call=1;
	   	/* 전화끊음 */
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventHeld(strPopupData)" language="javascript">
	   	SoftPhoneForm.status.value = "보류중";
	   	$("#status").removeClass('rest_color');
		$("#status").removeClass('work_color');
		$("#status").addClass('call_color');
	   	btncontrol(0,0,1,0,0,0,0,1,0,0,0);
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	   	/* 보류 */
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventRetrieved(strPopupData)" language="javascript">
	   	SoftPhoneForm.status.value = "통화중";
		$("#status").removeClass('rest_color');
		$("#status").removeClass('work_color');
		$("#status").addClass('call_color');
	   	btncontrol(0,0,1,0,1,0,1,0,1,0,0);
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	   	
	   	/* 보류복귀*/
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventConferenced(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventTransferred(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventTransferCleared(strPopupData)" language="javascript">
		/* 호전환-호전환 */
		$.ajax({
			type:"POST"
			,url:"call_add"
			,dataType:'json'
			,async:false
			,data:{ab_station:SoftPhoneForm.Station.value,ab_tel:sANI,ab_type:"3"}
			,success:function(data){
			}
			,error:function(data){
			}
		});
		getDataMain(4);
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	   	if(recoad==0){/* 녹취 중 일때 녹취 종료하기 */
	   		Erecoad();
	   	}
	   	p_call=1;
	   	cmd_ctAcw();
	   	/* cmd_ctNotReady('2'); */
	   	reset();
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventConsultCleared(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	   	consultationflag="N";
	   	child();
	   	cmd_ctRetrieve();
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventAbandonCleared(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	   	closecallPopup();
	   	cmd_ctACW();
	   	/* 포기 콜  */
	</SCRIPT>


	<SCRIPT	for="BridgeX"	event="OnEventIVRCleared(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventCustomerCleared(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	</SCRIPT>

	<SCRIPT	for="BridgeX"	event="OnEventMonitorEnd(strPopupData)" language="javascript">
	   	if(strPopupData.length==89){
			ex1(strPopupData);
		}else if(strPopupData.length==458){
			ex2(strPopupData);
		}else if(strPopupData.length==200){
			ex3(strPopupData);
		}
	</SCRIPT>


	<script>
	 var str; var sSvcCode; var sTimeKey; var sTime; var sStationKey; var sStation; var sAgentIDKey; var sAgentID; var sCallIDKey; var sCallID; var sChannelKey; var sChannel; var sCallTypeKey; var sCallType; var sEvtReserved;
	 var sUCIDKey; var sUCID; var sDNISKey; var sDNIS; var sANIKey; var sANI; var sQueueTime; var sInboundData; var sConsultData;
	 var p_flag_station; var p_station; var sPassword;
	 
	 var p_result_code;
	function ex1(strPopupData){
		sSvckey =removespace(strPopupData.substring(0,8));
		sSvcCode=removespace(strPopupData.substring(8,11));
		sTimeKey=removespace(strPopupData.substring(11,12));/* ‘m’ : Time 검색 키 */
		sTime=removespace(strPopupData.substring(12,26));/* YYYYMMDDHHMMSS */
		sStationKey=removespace(strPopupData.substring(26,27));/* ‘s’ : Station 검색 키 */
		sStation=removespace(strPopupData.substring(27,37));/* Station  */
		sAgentIDKey=removespace(strPopupData.substring(37,38));/* ‘a’ : AgentID 검색 키 */
		sAgentID=removespace(strPopupData.substring(38,48));/* PBX Login sCallTypeID */
		sCallIDKey=removespace(strPopupData.substring(48,49));/* ‘c’ : CallID 검색 키 */
		sCallID=removespace(strPopupData.substring(49,54));/* Call ID */
		sChannelKey=removespace(strPopupData.substring(54,55));/* ‘n’ : Channel 검색 키 */
		
		sChannel=removespace(strPopupData.substring(55,57));/* Channel Type */
		sCallTypeKey=removespace(strPopupData.substring(57,58));/* ‘t’ : Type 검색 키 */
		sCallType=removespace(strPopupData.substring(58,60));/* Call Type */
		sEvtReserved=removespace(strPopupData.substring(60,89));/* 추가 데이터 영역 */
		/* var ee=sSvckey+sSvcCode+sTimeKey+sTime+sStationKey+sStation+sAgentIDKey+sAgentID+sCallIDKey+sCallID+sChannelKey+sChannel+sCallTypeKey+sCallType+sEvtReserved; */
	}
		
	function ex2(strPopupData){
		/* 공통 시작 */
		sSvckey =removespace(strPopupData.substring(0,8));
		sSvcCode=removespace(strPopupData.substring(8,11));
		sTimeKey=removespace(strPopupData.substring(11,12));/* ‘m’ : Time 검색 키 */
		sTime=removespace(strPopupData.substring(12,26));/* YYYYMMDDHHMMSS */
		sStationKey=removespace(strPopupData.substring(26,27));/* ‘s’ : Station 검색 키 */
		sStation=removespace(strPopupData.substring(27,37));/* Station  */
		sAgentIDKey=removespace(strPopupData.substring(37,38));/* ‘a’ : AgentID 검색 키 */
		sAgentID=removespace(strPopupData.substring(38,48));/* PBX Login sCallTypeID */
		sCallIDKey=removespace(strPopupData.substring(48,49));/* ‘c’ : CallID 검색 키 */
		sCallID=removespace(strPopupData.substring(49,54));/* Call ID */
		sChannelKey=removespace(strPopupData.substring(54,55));/* ‘n’ : Channel 검색 키 */
		
		sChannel=removespace(strPopupData.substring(55,57));/* Channel Type */
		sCallTypeKey=removespace(strPopupData.substring(57,58));/* ‘t’ : Type 검색 키 */
		sCallType=removespace(strPopupData.substring(58,60));/* Call Type */
		sEvtReserved=removespace(strPopupData.substring(60,89));/* 추가 데이터 영역 */
		/* 공통  끝*/
		sUCIDKey=removespace(strPopupData.substring(89,90));/* ‘U’ : UCID 검색 키 */
		sUCID=removespace(strPopupData.substring(90,110));/* UCID(Universal Call ID) */
		sDNISKey=removespace(strPopupData.substring(110,111));/* ‘D’ : DNIS 검색 키 */
		sDNIS=removespace(strPopupData.substring(111,131));/* Dialed Number Identification Service*/
		sANIKey=removespace(strPopupData.substring(131,132));/* ‘A’ : ANI 검색 키 */
		sANI=removespace(strPopupData.substring(132,152));/* Automatic Number Identification (고객전화번호)*/
		sQueueTime=removespace(strPopupData.substring(152,158));/* Queue 대기시간 */
		sInboundData=removespace(strPopupData.substring(158,358));/* Inbound Data (From IVR) */
		sConsultData=removespace(strPopupData.substring(358,458));/* Consultation Data (From Agent) */
		
		/* var ee=sSvckey+sSvcCode+sTimeKey+sTime+sStationKey+sStation+sAgentIDKey+sAgentID+sCallIDKey+sCallID+sChannelKey+sChannel+sCallTypeKey+sCallType+sEvtReserved
		+sUCIDKey+sUCID+sDNISKey+sDNIS+sANIKey+sANI+sQueueTime+sInboundData+sConsultData; */
	}
		
	
	function ex3(strPopupData){
		/* 공통 시작 */
		sSvckey =removespace(strPopupData.substring(0,8));
		sSvcCode=removespace(strPopupData.substring(8,11));
		sTimeKey=removespace(strPopupData.substring(11,12));/* ‘m’ : Time 검색 키 */
		sTime=removespace(strPopupData.substring(12,26));/* YYYYMMDDHHMMSS */
		sStationKey=removespace(strPopupData.substring(26,27));/* ‘s’ : Station 검색 키 */
		sStation=removespace(strPopupData.substring(27,37));/* Station  */
		sAgentIDKey=removespace(strPopupData.substring(37,38));/* ‘a’ : AgentID 검색 키 */
		sAgentID=removespace(strPopupData.substring(38,48));/* PBX Login sCallTypeID */
		sCallIDKey=removespace(strPopupData.substring(48,49));/* ‘c’ : CallID 검색 키 */
		sCallID=removespace(strPopupData.substring(49,54));/* Call ID */
		sChannelKey=removespace(strPopupData.substring(54,55));/* ‘n’ : Channel 검색 키 */
		
		sChannel=removespace(strPopupData.substring(55,57));/* Channel Type */
		sCallTypeKey=removespace(strPopupData.substring(57,58));/* ‘t’ : Type 검색 키 */
		sCallType=removespace(strPopupData.substring(58,60));/* Call Type */
		sEvtReserved=removespace(strPopupData.substring(60,89));/* 추가 데이터 영역 */
		/* 공통  끝*/
		p_flag_station=removespace(strPopupData.substring(89,90));/* ‘i’ : IVR 검색키 */
		p_station=removespace(strPopupData.substring(90,100));/* 비번IVR 내선번호 */
		sPassword=removespace(strPopupData.substring(100,200));/* 비번정보  */
		
		/* var ee=sSvckey+sSvcCode+sTimeKey+sTime+sStationKey+sStation+sAgentIDKey+sAgentID+sCallIDKey+sCallID+sChannelKey+sChannel+sCallTypeKey+sCallType+sEvtReserved
		+p_flag_station+p_station+sPassword; */
	}
	
	
	
	
	
	function _event_packet_01(recv_data){						//전문길이 106
		
		p_packet_key =removespace(recv_data.substring(0,8));									//CTI_EVNT
		p_length=removespace(recv_data.substring(8,12));										//'0475'
		p_result_code=removespace(recv_data.substring(12,17));									//공백
		p_svc_key=removespace(recv_data.substring(17,25));										//서비스 키참조
		p_svc_code=removespace(recv_data.substring(25,28));										//서비스 코드 참조
		
		p_flag_time=removespace(recv_data.substring(28,29));									//'m'
		p_time=removespace(recv_data.substring(29,43));											//'YYYYMMDDHHMMSS'
		
		p_flag_station=removespace(recv_data.substring(43,44));									//'s'
		p_station=removespace(recv_data.substring(44,54));										//내선번호
		
		p_flag_agentid=removespace(recv_data.substring(54,55));									//'a'
		p_agentid=removespace(recv_data.substring(55,65));										//PBX Login ID
		
		p_flag_callid=removespace(recv_data.substring(65,66));									//'c'
		p_callid=removespace(recv_data.substring(66,71));										//Call ID
		
		p_flag_channel=removespace(recv_data.substring(71,72));									//'n'
		p_channel_type=removespace(recv_data.substring(72,74));									//Channel Type 참조
		
		p_flag_direct=removespace(recv_data.substring(74,75));									//'t'
		sCallType=removespace(recv_data.substring(75,77));										//Direction Type 참조
		
		p_res_basic=removespace(recv_data.substring(77,106));									//예약영역
	}
	function _event_packet_02(recv_data){						//전문길이 475
		
		p_packet_key =removespace(recv_data.substring(0,8));									//CTI_EVNT
		p_length=removespace(recv_data.substring(8,12));										//'0475'
		p_result_code=removespace(recv_data.substring(12,17));									//공백
		p_svc_key=removespace(recv_data.substring(17,25));										//서비스 키참조
		p_svc_code=removespace(recv_data.substring(25,28));										//서비스 코드 참조
		
		p_flag_time=removespace(recv_data.substring(28,29));									//'m'
		p_time=removespace(recv_data.substring(29,43));											//'YYYYMMDDHHMMSS'
		
		p_flag_station=removespace(recv_data.substring(43,44));									//'s'
		p_station=removespace(recv_data.substring(44,54));										//내선번호
		
		p_flag_agentid=removespace(recv_data.substring(54,55));									//'a'
		p_agentid=removespace(recv_data.substring(55,65));										//PBX Login ID
		
		p_flag_callid=removespace(recv_data.substring(65,66));									//'c'
		p_callid=removespace(recv_data.substring(66,71));										//Call ID
		
		p_flag_channel=removespace(recv_data.substring(71,72));									//'n'
		p_channel_type=removespace(recv_data.substring(72,74));									//Channel Type 참조
		
		p_flag_direct=removespace(recv_data.substring(74,75));									//'t'
		sCallType=removespace(recv_data.substring(75,77));										//Direction Type 참조
		
		p_res_basic=removespace(recv_data.substring(77,106));									//예약영역
		/* 공통 끝 */
		
		p_flag_ucid=removespace(recv_data.substring(106,107));									//'U'
		p_ucid=removespace(recv_data.substring(107,127));										//UCID(Universal Call ID)
		
		p_flag_dnis=removespace(recv_data.substring(127,128));									//'D'
		sDNIS=removespace(recv_data.substring(128,148));										//직전VDN번호
		
		p_flag_ani=removespace(recv_data.substring(148,149));									//'A'
		sANI=removespace(recv_data.substring(149,169));											//고객전화번호
		
		p_que_time=removespace(recv_data.substring(169,175));									//Queue 대기시간(초)
		p_inbound_data=removespace(recv_data.substring(175,375));								//INBOUND Data (From IVR)
		p_consult_data=removespace(recv_data.substring(375,475));								//Consult Data (From Agent)
		
	}
	function Srecoad(){/* 녹취시작 */
		//getDataMain(2);/* 녹취 키 넘기기  */
		var calltype = sCallType; /* I/o구분  */
		if(calltype==03){
			IO="I";
			rec_ani=sANI;
		}else if(calltype==05){
			IO="O";
			rec_ani=sDNIS;
		}else{
			IO="I";
			rec_ani=sANI;
		}
		
		$.ajax({
			type:"POST"
			,url:"rec_start"
			,data:{
					station:SoftPhoneForm.Station.value,
					agentId:SoftPhoneForm.Station.value,
					phoneNumber:rec_ani,
					direction:IO,
					optional1:key
					
			}
			,success:function(data){
			      if(data.result == "0"){// 정상버튼컨트롤처리
						recoad = 0;
						getDataMain(2); /* 녹취 키 넘기기 */  
						$("#Erecoading_on").show();
						$("#Erecoading_off").hide();
						$("#Srecoading_on").hide();
						$("#Srecoading_off").show();
			      }else{
			    	 // 실패 처리
			    	   alert("녹취시작실패");
			    	 }
			      }
			,error:function(data){
				
			}
		});
		 
	}
	function Erecoad() /* 녹취종료 */
	{
		$.ajax({
			type:"POST"
			,url:"rec_end"
			,data:{
					station:SoftPhoneForm.Station.value,
					agentId:SoftPhoneForm.Station.value,
					phoneNumber:rec_ani,
					direction:IO,
					optional1:key
					
			}
			,success:function(data){
			      if(data.result == "0"){// 정상버튼컨트롤처리
			    	  recoad = 1;
						rec_ani="";
						$("#Srecoading_on").show();
						$("#Srecoading_off").hide();
						$("#Erecoading_on").hide();
						$("#Erecoading_off").show();
			      }else{
			    	 // 실패 처리
			    	  alert("녹취종료실패");
			    	 }
			      }
			,error:function(data){
				
			}
		});
	}
	function dmskey(){
		dmskey = getTimeStamp()+SoftPhoneForm.AgentID.value;
	}
	function getTimeStamp() {
		  var d = new Date();
		  var s =
		    leadingZeros(d.getFullYear(), 4)  +
		    leadingZeros(d.getMonth() + 1, 2) + 
		    leadingZeros(d.getDate(), 2) +

		    leadingZeros(d.getHours(), 2) + 
		    leadingZeros(d.getMinutes(), 2) + 
		    leadingZeros(d.getSeconds(), 2);

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
		function closePage(){ 
			ct_logout_disconnect(); 
			// 창이 닫혔을 때 처리할 함수  (새로고침 할 때도 반응함)

			} 
		/* function check(name, progid){
	        var installed;
	        var msg;
	       
	        try {
	               var axObj = new ActiveXObject(progid);
	       
	               if(axObj){
	                       installed = true;
	               } else {
	                       installed = false;
	               }
	        } catch (e) {
	               installed = false;
	        }
	       
	        if(installed) {
	               msg = '설치됨';
	        } else {
	               msg = name + ' 미설치';
	        }     
	       
	        return '<b>' + msg + '</b><br>';
	}     
	 
	document.write(check('Adobe PDF Link Helper','AcroIEHelperShim.AcroIEHelperShimObj')); */

	</script>
	<script>
	/* 인증서 다운로드 */
	function ssl_cert_download(){
		/* if(confirm("인증서를 다운로드 하시겠습니까?")){ */
			/* location.href = "./SSL_192.168.100.80.zip"; */
			window.open("ssl_down", "인증서 설치방법", "width = 850, height = 900, top = 100, left = 200, location = no" );
		/* } */
	}
	</script>
	<BODY onbeforeunload="closePage()"> 
 <FORM METHOD="post"	NAME="SoftPhoneForm" onsubmit="return false">
 	<div id="loginForm" style="display:;">
		<span class="login_img">
			<img src="images/login_img.png" width="60" alt="" />
		</span>
		<div class="login_box">
			<span class="agent_name">상담원</span>
			<span class="agent_name_id">${userId}</span>
			<span class="login_tit">내선번호</span>
			<input class="login_txt" type="text" NAME="Station" id="station"/>
			<INPUT TYPE="hidden"NAME="l_agentid" SIZE='8'  MAXLENGTH='8'value="${l_agentid }">
			<INPUT TYPE="hidden"NAME="empId" id="empId" SIZE='8'  MAXLENGTH='8'value="${empId }"> 
			<INPUT TYPE="hidden" id="AgentID"NAME="AgentID" SIZE='8'  MAXLENGTH='8'>
			<INPUT TYPE="hidden"  NAME="ReasonCode" SIZE='2'	MAXLENGTH='2' VALUE="0">
		</div>
		<button class="login_btn" onclick="ssl_cert_download()" style="width:100px; margin: 10px 0 0 20px;">		
			<span>인증서 다운</span>
			<img src="images/login_icon.png" width="18" alt="" />
		</button>
		<button class="login_btn" id="login" NAME="login" onclick="ct_connect_login()" style="width:100px; margin: 10px 0 0 20px;">		
			<span>로그인</span>
			<img src="images/login_icon.png" width="18" alt="" />
		</button>
	</div>
 	<div id="softphone_wrap" style="display:;">
 		<input type="hidden" id="setTime"value="${inttime}">
 		<input type="hidden" id="setTime2"value="${inttime2}">
 		<input type="hidden" id="ab_onoff"value="${ab_onoff}">
		<div id="first_BTN">
			<span class="situation_LED">
			<input type="text" id="status" name="status" disabled/>
			</span>
			<!-- <span class="situation_LED" style="display:none;">
			<input type="text" class="rest_color" value="휴  식  중"/>
			</span>
			<span class="situation_LED" style="display:none;">
			<input type="text" class="work_color" value="업  무  중"/>
			</span>
			<span class="situation_LED" style="display:none;">
			<input type="text" class="call_color" value="통  화  중"/>
			</span>
			<span class="situation_LED" style="display:none;">
			<input type="text" class="call_color" value="보  류  중"/>
			</span>
			<span class="situation_LED" style="display:none;">
			<input type="text" class="call_color" value="연  결  중"/>
			</span> -->
	
			<span class="tel_LED">
			<input type="text" id="Dest" NAME="Dest" placeholder="번호입력" onkeydown="InpuOnlyNumber(this)">
			</span>
			<button class="situation_btn" onClick="ct_ready()" id="ready_on">		
			<span>대  기</span>
			<img src="images/icon/stand-by_on.png" alt="" />
			</button>
			
			<button class="situation_btn_off" style="display:none;" id="ready_off">		
			<span>대  기</span>
			<img src="images/icon/stand-by_on.png" alt="" />
			</button><!-- 대  기_off -->
			
			<button class="situation_btn" onClick="ct_aux('1')" id="notready_on">		
			<span>휴  식</span>
			<img src="images/icon/rest_on.png" alt="" />
			</button>
			
			<button class="situation_btn_off" style="display:none;" id="notready_off">		
			<span>휴  식</span>
			<img src="images/icon/rest_on.png" alt="" />
			</button><!-- 휴  식_off -->
			
			<button class="situation_btn" onClick="ct_aux('2')" id="acw_on">		
			<span>업  무</span>
			<img src="images/icon/work_on.png" alt="" />
			</button>
			
			<button class="situation_btn_off" style="display:none;" id="acw_off">		
			<span>업  무</span>
			<img src="images/icon/work_on.png" alt="" />
			</button><!-- 업  무_off -->
			
			<button class="situation_btn_dms" onclick="cmd_ctSDMS()" id="sdms_on">		
			<span>smart DMS</span>
			<img src="images/icon/smart-DMS_on.png" alt="" />
			</button>
			
			<button class="situation_btn_dms_off" style="display:none;" id="sdms_on">		
			<span>smart DMS</span>
			<img src="images/icon/smart-DMS_on.png" alt="" />
			</button>
			
			<button class="logout_btn" onClick="ct_logout_disconnect()" id="logout">		
			<span>로그아웃</span>
			</button><!-- smart DMS_off -->
			
		</div><!-- first_BTN End-->
		<div id="second_BTN">
		
			<button class="call_btn" onclick="ct_make()" id="make_on">		
				<span>전화걸기</span>
				<img src="images/icon/call_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="make_off">		
				<span>전화걸기</span>
				<img src="images/icon/call_off.png" alt="" />
			</button><!-- smart DMS_off -->
			
			<button class="call_btn" onClick="ct_clear()" id="clear_on">		
				<span>전화끊기</span>
				<img src="images/icon/phone_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="clear_off">		
				<span>전화끊기</span>
				<img src="images/icon/phone_off.png" alt="" />
			</button><!-- 전화끊기_off -->
			
			<button class="call_btn" onclick="ct_hold()" id="hold_on">		
				<span style="letter-spacing:0.5em;">보 류</span>
				<img src="images/icon/hold_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="hold_off">		
				<span style="letter-spacing:0.5em;">보 류</span>
				<img src="images/icon/hold_off.png" alt="" />
			</button><!-- 보 류_off -->
			
			<button class="call_btn" onClick="ct_retrieve()" id="retrieve_on">		
				<span>보류해제</span>
				<img src="images/icon/hold_cancel_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="retrieve_off">		
				<span>보류해제</span>
				<img src="images/icon/hold_cancel_off.png" alt="" />
			</button><!-- 보류해제_off -->
			
			<button class="call_btn" onClick="popup()" id="transfer_on">		
				<span style="letter-spacing:0.3em;">호전환</span>
				<img src="images/icon/call-transfer_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="transfer_off">		
				<span style="letter-spacing:0.3em;">호전환</span>
				<img src="images/icon/call-transfer_off.png" alt="" />
			</button><!-- 호전환_off -->
			
			<button class="call_btn" onClick="Srecoad()" id="Srecoading_on">		
				<span>녹취시작</span>
				<img src="images/icon/recording_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="Srecoading_off">		
				<span>녹취시작</span>
				<img src="images/icon/recording_off.png" alt="" />
			</button><!-- 녹취시작_off -->
			
			<button class="call_btn" onClick="Erecoad()" id="Erecoading_on">		
				<span>녹음종료</span>
				<img src="images/icon/recordingE_on.png" alt="" />
			</button>
			
			<button class="call_btn_off" style="display:none;" id="Erecoading_off">		
				<span>녹음종료</span>
				<img src="images/icon/recordingE_off.png" alt="" />
			</button><!-- 녹음종료_off -->
			
		</div><!-- second_BTN End-->
	</div><!-- softphone_wrap End-->
 </FORM>
		<!-- cti test용 server info  -->
		<input type="hidden" id="c_ip"name="c_ip"value="${new_c_ip}">
		<input type="hidden" id="c_port"name="c_port"value="${new_c_port}">
		
		
		<!-- 녹취서버정보  -->
		<input type="hidden" id="r_ip" name="r_ip"value="${r_ip}">
		<input type="hidden" id="r_port"name="r_port"value="${r_port}">
		
		
		<!-- 호전환 - 협의  -->
		<input type="hidden" id="consult_dest" name="consult_dest">
		<input type="hidden" id="consult_ani" name="consult_ani">
		<input type="hidden" id="consult_ucid" name="consult_ucid">
		<input type="hidden" id="consult_data1" name="consult_data1">
		<input type="hidden" id="consult_data2" name="consult_data2">
		<input type="hidden" id="consult_data2" name="consult_sDNIS">
		
		<!-- CTI 스마트 DMS 설정 정보 --> 
		
		<SCRIPT	language="JavaScript">
		var SetTimes = $('#setTime').val();
		var SetTimes2 = $('#setTime2').val();
		var tid="";
		var tid2="";
			function msg_time() {	//1초씩 카운트
				m = Math.floor(SetTimes / 60) + "분 " + (SetTimes % 60) + "초";	 // 남은 시간 계산 
				
				var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
				
				SetTimes--;					// 1초씩 감소
				
				if (SetTimes < 0) {			// 시간이 종료 되었으면..
					
					clearInterval(tid);		// 타이머 해제
					SetTimes = $('#setTime').val();
					ct_logout_disconnect();
					alert("132전화상담 세션이 종료 되었습니다.\n내선번호 입력 후 다시 로그인을 하여주시기 바랍니다.\nex) 휴식/업무 1시간 이상 세션종료\n");
				}
				
			}
			function TimerStart()
			{
				tid=setInterval('msg_time()',1000);
				
			}
			function TimerStop()
			{
				clearInterval(tid);
				SetTimes = $('#setTime').val();
			}
			function msg_time2() {	// 1초씩 카운트
				m = Math.floor(SetTimes2 / 60) + "분 " + (SetTimes2 % 60) + "초";	 // 남은 시간 계산 
				
				var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
				
				SetTimes2--;					// 1초씩 감소
				
				if (SetTimes2 < 0) {			// 시간이 종료 되었으면..
					
					clearInterval(tid2);		// 타이머 해제
					SetTimes2 = $('#setTime2').val();
					ct_logout_disconnect();
					alert("132전화상담 세션이 종료 되었습니다.\n내선번호 입력 후 다시 로그인을 하여주시기 바랍니다.\nex) 대기 5분 이상 세션종료\n");
				}
				
			}
			function TimerStart2()
			{
				tid2=setInterval('msg_time2()',1000);
				
			}
			function TimerStop2()
			{
				clearInterval(tid2);
				SetTimes2 = $('#setTime2').val();
			}
			new_c_ip = $("#new_c_ip").val();
			new_c_port = $("#new_c_port").val();
			 r_ip = $("#r_ip").val();
			 r_port = $("#r_port").val();
			/* var rc = BridgeX.ctSetServerConfig(c_ip,c_port);
			if (rc!=0){
				SoftPhoneForm.status.value="서버연결실패"+rc;
				btncontrol(0,0,0,0,0,0,0,0,0,0,0);
				$("#status").hide();
				$("#sdms").hide();
				$("#Desk").hide();
			}
			else if(rc==0){
 			} */  
			
			function popup(){
				objPopup = window.open("new_consultlist","new_cunsult","width=685,height=415,scrollbar=yes");
				objPopup.focus();
			}
			function closePopup(){
				if(objPopup!= null) objPopup.close();

			}
			function closecallPopup(){
				if(objcallpop!= null) objcallpop.close();

			}
			function child(){
				if(objPopup !=undefined){
					
					objPopup.$("#consultation").show();
					objPopup.$("#reconnect").hide();
					objPopup.$("#transfer").hide();
				}
			}
			function removespace(sth){
				sth = sth.replace(/(\s*)/g, "");
				return sth;
			}
			function InpuOnlyNumber(obj) 
			{
				$(obj).keyup(function(){
			         $(this).val($(this).val().replace(/[^0-9]/g,""));
			    }); 
			}
		</SCRIPT>
		
	</BODY>
    <script type="text/javascript"      src="./js/sp_sdk.js"></script>
    <script type="text/javascript"      src="./js/sp_display.js"></script>
    
    <script type="text/javascript"      src="./js/sp_result_code.js"></script>
    
    <script type="text/javascript"      src="./js/wsp_packet.js"></script>
    <script type="text/javascript"      src="./js/wsw_wrapper.js"></script>
    <script type="text/javascript"      src="./js/wso_observer.js"></script>
    <script type="text/javascript"      src="./js/wsk_kernel.js"></script>
    <script type="text/javascript"      src="./js/wse_event.js"></script>
	<script type="text/javascript"      src="./js/wsc_connector.js"></script>
    <script>
    	var WSK_API          = wsk_kernel.get_instance();
    	 WSK_API.wsk_reg_event_handler(wse_event_handler);
    </script>
</HTML>