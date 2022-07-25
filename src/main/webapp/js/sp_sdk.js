//##############################################################################
//
//			sp_sdk.js
//
//											Softphone SDK
//                                          for CTIBridge 3.7
//                                          Edit by Lee eon woo
//	
//											Hansol Inticube Co., Ltd.
//											All rights reserved.
//
//##############################################################################





//==============================================================================
//  pause
//==============================================================================
function pause(number_ms) {
    var now = new Date();
    var exit_time = now.getTime() + number_ms;

    while (true) {
        now = new Date();
        if (now.getTime() > exit_time) {
			return;
		}
    }
}

//==============================================================================
//  get_packet_time
//==============================================================================
function get_packet_time()
{
    var d = new Date();

    var s = leading_zeros(d.getFullYear(), 4) +
            leading_zeros(d.getMonth() + 1, 2) +
            leading_zeros(d.getDate(), 2) +
            leading_zeros(d.getHours(), 2) +
            leading_zeros(d.getMinutes(), 2) +
            leading_zeros(d.getSeconds(), 2);

    return s;
}

//==============================================================================
//  get_packet_field
//==============================================================================
function get_packet_field(str_field, len_field)
{
    //var diff = len_field - str_field.length;
    var diff = len_field - get_length(str_field);
    var blank = " ";
               
    for(var i=0; i<diff ; i++) {
        str_field = str_field + blank;
    }
    //disp_log("str_field=[" + str_field + "]");
    return str_field;
}
 
 
// 2018.08.20 
function get_length(str_input)
{ 
    var length  = 0;
    var ch1     = "";
    
    for (var i=0; i<str_input.length; i++) {
        ch1 = str_input.charAt(i);
        if (escape(ch1).length>4) {
            length +=2;
        }
        else {
            length += 1;
        }
    }
    //disp_log("Input=" + str_input + ", length=" + length);
    return length
}
   
   /*
// 2018.08.20 ����
//==============================================================================
//  leading_zeros
//==============================================================================
function leading_zeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (get_length(n) < digits) {
        for (i=0; i<digits - get_length(n); i++) {
        	zero += '0';
		}
    }
    return zero + n;
}  
*/
  


//==============================================================================
//  leading_zeros
//==============================================================================
function leading_zeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (n.length < digits) {
        for (i = 0; i < digits - n.length; i++) {
        	zero += '0';
		}
    }
    return zero + n;
}



//==============================================================================
//  pad
//==============================================================================
function pad(num, len) {
    return ("0" + num).slice(len == undefined ? -2 : -len)
}



//==============================================================================
//  log_time
//==============================================================================
function log_time()
{
	var now = new Date();
	var date_string =	leading_zeros(now.getHours(),2) +
						":" + leading_zeros(now.getMinutes(),2) +
						":" + leading_zeros(now.getSeconds(),2) +
						"." + leading_zeros(now.getMilliseconds(), 3);

    return date_string;						
}
		
				