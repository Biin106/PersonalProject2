<%@ page import="java.sql.Connection" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // InitialContext 객체 생성
    Context ctx = new InitialContext();

    // context.xml에 등록한 네이밍을 lookup하여 DataSource를 얻음
    DataSource source = (DataSource) ctx.lookup("java:comp/env/jdbc/ICTUSER");

    // DataSource의 getConnection() 메소드로 Connection 객체를 가져옴
    Connection conn = source.getConnection();

    String message;
    if (conn != null) {
        message = "<h3>커넥션 풀에서 커넥션 객체 가져오기 성공</h3>";
        // 커넥션 풀에 사용한 커넥션 객체 다시 반납
        conn.close();
    } else {
        message = "<h3>커넥션 풀에서 커넥션 객체 가져오기 실패</h3>";
    }
%>

<!DOCTYPE html>
<html>
<body>
    <div class="container">
        <div class="container-fluid">
            <div class="p-5 bg-warning text-white">
                <h1>커넥션 풀</h1>
            </div>
            <fieldset class="border rounded-3 p-3">
                <legend class="float-none w-auto px-3">Connection Pool</legend>
                <h1 class="display-6"><%= message %></h1>
            </fieldset>
        </div>
    </div>
</body>
</html>