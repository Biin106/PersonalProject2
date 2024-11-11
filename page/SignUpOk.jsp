<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<%--@ include file="/template/Config.jsp" --%>
		<jsp:include page="/template/Config.jsp"/>
		<title>SignUpOk.jsp</title>
	
	</head>
<body>
	<div class="container">
		<div class="container-fluid">
			<%--@ include file="/template/Header.jsp" --%>	
			<jsp:include page="/template/Header.jsp"/>		
			<!-- 컨텐츠 시작 -->	
			<div class="p-5 bg-success text-white">
				<h1 style="font-weight:bold;">회원가입 성공</h1>
			</div>	
			<fieldset class="border rounded-3 p-3 text-center mt-3 mb-3">
				<h1 class="display-6">${username}님 가입이 완료되었습니다!</h1>
				
				
				<div class="row mb-3 mt-4">
								<div class="col-md-12">
									<button type="submit" id="submitBtn" class="btn btn-dark" >로그인</button>
								</div>
							</div>
			</fieldset>		
			<!-- 컨텐츠 끝 -->
			<%--@ include file="/template/Footer.jsp" --%>
			<jsp:include page="/template/Footer.jsp"/>		
		</div><!-- container-fluid -->
	</div><!--container  -->
	
	 <script>
        document.getElementById('submitBtn').addEventListener('click', function() {
            window.location.href = '/YoonSeongBinProj2/page/Login.jsp';
        });
    </script>
    
</body>
</html>
			