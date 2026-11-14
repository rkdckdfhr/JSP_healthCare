<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
	<link rel="stylesheet" href="css/signup_style.css">
</head>
<%@ page import="java.util.*,healthCare.Users" %>
<%
	/// 기존 유저 리스트 정보 받기
	ArrayList<Users> userList = (ArrayList<Users>)application.getAttribute("userList");
%>
<script type="text/javascript">

	/// 아이디 중복 확인 여부 
	var idCheck = false;	
	
	function checkId()
	{
		/// 회원가입 정보 받기 
		var signupForm = document.signupForm;
		
		/// 아이디 공란 확인
		if (signupForm.userId.value.trim() == "") {
			alert("아이디를 입력하세요.");
			signupForm.userId.select();
			signupForm.userId.focus();
			return false;
		}
		
		/// 아이디 중복 확인 여부 false로 전환
		idCheck = false;	
		<%
			for(Users u : userList)/// for문 시작
			{
				
		%>	
			if (signupForm.userId.value == "<%= u.getId()%>") {
				alert("중복된 아이디 입니다.");
				signupForm.userId.select();
				signupForm.userId.focus();
				return false;
			}
		<%
			}/// for문 끝
		%>
		alert("사용 가능한 아이디입니다.");
		
		/// 아이디 중복 확인 여부 true로 전환
		idCheck = true;	
	    return true;
	}
	
	function checkSignup()
	{
		/// 회원가입 정보 받기 
		var signupForm = document.signupForm;
		
		/// 아이디 중복 확인 체크
		if (!idCheck) {
			alert("아이디 중복 확인을 해주세요.");
		    return false;
		}
		
		/// 이름 공란 확인
		if (	signupForm.userName.value.trim() == "" ) {
			alert("이름을 입력하세요.");
			signupForm.userName.select();
			signupForm.userName.focus();
			return false;
		}
		
		/// 아이디 공란 확인
		if (signupForm.userId.value.trim() == "") {
			alert("아이디를 입력하세요.");
			signupForm.userId.select();
			signupForm.userId.focus();
			return false;
		}
		
		/// 비밀번호 공란 확인
		if (signupForm.password.value.trim() == "") {
			alert("비밀번호를 입력하세요.");
			signupForm.password.select();
			signupForm.password.focus();
			return false;
		}
		
		/// 비밀번호 확인 공란 확인
		if (signupForm.passwordCheck.value.trim() == "") {
			alert("비밀번호 확인을 입력하세요.");
			signupForm.passwordCheck.select();
			signupForm.passwordCheck.focus();
			return false;
		}
		
		/// 비밀번호와 비밀번호 확인이 같은지 확인
		if (signupForm.password.value != signupForm.passwordCheck.value) {
			alert("비밀번호와 비밀번호 확인을 확인해주세요.");
			signupForm.passwordCheck.select();
			signupForm.passwordCheck.focus();
			return false;
		}
		
		signupForm.submit();
		return true;
	}
</script>


<body>

    <div class="container">

        <h1 class="title">건강 증진 프로젝트</h1>

        <div class="signup-box">

            <h2>회원가입</h2>

            <form name="signupForm" action="signupProcess.jsp" method="post">

				<div class="input-group">
                    <label for="userName">이름</label>
                    <input type="text" id="userName" name="userName"
                           placeholder="이름을 입력하세요" required>
                </div>

                <div class="input-group">
				    <label for="userId">아이디</label>
				
				    <div class="id-check-group">
				        <input type="text" id="userId" name="userId"
				               placeholder="아이디를 입력하세요" required
				               oninput="idCheck = false;">
				
				        <button type="button" class="signup-button"
				                onclick="checkId()">
				            중복확인
				        </button>
				    </div>
				</div>

                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password"
                           placeholder="비밀번호를 입력하세요" required>
                </div>
                <div class="input-group">
                    <label for="passwordCheck">비밀번호 확인</label>
                    <input type="password" id="passwordCheck" name="passwordCheck"
                           placeholder="비밀번호를 입력하세요" required>
                </div>

                <button type="button" class="signup-button" onclick="checkSignup()">
                    회원가입
                </button>

            </form>

            <a href="login.jsp" class="login-link">
                이미 계정이 있으신가요? 로그인
            </a>

        </div>

    </div>

</body>
</html>
