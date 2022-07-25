//##############################################################################
//
//      sp_result_code.js
//  
//##############################################################################


RT_CODE = {
	RT_SUCCESS					: 0,
	RT_INVALID_PARAMETER		: "90001",
	RT_SOCKET_CONNECT_FAIL		: "90002",
	RT_SOCKET_NOT_USE			: "90003",
	RT_SOCKET_SEND_FAIL			: "90004",
	RT_SOCKET_RECV_TIMEOUT		: "90005",
	RT_NO_HELD_CALL				: "90006",
	RT_INVLAID_PACKET_LENGTH	: "90007",
	
	RT_AGENT_ALREADY_LOGGEDIN	: "90010",
	RT_AGENT_NOT_LOGGEDIN		: "90011",
	RT_AGENT_INFO_MISMATCH		: "90012",
	RT_AGENT_REQUEST_PROCESSING	: "90013",
	
	RT_TRANSFER_EXCEPTION		: "91000",
	RT_SESSION_DROPPED			: "91001"
};



// 2018.07.23 파라미터 추가
function    sp_get_result_msg(result_code, cause)
{
    var ret_msg = "";
    
    switch(String(result_code)) { 
    
	    
	   
	    case "20040" : ret_msg = "연결된 콜이 없습니다.";
	                   break;                  
	    case "20050" : ret_msg = "보류중인 콜이 없습니다.";
                       break;                  
	    case "20070" : ret_msg = "이미 연결이 끊어졌거나 연결된 콜이 없습니다."; 
	                   break;       
	    case "20120" : ret_msg = "교환기에 없는 번호니다. 번호를 확인하십시오";
	                   break; 
	    case "20220" : ret_msg = "[로그인] AgentID가 다른 내선에 로그인되어 있습니다. 로그아웃을 하시고 재 로그인 해 주세요";
	                   break; 
	    case "20330" : ret_msg = "요청한 리소스가 Busy상태 입니다.";
	                   break;                  
	
		case "50101" : ret_msg = "내선번호나 Agent ID등 필수 파라미터가 없습니다.";
		               break;                 
	    case "50102" : ret_msg = "[Conference] [Transfer] 연결된 콜이 없습니다.";
	                   break;                  
	    case "50103" : ret_msg = "[CancelPW][IVR관련] 저장된 UUI 정보가 없습니다."; 
	                   break;                 
	    case "50104" : ret_msg = "소켓 Procedure 에러 입니다.";
	                   break;                 
	    case "50108" : ret_msg = "[Conference] [Transfer] 보류중인 호가 없습니다.";
	                   break;                  
	    
	    case "50111" : ret_msg = "[로그인] 현재 세션에 로그인된 내선번호와 현재 로그인 요청한 내선번호가 상이 합니다. (세션 로그인 내선번호=" + cause  + ")";
	                   break;   
	    
	    case "50112" : ret_msg = "[로그인] 동일 내선번호로 다른 AgentID가 로그인 되어 있습니다.(로그인 AgentID=" + cause  + ")";
	                   break;    
	    
	    case "50113" : ret_msg = "[로그인] 내선번호, AgentID, IP가 동일한 세션이 존재 합니다. (IP=" + cause  + ")";
	                   break;   
	    
	    case "50114" : ret_msg = "[로그인] 내선번호, AgentID가 동일하나 IP가 다른 세션이 존재 합니다.(Loggedon IP=" + cause  + ")";
	                   break;   

		case "90001" : ret_msg = "파라미터가 올바르지 않습니다. 또는 세션 연결이 없습니다.";
		               break;   
		               
		case "90002" : ret_msg = "CTI서버로 접속이 안됩니다. ";
		               break;   
		               
		case "90004" : ret_msg = "CTI서버로 소켓 전송이 실패하였습니다.";
		               break;   
		               
		case "90005" : ret_msg = "CTI서버에서 응답 수신 Timeout이 발생하였습니다.";
		               break;   
	               
		case "91000" : ret_msg = "CTI서버와 통신중 Exception(예외)이 발생하였습니다.";
		               break;   

		default      : ret_msg = "정의되지 않은 코드입니다.";                                                                   break;               

   
	}
	return String(result_code) +":" + ret_msg;
}

ws_get_reason = function(ws_code, reason)
{
		switch(ws_code) { 
			case 1000 : reason = "Normal closure, meaning that the purpose for which the connection was established has been fulfilled."; break;
			case 1001 : reason = "An endpoint is \"going away\", such as a server going down or a browser having navigated away from a page."; break;
			case 1002 : reason = "An endpoint is terminating the connection due to a protocol error";	break;
			case 1003 : reason = "An endpoint is terminating the connection because it has received a type of data it cannot accept (e.g., an endpoint that understands only text data MAY send this if it receives a binary message)."; break;
			case 1004 : reason = "Reserved. The specific meaning might be defined in the future."; break;
			case 1005 : reason = "No status code was actually present."; break;
			case 1006 : reason = "The connection was closed abnormally, e.g., without sending or receiving a Close control frame"; break;
			case 1007 : reason = "An endpoint is terminating the connection because it has received data within a message that was not consistent with the type of the message (e.g., non-UTF-8 [http://tools.ietf.org/html/rfc3629] data within a text message)."; break;
			case 1008 : reason = "An endpoint is terminating the connection because it has received a message that \"violates its policy\". This reason is given either if there is no other sutible reason, or if there is a need to hide specific details about the policy."; break;
			case 1009 : reason = "An endpoint is terminating the connection because it has received a message that is too big for it to process."; break;
			case 1010 : // Note that this status code is not used by the server, because it can fail the WebSocket handshake instead.
            			reason = "An endpoint (client) is terminating the connection because it has expected the server to negotiate one or more extension, but the server didn't return them in the response message of the WebSocket handshake. <br /> Specifically, the extensions that are needed are: " + event.reason; break;
			case 1011 : reason = "A server is terminating the connection because it encountered an unexpected condition that prevented it from fulfilling the request.";break;
			case 1015 : reason = "The connection was closed due to a failure to perform a TLS handshake (e.g., the server certificate can't be verified)."; break;
			default	 : reason = "Unknown reason"; break;
		}
}