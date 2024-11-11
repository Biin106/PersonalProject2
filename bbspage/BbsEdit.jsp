<%@page import="model.PagingUtil"%>
<%@page import="model.bbs.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  로그인 여부 판단:필터 사용시 아래 주석처리 -->
<%-- <jsp:include page="/common/IsUser.jsp" />--%>
<%
    // 파라미터(id) 값이 존재하고 비어있지 않으면 long 형으로 변환, 아니면 기본값 0L 사용
    String idParam = request.getParameter("id");
    long id = (idParam != null && !idParam.isEmpty()) ? Long.parseLong(idParam) : 0L;

    // 현재 페이지번호 받기
    String nowPage = request.getParameter(PagingUtil.NOWPAGE);
    
    // CRUD 작업용 BbsDao 생성
    BbsDAO dao = new BbsDAO(application);
    
    // 레코드 하나 가져오기
    BbsDTO item = dao.findById(String.valueOf(id));

    // DAO 사용 후 리소스 정리
    dao.close();
%>



<!DOCTYPE html>
<html>
<head>
<%--@ include file="/template/Config.jsp" --%>
<jsp:include page="/template/Config.jsp" />
<title>BbsEdit.jsp</title>

</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<%--@ include file="/template/Header.jsp" --%>
			<jsp:include page="/template/Header.jsp" />

			<!-- 컨텐츠 시작 -->
			<div class="p-5 bg-success text-white mb-3">
				<h1 style="font-weight: bold;">회원제 게시판 수정</h1>
			</div>
			<fieldset class="border rounded-3 p-3 text-center">
				<legend class="float-none w-auto px-3" style="font-weight: bold;">수정할
					제목과 내용을 입력하세요</legend>
				<form action="/YoonSeongBinProj2/bbspage/BbsEditOk.jsp" method="post">

					<input type="hidden" name="id" value="<%=id%>" /> <input
						type="hidden" name="<%=PagingUtil.NOWPAGE%>" value="<%=nowPage%>" />

					<div class="row justify-content-center">
						<div class="col-md-8">
							<div class="row mb-3">

								<div class="col-md-4 mb-2 mt-5 d-flex align-items-center justify-content-md-end">
									<label for="title" class="form-label" style="font-weight: bold;">제목</label>
								</div>

								<div class="col-md-6 mb-3 mt-5">
									<input type="text" class="form-control" id="title" placeholder="Enter title" name="title" value="<%=item.getTitle()%>">
								</div>
						</div>
								<div class="row mb-3">
									<div class="col-md-4 mb-2 mt-4 d-flex justify-content-md-end">
										<label for="content" class="form-label" style="font-weight: bold;">내용</label>
									</div>

									<div class="col-md-6 mb-3 mt-3">
										<textarea placeholder="Enter content" class="form-control"
											rows="18" id="content" name="content"><%=item.getContent()%></textarea>
									</div>
								</div>

								<div class="row mb-3">
									<div class="col-md-12">
										<button type="submit" class="btn btn-dark ml-auto" style="padding: 10px 30px;">수정</button>
									</div>
								</div>
							</div>
						
					</div>
				</form>
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
