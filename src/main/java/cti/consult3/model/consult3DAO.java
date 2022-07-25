package cti.consult3.model;

import java.util.ArrayList;

public interface consult3DAO {
	public ArrayList<consult3DTO> consultlist3(String dept_name); //기관이름 으로검색하여 정보가져오기
}
