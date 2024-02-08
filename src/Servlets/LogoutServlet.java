package Servlets;

import java.io.IOException;

import Model.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session if exists
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        String role = request.getParameter("role");

        if("INSTRUCTOR".equals(role)) {            
            RoleSessionManager.decrementSessionCounter(Role.INSTRUCTOR);
            response.sendRedirect(request.getContextPath() + "/instructorLogin");
        } else if("STUDENT".equals(role)) {
            RoleSessionManager.decrementSessionCounter(Role.STUDENT);
            response.sendRedirect(request.getContextPath() + "/studentLogin");
        } else {
            RoleSessionManager.decrementSessionCounter(Role.ADMIN);
            response.sendRedirect(request.getContextPath() + "/adminLogin");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
