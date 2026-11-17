<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, healthCare.QuestionManager" %>
<%
    List<String> questions = QuestionManager.getQuestions("sleep");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수면 패턴 검사 - 건강 복지 솔루션</title>
    <link rel="stylesheet" href="css/sleep_style.css">
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>수면 패턴 검사</h1>
        <p>각 문항을 읽고 현재 자신의 상태와 가장 잘 맞는 항목을 선택해주세요.</p>
    </div>

    <form action="result.jsp" method="post" class="form-container">
        <input type="hidden" name="category" value="sleep">
        <input type="hidden" name="questionCount" value="<%= questions.size() %>">

        <% for(int i = 0; i < questions.size(); i++) { %>
        <div class="question-box">
            <div class="question-title"><%= (i + 1) %>. <%= questions.get(i) %></div>
            <div class="radio-group">
                <label class="radio-label"><input type="radio" name="q_<%= i %>" value="1" required> 나쁨</label>
                <label class="radio-label"><input type="radio" name="q_<%= i %>" value="2"> 중간</label>
                <label class="radio-label"><input type="radio" name="q_<%= i %>" value="3"> 좋음</label>
            </div>
        </div>
        <% } %>

        <button type="submit" class="submit-btn">결과 확인하기</button>
    </form>

</body>
</html>