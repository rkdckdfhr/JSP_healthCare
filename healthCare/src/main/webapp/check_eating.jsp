<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식습관 평가 - 건강 복지 솔루션</title>
    <!-- 요청하신 CSS 파일 연결 -->
    <link rel="stylesheet" href="css/eating_style.css">
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>식습관 평가</h1>
        <p>각 문항을 읽고 현재 자신의 상태와 가장 잘 맞는 항목을 선택해주세요.</p>
    </div>

    <!-- 결과 처리 페이지로 이동 -->
    <form action="eating_result.jsp" method="post" class="form-container">
        
        <% 
            String[] questions = {
                "하루 3끼 규칙적인 식사 패턴 유지 정도는 어떠한가요?",
                "식사 시 신선한 채소와 과일 섭취량은 어떠한가요?",
                "인스턴트, 패스트푸드 등 가공식품을 적게 먹는 정도는 어떠한가요?",
                "하루 1.5리터 이상의 충분한 수분(물) 섭취량은 어떠한가요?",
                "맵고 짠 자극적인 음식을 피하는 정도는 어떠한가요?",
                "야식이나 불규칙한 간식을 자제하는 정도는 어떠한가요?",
                "식사 시 천천히 꼭꼭 씹어 먹는 습관은 어떠한가요?",
                "단당류(탄산음료, 과자 등) 섭취를 조절하는 정도는 어떠한가요?",
                "자신의 활동량에 알맞은 적정 식사량 조절 정도는 어떠한가요?",
                "평소 소화가 잘 되고 위장 건강이 편안한 정도는 어떠한가요?"
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