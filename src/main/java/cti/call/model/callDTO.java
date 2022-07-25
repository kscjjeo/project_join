package cti.call.model;

public class callDTO {
	

	private int ab_id;						//시퀀스
	private String ab_station;				//내선번호
	private String ab_tel;					//고객번호
	private String ab_type;				//콜 유형
	private String ab_date;				//콜 시간

	public callDTO(){
		
	}
	public int getAb_id() {
		return ab_id;
	}


	public void setAb_id(int ab_id) {
		this.ab_id = ab_id;
	}


	public String getAb_station() {
		return ab_station;
	}


	public void setAb_station(String ab_station) {
		this.ab_station = ab_station;
	}


	public String getAb_tel() {
		return ab_tel;
	}


	public void setAb_tel(String ab_tel) {
		this.ab_tel = ab_tel;
	}


	public String getAb_type() {
		return ab_type;
	}


	public void setAb_type(String ab_type) {
		this.ab_type = ab_type;
	}


	public String getAb_date() {
		return ab_date;
	}


	public void setAb_date(String ab_date) {
		this.ab_date = ab_date;
	}


	public callDTO(int ab_id, String ab_station, String ab_tel, String ab_type, String ab_date) {
		super();
		this.ab_id = ab_id;
		this.ab_station = ab_station;
		this.ab_tel = ab_tel;
		this.ab_type = ab_type;
		this.ab_date = ab_date;
	}
}
