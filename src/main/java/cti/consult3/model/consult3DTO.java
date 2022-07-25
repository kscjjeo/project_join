package cti.consult3.model;

public class consult3DTO {

	private String tele_numb; //전문가이관 번호
	private String dept_code; //URL 코드
	private String dept_name; //기관이름
	private String url; // url주소
	
	public String getTele_numb() {
		return tele_numb;
	}

	public void setTele_numb(String tele_numb) {
		this.tele_numb = tele_numb;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	public consult3DTO() {
		
	}
	public consult3DTO(String tele_numb, String dept_code, String dept_name, String url) {
		super();
		this.tele_numb = tele_numb;
		this.dept_code = dept_code;
		this.dept_name = dept_name;
		this.url = url;
	}

}
