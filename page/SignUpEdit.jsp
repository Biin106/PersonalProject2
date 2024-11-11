<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%--@ include file="/template/Config.jsp" --%>
<jsp:include page="/template/Config.jsp" />
<title>SignUpEdit.jsp</title>
</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<jsp:include page="/template/Header.jsp" />
			<!-- 컨텐츠 시작 -->
			<div class="p-5 bg-success text-white mb-3">
				<h1 style="font-weight: bold;">회원 정보 수정</h1>
			</div>
			<fieldset class="border rounded-3 p-3 text-center">
				<legend class="float-none w-auto px-3" style="font-weight: bold;">수정할 정보를 입력하세요</legend>
				<form class="needs-validation">
					<div class="row justify-content-center">
						<div class="col-md-8">

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-5 d-flex align-items-center justify-content-md-end">
									<label for="username" class="form-label" style="font-weight: bold;">아이디</label>
								</div>
								<div class="col-md-6 mb-3 mt-5">
									<input type="text" class="form-control" id="username" placeholder="아이디 입력" name="username">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="password" class="form-label" style="font-weight: bold;">비밀번호</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<input type="password" class="form-control" id="password" placeholder="비밀번호 입력" name="password">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="passwordConfirm" class="form-label" style="font-weight: bold;">비밀번호 확인</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<input type="password" class="form-control" id="passwordConfirm" placeholder="비밀번호 확인 입력" name="passwordConfirm">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label class="form-label" style="font-weight: bold;">성별</label>
								</div>
								<div class="col-md-6 mb-3 mt-2 d-flex align-items-center">
									<div class="form-check form-check-inline mb-2 mt-3">
										<input type="radio" class="form-check-input" id="radio1" name="gender" value="option1">
										<label class="form-check-label" for="radio1">남자</label>
									</div>
									<div class="form-check form-check-inline mb-2 mt-3">
										<input type="radio" class="form-check-input" id="radio2" name="gender" value="option2">
										<label class="form-check-label" for="radio2">여자</label>
									</div>
								</div>
							</div>

							<div class="row mb-3 align-items-center">
								<div class="col-md-4 mb-3 mt-4 d-flex align-items-center justify-content-md-end">
									<label class="form-label" style="font-weight: bold">관심사항<br>
										<span style="font-size: 13px; color: gray;">2개 이상 선택하세요</span>
									</label>
								</div>
								<div class="col-md-6 d-flex align-items-center">
									<div class="form-check form-check-inline mb-2 mt-2">
										<input type="checkbox" class="form-check-input" id="interest1" name="interest" value="option1">
										<label class="form-check-label" for="interest1">정치</label>
									</div>
									<div class="form-check form-check-inline mb-2 mt-2">
										<input type="checkbox" class="form-check-input" id="interest2" name="interest" value="option2">
										<label class="form-check-label" for="interest2">경제</label>
									</div>
									<div class="form-check form-check-inline mb-2 mt-2">
										<input type="checkbox" class="form-check-input" id="interest3" name="interest" value="option3">
										<label class="form-check-label" for="interest3">연예</label>
									</div>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="grade" class="form-label" style="font-weight: bold;">학력사항</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<select class="form-select" id="grade" name="grade">
										<option value="">학력을 선택하세요</option>
										<option value="ele">초등학교</option>
										<option value="mid">중학교</option>
										<option value="hig">고등학교</option>
										<option value="uni">대학교</option>
									</select>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
									<label for="self" class="form-label" style="font-weight: bold;">자기소개</label>
								</div>
								<div class="col-md-6 mb-3 mt-3">
									<textarea class="form-control" rows="5" id="self" name="self"></textarea>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-12">
									<button type="submit" class="btn btn-dark">확인</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</fieldset>
			<!-- 컨텐츠 끝 -->
			<jsp:include page="/template/Footer.jsp" />
		</div>
		<!-- container-fluid -->
	</div>
	<!--container  -->
</body>
</html>
