<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <%-- 필요한 스타일시트 및 스크립트 포함 --%>
    <jsp:include page="/template/Config.jsp" />
    <title>Login</title>
     <script>
        document.addEventListener('DOMContentLoaded', function() {
            var errorMsg = '<%= request.getAttribute("errorMsg") %>';
            if (errorMsg && errorMsg !== 'null') {
                alert(errorMsg);
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="container-fluid">
            <%-- 헤더 포함 --%>
            <jsp:include page="/template/Header.jsp" />

            <%-- 로그인 폼 시작 --%>
            <div class="p-5 bg-success text-white">
                <h1 style="font-weight: bold;">로그인</h1>
            </div>
            <fieldset class="border rounded-3 p-3 text-center mt-3 mb-3">
                <legend class="float-none w-auto px-3" style="font-weight: bold;">로그인 정보를 입력하세요</legend>
                <form class="needs-validation" action="${pageContext.request.contextPath}/LoginController" method="post">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <%-- 아이디 입력 --%>
                            <div class="row mb-3">
                                <div class="col-md-4 mb-2 mt-5 d-flex align-items-center justify-content-md-end">
                                    <label for="username" class="form-label" style="font-weight: bold;">아이디</label>
                                </div>
                                <div class="col-md-6 mb-3 mt-5">
                                    <input type="text" class="form-control" id="username" placeholder="아이디 입력" name="username" value="${param.username}">
                                </div>
                            </div>

                            <%-- 비밀번호 입력 --%>
                            <div class="row mb-3">
                                <div class="col-md-4 mb-2 mt-3 d-flex align-items-center justify-content-md-end">
                                    <label for="password" class="form-label" style="font-weight: bold;">비밀번호</label>
                                </div>
                                <div class="col-md-6 mb-3 mt-3">
                                    <input type="password" class="form-control" id="password" placeholder="비밀번호 입력" name="password">
                                </div>
                            </div>

                            <%-- 로그인 버튼 --%>
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <button type="submit" class="btn btn-dark">로그인</button>
                                </div>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <%-- 에러 메시지 출력 --%>
                                <div class="row mb-3">
                                    <div class="col-md-12 d-flex justify-content-center">
                                        <div class="alert alert-danger" style="max-width: 50%; padding: 20px;">
                                            ${errorMessage}
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </form>
            </fieldset>
            <%-- 로그인 폼 끝 --%>

            <%-- 푸터 포함 --%>
            <jsp:include page="/template/Footer.jsp" />
        </div>
        <%-- container-fluid --%>
    </div>
    <%-- container --%>
</body>
</html>

