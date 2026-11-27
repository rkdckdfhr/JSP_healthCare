
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="healthCare.Users" %>
<%@ page import="healthCare.UserScore" %>
<%@ page import="healthCare.HealthResults" %>

<%
    request.setCharacterEncoding("UTF-8");

    /// 로그인 사용자 확인
    Users loginUser = (Users)session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    /// myInfo의 URL에서 던진 카테고리 받기
    String category = request.getParameter("category");

    if (category == null || category.trim().isEmpty()) {
        response.sendRedirect("myInfo.jsp");
        return;
    }

    /// 전체 사용자 점수 목록 가져오기
    ArrayList<UserScore> userScoreList =
        (ArrayList<UserScore>)application.getAttribute("userScoreList");

    /// 로그인한 사용자의 해당 카테고리 검사 결과 찾기
    UserScore selectedScore = null;

    if (userScoreList != null) {

        for (UserScore score : userScoreList) {

            if (loginUser.getId().equals(score.getUserId())
                && category.equals(score.getCategory())) {

                /// 같은 카테고리의 결과가 여러 개라면 마지막 결과 사용
                selectedScore = score;
            }
        }
    }

    /// 해당 결과가 없으면 마이페이지로 이동
    if (selectedScore == null) {
        response.sendRedirect("myInfo.jsp");
        return;
    }

    /// 저장된 점수 정보
    int totalScore = selectedScore.getTotalScore();		///< 합산 점수
    int maxScore = selectedScore.getMaxScore();			///< 최대 점수

    /// HealthResults 객체 생성
    HealthResults healthResult = new HealthResults();

    /// 카테고리 지정
    healthResult.setCategory(category);

    /// 최대 점수는 문항 수 * 3이므로 문항 수 복원
    if (maxScore > 0) {
        healthResult.setQuestionCount(maxScore / 3);
    }

    /// 저장된 합산 점수를 HealthResults에 전달
    healthResult.addScore(totalScore);

    /// 카테고리별 진단 결과 및 솔루션
    String categoryName = healthResult.GetCategoryName();		///< 항목 이름 가져오기
    String grade = healthResult.GetGrade();					///< 진단 결과 가져오기
    String gradeColor = healthResult.GetGradeColor();		///< 진단 결과 폰트 색 가져오기
    String solution = healthResult.GetSolution();			///< 결과에 따른 솔루션 멘트 가져오기
  	
    /// 진단 결과에 따른 추천 영상 정보 가져오기
    String youtubeUrl = healthResult.GetYoutubeUrl();
    String thumbnailUrl = healthResult.GetThumbnailUrl();

    /// 잘못된 최대 점수 예외 처리
    if (maxScore <= 0) {
        grade = "검사 결과 없음";
        gradeColor = "#333333";
        solution = "정상적인 검사 결과가 아닙니다. 다시 검사를 진행해 주세요.";
    }
    
 	
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= categoryName %> 상세 결과</title>

    <link rel="stylesheet" href="css/myInfoDetail_style.css">
</head>

<body>

    <div class="container">

        <!-- 상단 영역 -->
        <header class="header">

            <div class="header-title">
                <h1>검사 상세 결과</h1>
                <p>카테고리별 건강 검사 결과를 자세히 확인해 보세요.</p>
            </div>

            <!-- 사용자 정보 -->
            <div class="user-info">
                <span class="user-name">
                    <%= loginUser.getName() %> 님
                </span>

                <span class="user-id">
                    <%= loginUser.getId() %>
                </span>
            </div>

        </header>


        <!-- 상세 결과 영역 -->
        <main class="main-content">

            <!-- 카테고리 -->
            <div class="category-badge">
                <%= categoryName %> 검사 결과
            </div>


            <!-- 점수 -->
            <div class="score-section">

                <span class="section-label">합산 점수</span>

                <div class="score-display">
                    <strong><%= totalScore %></strong>
                    <span>/ <%= maxScore %>점</span>
                </div>

            </div>


            <!-- 진단 결과 -->
            <div class="grade-section">

                <span class="section-label">진단 결과</span>

                <h2 style="color: <%= gradeColor %>;">
                    <%= grade %>
                </h2>

            </div>


            <!-- 맞춤형 솔루션 -->
            <div class="solution-section">

                <h3>맞춤형 건강 관리 솔루션</h3>

                <p><%= solution %></p>

            </div>
			<!-- 추천 유튜브 영상 -->
			<% if (!youtubeUrl.isEmpty()) { %>
			
			    <div class="video-section">
			
			        <h3>맞춤 추천 가이드 영상</h3>
			
			        <p class="video-guide">
			            건강 관리를 위한 추천 영상입니다.
			            썸네일을 클릭하면 유튜브로 이동합니다.
			        </p>
			
			        <!-- 문구와 이미지 사이 간격 -->
			        <div style="height: 30px;"></div>
			
			        <a href="<%= youtubeUrl %>"
			           target="_blank"
			           rel="noopener noreferrer"
			           class="thumbnail-link">
			
			            <img src="<%= thumbnailUrl %>"
			                 alt="추천 건강 가이드 썸네일"
			                 class="youtube-thumbnail">
			
			        </a>
			
			    </div>
			
			<% } %>

            <!-- 버튼 -->
            <div class="button-area">

                <a href="check_<%= category %>.jsp"
                   class="retry-button">
                    다시 검사하기
                </a>

                <a href="myInfo.jsp"
                   class="back-button">
                    마이페이지로 돌아가기
                </a>

            </div>

        </main>

    </div>

</body>
</html>
