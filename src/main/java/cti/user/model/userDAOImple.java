package cti.user.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;


public class userDAOImple implements userDAO{
	private SqlSession  sqlMap;

	public userDAOImple(SqlSession sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}
	public int insert_member(Map<String,Object>paramMap) {
		System.out.println("paramMap:"+paramMap.get("user_name"));
		int result=sqlMap.insert("insert_member",paramMap);
		return result;
	}
//	아이디 조회 및 중복확인
	public int select_member(Map<String,Object>paramMap) {
		int result=sqlMap.selectOne("select_member",paramMap);
		return result;
	}
//	이름 전화번호 생년월일 중복확인
	public List<userDTO> select_member_nbp(Map<String,Object>paramMap) {
		List<userDTO> list =sqlMap.selectList("select_member_nbp",paramMap);
		return list;
	}
//	패스워드 체크
	public int select_member_pass_check(Map<String,Object>paramMap) {
		int result=sqlMap.selectOne("select_member_pass_check",paramMap);
		return result;
	}
		
//	아이디 찾기 정보 체크
	public List<userDTO> select_member_id_information_check(Map<String,Object>paramMap) {
		List<userDTO> list=sqlMap.selectList("select_member_id_information_check",paramMap);
		
		return list;
	}
	public List<userDTO> select_member_pwd_information_check(Map<String,Object>paramMap) {
		List<userDTO> list=sqlMap.selectList("select_member_pwd_information_check",paramMap);
		return list;
	}
	
	/*시작 20220803 추가*/
	//결과 값이 여러개 있을 때 : size > 1
	public List<Map<String, String>>  selectListTest(Map<String,Object>paramMap) {
		
		List<Map<String, String>> list =   sqlMap.selectList("selectListTest", paramMap);
		return list;
	}
	
	//결과 값이 하나있을 때 : size = 1
	public HashMap<String, Object>  selectOneTest(Map<String,Object>paramMap) {
		
		HashMap<String, Object> list = sqlMap.selectOne("selectOneTest", paramMap);
		return list;
	}
	/*끝*/
	// 비밀번호 변경 // 20220808 추가
	public int update_member_pass(Map<String,Object>paramMap) {
		int result=sqlMap.update("update_member_pass",paramMap);
		return result;		
	}
}
