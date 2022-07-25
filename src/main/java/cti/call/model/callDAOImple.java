package cti.call.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class callDAOImple implements callDAO{

	private SqlSession  sqlMap;

	public callDAOImple(SqlSession sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

//	public void call_add(callDTO call) {
//		callDAO callSQL = sqlMap.getMapper(callDAO.class);
//		callSQL.call_add(call);
//	}
	public int call_add(String ab_station, String ab_tel,String ab_type) {
		Map map=new HashMap();
		map.put("ab_station", ab_station);
		map.put("ab_tel", ab_tel);
		map.put("ab_type", ab_type);
		int result=sqlMap.insert("call_add",map);
		return result;
	}
}
