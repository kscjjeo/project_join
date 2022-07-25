package cti.kakao.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;


public class kakaoDAOImple implements kakaoDAO{
	private SqlSession  sqlMap;

	public kakaoDAOImple(SqlSession sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

	public int insert_kakako(String RCV_PHN_ID) {
		Map map=new HashMap();
		map.put("RCV_PHN_ID", RCV_PHN_ID);
		int result=sqlMap.insert("insert_kakako",map);
		return result;
	}
}
