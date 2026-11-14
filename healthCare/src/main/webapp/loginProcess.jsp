<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*, healthCare.Users" %>

<%
	
	request.setCharacterEncoding("UTF-8");

	/// 로그인 정보 확인
	String id = request.getParameter("userId");
	String password = request.getParameter("password");

	/// 기존 유저 리스트 정보 받기
	ArrayList<Users> userList = (ArrayList<Users>)application.getAttribute("userList");
	
	/// session으로 저장할 유저 데이터 변수
	Users loginUser = null;

	/// 유저 정보가 있는지 확인
	if(userList != null)
	{
		/// 유저 정보 비교 반복문 실행 
		for(Users u : userList)
		{
			/// 아이디 비번 비교 
			if(u.getId().equals(id) && u.getPasswd().equals(password))
			{
				/// session에 넣을 유저 데이터 저장
				loginUser = u;
				break;
			}
		}
		
	}
	
	/// 유저 정보가 저장됐다면 session 저장해주고 메인페이지로 이동 
	if(loginUser != null) {
        session.setAttribute("loginUser", loginUser);
        response.sendRedirect("mainPage.jsp");
    }
	else
	{
		%>
		<script>
            alert("로그인 실패\n아이디와 비밀번호를 확인해주세요.");
            history.back();
        </script>
		<%
	}
	

	
			
%>