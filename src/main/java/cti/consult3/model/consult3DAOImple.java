package cti.consult3.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

public class consult3DAOImple implements consult3DAO{
	private SqlSession  sqlMap;

	public consult3DAOImple(SqlSession sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}
	
	public ArrayList<consult3DTO> consultlist3(String dept_name) {
		ArrayList<consult3DTO> result = new ArrayList<consult3DTO>();
		consult3DAO consult3SQL = sqlMap.getMapper(consult3DAO.class);
		result = consult3SQL.consultlist3(dept_name);
		return result;
	}
}
