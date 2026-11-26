<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // POST 방식으로 넘어오는 한글 깨짐 방지
    request.setCharacterEncoding("UTF-8");
%>

<!-- JavaBean 객체 생성 및 category, questionCount 자동 매핑 -->
<jsp:useBean id="HealthResults" class="healthCare.HealthResults" scope="page" />
<jsp:setProperty name="HealthResults" property="category" />
<jsp:setProperty name="HealthResults" property="questionCount" />

<!-- 유저 점수 클래스 import -->
<%@ page import="java.util.*,healthCare.UserScore,healthCare.Users" %>

<%
    // 문항 갯수를 count 변수에 넣고 갯수만큼 점수 계산
    int count = HealthResults.getQuestionCount();
    for (int i = 0; i < count; i++)
    {
        String value = request.getParameter("q_" + i);
        if (value != null)
        {
        		HealthResults.addScore(Integer.parseInt(value));
        		
        		/// 로그인 된 유저 아이디 받기
        		Users loginUser = (Users)session.getAttribute("loginUser");
        		
        		if(loginUser != null)
        		{
        			/// 유저 점수 리스트에 넣기 위한 유저 점수 변수
        			UserScore userScore = new UserScore(	loginUser.getId(),				///< 유저아이디
							HealthResults.getCategory(),		///< 카테고리
							HealthResults.GetTotalScore(),	///< 합산 점수
							HealthResults.GetMaxScore());	///< 최대 점수
				/// 유저 점수 리스트 받기
				ArrayList<UserScore> userScoreList = (ArrayList<UserScore>)application.getAttribute("userScoreList");
				
				/// 리스트가 없으면 새로 생성
				if (userScoreList == null) {
				userScoreList = new ArrayList<UserScore>();
				}
				/// 유저 점수 추가
				userScoreList.add(userScore);
				
				/// 웹 전체에서 사용 가능하도록 데이터 공유
				application.setAttribute("userScoreList", userScoreList);
        		}

        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= HealthResults.GetCategoryName() %> 결과 - 건강 복지 솔루션</title>
    <link rel="stylesheet" href="css/result_style.css">
</head>
<body>

    <div class="result-card">
        <div class="category-badge"><%= HealthResults.GetCategoryName() %> 검사 결과</div>
        
        <div class="score-display">
            <%= HealthResults.GetTotalScore() %> <span>/ <%= HealthResults.GetMaxScore() %>점</span>
        </div>

        <div class="grade-text">
            진단 결과 : <%= HealthResults.GetGrade() %>
        </div>

        <div class="solution-box">
            <h3>맞춤형 건강 관리 솔루션</h3>
            <p style="margin: 0;"><%= HealthResults.GetSolution() %></p>
        </div>

        <div class="btn-group">
            <a href="check_<%= HealthResults.getCategory() %>.jsp" class="btn btn-retry">다시 검사하기</a>
            <a href="mainPage.jsp" class="btn btn-main">메인으로 돌아가기</a>
        </div>
    </div>

</body>
</html>