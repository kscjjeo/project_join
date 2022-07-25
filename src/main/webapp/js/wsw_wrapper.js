//##############################################################################
//
//			wsw_wrapper.js
//
//											BridgeW Wrapper
//                                          for CTIBridge 3.7x
//                                          Edit by Lee eon woo
//
//											Hansol Inticube Co., Ltd.
//											All rights reserved.
//
//##############################################################################


// Connection Info
//var ct_server_ip_          = "127.0.0.1"; 
//var ct_server_port_        = 28090; 
var ct_server_ip_          = $("#c_ip").val(); 
var ct_server_port_        = $("#c_port").val();

// CTI Parameter
var ct_station_         = "";
var ct_agentid_         = "";
var ct_group_code_      = "";
var ct_employeeid_      = "";
var ct_reason_code_     = 0;
var rc                  = 0;


//==============================================================================
//  ct_connect_login
//==============================================================================
function ct_connect_login()
{    
	
	var empId=$("#empId").val();
	SoftPhoneForm.AgentID.value= SoftPhoneForm.l_agentid.value+SoftPhoneForm.Station.value;
	var l_agentid =SoftPhoneForm.AgentID.value;
	var l_station =SoftPhoneForm.Station.value;
	
	
    // Get connection info
    
    var server_ip          = ct_server_ip_;
    var server_port        = ct_server_port_;
    	        
    // Get CTI parameter
    ct_station_            = l_station;
    ct_agentid_            = SoftPhoneForm.AgentID.value;
    ct_group_code_         = "";
    ct_employeeid_         = ""; //document.getElementById("employeeid").value;
    
        
    disp_log("Connect & Login..., (" + server_ip  + "," +  server_port + ")");
    if(l_station=="1164"){
		alert('내선번호를 확인해주세요.');
		return false;
	}
    //-------------------------------------------
    //  wsk_connect
    //-------------------------------------------        
    WSK_API.wsk_connect(server_ip, server_port, function(rc) {
  	    if (rc === 0) {
  	        //-------------------------------------------
  	        //  WSK_API.wsk_login
  	        //-------------------------------------------   
  	        // Login
  	      $.ajax({
	  			type:"POST"
	  			,url:"loginA"
	  			,dataType:'json'
	  			,async:false
	  			,data:{empId:empId,l_station:l_station}
	  			,success:function(data){
	  				if(data.result=="success"){
	  					WSK_API.wsk_login(ct_station_, ct_agentid_, ct_group_code_, ct_employeeid_, function(rc) {
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
		  						setTimeout("ct_aux('1')",0);//로그인 성공 시 자동 휴식상태
		  						$("#Srecoading_on").hide();// 녹취시작 활성화버튼 숨기기 
		  						$("#Srecoading_off").show();// 녹취시작 비활성화버튼 보여주기 
		  						$("#Erecoading_on").hide();// 녹취종료 활성화버튼 숨기기 
		  						$("#Erecoading_off").show();// 녹취종료 비활성화버튼 보여주기 
		  					}else{// 로그인 실패 시 
		  						$("#loginForm").css("display", "");
		  						$("#softphone_wrap").css("display", "none");
		  						btncontrol(0,0,0,0,0,0,0,0,0,0,0);
		  						alert("로그인실패\n"+sp_get_result_msg(rc));
		  					}
	  					});
	  				}else{
	  					alert(data.result);
	  				}
	  			}
	  			,error:function(data){
	  				alert("로그인체크실패");
	  			}
	  		});
  	    	/*WSK_API.wsk_login(ct_station_, ct_agentid_, ct_group_code_, ct_employeeid_, function(rc) {
					if(rc==0){		// rc = 0 : 로그인성공 , else : 실패  
						v_login=1;
						setCookie('cti_station',SoftPhoneForm.Station.value,180);
						$("#loginForm").css("display", "none");// 로그인창 숨기기 
						$("#softphone_wrap").css("display", "");// 소프트폰 보여주기 
						btncontrol(1,0,0,0,0,0,0,0,0,0,0);
						setTimeout("ct_aux('1')",0);//로그인 성공 시 자동 휴식상태
						$("#Srecoading_on").hide();// 녹취시작 활성화버튼 숨기기 
						$("#Srecoading_off").show();// 녹취시작 비활성화버튼 보여주기 
						$("#Erecoading_on").hide();// 녹취종료 활성화버튼 숨기기 
						$("#Erecoading_off").show();// 녹취종료 비활성화버튼 보여주기 
					}else{// 로그인 실패 시 
						$("#loginForm").css("display", "");
						$("#softphone_wrap").css("display", "none");
						btncontrol(0,0,0,0,0,0,0,0,0,0,0);
						alert("로그인실패\n"+sp_get_result_msg(rc));
					}
				});*/
  	    }
  		else {
  			alert("서버접속실패\n"+sp_get_result_msg(rc));
        }
    });
}


