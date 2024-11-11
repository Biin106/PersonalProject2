package controller.signup;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.user.UserDAO;
import model.user.UserDTO;

@WebServlet("/SignUpController")
public class SignUpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");
        String gender = request.getParameter("gender");
        String[] interests = request.getParameterValues("interests");
        String grade = request.getParameter("grade");
        String self = request.getParameter("self");

        // 유효성 검사
        if (username == null || username.trim().isEmpty()) {
            handleError(request, response, "아이디를 입력하세요");
            return;
        }

        if (password == null || password.isEmpty()) {
            handleError(request, response, "비밀번호를 입력하세요");
            return;
        }

        if (!password.equals(passwordConfirm)) {
            handleError(request, response, "비밀번호를 다시 한번 확인해 주세요");
            return;
        }

        if (gender == null || gender.isEmpty()) {
            handleError(request, response, "성별을 선택하세요");
            return;
        }

        if (interests == null || interests.length < 2) {
            handleError(request, response, "관심사항은 2개 이상 선택하세요");
            return;
        }

        if (grade == null || grade.isEmpty()) {
            handleError(request, response, "학력을 선택하세요");
            return;
        }

        if (self == null || self.trim().isEmpty()) {
            handleError(request, response, "자기소개를 입력하세요");
            return;
        }

        // 중복 체크
        UserDAO userDAO = new UserDAO();
        if (userDAO.checkUsernameExists(username)) {
            handleError(request, response, "중복된 아이디가 있습니다. 다른 아이디를 사용해주세요");
            return;
        }

        // 유효성 검사를 모두 통과하면 UserDTO 객체를 생성하고 저장
        UserDTO user = new UserDTO(username, password, passwordConfirm, gender, interests, grade, self);

        if (userDAO.saveUser(user)) {
            // 성공적으로 저장된 경우
        	request.setAttribute("username", username);
            request.getRequestDispatcher("/page/SignUpOk.jsp").forward(request, response);
        } else {
            // 저장 실패한 경우
            handleError(request, response, "회원가입에 실패했습니다. 다시 시도해주세요.");
        }
    }

    // 오류 발생 시 처리 메서드
    private void handleError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("modalMessage", message);
        request.getRequestDispatcher("/page/SignUp.jsp").forward(request, response);
    }
}
