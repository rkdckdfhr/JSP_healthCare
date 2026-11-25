
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Map" %>

<%@ page import="healthCare.Users" %>
<%@ page import="healthCare.UserScore" %>

<%
    request.setCharacterEncoding("UTF-8");

    /// 로그인 된 유저 아이디 받기
    Users loginUser = (Users)session.getAttribute("loginUser");

    /// 로그인하지 않았다면 메인 페이지로 이동
    if (loginUser == null) {
        response.sendRedirect("mainPage.jsp");
        return;
    }

  	/// 유저 점수 리스트 받기
    ArrayList<UserScore> userScoreList =
        (ArrayList<UserScore>)application.getAttribute("userScoreList");

    /// 로그인한 사용자의 카테고리별 최신 점수 저장
    Map<String, UserScore> myScoreMap = new LinkedHashMap<>();

    if (userScoreList != null) {
        for (UserScore score : userScoreList) {

            /// 현재 로그인한 사용자의 점수만 추출
            if (loginUser.getId().equals(score.getUserId())) {

                /// 같은 카테고리가 다시 나오면 최신 결과로 교체
                myScoreMap.put(score.getCategory(), score);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <link rel="stylesheet" href="css/myInfo_style.css">
</head>

<body>

    <div class="container">

        <!-- 상단 영역 -->
        <header class="header">

            <div class="header-title">
                <h1>마이페이지</h1>
                <p>나의 건강 검사 결과를 확인해 보세요.</p>
            </div>

            <!-- 우측 상단 사용자 정보 -->
            <div class="user-info">
                <span class="user-name">
                    <%= loginUser.getName() %> 님
                </span>

                <span class="user-id">
                    <%= loginUser.getId() %>
                </span>
            </div>

        </header>


        <!-- 검사 결과 영역 -->
        <main class="main-content">

            <div class="section-title">
                <h2>나의 건강 검사 결과</h2>
                <p>카테고리별 검사 점수와 진단 결과입니다.</p>
            </div>


            <div class="score-list">

                <% if (myScoreMap.isEmpty()) {///검사 결과가 없다면 %>

                    <!-- 검사 결과가 없는 경우 -->
                    <div class="empty-result">
                        <div class="empty-icon">📋</div>
                        <h3>아직 검사 결과가 없습니다.</h3>
                        <p>건강 검사를 진행하면 이곳에서 결과를 확인할 수 있습니다.</p>
                    </div>

                <% } else {///검사 결과가 있다면 %>

                    <% for (UserScore score : myScoreMap.values()) {

                    	int totalScore = score.getTotalScore();
                        int maxScore = score.getMaxScore();

                        /// 점수 비율 계산
                        double ratio = 0;

                        if (maxScore > 0) {
                            ratio = (double)totalScore / maxScore;
                        }

                        /// 진단 결과 
                        String diagnosis = "";

                        if (maxScore == 0) {
                            diagnosis = "검사 결과 없음";
                        }
                        else if (ratio <= (1.0 / 3.0)) {
                            diagnosis = "나쁨 (주의 필요)";
                        }
                        else if (ratio <= (2.0 / 3.0)) {
                            diagnosis = "보통 (관리 권장)";
                        }
                        else {
                            diagnosis = "좋음 (매우 양호)";
                        }

                        /// 카테고리 이름
                        String categoryName = score.getCategory();

                        if ("mental".equals(categoryName)) {
                            categoryName = "심리 상태";
                        }
                        else if ("body".equals(categoryName)) {
                            categoryName = "신체 건강";
                        }
                        else if ("eating".equals(categoryName)) {
                            categoryName = "식습관 평가";
                        }
                        else if ("sleep".equals(categoryName)) {
                            categoryName = "수면 패턴";
                        }
                    %>

                        <!-- 카테고리별 점수 카드 -->
                        <div class="score-item">

                            <div class="category-area">
                                <span class="category-label">검사 카테고리</span>
                                <h3><%= categoryName %></h3>
                            </div>

                            <div class="score-area">
                                <span class="category-label">합산 점수</span>
                                <div class="score-number">
                                    <strong><%= totalScore %></strong>
                                    <span>/ <%= maxScore %>점</span>
                                </div>
                            </div>

                            <div class="diagnosis-area">
                                <span class="category-label">진단 결과</span>
                                <span class="diagnosis"><%= diagnosis %></span>
                            </div>

                            <div class="detail-area">
                                <a href="myInfoDetail.jsp?category=<%= URLEncoder.encode(score.getCategory(), "UTF-8") %>"
                                   class="detail-button">
                                    자세히 보기
                                </a>
                            </div>

                        </div>

                    <% } %>

                <% } %>

            </div>

            <!-- 하단 버튼 -->
            <div class="bottom-area">
                <a href="mainPage.jsp" class="main-button">
                    메인으로 돌아가기
                </a>
            </div>

        </main>

    </div>

</body>
</html>
