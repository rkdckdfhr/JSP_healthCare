<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="healthCare.Users, healthCare.QuestionManager" %>

<%
    request.setCharacterEncoding("UTF-8");

    /// 관리자 권한 확인
    Users loginUser = (Users)session.getAttribute("loginUser");

    /// 관리자 권한이 없다면 main페이지로 이동
    if (loginUser == null || !"admin".equals(loginUser.getAdminFlag())) {
        response.sendRedirect("mainPage.jsp");
        return;
    }

    /// 질문 추가인지 삭제인지 확인하는 변수
    String action = request.getParameter("action");
    
    /// 선택 된 카테고리 변수
    String category = request.getParameter("category");

    /// 올바른 검사 종류인지 확인
    if (category == null ||
        !(category.equals("mental") ||
          category.equals("body") ||
          category.equals("eating") ||
          category.equals("sleep"))) {

        response.sendRedirect("adminQuestion.jsp");
        return;
    }

    /// 질문 추가
    if ("add".equals(action)) {

    		/// 추가된 질문 받아오기
        String question = request.getParameter("question");
		
    		/// 질문 리스트에 추가
        if (question != null && !question.trim().isEmpty()) {
            QuestionManager.addQuestion(category, question);
        }

    }

    /// 질문 삭제
    else if ("delete".equals(action)) {
		
    		/// 질문 인덱스 받아오기
        String indexValue = request.getParameter("index");

        try {
        		/// 받아온 인덱스 정수형으로 변환
            int index = Integer.parseInt(indexValue);
			
        		/// 질문 리스트에서 해당 질문 삭제
            QuestionManager.removeQuestion(category, index);

        } 
      	/// 잘못된 인덱스 값이면 아무 작업도 하지 않음
        catch (NumberFormatException e) { }

    }

    /// 처리 후 기존 검사 종류 페이지로 이동
    response.sendRedirect("adminQuestion.jsp?category=" + category);
    return;
%>