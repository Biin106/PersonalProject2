<%@page import="model.PagingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="model.bbs.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  로그인 여부 판단:필터 사용시 아래 주석처리 -->
<%-- <jsp:include page="/common/IsUser.jsp" />--%>

<%
	//1]파라미터(키값) 받기
	long id = Long.parseLong(request.getParameter("id"));
	//현재 페이지번호 받기
	 String nowPageParam = request.getParameter(PagingUtil.NOWPAGE);
    int nowPage = (nowPageParam != null && !nowPageParam.isEmpty()) ? Integer.parseInt(nowPageParam) : 1;
	//페이지 사이즈 -삭제용
	 String pageSizeParam = request.getParameter(PagingUtil.PAGE_SIZE);
    int pageSize = (pageSizeParam != null && !pageSizeParam.isEmpty()) ? Integer.parseInt(pageSizeParam) : 10;
	//검색시
	String searchColumn = request.getParameter("searchColumn");
	String searchWord = request.getParameter("searchWord");
	String searchQuery="";
	if( searchColumn !=null && searchWord.length() !=0){		
		searchQuery=String.format("searchColumn=%s&searchWord=%s&", searchColumn,searchWord);
		
	}
	
	//2]CRUD작업용 BBSDao생성
	BbsDAO dao = new BbsDAO(application);
	//이전 페이지명 얻기:List.jsp에서 뷰로 올때만 조회수 증가 하기 위함
	//물론 파라미터 전달로 판단해도 됨.
	
	String referer=request.getHeader("referer");
	//System.out.println("이전 페이지:"+referer);//http://localhost:8080/JspNServletProj/bbs08/List.jsp
	String prevPage = referer.substring(referer.lastIndexOf("/")+1);
	//레코드 하나 가져오기
	BbsDTO item= dao.findById(String.valueOf(id),prevPage);	
	if(item==null){
		out.println("<script>");
		out.println("alert('유효하지 않는 글 번호입니다');");
		out.println("history.back();");
		out.println("</script>");
		dao.close();
		return;
		
	}
	//내용 줄바꿈 처리
	item.setContent(item.getContent().replace("\r\n", "<br/>"));
	//이전글/다음글 조회
	Map<String,BbsDTO> map= dao.prevNext(String.valueOf(id));	
	dao.close();
	
	
	
%>

<%
    // 쿠키에서 토큰 가져오기
    Cookie[] cookies = request.getCookies();
    String token = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
    }

    // 세션에서 사용자 이름 가져오기
    String username = (String) session.getAttribute("username");

    // 토큰 유효성 검사
    boolean isValidToken = false;
    if (username != null && token != null) {
        model.user.UserDAO userDAO = new model.user.UserDAO();
        isValidToken = userDAO.validateToken(username, token);
        
        if (!isValidToken) {
            // 토큰이 유효하지 않다면 세션 무효화 및 쿠키 삭제
            session.invalidate();
            Cookie tokenCookie = new Cookie("token", null);
            tokenCookie.setMaxAge(0);
            response.addCookie(tokenCookie);
            username = null; // 비로그인 상태로 설정
        }
    } else {
        // 사용자 이름이나 토큰이 없으면 비로그인 상태로 처리
        username = null;
    }
%>

<!DOCTYPE html>
<html>
<head>
<%--@ include file="/template/Config.jsp" --%>
<jsp:include page="/template/Config.jsp" />
<title>BbsView.jsp</title>
<style>
th.bg-dark.text-white {
	text-align: center;
}
</style>
<script>
    function isDelete(){
        var pageSize = "<%=pageSize %>";
        if(pageSize === null || pageSize === "") {
            pageSize = "10"; // 기본값 설정
        }
        if(confirm("정말로 삭제하시겠습니까?")){
            location.replace("/YoonSeongBinProj2/bbspage/BbsDelete.jsp?id=<%=item.getId()%>&<%=PagingUtil.NOWPAGE %>=<%=nowPage%>&<%=PagingUtil.PAGE_SIZE %>=" + pageSize);
        }
    }
