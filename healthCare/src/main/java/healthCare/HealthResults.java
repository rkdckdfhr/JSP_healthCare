package healthCare;

/// 문항을 동적으로 관리하기 위한 프레임워크
import java.util.ArrayList;
import java.util.List;

public class HealthResults
{
	/// 검사의 카테고리를 불러올 변수 ( body, eating, mental, sleep )
	private String category;
	private int questionCount;
	private List<Integer> scores = new ArrayList<>();
	
	/// getter setter 메소드
	public String getCategory() {	return category;	}
	public void setCategory(String category)	{	this.category = category;	}
	
	public int getQuestionCount() {	return questionCount;	}
	public void setQuestionCount(int questionCount) {	this.questionCount = questionCount;	}
	
	public List<Integer> getScores() {	return scores;	}
	public void setScores(List<Integer> scores) {	this.scores = scores;	}
	
	/// 문항 갯수만큼 더해주는 메소드 
	public void addScore (int score)
	{
		this.scores.add(score);
	}
	
	/// 리스트에 담긴 점수를 합산하여 총점을 계산해주는 메소드 
	public int GetTotalScore()
	{
		int sum = 0;
		
		for (int s : scores)
		{
			sum += s;
		}
		
		return sum;
	}
	
	/// 비율 계산을 위한 총점 구하기 메소드 
	public int GetMaxScore()
	{
		return questionCount * 3;
	}
	
	/// 받아온 점수로 비율 계산
	public String GetGrade()
	{
		int total = GetTotalScore();
		int max = GetMaxScore();
		
		double ratio = (double) total / max; /// 0.33 ~ 1.0 사이 값

        /// 전체 만점 대비 1/3 이하, 2/3 이하로 자동 3등분
        if (ratio <= (1.0 / 3.0))
        {
            return "나쁨 (주의 필요)";
        }
        else if (ratio <= (2.0 / 3.0)) 
        {
            return "보통 (관리 권장)";
        } 
        else 
        {
            return "좋음 (매우 양호)";
        }
	}
	
	/// 점수별 색상 코드 다르게 해주는 메소드 ( 없어도 됨 )
	public String GetGradeColor()
	{
		int max = GetMaxScore();
        if (max == 0) return "#333333";

        double ratio = (double) GetTotalScore() / max;
        if (ratio <= (1.0 / 3.0)) return "#ef5350";      // 빨강
        else if (ratio <= (2.0 / 3.0)) return "#ffa726"; // 주황
        else return "#4CAF50";                           // 초록
	}
	
	/// 카테고리를 화면에 띄워주기 위해 문자열을 반환하는 메소드
	public String GetCategoryName()
	{
		if ("mental".equals(category)) return "심리 상태";
        if ("body".equals(category)) return "신체 건강";
        if ("eating".equals(category)) return "식습관 평가";
        if ("sleep".equals(category)) return "수면 패턴";
        return "종합 건강";
	}
	
