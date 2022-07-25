package cti.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cti.user.model.userDAO;


@Controller
public class LoginController {
	@Autowired
	private userDAO userdao;
	/* properties 호출*/
//	@Value("#{props['hello.SetTime']}")   
//	private String helloSetTime;
	
	/**
	 * 로그인 페이지
	 * @param request
	 * @param sess
	 * @return ModelAndView
	 */
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request,HttpSession sess){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("login");
		return mv;
	}
	
	/**
	 * 회원가입 페이지
	 * @param request
	 * @param sess
	 * @return ModelAndView
	 */
	@RequestMapping("/memberNew")
	public ModelAndView memberNew(HttpServletRequest request,HttpSession sess){
		System.out.println("call memberNew()");
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("newMember");
		return mv;
	}
	
	/**
	 * 로그인 처리
	 * @param request
	 * @param sess
	 * @param param
	 * @return Map
	 */
	@RequestMapping(value={"/loginAction"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> loginAction(HttpServletRequest request,HttpSession sess,@RequestParam Map<String,Object> param){
		Map<String, String> map = new HashMap<String, String>();
		
		
		String result ="";
		String msg = "";
		
		int idCheck = userdao.select_member(param);	//아이디 조회
		int passCheck = userdao.select_member_pass_check(param);	//아이디 조회
		if(idCheck < 1) {
			msg = "아이디가 없습니다.";
		} else if(passCheck < 1) {
			msg = "비밀번호가 틀립니다.";
		} else {
			msg = "로그인성공";
			result = "suc";
		}
		
		map.put("msg", msg);
		map.put("result", result);
		map.get("msg");
		return map;
	}
	
	/**
	 * 회원가입 중복확인 체크
	 * @param request
	 * @param sess
	 * @param param
	 * @return
	 */
	@RequestMapping(value={"/idCheck"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> idCheck(HttpServletRequest request,HttpSession sess,@RequestParam Map<String,Object> param){
		Map<String, String> map = new HashMap<String, String>();
		int success = userdao.select_member(param);
		String result ="";
		String msg = "";
		if(success > 0) {
			msg = "이미 사용중인 아이디입니다.";
		} else {
			msg = "가입이 가능한 아이디입니다.";
			result = "suc";
		}
		map.put("msg", msg);
		map.put("result", result);
		return map;
	}
	boolean checkString(String str) {
		  return StringUtils.isEmpty(str);
	}
	/**
	 * 회원가입 처리
	 * @param request
	 * @param sess
	 * @param param
	 * @return
	 */
	@RequestMapping("/newMemberAction")
	public ModelAndView newMemberAction(HttpServletRequest request,HttpSession sess,@RequestParam Map<String,Object> param){
		System.out.println("call newMemberAction()");
		ModelAndView mv = new ModelAndView();
		String user_birth = "";
		String user_phone = "";
		String birth_m = (String)param.get("user_birth_m");
		String birth_d = (String)param.get("user_birth_d");
		if(!checkString(birth_m)) {
			if ( birth_m.length() == 1 ) {
				birth_m = "0"+birth_m;
			}
		}
		if(!checkString(birth_d)) {
			if ( birth_d.length() == 1 ) {
				birth_d = "0"+birth_d;
			}
		}
		user_birth = (String)param.get("user_birth_y") + birth_m + birth_d;
		user_phone = (String)param.get("user_phone_1") + param.get("user_phone_2") + param.get("user_phone_3");
		
		
		param.put("user_birth", user_birth);
		param.put("user_phone", user_phone);
		
		System.out.println("전송할 Param:"+param);
		
		int success = userdao.insert_member(param);
		if (success > 0) {
			System.out.println("회원가입이 되었습니다.");
		}
		mv.setViewName("login");
		return mv;
	}
	
	/**
	 * 메인페이지
	 * @param request
	 * @param sess
	 * @return
	 */
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request, HttpSession sess){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("main");
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*	@SuppressWarnings("unused")
	private String getBrowser(HttpServletRequest request) {
		  String header = request.getHeader("User-Agent");
		  if (header != null) {
		   if (header.indexOf("Trident") > -1) {
			return "login";
//		    return "MSIE";
		   } else if (header.indexOf("Chrome") > -1) {
			return "new_login";   
//		    return "Chrome";
		   } else {
			   return "new_login";   
		   }
		  }
		  return "new_login";
	 }


	@RequestMapping(value={"/call_add"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> call_add(HttpServletRequest request,HttpSession sess,String ab_station,String ab_tel,String ab_type){
		Map<String, String> map = new HashMap<String, String>();
		
		System.out.println("내선번호: "+ab_station);
		System.out.println("고객번호: "+ab_tel);
		if(ab_type.equals("1")){
			System.out.println("콜 타입 : 인입");
		}else if(ab_type.equals("2")){
			System.out.println("콜 타입 : 시작");
		}else if(ab_type.equals("3")){
			System.out.println("콜 타입 : 종료");
		}else if(ab_type.equals("4")){
			System.out.println("콜 타입 : 포기콜");
		}else{
			System.out.println("error ab_type : "+ab_type);
		}
		int call = calldao.call_add(ab_station, ab_tel, ab_type);
		if(call==1){
			map.put("result", "success");
		}
		return map;
	}
	@RequestMapping(value = "/history")
	public ModelAndView history(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String first= request.getParameter("option"); 검색분류 
		String second= request.getParameter("h_name"); 검색 할 단어 
		String year = request.getParameter("year");
		String month= request.getParameter("month");
		String day = request.getParameter("day");
		String year2 = request.getParameter("year2");
		String month2= request.getParameter("month2");
		String day2 = request.getParameter("day2");
		String third=year+month+day;
		String fourth=year2+month2+day2;
		System.out.println("검색분류 : "+first);
		System.out.println("검색 한 단어 : "+second);
		List<historyDTO> list2 = historydao.history(first,second,third,fourth);
		int count =list2.size();
		System.out.println("검색 갯수 : "+count);	
		mv.addObject("count", count);
		mv.addObject("list2", list2);
		mv.setViewName("history");
		return mv;
	}
	
	@RequestMapping("/o_history")  로그아웃 성공 시 이력저장
	public	ModelAndView o_history(HttpServletRequest request,HttpSession sess){
		ModelAndView mv = new ModelAndView();
		String userId= request.getParameter("userId");
		String l_agentid = request.getParameter("l_agentid");
		String l_station = request.getParameter("l_station");
		String l_empId= request.getParameter("empId");
		String l_onoff="0";
		historyDTO history= new historyDTO();
		history.setAb_agent(l_agentid);
		history.setAb_station(l_station);
		history.setAb_empid(l_empId);		
		history.setAb_onoff(l_onoff);
		historydao.addhistory(history);

		mv.addObject("userId", userId);
		mv.setViewName("login");
		return mv;
	}
	
	@RequestMapping("/l_history")  로그인 성공 시 이력저장 
	public	ModelAndView l_history(HttpServletRequest request,HttpSession sess){
		ModelAndView mv = new ModelAndView();
		String userId= request.getParameter("userId");
		String l_agentid = request.getParameter("l_agentid");
		String l_station = request.getParameter("l_station");
		String l_empId= request.getParameter("empId");
		String l_onoff="1";
		
		historyDTO history= new historyDTO();
		history.setAb_agent(l_agentid);
		history.setAb_station(l_station);
		history.setAb_empid(l_empId);
		history.setAb_onoff(l_onoff);
		historydao.addhistory(history);

		mv.addObject("userId", userId);
		mv.setViewName("login");
		return mv;
	}
	@RequestMapping("/map") SDMS-URL창 
	public	ModelAndView map(HttpServletRequest request,HttpSession sess){
		ModelAndView mv = new ModelAndView();
		String org_code= request.getParameter("org_code");
		mv.addObject("org_code", org_code);
		mv.setViewName("map");
		return mv;
	}
	@RequestMapping("/index")
	public String index() {
		
		return "index";
	}
	@RequestMapping(value = "/c_check") 호전환 -협의 검색
	public ModelAndView c_check(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String ab_name= request.getParameter("c_search");
		try {
			List<userDTO> list3 = userdao.namelist(ab_name);
			int count =list3.size();
			mv.addObject("count", count);
			mv.addObject("list3", list3);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("consultlist");
		return mv;
	}
	@RequestMapping(value = "/new_c_check") 호전환 -협의 검색
	public ModelAndView new_c_check(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String ab_name= request.getParameter("c_search");
		try {
			List<userDTO> list3 = userdao.namelist(ab_name);
			int count =list3.size();
			mv.addObject("count", count);
			mv.addObject("list3", list3);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("new_consultlist");
		return mv;
	}
	@RequestMapping(value = "/c_check2") 호전환 - 외부전문기관
	public ModelAndView c_check2(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String view = request.getParameter("view");
		String ab_name2= request.getParameter("c_search2");
		try {
			List<consult3DTO> list = consult3dao.consultlist3(ab_name2);
			int count2 =list.size();
			mv.addObject("count2", count2);
			mv.addObject("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.addObject("view",view);
		mv.setViewName("consultlist");
		return mv;
	}
	@RequestMapping(value = "/new_c_check2") 호전환 - 외부전문기관
	public ModelAndView new_c_check2(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String view = request.getParameter("view");
		String ab_name2= request.getParameter("c_search2");
		try {
			List<consult3DTO> list = consult3dao.consultlist3(ab_name2);
			int count2 =list.size();
			mv.addObject("count2", count2);
			mv.addObject("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.addObject("view",view);
		mv.setViewName("new_consultlist");
		return mv;
	}
	@RequestMapping(value = "/consultlist")
	public ModelAndView consultlist(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("consultlist");
		return mv;
	}//
	@RequestMapping(value = "/new_consultlist")
	public ModelAndView new_consultlist(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("new_consultlist");
		return mv;
	}//
	@RequestMapping(value = "/urlsubmit") url전송 
	public ModelAndView urlsubmit(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String phone = request.getParameter("phone");
		String dmskey= request.getParameter("dmskey");
		String url = request.getParameter("url");
		String key= request.getParameter("key");key=1 :  팝업창생성 후 sdms전송 후 자동 팝업창 종료, key =0 : histroy.go(-1)
		String smstext= request.getParameter("smstext");
		smstext=s_smstext+smstext;
		String phone_c ="";
		String v_svrcode="0";
		if(key.equals("1")){
			v_svrcode=s_svccodeapp;
		}else {
			v_svrcode=s_svccodecti;
		}
		if(!phone.equals("")&&!phone.equals(null)){
			phone_c="true";
		}else
			phone_c="false";
		System.out.println("번호 유무 : "+phone_c);
		System.out.println("dmskey : " +dmskey);
		System.out.println("url : " +url);
		System.out.println("smstext : " +smstext);
		System.out.println("key: " +key);
		//스마트DMS 문자 길이 총 465byte. 각각의 길이는 고정 입력값 길이가 부족하면 공백으로 처리하여 길이 맞춘다
		int length_mSize = 4;  
		int length_mNo = 20; 
		int length_mServiceId = 16; 
		int length_mType = 10; 
		int length_authKey = 40; 
		int length_svcCode = 16;
		int length_userMdn = 16; 
		int length_cCode = 6; 
		int length_direct = 1;
		int length_sText = 120;
		int length_callerMdn = 16;
		int length_mUrl = 200;
		String s1 ="";
		String s2="";
		Socket socket = new Socket();
		
		try {
			
			String mSize = s_size;  //전체길이  4byte
			String mNo = dmskey;  //유니크한 번호  20byte
			String mServiceId = s_serviceid; //고객사별 서비스별로 생성된 ID KLAC001  16byte
			String mType = s_type; //메시지 유형 = ‘DMS1000Q’  10byte
			String authKey = s_authkey; //인증키 40byte 584CD27A309FFDE45E5B089B6499A64932A193F6  
			String svcCode = v_svrcode; //연동코드 고객사의 서비스 별 구분 13201 16byte
			String userMdn = phone; //단말 이용자 전화번호 16byte
			String cCode =s_code; //메뉴 코드 1000  6byte
			String direct = s_direct; 
			//Direct URL SMS를 사용할지 여부  1byte
			//N=Redirect URL SMS 사용 (기존방식, 기본값) 
			//Direct URL SMS를 사용하는 경우에 해당 URL을 통하여 접속한 접속통계는 CallQuest에 기록되지 않음
			String sText = smstext;  // 120byte
			//SMS 메시지 UTF-8 * Redirect URL SMS : 최대 한글 26자 또는 영문 52자 * Direct URL SMS : 최대 한글 39자 또는 영문 78자
			String callerMdn = s_callermdn;  //발신자번호 025292170  16byte
			String mUrl = url; //전송URL  200byte
			System.out.println("mSize: "+mSize+"mNo : "+mNo+"mServiceId : "+mServiceId+"mType : "+mType+"authKey : "+authKey+"svcCode : "+svcCode+" cCode : "+cCode+"direct : "+direct);
			byte[] temp_mSize = mSize.getBytes();  
			byte[] temp_mNo = mNo.getBytes(); 
			byte[] temp_mServiceId = mServiceId.getBytes(); 
			byte[] temp_mType = mType.getBytes(); 
			byte[] temp_authKey = authKey.getBytes(); 
			byte[] temp_svcCode = svcCode.getBytes();
			byte[] temp_userMdn = userMdn.getBytes(); 
			byte[] temp_cCode = cCode.getBytes();
			byte[] temp_direct = direct.getBytes();
			byte[] temp_sText = sText.getBytes("utf-8");
			byte[] temp_callerMdn = callerMdn.getBytes();
			byte[] temp_mUrl = mUrl.getBytes("utf-8");
			
			StringBuffer outData = new StringBuffer();	
			
			outData.append(appendSpace(mSize,length_mSize));
		   outData.append(appendSpace(mNo,length_mNo));
		   outData.append(appendSpace(mServiceId,length_mServiceId));
		   outData.append(appendSpace(mType,length_mType));
		   outData.append(appendSpace(authKey,length_authKey));
		   outData.append(appendSpace(svcCode,length_svcCode));
		   outData.append(appendSpace(userMdn,length_userMdn));
		   outData.append(appendSpace(cCode,length_cCode));
		   outData.append(appendSpace(direct,length_direct));
		   outData.append(appendSpace(sText,length_sText));
		   outData.append(appendSpace(callerMdn,length_callerMdn));
		   outData.append(appendSpace(mUrl,length_mUrl));
			
			System.out.println("outData 의 길이 :"+outData.toString().getBytes("utf-8").length);
			String bb= outData.toString();
			int timeout = 3000;
			String serverIP = s_ip; // 127.0.0.1 & localhost 본인
			int port = Integer.parseInt(s_port); //접속할 서버 포트
			System.out.println("서버에 연결중입니다. 서버 IP : " + serverIP); 
			// 소켓을 생성하여 연결을 요청한다.
			System.out.println("serverIP : "+serverIP+ "port : "+port);
			SocketAddress serverAddress = new InetSocketAddress(serverIP, port); // IP 형식에 맞도록 변경
//			socket.setSoTimeout(timeout);
			socket.connect(serverAddress, timeout); // 연결시도  1000=1초
			
			OutputStream out = socket.getOutputStream(); 
			PrintWriter pw = new PrintWriter(new OutputStreamWriter(out,"utf-8"));
			// 소켓의 입력스트림을 얻는다. 
			InputStream in = socket.getInputStream(); 
			//DataInputStream dis = new DataInputStream(in); // 기본형 단위로 처리하는 보조스트림 
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			// 소켓으로 부터 받은 데이터를 출력한다. 
//			String id = "04651509945283332       KLAC001         DMS1000Q  584CD27A309FFDE45E5B089B6499A64932A193F613201           01090453410     1000  NSMS_TEXT샘플                                                                                                             025292170       http://m.daum.net                                                                                                                                                                                       ";
//			pw.print(id); //메시지를 클라이언트에게 전송

//			System.out.println(id);
//			System.out.println("EUC_KR : "+id.getBytes("euc_kr"));
//			System.out.println("UTF-8 : "+id.getBytes("utf-8"));
			System.out.println("메시지 전송 문자열: "+bb);
			pw.print(bb);//메시지를 클라이언트에게 전송
	        pw.flush(); //버퍼를 비움
	        String recvStr = null; //받은 문자열
	        byte arr[] = new byte[127];
	        		in.read(arr);
	        		recvStr = new String(arr);  
	        while((recvStr = br.readLine()) != null){
	        	br.close();
	        	in.close();
	        	pw.close();
	        	out.close();
	        	
	            System.out.println(getTime() + " 서버로부터 받은 문자열 : " + recvStr);
	            break;
	        }
	        System.out.println("recvStr : "+recvStr);
//			String recvStr = "127 201711211123131254  KLAC001         DMS1000S  584CD27A309FFDE45E5B089B6499A64932A193F613201           01050546365     0002R";
	        s1 = recvStr.substring(122,126);  //성공여부 0000 아니면 실패
	        s2 = recvStr.substring(126,127);  //전송방식
	        System.out.println("성공여부 : "+s1);
	        System.out.println("전송방식 : "+s2);
	        mv.addObject("s1", s1);
	        mv.addObject("bb", bb);
	        서비스 처리된 경우 처리 방법 : S2
	        - W : Web 화면 표출 요청 (APNS, GCM PUSH)
	        - A : App 실행 요청 (APNS, GCM PUSH)
	        - R : Redirect URL SMS 전송
	        - D : Direct URL SMS 전송
	        - N : 실패 (처리불가)
			//System.out.println("연결을 종료합니다."); 
			// 스트림과 소켓을 닫는다. 
				br.close(); 
				socket.close(); 
		} catch (ConnectException ce) { 
			ce.printStackTrace(); 
			}catch(SocketTimeoutException xe){
			}catch (IOException ie) { 
				ie.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
		} finally {
		      try {
		    	  if(socket!=null)
				                socket.close();
				            } catch (IOException e) {
				                e.printStackTrace();
				            }
				        }

		//mv.setViewName("jsonView");

		mv.addObject("key", key);
		String msg = "urlmsg";
		key :0 검색창에서 전송 //key :1 상담앱에서 받음  // key :2 툴바url창에서 전송,상담예약
		 key 0 form으로 전송 // else ajax  
		if(s1.equals("0000")&&key.equals("0")){
			mv.setViewName(msg);
			System.out.println("key :"+key +" s1 :"+s1);
		}else if(s1.equals("0000")&&key.equals("1")){
			mv.setViewName(msg);
			System.out.println("key :"+key +" s1 :"+s1);
			
		}else if(s1.equals("0000")&&key.equals("2")){
			mv.setViewName(msg);
			System.out.println("key :"+key +" s1 :"+s1);
			
		}else if(!s1.equals("0000")&&key.equals("0")){
			mv.setViewName(msg);
			System.out.println("key :"+key +" s1 :"+s1);
			
		}else if(!s1.equals("0000")&&key.equals("1")){
			System.out.println("key :"+key +" s1 :"+s1);
			
		}else if(!s1.equals("0000")&&key.equals("2")){
			
			System.out.println("key :"+key +" s1 :"+s1);
		}
		return mv;
	}
	static String getTime(){
        SimpleDateFormat f = new SimpleDateFormat("[hh:mm:ss]"); //날짜 출력
        return f.format(new Date());
    }
	//길이 계산해서 공백 넣기
	public String getString(byte[] org,int length){

		StringBuffer sb = new StringBuffer();	
		byte[] blank = new byte[length-org.length];
		return sb.append(new String(org)).append(new String(blank)).toString();
	}
	@RequestMapping(value = "/namelist")  검색	
	public ModelAndView namelist(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String name= request.getParameter("search");
		String dest= request.getParameter("dest");
		String agentid= request.getParameter("AgentID");
		try{
			List<consult3DTO> namelist = consult3dao.consultlist3(name);
			int count =namelist.size();
			mv.addObject("namelist", namelist);
			mv.addObject("count", count);
		}catch(Exception e){
			e.printStackTrace();
		}
		mv.addObject("dest", dest);
		mv.addObject("agentid", agentid);
		mv.setViewName("sdms");
		return mv;
	}// 
	@RequestMapping("/sdms")
	public ModelAndView sdms(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String agentid = request.getParameter("agentid");
		String dest = request.getParameter("dest");
		String dmstype = request.getParameter("dmstype");
		String emp_id = request.getParameter("empId");
		
		//대표번호 가져오기
		
		 * String comp_tenr = ""; try { //comp_tenr = userdao.get_comp_tenr(emp_id);
		 * comp_tenr = "132"; // 임시 테스트용 } catch (Exception e) { e.printStackTrace(); }
		 * mv.addObject("comp_tenr", comp_tenr);
		 
		
		mv.addObject("agentid",agentid);
		mv.addObject("dest",dest);
		mv.addObject("dmstype",dmstype);
		mv.setViewName("sdms");
		return mv;
	}
	20180807 콜 시작종료 DB ~497	
	@RequestMapping("/call_in")
	public ModelAndView call_in(HttpServletRequest request,HttpSession sess,String station,
			String empId,String dest) {
		ModelAndView mv = new ModelAndView();
		callDTO call= new callDTO();
		call.setCall_number(dest);
		call.setCall_empid(empId);
		call.setCall_station(station);
		call.setCall_onoff("1");
		System.out.println(dest);
		System.out.println(empId);
		System.out.println(station);
		calldao.call_add(call);
		mv.setViewName("login");
		return mv;
	}
	@RequestMapping("/call_out")
	public ModelAndView call_out(HttpServletRequest request,HttpSession sess,String station,
			String empId,String dest) {
		ModelAndView mv = new ModelAndView();
		callDTO call= new callDTO();
		call.setCall_number(dest);
		call.setCall_empid(empId);
		call.setCall_station(station);
		call.setCall_onoff("0");
		System.out.println(dest);
		System.out.println(empId);
		System.out.println(station);
		calldao.call_add(call);
		mv.setViewName("login");
		return mv;
	}
	@RequestMapping("/call")
	public ModelAndView call(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String phone = request.getParameter("phone");
		mv.addObject("phone",phone);
		mv.setViewName("call");
		return mv;
	}
	@RequestMapping("/new_call")
	public ModelAndView new_call(HttpServletRequest request,HttpSession sess) {
		ModelAndView mv = new ModelAndView();
		String phone = request.getParameter("phone");
		mv.addObject("phone",phone);
		mv.setViewName("new_call");
		return mv;
	}
	@RequestMapping("/schedule")  로그아웃 안된 계정 로그아웃으로초기화
	public	ModelAndView schedule(HttpServletRequest request,HttpSession sess,String empId,String l_station){
		ModelAndView mv = new ModelAndView();
		List<historyDTO> select = historydao.clear_select();
		for(int i=0; i<select.size(); i++){
			int success = historydao.clear_insert(select.get(i).getAb_agent(), select.get(i).getAb_station(), select.get(i).getAb_empid(), "0");
			if(success==1){
				if(select.size()==i+1)
				System.out.println("초기화:"+select.size()+"개 성공");
			}
		}
		mv.setViewName("loginreset");
		return mv;
	}
	@RequestMapping("/schedule2")  로그아웃 안된 계정 로그아웃으로초기화
	public	ModelAndView schedule2(HttpServletRequest request,HttpSession sess,String empId,String l_station){
		ModelAndView mv = new ModelAndView();
		List<historyDTO> select = historydao.clear_select2();
		for(int i=0; i<select.size(); i++){
			int success = historydao.clear_insert(select.get(i).getAb_agent(), select.get(i).getAb_station(), select.get(i).getAb_empid(), "0");
			if(success==1){
				if(select.size()==i+1)
				System.out.println("초기화:"+select.size()+"개 성공");
			}
		}
		mv.setViewName("loginreset");
		return mv;
	}
	@RequestMapping("/ocx")
	public String ocx() {

		return "ocx";
	}
	@RequestMapping("/ssl_down")
	public String ssl_down() {

		return "ssl_down";
	}
	public String appendSpace(String org,int len){
		sText,length_sText 
		  int orgLength;
		  try {
		   orgLength = org.getBytes("utf-8").length;
		   if(orgLength < len){
		    int endCount = len - orgLength;
		    for(int i =0;i < endCount; i++){
		     org = org + " ";
		    }
		   }else if(orgLength > len){
		    byte[] temp = new byte[len];
		    System.arraycopy(org.getBytes(), 0, temp, 0, len);
		    org = new String(temp);
		   }
		   
		  } catch (UnsupportedEncodingException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		  return org;
		 }
	
	@RequestMapping(value={"/rec_start"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> rec_start(HttpServletRequest request,HttpSession sess,
			String station, String agentId, String phoneNumber, String direction,String optional1){
		Map<String, String> map = new HashMap<String, String>();
		int callId = 0;
		callId =Integer.parseInt("1"+station);
		CallEventSocket rec_socket = new CallEventSocket();
		rec_socket.connect(r_ip,r_port);
		rec_socket.startCall(callId, station, agentId, phoneNumber, direction, optional1, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
		map.put("result", "0");
		return map;
	}
	
	@RequestMapping(value={"/rec_end"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> rec_end(HttpServletRequest request,HttpSession sess,
			String station, String agentId, String phoneNumber, String direction,String optional1){
		Map<String, String> map = new HashMap<String, String>();
		int callId = 0;
		callId =Integer.parseInt("1"+station);
		CallEventSocket rec_socket = new CallEventSocket();
		rec_socket.connect(r_ip,r_port);
		rec_socket.endCall(callId, station, agentId, phoneNumber, direction, optional1, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
		map.put("result", "0");
		return map;
	}
	@RequestMapping(value={"/kakao_submit"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> kakao_submit(HttpServletRequest request,HttpSession sess,String RCV_PHN_ID){
		Map<String, String> map = new HashMap<String, String>();
		String result="false";
		
		//System.out.println("대표번호 : " + comp_tenr + " | 고객 전화번호 " + RCV_PHN_ID);
		System.out.println("고객 전화번호 " + RCV_PHN_ID);
		
		//int call = kakaodao.insert_kakako(RCV_PHN_ID);
		//if(call==1){
			//result="success";
		//}
		map.put("result",result);
		return map;
	}*/

}