</script>
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<%--@ include file="/template/Header.jsp" --%>
			<jsp:include page="/template/Header.jsp" />

			<!-- 컨텐츠 시작 -->
			<div class="p-5 bg-success text-white">
				<h1 style="font-weight:bold">작성글 상세 보기</h1>
			</div>
			<fieldset class="border rounded-3 p-3 text-center mt-2">
			<table class="table table-hover">
				<tbody>
					<tr >
						<th class="bg-dark w-25 text-white" >번호</th>
						<td><%=item.getId() %></td>
					</tr>
					<tr>
						<th class="bg-dark w-25 text-white">작성자</th>
						<td><%=item.getUsername() %></td>
					</tr>
					<tr>
						<th class="bg-dark w-25 text-white">작성일</th>
						<td><%=item.getPostDate() %></td>
					</tr>
					<tr>
						<th class="bg-dark w-25 text-white">조회수</th>
						<td><%=item.getHitCount() %></td>
					</tr>
					<tr>
						<th class="bg-dark w-25 text-white">제목</th>
						<td><%=item.getTitle() %></td>
					</tr>
					<tr>
						<th class="bg-dark text-white" colspan="2">내용</th>
					</tr>
					<tr>
						<td colspan="2"><%=item.getContent()%></td>
					</tr>

				</tbody>
			</table>
			<!-- 이전글/다음글 -->
			<div>
				<table class="table" >
					<tbody>
						
						<tr>
							<td class="text-white bg-dark w-25 text-center" style="font-weight:bold">다음글</td>
							<td>
							 <%=map.get("NEXT") == null ? "다음글이 없습니다" : String.format("<a href='/YoonSeongBinProj2/bbspage/BbsView.jsp?id=%s&%s=%s&%s=%s'>%s</a>",
                        map.get("NEXT").getId(), PagingUtil.NOWPAGE, nowPage, PagingUtil.PAGE_SIZE, pageSize, map.get("NEXT").getTitle()) %>
							</td>
						</tr>
						<tr>
							<td class="text-white bg-dark w-25 text-center" style="font-weight:bold">이전글</td>
							<td>
							 <%=map.get("PREV") == null ? "이전글이 없습니다" : String.format("<a href='/YoonSeongBinProj2/bbspage/BbsView.jsp?id=%s&%s=%s&%s=%s'>%s</a>",
                        map.get("PREV").getId(), PagingUtil.NOWPAGE, nowPage, PagingUtil.PAGE_SIZE, pageSize, map.get("PREV").getTitle()) %>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 수정/삭제/목록 컨트롤 버튼 -->
			<div class="text-center">
				
				 <% if (isValidToken && username != null && username.equals(item.getUsername())) { %>
				<a href="/YoonSeongBinProj2/bbspage/BbsEdit.jsp?id=<%=item.getId() %>&<%=PagingUtil.NOWPAGE+"="+nowPage %>" class="btn btn-success">수정</a> 
				<a href="javascript:isDelete()"	class="btn btn-success" >삭제</a>				
				<a href="/YoonSeongBinProj2/bbspage/BbsList.jsp?<%=PagingUtil.NOWPAGE+"="+nowPage+"&"+searchQuery %>" class="btn btn-success">목록</a>
			 	<% } else { %>
				<a href="/YoonSeongBinProj2/bbspage/BbsList.jsp?<%=PagingUtil.NOWPAGE+"="+nowPage+"&"+searchQuery %>" class="btn btn-success">목록</a>
				<%}%>
			</div>
			</fieldset>
			<!-- 컨텐츠 끝 -->
			<%--@ include file="/template/Footer.jsp" --%>
			<jsp:include page="/template/Footer.jsp" />
		</div>
		<!-- container-fluid -->
	</div>
	<!--container  -->
</body>
</html>
