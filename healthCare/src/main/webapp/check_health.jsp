<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, healthCare.QuestionManager" %>
<%
    /// 종합 검진('health') 전용 문항 리스트 불러오기 (초기 12문항 + 관리자 추가/삭제 반영)
    List<String> questions = QuestionManager.getQuestions("health");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>종합 건강 검진 - 건강 복지 솔루션</title>
    <link rel="stylesheet" href="css/health_style.css">
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>종합 건강 검진</h1>
        <p>신체, 심리, 식습관, 수면 패턴을 종합적으로 진단합니다. (총 <%= questions.size() %>문항)</p>
    </div>

    <form action="result.jsp" method="post" class="form-container">
        <input type="hidden" name="category" value="health">
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

        <button type="submit" class="submit-btn">종합 검진 결과 확인하기</button>
    </form>

</body>
</html>