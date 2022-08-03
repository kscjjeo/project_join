package cti.user.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



public interface userDAO {
	public int insert_member(Map<String,Object>paramMap);
	public int select_member(Map<String,Object>paramMap);
	public int select_member_pass_check(Map<String,Object>paramMap);
	public List<userDTO> select_member_id_information_check(Map<String,Object>paramMap);
	
	/*시작 20220803 추가*/
	public List<Map<String, String>>  selectListTest(Map<String,Object>paramMap);
	public HashMap<String, Object>  selectOneTest(Map<String,Object>paramMap);
	/*끝*/
}

