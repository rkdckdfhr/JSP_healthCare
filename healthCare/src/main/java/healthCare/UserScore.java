package healthCare;

public class UserScore {
	private String userId;		///< 유저 아이디
	private String category;  	///< 검사 카테고리
    private int totalScore;   	///< 합산 점수
    private int maxScore;    	///< 최대 점수
	
    /// 생성자
    public UserScore(String userId, String category, int totalScore, int maxScore) {
		super();
		this.userId = userId;
		this.category = category;
		this.totalScore = totalScore;
		this.maxScore = maxScore;
	}

    /// setter/getter
    public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getCategory() {
		return category;
	}

	
	public void setCategory(String category) {
		this.category = category;
	}

	public int getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}

	public int getMaxScore() {
		return maxScore;
	}

	public void setMaxScore(int maxScore) {
		this.maxScore = maxScore;
	}
}
