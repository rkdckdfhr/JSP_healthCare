package healthCare;

public class Users {
	private String id;			///< 아이디
	private String passwd;		///< 비밀번호
	private String name;			///< 이름
	private String adminFlag;	///< 관리자 여부
	
	/// 생성자 
	public Users(String id, String passwd, String name, String adminFlag) {
		super();
		this.id = id;
		this.passwd = passwd;
		this.name = name;
		this.adminFlag = adminFlag;
	}

	/// setter/getter
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAdminFlag() {
		return adminFlag;
	}

	public void setAdminFlag(String adminFlag) {
		this.adminFlag = adminFlag;
	}
	

}
