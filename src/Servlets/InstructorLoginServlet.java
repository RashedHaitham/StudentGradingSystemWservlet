package Servlets;

import java.io.IOException;
import java.util.UUID;

import Database.Database;
import Model.Role;
import Util.Validation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/instructorLogin")
public class InstructorLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Database db = Database.getInstance();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session without creating a new one
        if (session != null && session.getAttribute("logged") != null && (boolean) session.getAttribute("logged")) {
        	
		 	int userId = Integer.parseInt(request.getParameter("user_id"));
   		 	String username =request.getParameter("username");
	        request.setAttribute("username",username);
	        request.setAttribute("user_id",userId);

            request.getRequestDispatcher("views/instructor_dashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "");
            request.getRequestDispatcher("views/instructorLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("user_id");
        String password = request.getParameter("password");
        Role role = Role.INSTRUCTOR;
        
        if (!RoleSessionManager.canCreateSession(Role.INSTRUCTOR)) {
            request.setAttribute("errorMessage", "Server is currently busy. Please try again later.");
            request.getRequestDispatcher("views/instructorLogin.jsp").forward(request, response);
            return;
        }

        String errorMessage = Validation.validateUserInput(role, userIdStr, password);
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("views/instructorLogin.jsp").forward(request, response);
            return;
        }
        HttpSession session = request.getSession(true); // Create a new session or use the existing one
        session.setAttribute("username", userIdStr);
        session.setAttribute("logged", true); // Mark the user as logged in
        int userId = Integer.parseInt(userIdStr);
        
        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        
        RoleSessionManager.incrementSessionCounter(Role.INSTRUCTOR);
        request.setAttribute("user_id", userId);
        request.setAttribute("username", db.getDbUsername(role, userId));
        
       
        request.getRequestDispatcher("views/instructor_dashboard.jsp").forward(request, response);
    }
}
