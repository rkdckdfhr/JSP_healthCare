<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>건강 복지 관리 솔루션</title>
    <style>
        /* 밝은 테마 기본 레이아웃 */
        body {
            background-color: #f4f7f6;
            color: #333333;
            font-family: 'Malgun Gothic', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        /* 우측 상단 로그인 버튼 */
        .login-btn {
            position: absolute;
            top: 30px;
            right: 40px;
            padding: 10px 24px;
            background-color: #ffffff;
            color: #333333;
            text-decoration: none;
            border: 1px solid #cccccc;
            border-radius: 6px;
            font-weight: bold;
            transition: all 0.2s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .login-btn:hover {
            background-color: #4CAF50;
            color: #ffffff;
            border-color: #4CAF50;
        }

        /* 중앙 상단 제목 영역 */
        .header-section {
            margin-bottom: 50px;
            text-align: center;
        }

        .header-section h1 {
            font-size: 2.8rem;
            margin: 0 0 15px 0;
            color: #222222;
        }

        .header-section p {
            font-size: 1.1rem;
            color: #666666;
            margin: 0;
        }

        /* 검사 박스 컨테이너 (중앙 버튼 배치를 위해 relative 적용) */
        .test-container {
            position: relative;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            width: 80%;
            max-width: 1050px;
        }

        /* 개별 검사 박스 */
        .test-box {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 50px 30px;
            text-align: center;
            text-decoration: none;
            color: #333333;
            min-height: 120px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
        }

        .test-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border-color: #4CAF50;
        }

        .test-box h2 {
            margin: 0 0 10px 0;
            font-size: 1.4rem;
            color: #2c3e50;
        }

        .test-box p {
            margin: 0;
            font-size: 0.95rem;
            color: #7f8c8d;
        }

        /* 정중앙 종합 검진 원형 버튼 */
        .center-circle-btn {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* 정확히 정중앙으로 이동 */
            width: 205px;
            height: 205px;
            background-color: #4CAF50;
            color: #ffffff;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.3rem;
            text-align: center;
            box-shadow: 0 6px 15px rgba(76, 175, 80, 0.4);
            border: 4px solid #f4f7f6; /* 배경색과 동일한 테두리로 분리감 부여 */
            z-index: 10;
            transition: transform 0.2s ease, background-color 0.2s ease;
        }

        .center-circle-btn:hover {
            background-color: #45a049;
            transform: translate(-50%, -50%) scale(1.05); /* 커지는 효과 */
        }
        
        .center-circle-btn span {
            font-size: 0.85rem;
            font-weight: normal;
            margin-top: 5px;
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <!-- 로그인 버튼 -->
    <a href="login.jsp" class="login-btn">로그인</a>

    <!-- 중앙 타이틀 -->
    <div class="header-section">
        <h1>맞춤형 건강 복지 솔루션</h1>
        <p>개별 항목을 검사하거나 종합 검진을 통해 나만의 솔루션을 확인해보세요.</p>
    </div>

    <!-- 검사 항목 박스 및 중앙 버튼 -->
    <div class="test-container">
        
        <a href="checkup_physical.jsp" class="test-box">
            <h2>신체 건강</h2>
            <p>전반적인 신체 활력 점검</p>
        </a>
        
        <a href="checkup_mental.jsp" class="test-box">
            <h2>심리 상태</h2>
            <p>스트레스 및 멘탈 확인</p>
        </a>
        
        <a href="checkup_diet.jsp" class="test-box">
            <h2>식습관 평가</h2>
            <p>영양 섭취 패턴 분석</p>
        </a>
        
        <a href="checkup_sleep.jsp" class="test-box">
            <h2>수면 패턴</h2>
            <p>수면의 질과 규칙성 진단</p>
        </a>

        <!-- 정중앙 원형 버튼 (z-index로 4개 박스 위에 띄움) -->
        <a href="checkup_comprehensive.jsp" class="center-circle-btn">
            종합 검진
            <span>Start All</span>
        </a>
        
    </div>

</body>
</html>