package cti.kakao.model;

public class kakaoDTO {

	private String RCV_PHN_ID; 	/* 고개전화번호 */

	
	public String getCust_num() {
		return RCV_PHN_ID;
	}	

	public void setCust_num(String cust_num) {
		this.RCV_PHN_ID = cust_num;
	}

	public kakaoDTO(String cust_num) {
		super();

		this.RCV_PHN_ID = cust_num;
	}

	public kakaoDTO() {
		
	}
}
