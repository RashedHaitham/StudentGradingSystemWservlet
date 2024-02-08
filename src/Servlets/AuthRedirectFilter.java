package Servlets;
import java.io.IOException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.*;

public class AuthRedirectFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String path = request.getRequestURI();

        // Example of session attribute to check if user is logged in
        Boolean isLoggedIn = (Boolean) request.getSession().getAttribute("isLoggedIn");
        String role = (String) request.getSession().getAttribute("role"); // assuming role is stored in session

        if (isLoggedIn == null || !isLoggedIn) {
            if (path.startsWith("/admin/")) {
                response.sendRedirect("/adminLogin");
                return;
            } else if (path.startsWith("/instructor/")) {
                response.sendRedirect("/instructorLogin");
                return;
            } else if (path.startsWith("/student/")) {
                response.sendRedirect("/studentLogin");
                return;
            }
        } else {
            // If logged in but trying to access a different role's path
            if ((role != null) && !path.startsWith("/" + role + "/")) {
                // Redirect users to their role's base path or login page if they are trying to access another role's path
                response.sendRedirect("/" + role + "Login");
                return;
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
