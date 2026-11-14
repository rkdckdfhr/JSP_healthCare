<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 	
	/// 세션 데이터 날리기
	session.invalidate();
	/// 메인페이지로 이동
	response.sendRedirect("mainPage.jsp");
%>