//==============================================================================
//  ct_logout_disconnect
//==============================================================================
function ct_logout_disconnect(){
	
	var empId=$("#empId").val();
	var l_agentid =SoftPhoneForm.AgentID.value;
	var l_station =SoftPhoneForm.Station.value;
	
    WSK_API.wsk_logout_disconnect(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
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
        }
        else {
        	if(v_login==1){
				alert("로그아웃실패\n"+sp_get_result_msg(rc));
			}
        }
    });
}






//======================================================================
//  ct_connect
//======================================================================
function ct_connect()
{
    server_ip       = document.getElementById("new_server_ip").value;
    server_port     = document.getElementById("new_server_port").value;
    
    WSK_API.wsk_connect(server_ip, server_port, function(rc) {
  	    if (rc === 0) {
  	    }
		else {
			alert("서버접속실패\n"+sp_get_result_msg(rc));
        }
    });
    
	
} 	

//======================================================================
//  ct_disconnect
//======================================================================
function ct_disconnect()
{
    var promise = WSK_API.wsk_disconnect(function(rc) {			
	    if (rc === 0) {
  	    }
		else {
			alert("서버접속해제실패\n"+sp_get_result_msg(rc));
        }
    });
} 	



     
     
//==============================================================================
//  ct_ready
//==============================================================================
function ct_ready()
{
    WSK_API.wsk_ready(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
        	btncontrol(1,0,0,1,0,1,0,0,0,0,1);
			SoftPhoneForm.status.value="대기";
			v_acw=0;
			$("#status").removeClass('rest_color');
			$("#status").removeClass('work_color');
			$("#status").removeClass('call_color');
			//TimerStart2();
			TimerStop();
			p_status = 1;
        }
        else {
        	alert("대기실패\n"+sp_get_result_msg(rc));
        }
    });               
}
   
//==============================================================================
//  ct_aux
//==============================================================================
function ct_aux(reason_code)
{
    WSK_API.wsk_aux(ct_station_, ct_agentid_, reason_code, function(rc) {
        if (rc == 0) {
        	if(reason_code==1){
				SoftPhoneForm.status.value="휴식";
				btncontrol(1,1,0,0,0,1,0,0,0,0,1);
				//TimerStop2();
			}else if(reason_code==2){
				SoftPhoneForm.status.value="업무";
				btncontrol(1,1,0,1,0,1,0,0,0,0,0);
				//TimerStop2();
			}
			$("#status").addClass('rest_color');
			$("#status").removeClass('work_color');
			$("#status").removeClass('call_color');
			
			//로그아웃 대기 전화걸기 후처리
			p_status =0;
        }
        else {
        	alert("휴식실패\n"+sp_get_result_msg(rc));
        }
    });              

    
}
   
//==============================================================================
//  ct_acw
//==============================================================================
function ct_acw()
{ 
    WSK_API.wsk_acw(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
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
			p_status = 1;
			if(end==0){
				/* btncontrol(1,0,0,1,0,1,0,0,0,0,1); */
			}
        }
        else {
        	alert("후처리실패\n"+sp_get_result_msg(rc));
        }
    });
    
} 

 






