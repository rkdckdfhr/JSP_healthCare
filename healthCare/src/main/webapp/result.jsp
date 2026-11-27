<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="HealthResults" class="healthCare.HealthResults" scope="page" />
<jsp:setProperty name="HealthResults" property="category" />
<jsp:setProperty name="HealthResults" property="questionCount" />

<%@ page import="java.util.*,healthCare.UserScore,healthCare.Users" %>

<%
    int count = HealthResults.getQuestionCount();
    for (int i = 0; i < count; i++)
    {
        String value = request.getParameter("q_" + i);
        if (value != null)
        {
            HealthResults.addScore(Integer.parseInt(value));
        }
    }

    Users loginUser = (Users)session.getAttribute("loginUser");
    if(loginUser != null && count > 0)
    {
        UserScore userScore = new UserScore(
            loginUser.getId(),
            HealthResults.getCategory(),
            HealthResults.GetTotalScore(),
            HealthResults.GetMaxScore()
        );

        ArrayList<UserScore> userScoreList = (ArrayList<UserScore>)application.getAttribute("userScoreList");
        if (userScoreList == null) {
            userScoreList = new ArrayList<UserScore>();
        }
        userScoreList.add(userScore);
        application.setAttribute("userScoreList", userScoreList);
    }

    /// 추천 영상 URL 가져오기 (나쁨/보통일 때만 값이 존재)
    String youtubeUrl = HealthResults.GetYoutubeUrl();
    String thumbnailUrl = HealthResults.GetThumbnailUrl();
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

        <%-- 나쁨 또는 보통일 경우에만 추천 영상 썸네일 영역 출력 --%>
        <% if (!youtubeUrl.isEmpty()) { %>
        <div class="video-section">
            <p class="video-guide">맞춤 추천 가이드 영상 (클릭 시 유튜브로 이동)</p>
            <a href="<%= youtubeUrl %>" target="_blank" rel="noopener noreferrer" class="thumbnail-link">
                <img src="<%= thumbnailUrl %>" alt="추천 건강 가이드 썸네일" class="youtube-thumbnail">
            </a>
        </div>
        <% } %>

        <div class="btn-group">
            <a href="check_<%= HealthResults.getCategory() %>.jsp" class="btn btn-retry">다시 검사하기</a>
            <a href="mainPage.jsp" class="btn btn-main">메인으로 돌아가기</a>
        </div>
    </div>

</body>
</html>