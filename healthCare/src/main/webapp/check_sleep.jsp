<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수면 패턴 검사 - 건강 복지 솔루션</title>
    <!-- 요청하신 CSS 파일 연결 -->
    <link rel="stylesheet" href="css/sleep_style.css">
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>수면 패턴 검사</h1>
        <p>각 문항을 읽고 현재 자신의 상태와 가장 잘 맞는 항목을 선택해주세요.</p>
    </div>

    <!-- 결과 처리 페이지로 이동 -->
    <form action="sleep_result.jsp" method="post" class="form-container">
        
        <% 
            String[] questions = {
                "하루 7~8시간의 적정 수면 시간 유지 정도는 어떠한가요?",
                "잠자리에 누운 후 30분 이내에 잠드는 입면 능력은 어떠한가요?",
                "수면 중 깨지 않고 푹 자는 숙면 정도는 어떠한가요?",
                "아침에 일어났을 때 느끼는 개운함과 상쾌함은 어떠한가요?",
                "매일 일정한 시간에 자고 일어나는 수면 규칙성은 어떠한가요?",
                "낮 시간 동안 졸음이 쏟아지지 않는 맑은 각성 상태는 어떠한가요?",
                "취침 전 스마트폰이나 TV 시청을 자제하는 정도는 어떠한가요?",
                "코골이나 수면 무호흡 없이 편안하게 호흡하는 정도는 어떠한가요?",
                "수면에 방해되지 않는 편안한 침실 환경(빛, 소음 등) 상태는 어떠한가요?",
                "수면의 질이 다음 날 컨디션에 미치는 긍정적 영향은 어떠한가요?"
            };

            for(int i = 0; i < questions.length; i++) { 
                String qName = "q" + (i + 1); 
        %>
        <div class="question-box">
            <div class="question-title"><%= (i + 1) %>. <%= questions[i] %></div>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="radio" name="<%= qName %>" value="1" required> 나쁨
                </label>
                <label class="radio-label">
                    <input type="radio" name="<%= qName %>" value="2"> 중간
                </label>
                <label class="radio-label">
                    <input type="radio" name="<%= qName %>" value="3"> 좋음
                </label>
            </div>
        </div>
        <% } %>

        <button type="submit" class="submit-btn">결과 확인하기</button>
    </form>

</body>
</html>