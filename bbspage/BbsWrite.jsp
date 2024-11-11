<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/template/Config.jsp" />
<title>BbsWrite.jsp</title>
</head>
<body>
    <div class="container">
        <div class="container-fluid">
            <jsp:include page="/template/Header.jsp" />
            <!-- 컨텐츠 시작 -->
            <div class="p-5 bg-success text-white mb-3">
                <h1 style="font-weight: bold;">게시글 등록</h1>
            </div>
            <fieldset class="border rounded-3 p-3 text-center">
                <legend class="float-none w-auto px-3" style="font-weight: bold;">등록할 제목과 내용을 입력하세요</legend>
                <form action="${pageContext.request.contextPath}/WriteController" method="post">
                
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="row mb-3">
                            
                                <div class="col-md-4 mb-2 mt-5 d-flex align-items-center justify-content-md-end">
                                    <label for="title" class="form-label" style="font-weight: bold;">제목</label>
                                </div>
                                
                                <div class="col-md-6 mb-3 mt-5">
                                    <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요" name="title">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-4 mb-2 mt-4 d-flex justify-content-md-end">
                                    <label for="content" class="form-label" style="font-weight: bold;">글 내용</label>
                                </div>
                                <div class="col-md-6 mb-3 mt-3">
                                    <textarea class="form-control" rows="18" id="content" name="content" placeholder="글을 입력하세요"></textarea>
                                </div>
                            </div>
                                
                            <div class="row mb-3">
                                <div class="col-md-12">
                                     <button type="submit" class="btn btn-dark ml-auto" style="padding: 10px 30px;">등록</button>
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
