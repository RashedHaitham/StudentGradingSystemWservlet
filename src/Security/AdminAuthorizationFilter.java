package Security;

import java.io.IOException;
import jakarta.servlet.Filter; // Corrected import
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/crud")
public class AdminAuthorizationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        if (session != null && "admin".equals(session.getAttribute("role"))) {
            chain.doFilter(request, response); // User is admin, proceed
        } else {
            httpRequest.setAttribute("errorMessage", "Please, login to access that page.");
            request.getRequestDispatcher("views/adminLogin.jsp").forward(request, response);
        }
    }
}
