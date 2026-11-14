<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>건강 복지 관리 솔루션</title>
    <link rel="stylesheet" href="css/mainPage_style.css">
    
</head>

<%-- ArrayList 및 Users 클래스 임포트 --%>
<%@ page import="java.util.*,healthCare.Users" %>

<%
	
	/// 기존 유저 배열 가져오기 (최초 실행 시 NULL)
	ArrayList<Users> userList = (ArrayList<Users>)application.getAttribute("userList");

	/// 최초 실행 시 어드민 계정 생성
	if(userList == null)
	{
		/// 배열 생성
		userList = new ArrayList<Users>();
		
		/// 관리자 계정 추가
		userList.add(new Users("admin","pass","관리자","admin"));	
		
		/// 웹 전체에서 사용 가능하도록 데이터 공유
		application.setAttribute("userList", userList);
		
	}
	
	
	
%>
<body>

<%
	/// 로그인 된 유저 아이디 받기
	Users loginUser = (Users)session.getAttribute("loginUser");

	/// 로그인 상태상태라면
	if(loginUser != null)
	{
		%>
		<!-- 로그인 정보 -->
    		<div class="login-info">
            <span><%= loginUser.getName() %>님</span>
            <a href="myInfo.jsp" class="my-info-btn">내 정보</a>
            <%
            		if(loginUser.getAdminFlag() == "admin")
            		{
            			%>
            			<a href="adminManage.jsp" class="my-info-btn">관리자페이지</a>
            			<%
            		}
            %>
            <a href="logout.jsp" class="my-info-btn">로그아웃</a>
        </div>
		<%
	}
	else
	{
		%>
		<!-- 로그인 버튼 -->
    		<a href="login.jsp" class="login-btn">로그인</a>
		<%
	}
%>
    <!-- 중앙 타이틀 -->
    <div class="header-section">
        <h1>맞춤형 건강 복지 솔루션</h1>
        <p>개별 항목을 검사하거나 종합 검진을 통해 나만의 솔루션을 확인해보세요.</p>
    </div>

    <!-- 검사 항목 박스 및 중앙 버튼 -->
    <div class="test-container">
        
        <a href="check_body.jsp" class="test-box">
            <h2>신체 건강</h2>
            <p>전반적인 신체 활력 점검</p>
        </a>
        
        <a href="check_mental.jsp" class="test-box">
            <h2>심리 상태</h2>
            <p>스트레스 및 멘탈 확인</p>
        </a>
        
        <a href="check_eating.jsp" class="test-box">
            <h2>식습관 평가</h2>
            <p>영양 섭취 패턴 분석</p>
        </a>
        
        <a href="check_sleep.jsp" class="test-box">
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