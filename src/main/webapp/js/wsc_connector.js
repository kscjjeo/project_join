//##############################################################################
//
//			wsc_connector.js
//
//											Web Worker for Websocket Connector
//                                          for CTIBridge 3.7x
//                                          Edit by Lee eon woo
//
//											Hansol Inticube Co., Ltd.
//											All rights reserved.
//
//##############################################################################


//------------------------------------------------------------------------------
// ready state constants
// 0:CONNECTING, 1:OPEN, 2:CLOSING, 3:CLOSED

//  Websocket Code
// 1000:CLOSE_NORMAL 
// 1001:CLOSE_GOING_AWAY 
// 1002:CLOSE_PROTOCOL_ERROR 
// 1003:CLOSE_UNSUPPORTED 
// 1006:CLOSE_ABNORMAL
//------------------------------------------------------------------------------
 
  
var wsc_connector_       = null;

 
//==============================================================================
//  onmessage
//============================================================================== 
onmessage = function(e) {
    
    switch (e.data.command) {
    case "connector_start":
    {
        console.log("[wsc_connector] start");
        if (wsc_connector_ != null) {
            console.log("[wsc_connector] start, close & delete exist connector!");
            wsc_connector_.close();
            delete wsc_connector_;
        }
        console.log("[wsc_connector] start, new creator connector");
        wsc_connector_ = new wsc_connector(e.data.server_ip, e.data.server_port);
        break;
    }
            
    case "connector_stop":
    {
        console.log("[wsc_connector] stop");
        if (wsc_connector_ != null) {
            console.log("[wsc_connector] stop, close");
            wsc_connector_.close();
            delete wsc_connector_;
            wsc_connector_ = null;
        }
        break;
    }
        
    case "connector_send":
    {
        if (wsc_connector_ != null) {
        //console.log("[wsc_connector] send, data=[" + e.data.message +  "](" + e.data.message.length + ")bytes");
            wsc_connector_.send(e.data.message);
        }
        else {
            console.log("[wsc_connector] send, NULL!");
        }
        break;
    }
    default:
        console.log("[wsc_connector] unknown command: " + e.data.command);
        break
    }
};



 

//==============================================================================
//  wsc_connector
//==============================================================================
function wsc_connector(server_ip, server_port)
{
	// Create websocket
    var wsc_url  = "ws://" + server_ip + ":" + server_port;
    var wsc_sock = new WebSocket(wsc_url);

	console.log("[wsc_connector] URL=[" + wsc_url + "]");

    //---------------------------------
    //  wsc_sock.onopen
    //---------------------------------
    wsc_sock.onopen = function() {
        console.log("[wsc_connector] <opened>");
        postMessage({message: 'ws_on_opened'});
    }

	//---------------------------------
    //  wsc_sock.onclose
    //---------------------------------
	wsc_sock.onclose = function(e) {
	    console.log("[wsc_connector] <closed>");
		postMessage({message: 'ws_on_closed'});
	}	
	
	//---------------------------------
    //  wsc_sock.onmessage
    //---------------------------------
	wsc_sock.onmessage = function(e) {
	    console.log("[wsc_connector] recv, data=[" + e.data + "](" +  e.data.length + ")bytes");
		if (e.data.length == 4 && e.data == "PONG")	{
		    console.log("[wsc_connector] recv, data=[" + e.data + "](" +  e.data.length + ")bytes ==> Ignore data!");
		    return;
		}
		postMessage({message: 'ws_on_message', data: e.data});
	}	

	//---------------------------------
    //  send
    //---------------------------------
    function send(data)
    {
        if (wsc_sock.readyState != 1) { // 1=open
		    console.log("[wsc_connector] send, failure!, invalid state: (" + wsc_sock.readyState + ")"); 
			return;
		}  
		
		try {
			wsc_sock.send(data);
		} catch(e) {
			console.log("[wsc_connector] send, exception! (" + e + ")");
			return;
		} 
		console.log("[wsc_connector] send, data=[" + data +"](" + data.length + ")bytes");
    }
    
    //---------------------------------
    //  close
    //---------------------------------
    function close()
    {
	    try {
		    console.log("[wsc_connector] close");
			wsc_sock.close();
		} catch(e) {
		    console.log("[wsc_connector] close, exception! (" + e + ")");
		}
	}
	
	//--------------------------------------------------------------------------
    //  connector_function
    //--------------------------------------------------------------------------
	function connector_function() {
	}
	return {
		send    : send,
		close   : close
	};
}
		
