<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/template/Config.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>SignUp.jsp</title>
</head>
<body>

	<div class="container">
		<div class="container-fluid">
			<jsp:include page="/template/Header.jsp" />

			<!-- 회원가입 양식 시작 -->
			<div class="p-5 bg-success text-white mb-3">
				<h1 style="font-weight: bold;">회원가입</h1>
			</div>

			<fieldset class="border rounded-3 p-3 text-center">
				<legend class="float-none w-auto px-3" style="font-weight: bold;">회원
					가입 정보를 입력하세요</legend>
				<form method="post"
					action="${pageContext.request.contextPath}/SignUpController"
					novalidate>
					<div class="row justify-content-center">
						<div class="col-md-8">

							<!-- 아이디 입력 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-5 d-flex align-items-center justify-content-md-end">
									<label for="username" class="form-label"
										style="font-weight: bold;">아이디</label>
								</div>
								<div class="col-md-6 mb-3 mt-5">
									<input type="text" class="form-control" id="username"
										placeholder="아이디 입력" name="username"
										value="${not empty param.username ? param.username : ''}"
										required>
								</div>
							</div>

							<!-- 비밀번호 입력 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="password" class="form-label"
										style="font-weight: bold;">비밀번호</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<input type="password" class="form-control" id="password"
										placeholder="비밀번호 입력" name="password"
										value="${not empty param.password ? param.password : ''}"
										required>
								</div>
							</div>

							<!-- 비밀번호 확인 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="passwordConfirm" class="form-label"
										style="font-weight: bold;">비밀번호 확인</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<input type="password" class="form-control"
										id="passwordConfirm" placeholder="비밀번호 확인 입력"
										name="passwordConfirm"
										value="${not empty param.passwordConfirm ? param.passwordConfirm : ''}"
										required>
								</div>
							</div>

							<!-- 성별 선택 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label class="form-label" style="font-weight: bold;">성별</label>
								</div>
								<div class="col-md-6 mb-3 mt-2 d-flex align-items-center">
									<div class="form-check form-check-inline mb-2 mt-3">
										<input type="radio" class="form-check-input" id="radio1"
											name="gender" value="남자"
											${param.gender == '남자' ? 'checked' : ''}> <label
											class="form-check-label" for="radio1">남자</label>
									</div>
									<div class="form-check form-check-inline mb-2 mt-3">
										<input type="radio" class="form-check-input" id="radio2"
											name="gender" value="여자"
											${param.gender == '여자' ? 'checked' : ''}> <label
											class="form-check-label" for="radio2">여자</label>
									</div>
								</div>
							</div>

							<!-- 관심사항 선택 -->
						
<%
    String[] interests = request.getParameterValues("interests");
%>

<div class="row mb-3 align-items-center">
    <div class="col-md-4 mb-3 mt-4 d-flex align-items-center justify-content-md-end">
        <label class="form-label" style="font-weight: bold">관심사항<br>
            <span style="font-size: 13px; color: gray;">2개 이상 선택하세요</span>
        </label>
    </div>
    <div class="col-md-6 d-flex align-items-center">
        <div class="form-check form-check-inline mb-2 mt-2">
            <input type="checkbox" class="form-check-input" id="interest1" name="interests" value="정치"
                   <%-- interests 배열이 null이 아니고 '정치'가 포함되어 있으면 checked 속성 추가 --%>
                   <% if (interests != null && Arrays.asList(interests).contains("정치")) {
                       out.print("checked");
                   } %>
            >
            <label class="form-check-label" for="interest1">정치</label>
        </div>
        <div class="form-check form-check-inline mb-2 mt-2">
            <input type="checkbox" class="form-check-input" id="interest2" name="interests" value="경제"
                   <%-- interests 배열이 null이 아니고 '경제'가 포함되어 있으면 checked 속성 추가 --%>
                   <% if (interests != null && Arrays.asList(interests).contains("경제")) {
                       out.print("checked");
                   } %>
            >
            <label class="form-check-label" for="interest2">경제</label>
        </div>
        <div class="form-check form-check-inline mb-2 mt-2">
            <input type="checkbox" class="form-check-input" id="interest3" name="interests" value="연예"
                   <%-- interests 배열이 null이 아니고 '연예'가 포함되어 있으면 checked 속성 추가 --%>
                   <% if (interests != null && Arrays.asList(interests).contains("연예")) {
                       out.print("checked");
                   } %>
            >
            <label class="form-check-label" for="interest3">연예</label>
        </div>
    </div>
</div>




							<!-- 학력 선택 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="grade" class="form-label"
										style="font-weight: bold;">학력사항</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<select class="form-select" id="grade" name="grade">
										<option value="" ${empty param.grade ? 'selected' : ''}>학력을
											선택하세요</option>
										<option value="ele" ${param.grade == 'ele' ? 'selected' : ''}>초등학교</option>
										<option value="mid" ${param.grade == 'mid' ? 'selected' : ''}>중학교</option>
										<option value="high"
											${param.grade == 'high' ? 'selected' : ''}>고등학교</option>
										<option value="uni" ${param.grade == 'uni' ? 'selected' : ''}>대학교</option>
									</select>
								</div>
							</div>
							<!-- 자기소개 입력 -->
							<div class="row mb-3">
								<div
									class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="self" class="form-label" style="font-weight: bold;">자기소개</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<textarea class="form-control" rows="5" id="self" name="self">${not empty param.self ? param.self : ''}</textarea>
								</div>
							</div>

							<!-- 확인 버튼 -->
							<div class="row mb-3">
								<div class="col-md-12">
									<button type="submit" id="submitBtn" class="btn btn-dark">확인</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</fieldset>
			<!-- 회원가입 양식 끝 -->
			<jsp:include page="/template/Footer.jsp" />
		</div>
		<!-- container-fluid -->
	</div>
	<!-- container -->

	<!-- Modal for displaying messages -->
	<div class="modal fade" id="messageModal" tabindex="-1"
		aria-labelledby="messageModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="messageModalLabel" style="font-weight:bold">알림</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" >
					<p id="modalMessage"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-dark"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
	<%-- 서버로부터 받은 메시지를 모달에 표시 --%>
		
	<%if (request.getAttribute("modalMessage") != null) {%>
		$('#modalMessage').text("${modalMessage}");
			$('#messageModal').modal('show');
	<%}%>
		});
		
		
	</script>
	
	


</body>
</html>
