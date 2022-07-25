package cti.history.model;

public class historyDTO {
	private int ab_no;
	private String ab_agent;
	private String ab_station;
	private String ab_empid;
	private String ab_date;
	private String ab_onoff;
	public String getAb_date() {
		return ab_date;
	}
	public void setAb_date(String ab_date) {
		this.ab_date = ab_date;
	}
	
	public int getAb_no() {
		return ab_no;
	}
	public void setAb_no(int ab_no) {
		this.ab_no = ab_no;
	}
	public String getAb_agent() {
		return ab_agent;
	}
	public void setAb_agent(String ab_agent) {
		this.ab_agent = ab_agent;
	}
	public String getAb_station() {
		return ab_station;
	}
	public void setAb_station(String ab_station) {
		this.ab_station = ab_station;
	}
	public String getAb_empid() {
		return ab_empid;
	}
	public void setAb_empid(String ab_empid) {
		this.ab_empid = ab_empid;
	}
	public String getAb_onoff() {
		return ab_onoff;
	}
	public void setAb_onoff(String ab_onoff) {
		this.ab_onoff = ab_onoff;
	}
	public historyDTO(int ab_no, String ab_agent, String ab_station, String ab_empid,String ab_date, String ab_onoff) {
		super();
		this.ab_no = ab_no;
		this.ab_agent = ab_agent;
		this.ab_station = ab_station;
		this.ab_empid = ab_empid;
		this.ab_date = ab_date;
		this.ab_onoff = ab_onoff;
	}
	public historyDTO(){
		
	}
	
}
