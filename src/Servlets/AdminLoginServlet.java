package Servlets;

import java.io.IOException;
import java.util.UUID;

import Database.Database;
import Model.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = "/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Database db = Database.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session without creating a new one
        if (session != null && session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
            String password = request.getParameter("password");
            String userIdStr = request.getParameter("user_id");
            request.setAttribute("password", password);
            request.setAttribute("user_id",userIdStr );
            request.getRequestDispatcher("views/admin_dashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "");
            request.getRequestDispatcher("views/adminLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("user_id");
        String password = request.getParameter("password");

        if (!RoleSessionManager.canCreateSession(Role.ADMIN)) {
            request.setAttribute("errorMessage", "Server is currently busy. Please try again later.");
            request.getRequestDispatcher("views/adminLogin.jsp").forward(request, response);
            return;
        }

        if (db.isAdminCredentials(userIdStr, password)) {
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(300);
            session.setAttribute("username", userIdStr);
            session.setAttribute("logged", true);
            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", csrfToken);
            RoleSessionManager.incrementSessionCounter(Role.ADMIN);
            request.setAttribute("password", password);
            request.getRequestDispatcher("views/admin_dashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Wrong credentials, please try again.");
            request.getRequestDispatcher("views/adminLogin.jsp").forward(request, response);
        }
    }
}
