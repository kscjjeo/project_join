package cti.user.model;

public class userDTO {
	private int user_no;	/* 회원번호*/
	private String user_id;	/* 회원아이디 */
	private String user_pass;	/* 회원패스워드*/
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
}