	/// 솔루션 제공을 위한 메소드
	public String GetSolution()
	{
		int max = GetMaxScore();
        if (max == 0) return "정상적인 경로로 검사를 진행해 주세요.";			/// 예외처리

        double ratio = (double) GetTotalScore() / max;

        if ("mental".equals(category)) {
            if (ratio <= (1.0 / 3.0)) 
            {
                return "현재 심리적 피로도와 스트레스가 매우 높은 상태입니다. 혼자 고민하기보다 주변 지인이나 전문 상담 기관의 도움을 받아 마음을 털어놓는 시간을 꼭 가지세요. 하루 15분 명상과 가벼운 산책부터 시작해 보세요.";
            } 
            else if (ratio <= (2.0 / 3.0)) 
            {
                return "일상적인 스트레스를 겪고 있지만 어느 정도 조절하고 계십니다. 주말에는 업무나 학업에서 완전히 벗어나 자신만의 취미 활동에 집중하며 재충전하는 시간을 늘려보세요.";
            } 
            else 
            {
                return "매우 건강하고 안정적인 멘탈을 유지하고 계십니다! 지금처럼 긍정적인 마인드와 원만한 대인관계를 유지하시고, 가끔은 스스로에게 작은 보상을 주며 활력을 이어가세요.";
            }
        } 
        else if ("body".equals(category)) 
        {
            if (ratio <= (1.0 / 3.0))
            {
                return "신체 활력이 크게 떨어져 있고 기초 체력이 부족한 상태입니다. 무리한 운동보다는 매일 20분씩 가볍게 걷기와 스트레칭으로 굳은 근육을 풀어주는 것부터 시작해야 합니다.";
            } 
            else if (ratio <= (2.0 / 3.0)) 
            {
                return "전반적인 신체 상태는 무난하지만 꾸준한 관리가 필요합니다. 주 3회 이상, 30분 정도 숨이 약간 찰 정도의 유산소 운동과 근력 운동을 병행해 기초 체력을 한 단계 끌어올려 보세요.";
            } 
            else 
            {
                return "훌륭한 신체 컨디션과 체력을 유지하고 계십니다! 현재의 운동 습관을 꾸준히 이어가시되, 운동 전후 충분한 준비운동과 쿨다운으로 부상을 예방하세요.";
            }
        }
        else if ("eating".equals(category))
        {
            if (ratio <= (1.0 / 3.0))
            {
                return "불규칙한 식사와 자극적인 음식 섭취로 위장 건강이 위협받고 있습니다. 당장 야식과 인스턴트 식품을 줄이고, 하루 한 끼라도 신선한 채소와 단백질이 포함된 규칙적인 식사를 챙겨 드세요.";
            } 
            else if (ratio <= (2.0 / 3.0)) 
            {
                return "기본적인 식사는 하고 계시지만 영양 균형이나 수분 섭취가 다소 아쉽습니다. 하루 물 1.5L 마시기와 식사 시 천천히 20번 이상 씹어 먹는 습관을 추가해 보세요.";
            }
            else
            {
                return "매우 모범적이고 건강한 식습관을 가지고 계십니다! 지금처럼 규칙적인 식사와 균형 잡힌 영양 섭취를 유지하시면서 제철 음식을 다양하게 즐겨보세요.";
            }
        }
        else if ("sleep".equals(category)) 
        {
            if (ratio <= (1.0 / 3.0)) 
            {
                return "만성적인 수면 부족이나 심각한 수면 질 저하가 의심됩니다. 잠들기 1시간 전에는 스마트폰을 멀리하고, 침실을 최대한 어둡고 조용하게 만들어 수면 환경을 전면 개선해야 합니다.";
            } 
            else if (ratio <= (2.0 / 3.0)) 
            {
                return "수면 시간은 확보하고 있으나 깊은 숙면을 취하지 못할 때가 있습니다. 주말에도 평일과 비슷한 시간에 기상하여 생체 리듬을 일정하게 맞추고, 오후 늦게는 카페인 섭취를 자제해 보세요.";
            } 
            else 
            {
                return "최상의 수면 패턴과 숙면의 질을 유지하고 계십니다! 규칙적인 기상 시간과 건강한 수면 습관이 다음 날의 높은 컨디션을 만들어주고 있습니다. 계속 잘 유지해 주세요.";
            }
        }
        return "검사 항목을 다시 확인해 주세요.";
    }
	
	/// [신규] 나쁨/보통 등급일 때 추천 유튜브 영상 ID 반환 (좋음일 때는 빈 문자열 반환)
		public String GetVideoId()
		{
			int max = GetMaxScore();
			if (max == 0) return "";

			double ratio = (double) GetTotalScore() / max;
			boolean isBad = ratio <= (1.0 / 3.0);
			boolean isNormal = ratio > (1.0 / 3.0) && ratio <= (2.0 / 3.0);

			/// '좋음' 등급이면 영상 추천 안 함
			if (!isBad && !isNormal) return "";

			if ("mental".equals(category)) {
				return isBad ? "_MTd1opMBk0" : "6soiPqRSfU4";
			} else if ("body".equals(category)) {
				return isBad ? "tZEZNsuDkLY" : "bqHZT259dlw";
			} else if ("eating".equals(category)) {
				return isBad ? "zGm-7y_p9Vc" : "yZ-Rsgo7zVw";
			} else if ("sleep".equals(category)) {
				return isBad ? "wOrzI6KBDbM" : "TRQV5h0XMns";
			} else if ("health".equals(category)) {
				return isBad ? "_4pmSuPQnIM" : "tk_mVOCRaak";
			}
			return "";
		}

		/// [신규] 유튜브 썸네일 이미지 URL 반환 (hqdefault.jpg: 고화질 480x360)
		public String GetThumbnailUrl()
		{
			String videoId = GetVideoId();
			if (videoId.isEmpty()) return "";
			return "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg";
		}

		/// [신규] 클릭 시 이동할 유튜브 영상 원본 URL 반환
		public String GetYoutubeUrl()
		{
			String videoId = GetVideoId();
			if (videoId.isEmpty()) return "";
			return "https://www.youtube.com/watch?v=" + videoId;
		}
	
	
}