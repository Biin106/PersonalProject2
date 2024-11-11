<%@page import="model.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.bbs.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  로그인 여부 판단:필터 사용시 아래 주석처리 -->
<%-- <jsp:include page="/common/IsUser.jsp" />--%>
<%
//검색과 관련된 파라미터 받기
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
Map<String, String> map = new HashMap<>();
String linkUrl = request.getContextPath() + "/YoonSeongBinProj2/bbspage/BbsList.jsp?";
String searchQuery = "";
if (searchColumn != null && searchWord != null && !searchWord.isEmpty()) {
	map.put("searchColumn", searchColumn);
	map.put("searchWord", searchWord);
	searchQuery = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
	linkUrl += searchQuery;
}
//전체 글 목록 가져오기	
BbsDAO dao = new BbsDAO(application);


map.put(PagingUtil.PAGE_SIZE, this.getInitParameter("PAGE-SIZE"));
map.put(PagingUtil.BLOCK_PAGE, this.getInitParameter("BLOCK-PAGE"));
PagingUtil.setMapForPaging(map, dao, request);
int totalRecordCount = Integer.parseInt(map.get(PagingUtil.TOTAL_RECORD_COUNT));
int pageSize = Integer.parseInt(map.get(PagingUtil.PAGE_SIZE));
int blockPage = Integer.parseInt(map.get(PagingUtil.BLOCK_PAGE));
int nowPage = Integer.parseInt(map.get(PagingUtil.NOWPAGE));
//페이징을 위한 로직 끝
List<BbsDTO> items = dao.findAll(map);

dao.close();
%>


<!DOCTYPE html>
<html>
<head>
<%--@ include file="/template/Config.jsp" --%>
<jsp:include page="/template/Config.jsp" />
<title>BbsList.jsp</title>

</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<%--@ include file="/template/Header.jsp" --%>
			<jsp:include page="/template/Header.jsp" />

			<!-- 컨텐츠 시작 -->
			<div class="p-5 bg-success text-white mb-3">
				<h1 style="font-weight: bold;">게시판 목록</h1>
			</div>
			<div class="my-2 text-end">
			 <% String username = (String) session.getAttribute("username");
                   String token = (String) session.getAttribute("token");
                   if (username != null && token != null) { %>
				<a href="BbsWrite.jsp" class="btn btn-danger">게시글 등록</a>
				 <% } else {} %>
				  
			</div>
			<table class="table table-hover text-center">
				<thead class="table-dark">
					<tr>
						<th class="col-1">번호</th>
						<th class="col-auto">제목</th>
						<th class="col-2">작성자</th>
						<th class="col-1">조회수</th>
						<th class="col-2">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (items.isEmpty()) {
					%>
					<tr>
						<td colspan="5">등록된 글이 없습니다.</td>
					</tr>
					<%
					} else {
					int loop = 0;
					for (BbsDTO item : items) {
					%>
					<tr>
						<td><%=totalRecordCount - (((nowPage - 1) * pageSize) + loop)%></td>
						<td class="text-start"><a
							href="BbsView.jsp?id=<%=item.getId() + "&" + PagingUtil.NOWPAGE + "=" + nowPage + "&" + searchQuery + PagingUtil.PAGE_SIZE + "="
		+ pageSize%>"><%=item.getTitle()%></a></td>
						<td><%=item.getUsername()%></td>
						<td><%=item.getHitCount()%></td>
						<td><%=item.getPostDate()%></td>
					</tr>
					<%
					loop++;
					}
					}
					%>
				</tbody>
			</table>
			<!-- 페이징 출력 -->
			<%=PagingUtil.pagingBootStrapStyle(totalRecordCount, pageSize, blockPage, nowPage, linkUrl)%>
			<!-- 검색 UI -->

			<form method="post" class="row justify-content-center">

				<div class="col-2">
					<select class="form-control" name="searchColumn">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="username"> 작성자</option>
					</select>
				</div>
				<div class="col-5">
					<input type="text" class="form-control mx-2"
						placeholder="검색어를 입력하세요" name="searchWord" />
				</div>
				<div class="col-auto">
					<button type="submit" class="btn btn-primary">검색</button>
				</div>

			</form>
			<!-- 컨텐츠 끝 -->
			<jsp:include page="/template/Footer.jsp" />
		</div>
		<!-- container-fluid -->
	</div>
	<!--container  -->
</body>
</html>
