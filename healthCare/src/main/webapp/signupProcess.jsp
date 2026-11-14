<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*,healthCare.Users" %>
<%

	request.setCharacterEncoding("utf-8");

	/// 회원가입 정보 받기
	String id = request.getParameter("userId");
	String password = request.getParameter("password");
	String name = request.getParameter("userName");
	
	/// 기존 유저 리스트 정보 받기
	ArrayList<Users> userList = (ArrayList<Users>)application.getAttribute("userList");
	
	/// 유저 추가
	userList.add(new Users(id,password,name,"user"));
	
	/// 웹 전체에서 사용 가능하도록 데이터 공유
	application.setAttribute("userList", userList);
%>
<script>
    alert("회원가입이 완료되었습니다.");
    location.href = "mainPage.jsp";
</script>