//==============================================================================
//  ct_ipt_connect_login
//==============================================================================
function ct_ipt_connect_login()
{    
    // Get connection info
    ct_server_ip_          = document.getElementById("new_c_ip").value;
    ct_server_port_        = document.getElementById("new_c_port").value;
    
    var server_ip          = document.getElementById("server_ip").value;
    var server_port        = document.getElementById("server_port").value;
    	        
    // Get CTI parameter
    ct_station_            = document.getElementById("station").value;
    ct_agentid_            = document.getElementById("agentid").value;
    ct_group_code_         = "";
    ct_employeeid_         = "";
    
        
    disp_log("Connect & IPT_Login..., (" + server_ip  + "," +  server_port + ")");
    
    //-------------------------------------------
    //  wsk_connect
    //-------------------------------------------        
    WSK_API.wsk_connect(server_ip, server_port, function(rc) {
  	    if (rc === 0) {
  	        disp_log("Connect...OK");
  	        //disp_conn_status(CONN_STATUS_ON);
  	        
  	        //-------------------------------------------
  	        //  WSK_API.wsk_ipt_login
  	        //-------------------------------------------   
  	        // IPT Login
  	        disp_log("IPT Login..., (" + ct_station_  + "," +  ct_agentid_ + ")");
  	        WSK_API.wsk_ipt_login(ct_station_, ct_agentid_, function(rc) {
  	           if (rc == 0) {
       	            disp_log("IPT_Login...OK");
       	            //disp_agent_status(SVC_CODE_SET_READY, 0);
          	    }
          	    else {
                    disp_log("IPT_Login...Fail! (" + sp_get_result_msg(rc, WSK_API.wsk_res_common_) + ")");
                    
                    //#############################
                    // 2018.07.19
                    //#############################
                    WSK_API.wsk_disconnect(function(rc) {
                        if (rc == 0) {
                            disp_log("Disconnect...OK");
                            //disp_agent_status(SVC_CODE_SET_LOGOUT, 0);
                        }
                        else {
                            disp_log("Disconnect...Fail! (" + rc + ")");
                        }   
                    });
                    //##############################
                    
                }
            });
  	    }
  		else {
  		    disp_log("Connect...Fail! (" +sp_get_result_msg(rc) + ")");
  		    //disp_conn_status(CONN_STATUS_OFF);
        }
    });
}



//==============================================================================
//  ct_ipt_logout_disconnect
//==============================================================================
function ct_ipt_logout_disconnect()
{
    disp_log("IPT_LogoutDisconnect...");
    WSK_API.wsk_ipt_logout_disconnect(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
            disp_log("IPT_LogoutDisconnect...OK");
            //disp_agent_status(SVC_CODE_SET_LOGOUT, 0);
        }
        else {
            disp_log("IPT_LogoutDisconnect...Fail! (" + rc + ")");
        }
    });
}


//==============================================================================
//  ct_ipt_ready
//==============================================================================
function ct_ipt_ready()
{
    disp_log("IPT_Ready...");
    WSK_API.wsk_ipt_ready(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
            disp_log("IPT_Ready...OK");
            //disp_agent_status(SVC_CODE_SET_READY, 0);
        }
        else {
            disp_log("IPT_Ready...Fail! (" + rc + ")");
        }
    });                
}
   
//==============================================================================
//  ct_ipt_aux
//==============================================================================
function ct_ipt_aux(reason_code)
{
    disp_log("IPT_AUX(" + reason_code + ")...");
    WSK_API.wsk_ipt_aux(ct_station_, ct_agentid_, reason_code, function(rc) {
        if (rc == 0) {
            disp_log("IPT_AUX(" + reason_code + ")...OK");
            //disp_agent_status(SVC_CODE_SET_AUX, reason_code);
        }
        else {
            disp_log("IPT_AUX(" + reason_code + ")...Fail! (" + rc + ")");
        }
    });              

    
}
   
//==============================================================================
//  ct_ipt_acw
//==============================================================================
function ct_ipt_acw()
{ 
    disp_log("IPT_ACW...");
    WSK_API.wsk_ipt_acw(ct_station_, ct_agentid_, function(rc) {
        if (rc == 0) {
            disp_log("IPT_ACW...OK");
            //disp_agent_status(SVC_CODE_SET_ACW, 0);
        }
        else {
            disp_log("IPT_ACW...Fail! (" + rc + ")");
        }
    });
    
} 




//==============================================================================
//  ct_set_fwd
//==============================================================================
function ct_set_fwd()
{
    var fwd_dest = document.getElementById("fwd_dest").value;  
        
    disp_log("SetFWD(" + fwd_dest + ")...");
    WSK_API.wsk_set_fwd(ct_station_, "00", fwd_dest, function(rc) {
        if (rc == 0) {
            disp_log("SetFWD(" + fwd_dest + ")...OK");
        }
        else {
            disp_log("SetFWD(" + fwd_dest + ")...Fail! (" + rc + ")");
        }
    });
}		

