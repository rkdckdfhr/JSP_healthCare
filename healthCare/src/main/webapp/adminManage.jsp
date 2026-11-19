
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="healthCare.Users" %>

<%
    Users loginUser = (Users)session.getAttribute("loginUser");

    // 관리자 로그인 여부 확인
    if(loginUser == null || !"admin".equals(loginUser.getAdminFlag())) {
        response.sendRedirect("mainPage.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="css/adminManage_style.css">
</head>

<body>

<div class="admin-container">

    <!-- 왼쪽 사이드바 -->
    <aside class="sidebar">

        <div class="sidebar-header">
            <h2>건강 증진 프로젝트</h2>
            <span>ADMINISTRATOR</span>
        </div>

        <div class="sidebar-menu">

            <p class="menu-title">관리자 메뉴</p>

            <a href="adminQuestion.jsp" class="menu-item">
                <span class="menu-icon">☷</span>
                <span>검사 항목 수정</span>
            </a>

            <a href="adminResult.jsp" class="menu-item">
                <span class="menu-icon">▤</span>
                <span>유저 검사 결과 리스트</span>
            </a>

        </div>

        <div class="sidebar-footer">
            <a href="mainPage.jsp">메인 페이지로 이동</a>
            <a href="logout.jsp">로그아웃</a>
        </div>

    </aside>


    <!-- 오른쪽 메인 영역 -->
    <main class="main-content">

        <header class="top-header">
            <div>
                <h1>관리자 대시보드</h1>
                <p>건강 증진 프로젝트 관리 페이지입니다.</p>
            </div>

            <div class="admin-profile">
                <span class="admin-badge">ADMIN</span>
                <span><%= loginUser.getName() %>님</span>
            </div>
        </header>


        <!-- 환영 영역 -->
        <section class="welcome-section">

            <div class="welcome-text">
                <span>ADMINISTRATOR</span>
                <h2>관리자 페이지에 오신 것을 환영합니다.</h2>
                <p>
                    검사 항목과 사용자 검사 결과를 관리할 수 있습니다.
                </p>
            </div>

        </section>


        <!-- 관리 메뉴 -->
        <section class="management-section">

            <h2>관리 메뉴</h2>
            <p class="section-description">
                원하는 관리 기능을 선택해주세요.
            </p>

            <div class="management-cards">

                <!-- 검사 항목 수정 -->
                <a href="adminQuestion.jsp" class="management-card">

                    <div class="card-icon question-icon">
                        ☷
                    </div>

                    <div class="card-content">
                        <h3>검사 항목 수정</h3>
                        <p>
                            정신 건강, 신체 건강, 식습관, 수면 등
                            카테고리별 검사 항목을 추가하거나 삭제할 수 있습니다.
                        </p>
                    </div>

                    <span class="card-arrow">→</span>

                </a>


                <!-- 유저 검사 결과 -->
                <a href="adminResult.jsp" class="management-card">

                    <div class="card-icon result-icon">
                        ▤
                    </div>

                    <div class="card-content">
                        <h3>유저 검사 결과 리스트</h3>
                        <p>
                            사용자들이 진행한 건강 검사 결과를
                            확인하고 관리할 수 있습니다.
                        </p>
                    </div>

                    <span class="card-arrow">→</span>

                </a>

            </div>

        </section>

    </main>

</div>

</body>
</html>
