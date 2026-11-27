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

    /// 질문 추가인지 삭제인지 확인
    String action = request.getParameter("action");

    /// 선택된 카테고리
    String category = request.getParameter("category");

    /// 올바른 검사 종류인지 확인
    if (category == null ||
        !(category.equals("mental") ||
          category.equals("body") ||
          category.equals("eating") ||
          category.equals("sleep") ||
          category.equals("health"))) {

        response.sendRedirect("adminQuestion.jsp");
        return;
    }

    /// 알림 메시지
    String message = "";
    
    /// 알림 메세지에 넣을 카테고리 이름
    String categoryName = "";

    switch (category) {
        case "mental":
            categoryName = "심리 상태 검사";
            break;
        case "body":
            categoryName = "신체 건강 검사";
            break;
        case "eating":
            categoryName = "식습관 평가";
            break;
        case "sleep":
            categoryName = "수면 패턴 검사";
            break;
        case "health":
        	categoryName = "종합 건강 검진";
    }

    /// 질문 추가
    if ("add".equals(action)) {

        String question = request.getParameter("question");

        if (question != null && !question.trim().isEmpty()) {
			/// 질문 리스트에 추가
            QuestionManager.addQuestion(category, question);
            message = categoryName + "에 문항이 추가되었습니다.";

        } else {
            message = "질문 내용을 입력해주세요.";
        }
    }

    /// 질문 삭제
    else if ("delete".equals(action)) {

        String indexValue = request.getParameter("index");

        try {
            int index = Integer.parseInt(indexValue);
          	
            /// 질문 리스트에서 해당 질문 삭제
            QuestionManager.removeQuestion(category, index);
            message = categoryName + "에 문항이 삭제되었습니다.";

        } catch (NumberFormatException e) {
            message = "잘못된 요청입니다.";
        }
    }

    /// 처리 후 알림 출력 및 페이지 이동
%>

<script>
    alert("<%= message %>");
    location.href = "adminQuestion.jsp?category=<%= category %>";
</script>