//==============================================================================
//  ct_cancel_fwd
//==============================================================================
function ct_cancel_fwd() 
{
    disp_log("CancelFWD...");
    WSK_API.wsk_cancel_fwd(ct_station_, function(rc) {
        if (rc == 0) {
            disp_log("CancelFWD...OK");
        }
        else {
            disp_log("CancelFWD...Fail! (" + rc + ")");
        }
    });
}


//==============================================================================
//  ct_clear
//==============================================================================
function ct_clear() 
{
    WSK_API.wsk_clear(ct_station_, function(rc) {
        if (rc == 0) {
        }
        else {
        	alert("전화끊기실패\n"+sp_get_result_msg(rc));
        }
    });
}

//==============================================================================
//  ct_answer
//==============================================================================
function ct_answer()
{
    WSK_API.wsk_answer(ct_station_, function(rc) {
        if (rc == 0) {
        }
        else {
        }
    });
}		

//==============================================================================
//  ct_hold
//==============================================================================
function ct_hold() 
{
    WSK_API.wsk_hold(ct_station_, function(rc) {
        if (rc == 0) {
        }
        else {
        	alert("보류실패\n"+sp_get_result_msg(rc));
        }
    });
}		

//==============================================================================
//  ct_retrieve
//==============================================================================
function ct_retrieve() 
{
    WSK_API.wsk_retrieve(ct_station_, function(rc) {
        if (rc == 0) {
        }
        else {
        	alert("보류해제실패\n"+sp_get_result_msg(rc));
        }
    });
}	




//==============================================================================
//  ct_conference
//==============================================================================
function ct_conference() 
{
    WSK_API.wsk_conference(ct_station_, function(rc) {
        if (rc == 0) {
        }
        else {
        }
    });
}			

//==============================================================================
//  ct_transfer
//==============================================================================
function ct_transfer() 
{
    WSK_API.wsk_transfer(ct_station_, function(rc) {
        if (rc == 0) {
        	setTimeout("ct_acw()",200);
 			closePopup();
        }
        else {
        	alert("호전환-호전환실패\n"+sp_get_result_msg(rc));
        }
    });
}			

//==============================================================================
//  ct_reconnect
//==============================================================================
function ct_reconnect() 
{
    WSK_API.wsk_reconnect(ct_station_, function(rc) {
        if (rc == 0) {
        	child();
        }
        else {
        	alert("호전환-협의복귀실패\n"+sp_get_result_msg(rc));
        }
    });
}			

//==============================================================================
//  ct_cancel_password
//==============================================================================
function ct_cancel_password() 
{
    disp_log("CancelPassword...");
    WSK_API.wsk_cancel_password(ct_station_, function(rc) {
        if (rc == 0) {
            disp_log("CancelPassword...OK");
        }
        else {
            disp_log("CancelPassword...Fail! (" + rc + ")");
        }
    });
}	



//==============================================================================
//  ct_make
//==============================================================================
function ct_make() 
{
    var make_dest='';   
    r_desk = removespace(SoftPhoneForm.Dest.value);
	if(r_desk==""||r_desk==null){
		alert('번호를 입력해주세요.');
		SoftPhoneForm.Dest.focus();
		return false;
	}
	make_dest = r_desk;
    WSK_API.wsk_make(ct_station_, make_dest, function(rc) {
        if (rc == 0) {
            TimerStop();
    		SoftPhoneForm.Dest.value=r_desk;
        }
        else {
        	alert("전화걸기실패\n"+sp_get_result_msg(rc));
        }
    });
}

//==============================================================================
//  ct_make
//==============================================================================
function ct_make_uui() 
{
    var make_dest   = document.getElementById("make_uui_dest").value;   
    var uui_data    = document.getElementById("make_uui_data").value;   
    
   
    disp_log("MakeUUI(" + make_dest + ", UUI=" + uui_data + ")...");
    WSK_API.wsk_make_uui(ct_station_, make_dest, uui_data, function(rc) {
        if (rc == 0) {
            disp_log("MakeUUI(" + make_dest + ")...OK");
        }
        else {
            disp_log("MakeUUI(" + make_dest + ")...Fail! ("+ rc + ")");
        }
    });
}


