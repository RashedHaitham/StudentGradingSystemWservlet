package Servlets;
import java.io.IOException;

import Database.Database;
import Model.Role;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
public class adminFilter implements Filter{
		
    Database db = Database.getInstance();

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
       
        HttpServletRequest httpRequest = (HttpServletRequest) req;
        
        HttpSession session = httpRequest.getSession(false);
        
            // For POST requests, validate CSRF token
            String sessionCsrfToken = (session != null) ? (String) session.getAttribute("csrfToken") : null;
            String requestCsrfToken = req.getParameter("csrfToken");

            if (sessionCsrfToken == null || !sessionCsrfToken.equals(requestCsrfToken)) {
                // CSRF token validation failed, handle error
                httpRequest.setAttribute("errorMessage", "Please, login to access that page.");
                httpRequest.getRequestDispatcher("views/adminLogin.jsp").forward(req, res);
                return;
            }

        
	}

}
