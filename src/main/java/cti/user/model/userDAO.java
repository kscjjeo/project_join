package cti.user.model;

import java.util.Map;

public interface userDAO {
	public int insert_member(Map<String,Object>paramMap);
	public int select_member(Map<String,Object>paramMap);
	public int select_member_pass_check(Map<String,Object>paramMap);
	public int select_member_id_information_check(Map<String,Object>paramMap);

}
