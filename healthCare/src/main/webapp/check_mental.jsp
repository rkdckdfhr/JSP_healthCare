<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심리 상태 검사 - 건강 복지 솔루션</title>
    
    <!-- CSS 파일 연결 -->
    <link rel="stylesheet" href="css/mental_style.css">
    
</head>
<body>

    <a href="mainPage.jsp" class="back-btn">메인으로</a>

    <div class="header-section">
        <h1>심리 상태 검사</h1>
        <p>각 문항을 읽고 현재 자신의 상태와 가장 잘 맞는 항목을 선택해주세요.</p>
    </div>

    <form action="mental_result.jsp" method="post" class="form-container">
        
        <% 
        /// 문항 생성 ( 10문항 )
            String[] questions = {
                "최근 2주 동안 우울하거나 슬픈 감정을 자주 느꼈나요?",
                "평소 스트레스를 해소할 만한 취미나 여가 활동이 있나요?",
                "일상생활에서 불안감이나 초조함을 느끼는 빈도는 어떠한가요?",
                "자신의 삶과 현재 상황에 대한 전반적인 만족도는 어떠한가요?",
                "주변 사람(가족, 친구, 동료)들과의 대인관계가 원만한가요?",
                "최근 들어 집중력이 떨어지거나 기억력이 저하되었다고 느끼시나요?",
                "아침에 일어났을 때 하루를 시작하는 기분이나 활력은 어떠한가요?",
                "스스로 감정 기복을 조절하거나 화를 다스리는 데 어려움이 있나요?",
                "어려운 일이 닥쳤을 때 긍정적으로 대처할 수 있는 자신감이 있나요?",
                "미래에 대한 불안감이나 걱정이 일상생활에 지장을 주나요?"
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