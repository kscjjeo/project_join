package cti.history.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class historyDAOImple implements historyDAO {
	private SqlSession  sqlMap;

	public historyDAOImple(SqlSession sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

	public void addhistory(historyDTO history) {
		historyDAO historySQL = sqlMap.getMapper(historyDAO.class);
		historySQL.addhistory(history);
	}

	public ArrayList<historyDTO> history(String first, String second, String thrid, String fourth) {
		ArrayList<historyDTO> result = new ArrayList<historyDTO>();
		historyDAO historySQL = sqlMap.getMapper(historyDAO.class);
		result = historySQL.history(first, second, thrid, fourth);
		return result;
	}
	
	public List<historyDTO> first_history(String ab_empid) {
		List<historyDTO> list=sqlMap.selectList("first_history",ab_empid);
		
		return list;
	}
	public List<historyDTO> second_history(String ab_station) {
		List<historyDTO> list=sqlMap.selectList("second_history",ab_station);
		
		return list;
	}
	
	public List<historyDTO> clear_select() {
		List<historyDTO> list=sqlMap.selectList("clear_select");
		
		return list;
	}
	public List<historyDTO> clear_select2() {
		List<historyDTO> list=sqlMap.selectList("clear_select2");
		
		return list;
	}
	public int clear_insert(String ab_agent,String ab_station, String ab_empid,String ab_onoff) {
		Map map=new HashMap();
		
		map.put("ab_agent", ab_agent);
		map.put("ab_station", ab_station);
		map.put("ab_empid", ab_empid);
		map.put("ab_onoff", ab_onoff);
		
		int result=sqlMap.insert("clear_insert",map);
		return result;
	}
}
