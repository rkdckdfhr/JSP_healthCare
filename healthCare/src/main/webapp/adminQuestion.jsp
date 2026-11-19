<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, healthCare.Users, healthCare.QuestionManager" %>

<%
	/// 로그인 된 유저 아이디 받기
    Users loginUser = (Users)session.getAttribute("loginUser");

	/// 관리자 로그인 확인
    if (loginUser == null || !"admin".equals(loginUser.getAdminFlag())) {
        response.sendRedirect("mainPage.jsp");
        return;
    }

    /// 검사 종류 선택 시 받아오는 변수
    String category = request.getParameter("category");

    /// null이라면 기본값을 mental(심리검사)로 지정
    if (category == null ||
        !(category.equals("mental") ||
          category.equals("body") ||
          category.equals("eating") ||
          category.equals("sleep"))) {
        category = "mental";
    }

    // 검사 종류별 질문 가져오기
    List<String> questions = QuestionManager.getQuestions(category);

    // 선택된 검사 종류 이름
    String categoryName = "";

    switch (category) {
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
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검사 항목 수정</title>
    <link rel="stylesheet" href="css/adminQuestion.css">
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

            <a href="adminQuestion.jsp" class="menu-item active">
                <span class="menu-icon">📝</span>
                검사 항목 수정
            </a>

            <a href="adminResult.jsp" class="menu-item">
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
                <h1>검사 항목 수정</h1>
                <p>건강 검사에 사용되는 질문 항목을 관리합니다.</p>
            </div>

            <div class="admin-profile">
                <span class="admin-badge">ADMIN</span>
                <span><%= loginUser.getName() %>님</span>
            </div>

        </header>


        <!-- 검사 항목 관리 -->
        <section class="question-section">

            <div class="section-header">
                <h2>검사 종류 선택</h2>
                <p>수정할 검사 종류를 선택해 주세요.</p>
            </div>


            <!-- 검사 종류 선택 시 해당 검사의 리스트가 나오도록 처리 -->
            <form action="adminQuestion.jsp" method="get" class="category-form">

                <select name="category" onchange="this.form.submit()">

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

                </select>

            </form>


            <!-- 문항 목록 -->
            <div class="question-list-section">

                <div class="question-list-header">

                    <div>
                        <h2><%= categoryName %> 항목</h2>
                        <!-- 문항 개수 출력 -->
                        <p>현재 등록된 문항은 총 <strong><%= questions.size() %></strong>개입니다.</p>
                    </div>

                </div>


				<!-- 검사 문항 리스트 출력 -->
                <div class="question-list">

                    <% for (int i = 0; i < questions.size(); i++) { %>

                        <div class="question-item">

                            <div class="question-number">
                                <%= i + 1 %>
                            </div>

                            <div class="question-text">
                                <%= questions.get(i) %>
                            </div>

                            <!-- 삭제 폼 -->
                            <form action="adminQuestionProcess.jsp" method="post">

								<!-- process에서 사용되는 변수값 전달 -->
								<!-- action변수에 add 전달 -->
                                <input type="hidden" name="action" value="delete">
                                <!-- 카테고리 전달 -->
                                <input type="hidden" name="category" value="<%= category %>">
                                <!-- 삭제 할 항목의 인덱스값 전달 -->
                                <input type="hidden" name="index" value="<%= i %>">

                                <button type="submit" class="delete-button"
                                    onclick="return confirm('이 항목을 삭제하시겠습니까?');">
                                    삭제
                                </button>

                            </form>

                        </div>

                    <% } %>

                    <% if (questions.isEmpty()) { %>

                        <div class="empty-message">
                            등록된 질문이 없습니다.
                        </div>

                    <% } %>

                </div>

            </div>


            <!-- 질문 추가 -->
            <div class="add-section">

                <button type="button" class="add-open-button"
                    onclick="showAddArea()">
                    + 항목 추가
                </button>


                <!-- 처음에는 숨겨져 있는 입력 영역 -->
                <div class="add-area" id="add-area">

                    <h3>새로운 검사 항목 추가</h3>

                    <form action="adminQuestionProcess.jsp" method="post">

						<!-- process에서 사용되는 변수값 전달 -->
                        <!-- action변수에 add 전달 -->
                        <input type="hidden" name="action" value="add">
                        <!-- 카테고리 전달 -->
                        <input type="hidden" name="category" value="<%= category %>">

						<!-- 추가할 항목을 입력하는 텍스트 박스 -->
                        <input type="text"
                            name="question"
                            id="question"
                            placeholder="추가할 질문 내용을 입력해 주세요."
                            maxlength="200"
                            required>

                        <div class="add-buttons">

                            <button type="button" class="cancel-button"
                                onclick="hideAddArea()">
                                취소
                            </button>

                            <button type="submit" class="submit-button">
                                항목 등록
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </section>

    </main>

</div>


<script>

    // 질문 추가 영역 표시
    function showAddArea() {
        document.getElementById("add-area").style.display = "block";
        document.getElementById("question").focus();
    }

    // 질문 추가 영역 숨기기
    function hideAddArea() {
        document.getElementById("add-area").style.display = "none";
        document.getElementById("question").value = "";
    }

</script>

</body>
</html>