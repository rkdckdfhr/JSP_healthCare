
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, healthCare.Users, healthCare.UserScore,healthCare.HealthResults" %>

<%
    request.setCharacterEncoding("UTF-8");

    /// 관리자 로그인 확인
    Users loginUser = (Users)session.getAttribute("loginUser");

    /// 관리자 로그인이 아닐 시 메인페이지로 이동
    if (loginUser == null || !"admin".equals(loginUser.getAdminFlag())) {
        response.sendRedirect("mainPage.jsp");
        return;
    }

    /// 검사 종류 선택
    String category = request.getParameter("category");

    /// 처음에는 모든 검사 리스트 보기
    if (category == null ||
        !(category.equals("all") ||
          category.equals("mental") ||
          category.equals("body") ||
          category.equals("eating") ||
          category.equals("sleep") ||
          category.equals("health"))) {
        category = "all";
    }

    /// 선택한 검사 종류 이름
    String categoryName = "";

    /// 카테고리에 따라 카테고리 이름 넣어주기
    switch (category) {
        case "all":
            categoryName = "전체 검사 결과";
            break;
        case "mental":
            categoryName = "정신 건강";
            break;
        case "body":
            categoryName = "신체 건강";
            break;
        case "eating":
            categoryName = "식습관";
            break;
        case "sleep":
            categoryName = "수면";
            break;
        case "health":
            categoryName = "종합 건강";
            break;
    }

    /// 전체 사용자 검사 결과 가져오기
    ArrayList<UserScore> userScoreList =
        (ArrayList<UserScore>)application.getAttribute("userScoreList");

    /// 선택한 카테고리에 해당하는 결과만 저장
    ArrayList<UserScore> filteredList = new ArrayList<>();

    if (userScoreList != null) {
        for (UserScore score : userScoreList) {
            if (category.equals("all") ||
                category.equals(score.getCategory())) {
                filteredList.add(score);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유저 검사 결과</title>
    <link rel="stylesheet" href="css/adminQuestion.css">
    <link rel="stylesheet" href="css/adminResult_style.css">
</head>

<body>

<div class="admin-container">

    <!-- 사이드바 -->
    <aside class="sidebar">

        <div class="sidebar-header">
            <h2>건강 증진 프로젝트</h2>
            <span>ADMINISTRATOR</span>
        </div>

        <nav class="sidebar-menu">
            <p class="menu-title">관리 메뉴</p>

            <a href="adminQuestion.jsp" class="menu-item">
                <span class="menu-icon">📝</span>
                검사 항목 수정
            </a>

            <a href="adminResult.jsp" class="menu-item active">
                <span class="menu-icon">📊</span>
                유저 검사 결과
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="mainPage.jsp">🏠 메인 페이지</a>
            <a href="logout.jsp">🚪 로그아웃</a>
        </div>

    </aside>


    <!-- 메인 콘텐츠 -->
    <main class="main-content">

        <!-- 상단 헤더 -->
        <header class="top-header">

            <div>
                <h1>유저 검사 결과</h1>
                <p>사용자들의 건강 검사 결과를 확인합니다.</p>
            </div>

            <div class="admin-profile">
                <span class="admin-badge">ADMIN</span>
                <span><%= loginUser.getName() %>님</span>
            </div>

        </header>


        <!-- 검사 결과 관리 -->
        <section class="question-section">

            <div class="section-header">
                <h2>검사 결과 조회</h2>
                <p>조회할 검사 종류를 선택해 주세요.</p>
            </div>


            <!-- 검사 종류 선택 -->
            <form action="adminResult.jsp" method="get"
                  class="category-form">

                <select name="category" onchange="this.form.submit()">

                    <option value="all"
                        <%= category.equals("all") ? "selected" : "" %>>
                        전체 검사 결과
                    </option>

                    <option value="mental"
                        <%= category.equals("mental") ? "selected" : "" %>>
                        심리 상태 검사
                    </option>

                    <option value="body"
                        <%= category.equals("body") ? "selected" : "" %>>
                        신체 건강 검사
                    </option>

                    <option value="eating"
                        <%= category.equals("eating") ? "selected" : "" %>>
                        식습관 평가
                    </option>

                    <option value="sleep"
                        <%= category.equals("sleep") ? "selected" : "" %>>
                        수면 패턴 검사
                    </option>

                    <option value="health"
                        <%= category.equals("health") ? "selected" : "" %>>
                        종합 건강 검진
                    </option>

                </select>

            </form>


            <!-- 검사 결과 목록 -->
            <div class="question-list-section">

                <div class="question-list-header">
                    <div>
                        <h2><%= categoryName %></h2>
                        <p>
                            조회된 검사 결과는 총
                            <strong><%= filteredList.size() %></strong>건입니다.
                        </p>
                    </div>
                </div>


                <div class="question-list">

                    <% 
                    
                    		/// 반복문으로 모든 유저의 검사 결과 리스트 출력하기
                    		for (int i = 0; i < filteredList.size(); i++) {

						    UserScore score = filteredList.get(i);
							
						    /// 검사 결과 변수
						    HealthResults result = new HealthResults();
						    result.setCategory(score.getCategory());				///< 카테고리 
						    result.setQuestionCount(score.getMaxScore() / 3);	///< 검사 항목 개수
						    result.addScore(score.getTotalScore());				///< 점수
						
						    /// 검사 결과
						    String grade = result.GetGrade();
						
						    String gradeClass = "grade-good";
						
						    if (grade.startsWith("나쁨")) {
						        gradeClass = "grade-bad";
						    }
						    else if (grade.startsWith("보통")) {
						        gradeClass = "grade-normal";
						    }
						
						    String rowCategoryName = result.GetCategoryName();
					%>
					
					<div class="question-item result-item">
					    <div class="result-column">
					        <span class="result-label">ID</span>
					        <strong><%= score.getUserId() %></strong>
					    </div>
					
					    <div class="result-column">
					        <span class="result-label">검사종류</span>
					        <strong><%= rowCategoryName %></strong>
					    </div>
					
					    <div class="result-column">
					        <span class="result-label">점수</span>
					        <strong>
					            <%= score.getTotalScore() %> / <%= score.getMaxScore() %>점
					        </strong>
					    </div>
					
					    <div class="result-column">
					        <span class="result-label">검사결과</span>
					        <span class="grade-badge <%= gradeClass %>">
					            <%= grade %>
					        </span>
					    </div>
					</div>
					
					<% } %>


                    <!-- 검사 결과가 없는 경우 -->
                    <% if (filteredList.isEmpty()) { %>

                        <div class="empty-message">
                            등록된 검사 결과가 없습니다.
                        </div>

                    <% } %>

                </div>

            </div>


            <!-- 메인 페이지 이동 -->
            <div class="result-footer">
                <a href="mainPage.jsp" class="main-return-button">
                    🏠 메인으로 돌아가기
                </a>
            </div>

        </section>

    </main>

</div>

</body>
</html>
