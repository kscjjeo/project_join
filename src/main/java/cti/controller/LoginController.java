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
		
		int nameCheck = userdao.select_member_id_information_check(param);	//이름 조회
		if(nameCheck < 1) {
			msg = "기입한 정보의 아이디를 찾을 수 없습니다.";
		} else {
			msg = "아이디 찾기 성공";
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
	@RequestMapping("/findIdCheckResult")
	public ModelAndView findIdCheckResult(HttpServletRequest request, HttpSession sess){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("findIdCheckResult");
		return mv;
	}	
}

