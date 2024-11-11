<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.PagingUtil"%>
<%@page import="model.bbs.BbsDTO"%>
<%@page import="model.bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Delete.jsp -->
<!--  로그인 여부 판단:필터 사용시 아래 주석처리 -->
<%-- <jsp:include page="/common/IsUser.jsp" />--%>
<%
	
	//1]파라미터(키값) 받기	
	long id = Long.parseLong(request.getParameter("id"));
	//현재 페이지번호 받기
	int nowPage = request.getParameter(PagingUtil.NOWPAGE) == null ? 1 : Integer.parseInt(request.getParameter(PagingUtil.NOWPAGE));
	//페이지 사이즈 -삭제용
	int pageSize = request.getParameter(PagingUtil.PAGE_SIZE) == null ? 10 : Integer.parseInt(request.getParameter(PagingUtil.PAGE_SIZE));
	
	
	//2]CRUD작업용 BbsDao생성
	BbsDAO dao = new BbsDAO(application);	
	BbsDTO dto = new BbsDTO();
	dto.setId(id);
	int affected=dao.delete(dto);
	//삭제후에 총 페이지수를 구한다
	int totalRecordCount = dao.getTotalRecordCount(null);//검색시도 적용시는 받드시 맵을 전달
	
	int totalPage=(int)Math.ceil((double)totalRecordCount/pageSize);
	dao.close();
	if(totalPage < nowPage) nowPage=totalPage;
	
	
	if(affected==1){
		response.sendRedirect("/YoonSeongBinProj2/bbspage/BbsList.jsp?"+PagingUtil.NOWPAGE+"="+nowPage);
	}
	else{
		out.println("<script>");
		out.println("alert('삭제 실패했어요');");
		out.println("history.back();");
		out.println("</script>");
	}

%>
