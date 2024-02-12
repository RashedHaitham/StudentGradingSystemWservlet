package Security;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/manage")
public class InstructorAuthorizationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        if (session != null && ("instructor".equals(session.getAttribute("role")) || "student".equals(session.getAttribute("role")))) {
            chain.doFilter(request, response);
        } else {
            httpRequest.setAttribute("errorMessage", "Please, login to access that page.");
            if("instructor".equals(session.getAttribute("role")))
            request.getRequestDispatcher("views/instructorLogin.jsp").forward(request, response);
            else if("student".equals(session.getAttribute("role")))
                request.getRequestDispatcher("views/studentLogin.jsp").forward(request, response);

        }
    }
}
