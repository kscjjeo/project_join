
var logout; /* 로그아웃 */ var ready; /* 대기 */ var transfer;/* 호전환 */
var notready; /* 휴식 */ var clear; /* 전화끊기 */var make;/* 전화걸기 */
var hold; /* 보류 */ var retrieve; /* 보류복귀 */ 
var consultation; /* 협의  */ var reconnect; /* 협의복귀 */
var acw; /* 업무*/ 


logout=0;	ready=0;	transfer=0; 
notready=0;	clear=0;	make=0;
hold=0;	retrieve=0;	consultation=0;
reconnect=0;	 acw=0;
function btncontrol(logout,ready,transfer,notready,clear,make,hold,retrieve,consultation,reconnect,acw){
		
		/* 1 */
		if(logout==0){
			$("#logout").hide();
		}else if(logout==1){
			$("#logout").show();
		}
		/* 2 */
		if(ready==0){
			$("#ready_on").hide();
			$("#ready_off").show();
		}else if(ready==1){
			$("#ready_on").show();
			$("#ready_off").hide();
		}
		/* 3 */
		if(notready==0){
			$("#notready_on").hide();
			$("#notready_off").show();
		}else if(notready==1){
			$("#notready_on").show();
			$("#notready_off").hide();
		}
		/* 4 */
		if(transfer==0){
			$("#transfer_on").hide();
			$("#transfer_off").show();
		}else if(transfer==1){
			$("#transfer_on").show();
			$("#transfer_off").hide();
		}
		/* 5 */
		if(clear==0){
			$("#clear_on").hide();
			$("#clear_off").show();
		}else if(clear==1){
			$("#clear_on").show();
			$("#clear_off").hide();
		}
		/* 6 */
		if(make==0){
			$("#make_on").hide();
			$("#make_off").show();
		}else if(make==1){
			$("#make_on").show();
			$("#make_off").hide();
		}
		/* 7 */
		if(hold==0){
			$("#hold_on").hide();
			$("#hold_off").show();
		}else if(hold==1){
			$("#hold_on").show();
			$("#hold_off").hide();
		}/* 8 */
		if(retrieve==0){
			$("#retrieve_on").hide();
			$("#retrieve_off").show();
		}else if(retrieve==1){
			$("#retrieve_on").show();
			$("#retrieve_off").hide();
		}/* 9 */
		if(consultation==0){
			$("#consultation_on").hide();
			$("#consultation_off").show();
		}else if(consultation==1){
			$("#consultation_on").show();
			$("#consultation_off").hide();
		}/* 10 */
		if(reconnect==0){
			$("#reconnect_on").hide();
			$("#reconnect_off").show();
		}else if(reconnect==1){
			$("#reconnect_on").show();
			$("#reconnect_off").hide();
		}/*11  */
		if(acw==0){
			$("#acw_on").hide();
			$("#acw_off").show();
		}else if(acw==1){
			$("#acw_on").show();
			$("#acw_off").hide();
		}
}