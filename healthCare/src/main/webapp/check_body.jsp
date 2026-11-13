<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신체 건강 검사 - 건강 복지 솔루션</title>
    <!-- 요청하신 CSS 파일 연결 -->
    <link rel="stylesheet" href="css/body_style.css">
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>신체 건강 검사</h1>
        <p>각 문항을 읽고 현재 자신의 상태와 가장 잘 맞는 항목을 선택해주세요.</p>
    </div>

    <!-- 결과 처리 페이지로 이동 -->
    <form action="body_result.jsp" method="post" class="form-container">
        
        <% 
            String[] questions = {
                "현재 느끼는 전반적인 체력 상태는 어떠한가요?",
                "평소 몸의 가벼움과 활력 정도는 어떠한가요?",
                "규칙적인 운동(주 3회 이상) 실천 정도는 어떠한가요?",
                "목, 어깨, 허리 등 관절이나 근육의 편안함 정도는 어떠한가요?",
                "계단을 오르거나 가벼운 달리기 시 심폐 지구력 상태는 어떠한가요?",
                "평소 면역력(잔병치레가 없는 정도) 상태는 어떠한가요?",
                "충분한 휴식 후 신체 컨디션 회복력은 어떠한가요?",
                "일상적인 활동을 할 때 느끼는 근력 상태는 어떠한가요?",
                "평소 앉거나 걸을 때 올바른 자세를 유지하는 정도는 어떠한가요?",
                "신체적인 건강이 현재 삶의 질에 미치는 긍정적 영향은 어떠한가요?"
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