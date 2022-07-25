package cti.history.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface historyDAO {

	public void addhistory(historyDTO history);
	public ArrayList<historyDTO> history(@Param("first") String first, @Param("second") String second, @Param("third") String third, @Param("fourth") String fourth);
	
	public List<historyDTO> first_history(String ab_empid);
	public List<historyDTO> second_history(String ab_station);
	public List<historyDTO> clear_select();//전날 로그아웃 안된 계정 조회
	public List<historyDTO> clear_select2();//당일 로그아웃 안된 계정 조회
	public int clear_insert(String ab_agent,String ab_station, String ab_empid,String ab_onoff);//로그아웃안된 계정 로그인가능케만들기
}
