package Servlets;

import java.io.IOException;

import Database.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/addRecord")
public class CreateRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	Database db = Database.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String table = request.getParameter("table");
        if (table == null) {
            return;
        }
        request.setAttribute("errorMessage", "");
        request.setAttribute("table", table);
        request.getRequestDispatcher("views/create_record.jsp").forward(request, response);
    }

    
}