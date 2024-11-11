<%@page import="model.PagingUtil"%>
<%@page import="model.bbs.BbsDAO"%>
<%@page import="model.bbs.BbsDTO"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- EditOk.jsp -->
<!--  로그인 여부 판단:필터 사용시 아래 주석처리 -->
<%-- <jsp:include page="/common/IsUser.jsp" />--%>
<%
	//POST방식일때 한글 깨지는 거 처리용(톰캣 10버전은 안깨짐)
	//request.setCharacterEncoding("UTF-8");

	//파라미터 받기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	long id = Long.parseLong(request.getParameter("id"));	
	//현재 페이지번호 받기
	String nowPage = request.getParameter(PagingUtil.NOWPAGE);
	//데이타를 전달할 DTO객체 생성및 데이타 설정
	BbsDTO item = new BbsDTO();
	item.setContent(content);
	item.setTitle(title);
	item.setId(id);
	//CRUD작업용 DAO계열 객체 생성
	BbsDAO dao = new BbsDAO(application);
	int affected=dao.update(item);
	dao.close();
	
	if(affected==1) response.sendRedirect("/YoonSeongBinProj2/bbspage/BbsView.jsp?id="+id+"&"+PagingUtil.NOWPAGE+"="+nowPage);
	else{
		out.println("<script>");
		out.println("alert('수정 실패했어요');");
		out.println("history.back();");
		out.println("</script>");
	}
	
%>