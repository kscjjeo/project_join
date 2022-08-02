package cti.user.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



public interface userDAO {
	public int insert_member(Map<String,Object>paramMap);
	public int select_member(Map<String,Object>paramMap);
	public int select_member_pass_check(Map<String,Object>paramMap);
	public List<userDTO> select_member_id_information_check(Map<String,Object>paramMap);
	
//	
//	public userDAO userdao = new userDAO() {
//		userdao user_id = null;
//
//	    Connection conn = null;
//	    PreparedStatement pstmt = null;
//	    ResultSet rs = null;
//
//	    String sql = "select * from member where id= ? ";
//	    try {
//            conn = ds.getConnection();
//            pstmt = conn.prepareStatement(sql); // SQL Injection공격, 성능향상
//            pstmt.setString(1, id);
//
//            rs = pstmt.executeQuery(); //  select
//
//            if (rs.next()) {
//                user = new User();
//               
//            }
//        } catch (SQLException e) {
//            return null;
//        } finally {
//            // close()를 호출하다가 예외가 발생할 수 있으므로, try-catch로 감싸야함.
//            // close()의 호출순서는 생성된 순서의 역순
////            try { if(rs!=null)    rs.close();    } catch (SQLException e) { e.printStackTrace();}
////            try { if(pstmt!=null) pstmt.close(); } catch (SQLException e) { e.printStackTrace();}
////            try { if(conn!=null)  conn.close();  } catch (SQLException e) { e.printStackTrace();}
//            close(rs, pstmt, conn);  //     private void close(AutoCloseable... acs) {
//        }
//
//        return user;
//    }

}

