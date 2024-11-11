<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%--@ include file="/template/Config.jsp" --%>
    <jsp:include page="/template/Config.jsp"/>
    <title>LoginOk.jsp</title>
     <script>
        // 클라이언트 측 JavaScript 코드 작성
        var token = '${sessionScope.token}';
        localStorage.setItem('token', token); // 예: 로컬 스토리지에 토큰 저장
    </script>
</head>
<body>
    <div class="container">
        <div class="container-fluid">
            <%--@ include file="/template/Header.jsp" --%>    
            <jsp:include page="/template/Header.jsp"/>        
            
            <!-- 컨텐츠 시작 -->    
            <div class="p-5 bg-success text-white">
                <h1 style="font-weight:bold;">로그인 성공</h1>
            </div>    
            
            <fieldset class="border rounded-3 p-3 text-center mt-3 mb-3">
                <h3 class="display-6" style="font-weight:bold;"  >${sessionScope.username}님 환영합니다!</h3>
                
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h5>상단 메뉴를 통해 이동해주세요</h5>
                    </div>
                </div>
                
               
                
            </fieldset>        
            <!-- 컨텐츠 끝 -->
            
            <%--@ include file="/template/Footer.jsp" --%>
            <jsp:include page="/template/Footer.jsp"/>        
        </div><!-- container-fluid -->
    </div><!-- container -->
    
    <script>
        document.getElementById('boardBtn').addEventListener('click', function() {
            window.location.href = '${pageContext.request.contextPath}/BoardController'; // 게시판 페이지 경로로 변경
        });
    </script>
</body>
</html>


