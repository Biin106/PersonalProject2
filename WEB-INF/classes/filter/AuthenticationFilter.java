package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebFilter("/bbspage/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 초기화 코드가 필요 없는 경우 생략
    }

    @Override
    public void doFilter(jakarta.servlet.ServletRequest req, jakarta.servlet.ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

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

        // 토큰이 있으면 로그인 상태로 간주
        if (token != null) {
            chain.doFilter(req, resp); // 요청 계속 처리
        } else {
            // 토큰이 없으면 로그인 페이지로 리다이렉트
            request.setAttribute("errorMsg", "로그인 후 이용하세요");
            request.getRequestDispatcher("/page/Login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        // 필터 종료 시 처리할 코드가 필요 없는 경우 생략
    }
}
