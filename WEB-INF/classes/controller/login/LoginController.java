package controller.login;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // HttpSession을 임포트

import model.user.UserDAO;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 간단한 유효성 검사 (비밀번호 확인은 UserDAO에서 처리)
        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            handleError(request, response, "아이디와 비밀번호를 모두 입력하세요");
            return;
        }

        UserDAO userDAO = new UserDAO();

        // 아이디와 비밀번호 검증
        if (userDAO.validateUser(username, password)) {
            // 인증 성공 시 토큰 발급
            String token = userDAO.issueToken(username);
            Cookie tokenCookie = new Cookie("token", token);
            tokenCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 설정 (예: 7일)
            response.addCookie(tokenCookie);

            // HttpSession을 이용하여 username을 세션에 저장
            HttpSession session = request.getSession();
            request.getSession().setAttribute("token", token);
            session.setAttribute("token", token);
            session.setAttribute("username", username);

            // 로그인 성공 후 이동할 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/page/LoginOk.jsp");
        } else {
            // 인증 실패 시 에러 메시지 출력
            handleError(request, response, "아이디 또는 비밀번호가 잘못되었습니다");
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/page/Login.jsp").forward(request, response);
    }
}

