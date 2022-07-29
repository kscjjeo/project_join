package cti.user.model;

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
//	패스워드 체크
	public int select_member_pass_check(Map<String,Object>paramMap) {
		int result=sqlMap.selectOne("select_member_pass_check",paramMap);
		return result;
	}
		
//	아이디 찾기 정보 체크
	public int select_member_id_information_check(Map<String,Object>paramMap) {
		int result=sqlMap.selectOne("select_member_id_information_check",paramMap);
		return result;
	}
	
}