//==============================================================================
//  ct_consultation
//==============================================================================
function ct_consultation(c_number) 
{
    var consult_dest    = document.getElementById("consult_dest").value;   
    var consult_ani     = document.getElementById("consult_ani").value;   
    var consult_ucid    = document.getElementById("consult_ucid").value;    // 2018.06.19 �������� 
    var consult_data1   = document.getElementById("consult_data1").value;   
    var consult_data2   = document.getElementById("consult_data2").value;
    WSK_API.wsk_consultation(ct_station_, c_number, consult_ani, consult_ucid, consult_data1, consult_data2, function(rc) {
        if (rc == 0) {
        	consultationflag="Y";
			btncontrol(0,0,1,0,0,0,0,1,0,0,0);
        }
        else {
        	consultationflag="N";
			alert("호전환-협의실패\n"+sp_get_result_msg(rc));
			closePopup();
        }
    });
}	

//==============================================================================
//ct_blind_transfer
//==============================================================================
function ct_blind_transfer(b_number) 
{
	if(sCallType==05){ 
		sendnum=sDNIS;
	}else if(sCallType==03){
		sendnum=sANI;
	}
	 	var consult_dest    = document.getElementById("consult_dest").value;   
	    var consult_ani     = document.getElementById("consult_ani").value;   
	    var consult_ucid    = document.getElementById("consult_ucid").value;    // 2018.06.19 �������� 
	    var consult_data1   = document.getElementById("consult_data1").value;   
	    var consult_data2   = document.getElementById("consult_data2").value;
	WSK_API.wsk_blind_transfer(ct_station_, b_number, sendnum, consult_ucid, consult_data1, consult_data2, function(rc) {
	    if (rc == 0) {
	    }
	    else {
	    	alert("바로호전환실패\n"+sp_get_result_msg(rc));
	    }
	});
}	

//==============================================================================
//  ct_consult_shl
//==============================================================================
function ct_consult_shl() 
{
    var consult_dest    = document.getElementById("consult_dest").value;   
    var consult_ani     = document.getElementById("consult_ani").value;   
    var consult_ucid    = document.getElementById("consult_ucid").value;    // 2018.06.19 �������� 
    var consult_data1   = document.getElementById("consult_data1").value;   
    var consult_data2   = document.getElementById("consult_data2").value;  
    
    WSK_API.wsk_consult_shl(ct_station_, consult_dest, consult_ani, consult_ucid, consult_data1, consult_data2, function(rc) {
        if (rc == 0) {
            disp_log("Consult_SHL(" + consult_dest + ")...OK");
        }
        else {
            disp_log("Consult_SHL(" + consult_dest + ")...Fail! (" + rc + ")");
        }
    });
}	

//==============================================================================
//  ct_consult_enc
// 2018.07.03
//==============================================================================
function ct_consult_enc() 
{
    var consult_dest    = document.getElementById("consult_dest").value;   
    var consult_ani     = document.getElementById("consult_ani").value;   
    var consult_ucid    = document.getElementById("consult_ucid").value;    // 2018.06.19 �������� 
    var enc_data        = document.getElementById("enc_data").value;   
  
    
    WSK_API.wsk_consult_enc(ct_station_, consult_dest, consult_ani, consult_ucid, enc_data, function(rc) {
        if (rc == 0) {
            disp_log("Consult_ENC(" + consult_dest + ")...OK");
        }
        else {
            disp_log("Consult_ENC(" + consult_dest + ")...Fail! (" + rc + ")");
        }
    });
}	


//==============================================================================
//  ct_ask_password
//==============================================================================
function ct_ask_password() 
{
    disp_log("AskPassword...");
    
    var pw_control  = document.getElementById("pw_control").value;   
    var pw_data     = document.getElementById("pw_data").value;   
    
    
    WSK_API.wsk_ask_password(ct_station_, pw_control, pw_data, function(rc) {
        if (rc == 0) {
            disp_log("AskPassword...OK");
        }
        else {
            disp_log("AskPassword...Fail! (" + rc + ")");
        }
    });
}	    

// 2018.10.10
//==============================================================================
//  ct_get_ucid
//==============================================================================
function ct_get_ucid() 
{
    disp_log("GetUCID...");
    
    var qry_cid = document.getElementById("qry_cid").value;   
      
    WSK_API.wsk_get_ucid(ct_station_, qry_cid, function(rc, ucid) {
        if (rc == 0) {
            disp_log("GetUCID...OK, UCID=" + ucid);
        }
        else {
            disp_log("GetUCID...Fail! (" + rc + ")");
        }
    });
}	    




		