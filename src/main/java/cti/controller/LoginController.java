package cti.controller;

import java.util.HashMap;
import java.util.List;
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
import cti.user.model.userDTO;


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
	 * 
	 * @param request
	 * @param sess
	 * @return
	 */
	@RequestMapping("/findId")
	public ModelAndView findId(HttpServletRequest request,HttpSession sess){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("findId");
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
	/**
	 * 아이디찾기 처리
	 * @param request
	 * @param sess
	 * @param param
	 * @return Map
	 */
	@RequestMapping(value={"/findIdAction"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, String> findIdAction(HttpServletRequest request,HttpSession sess,@RequestParam Map<String,Object> param){
		Map<String, String> map = new HashMap<String, String>();
		
		String result ="";
		String msg = "";
		String user_id = "";
		
		List<userDTO> idList = userdao.select_member_id_information_check(param);	//이름 조회
		
		
		System.out.println("idList:"+idList.toString());
		int nameCheck = idList.size();
		System.out.println("nameCheck:"+nameCheck);
		
		if(nameCheck < 1) {
			msg = "기입한 정보의 아이디를 찾을 수 없습니다.";
		} else {
			msg = "아이디 찾기 성공";
			result = "suc";
			user_id = idList.get(0).getUser_id();
			System.out.println("user_id:"+user_id);
		}
		
		map.put("msg", msg);
		map.put("result", result);
		map.put("user_id", user_id);
		
		return map;
	}
	/**
	 * 아이디찾기 결과
	 * @param request
	 * @param sess
	 * @return
	 */
	@RequestMapping("/findIdCheckResult")
	public ModelAndView findIdCheckResult(HttpServletRequest request, HttpSession sess){
		ModelAndView mv = new ModelAndView();
		System.out.println("call findIdCheckResult");
		
		String userId = (String)request.getParameter("user_id");
		String userResult = (String)request.getParameter("result");
		
		//findIdCheckResult페이지에 넘길 값 - jsp 페이지에서는 <c:out value="${userId}" /> 식으로 사용해야함
		mv.addObject("userId", userId);
		mv.addObject("userResult", userResult);
		mv.setViewName("findIdCheckResult");
		
		return mv;
	}	
	
	//20220803 추가
	@RequestMapping(value={"/test"},method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> test(HttpServletRequest request,HttpSession sess,@RequestParam Map<String,Object> param){
		Map<String, Object> map = new HashMap<String, Object>();
		
		param.put("user_name", "김성철");
		param.put("user_birth", "19890922");
		param.put("user_phone", "01089452059");
		HashMap returnMap = (HashMap)userdao.selectOneTest(param);
		if(returnMap != null) {
			System.out.println("selectOneTest 출력시작----------------------------");
			System.out.println("아이디 : "+returnMap.get("userId"));
			System.out.println("비밀번호 : "+returnMap.get("userPass"));
			System.out.println("성명 : "+returnMap.get("userName"));
			System.out.println("생년월일 : "+returnMap.get("userBirth"));
			System.out.println("핸드폰번호 : "+returnMap.get("userPhone"));
			System.out.println("selectOneTest 출력 끝----------------------------");
		}


		
		List<Map<String,String>> returnMap2 = userdao.selectListTest(param);
		
		System.out.println("selectListTest 출력 시작 ----------------------");
		for(int i = 0; i < returnMap2.size(); i++) {
			System.out.println(i+"번째 시작");
			System.out.println("아이디 : "+returnMap2.get(i).get("userId"));
			System.out.println("비밀번호 : "+returnMap2.get(i).get("userPass"));
			System.out.println("성명 : "+returnMap2.get(i).get("userName"));
			System.out.println("생년월일 : "+returnMap2.get(i).get("userBirth"));
			System.out.println("핸드폰번호 : "+returnMap2.get(i).get("userPhone"));
			System.out.println(i+"번째 끝");
		}
		
		System.out.println("selectListTest 출력 끝----------------------------");
		map.put("oneList", returnMap);
		map.put("list", returnMap2);
		return map;
	}
	//끝
}

