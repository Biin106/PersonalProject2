package controller.bbs;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bbs.BbsDAO;
import model.bbs.BbsDTO;

@WebServlet("/WriteController")
public class WriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String token = (String) session.getAttribute("token");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 사용자 아이디가 없으면 로그인 페이지로 이동
        if (username == null || username.isEmpty() || token == null || token.isEmpty()) {
            response.sendRedirect("/YoonSeongBinProj2/page/Login.jsp");
        } else {
            // 제목과 내용을 파라미터에서 가져오기
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // 제목이나 내용이 비어있는 경우
            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                out.println("<script>");
                out.println("alert('제목과 내용을 입력해주세요.');");
                out.println("history.back();"); // 이전 페이지로 돌아가기
                out.println("</script>");
            } else {
                // 게시글 등록 로직
                ServletContext application = getServletContext();
                BbsDTO item = new BbsDTO();
                item.setContent(content);
                item.setTitle(title);
                item.setUsername(username);
                
              
                
                BbsDAO dao = new BbsDAO(application);
                int affected = dao.insert(item);
                dao.close();

                if (affected > 0) {
                    out.println("<script>");
                    out.println("alert('게시글 등록이 완료되었습니다');");
                    out.println("location.href='/YoonSeongBinProj2/bbspage/BbsList.jsp';"); // 게시글 목록 페이지로 이동
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('게시글 등록에 실패하였습니다. 다시 시도해주세요');");
                    out.println("history.back();"); // 이전 페이지로 돌아가기
                    out.println("</script>");
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}



