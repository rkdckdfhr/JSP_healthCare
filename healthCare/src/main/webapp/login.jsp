<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

    <div class="page-container">

        <!-- 상단 프로젝트 제목 -->
        <header class="login-header">
            <h1>건강 증진 프로젝트</h1>
        </header>

        <!-- 로그인 영역 -->
        <main class="login-area">
            <div class="login-container">

                <form action="loginProcess.jsp" method="post">

                    <div class="input-group">
                        <label for="userid">아이디</label>
                        <input type="text" id="userid" name="userid"
                               placeholder="아이디를 입력하세요">
                    </div>

                    <div class="input-group">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="password"
                               placeholder="비밀번호를 입력하세요">
                    </div>

                    <div class="button-group">
                        <a href="signup.jsp" class="signup-btn">회원가입</a>
                        <button type="submit" class="submit-btn">로그인</button>
                    </div>

                </form>

            </div>
        </main>

        <!-- 하단 메인 페이지 이동 -->
        <footer class="login-footer">
            <a href="mainPage.jsp" class="main-btn">
		        메인 페이지로 이동
		    </a>
        </footer>

    </div>

</body>
</html>
