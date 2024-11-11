<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // 쿠키에서 토큰 가져오기
    String token = null;
	Cookie[] cookies = request.getCookies();
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
    if (username != null && token != null) {
        model.user.UserDAO userDAO = new model.user.UserDAO();
        boolean isValidToken = userDAO.validateToken(username, token);
        
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

<!-- 상단 네비게이션 바 -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/YoonSeongBinProj2/page/Home.jsp"><i class="fa-solid fa-house-chimney"></i></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
            <ul class="navbar-nav">
                <% if (username != null) { %>
                    <!-- 로그인 상태 -->
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/LogoutController"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
                <% } else { %>
                    <!-- 비로그인 상태 -->
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/page/SignUp.jsp"><i class="fa-solid fa-user-plus"></i> 회원가입</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/page/Login.jsp"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
                <% } %>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/bbspage/BbsList.jsp"><i class="fa-solid fa-chess-board"></i> 게시판</a></li>
            </ul>
        </div>
    </div>
</nav>

<script>
    function redirectToLogin() {
        window.location.href = "/YoonSeongBinProj2/page/Login.jsp";
    }
</script>
<!-- 상단 네비게이션바 끝 -->

