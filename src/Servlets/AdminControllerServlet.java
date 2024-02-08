package Servlets;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.*;

import Database.Database;
import Util.PasswordHashing;
import jakarta.servlet.http.*;
@WebServlet(urlPatterns = "/crud")
public class AdminControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Database db = Database.getInstance();

    public AdminControllerServlet() {
        super();
    }
		

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		  HttpServletRequest httpRequest = (HttpServletRequest) request;
	        
	      HttpSession session = httpRequest.getSession(false);
		
		 String sessionCsrfToken = (session != null) ? (String) session.getAttribute("csrfToken") : null;
         String requestCsrfToken = request.getParameter("csrfToken");

         if (sessionCsrfToken == null || !sessionCsrfToken.equals(requestCsrfToken)) {
             // CSRF token validation failed, handle error
             httpRequest.setAttribute("errorMessage", "Please, login to access that page.");
             httpRequest.getRequestDispatcher("views/adminLogin.jsp").forward(request, response);
             return;
         }	
		
		try {
			String theCommand=request.getParameter("command");
			if(theCommand==null) {
				theCommand="LIST";
			}
			switch(theCommand) {
			case "LIST":listRecord(request,response);break;
			case "ADD":addRecord(request,response);break;
			case "LOAD":loadRecord(request,response);break;
			case "UPDATE":updateRecord(request,response);break;
			case "DELETE":deleteRecord(request,response);break;

			default:listRecord(request,response);break;

			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void deleteRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id=request.getParameter("Id");
        String table = request.getParameter("table");

		db.deleteRecord(table, id);
		
		listRecord(request,response);
		
	}

	private void updateRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String table = request.getParameter("table");
	    List<String> columns = db.getTableColumns(table);
	    String primaryKeyColumn = columns.get(0);
	    String secondaryKeyColumn = columns.get(1);
	    String name = request.getParameter("name");
	    String idToUpdate = request.getParameter("Id");
	    String newId = request.getParameter("newId");
	    String newUsername = request.getParameter("newUsername");

	    if (!newId.matches("\\d{7}")) {
	        forwardWithError(request, response, table, name, idToUpdate,
	                "Invalid ID format. ID must be a 7-digit numeric value.");
	        return;
	    }
	    if(newId.equals(idToUpdate)) {
		    db.updateRecord(table, secondaryKeyColumn, primaryKeyColumn, idToUpdate, newUsername);
	        response.sendRedirect(request.getContextPath() + "/crud?role=ADMIN&table="+table); // Redirect to prevent double submission
	        return;
	    }
	    if (db.isIdExists(newId, table)) {
	        forwardWithError(request, response, table, name, idToUpdate,
	                "Error: " + newId + " ID already exists. Please enter a different ID.");
	        return;
	    }

	    db.updateRecord(table, secondaryKeyColumn, primaryKeyColumn, idToUpdate, newUsername);
	    boolean isUpdated = db.updateRecord(table, primaryKeyColumn, primaryKeyColumn, idToUpdate, newId);

	    if (isUpdated) {
	        response.sendRedirect(request.getContextPath() + "/crud?role=ADMIN&table="+table); // Redirect to prevent double submission
	    } else {
	        forwardWithError(request, response, table, name, idToUpdate, "No record was found with the specified ID.");
	    }
	}

	private void forwardWithError(HttpServletRequest request, HttpServletResponse response,
	                              String table, String name, String idToUpdate, String errorMessage)
	        throws ServletException, IOException {
	    request.setAttribute("table", table);
	    request.setAttribute("name", name);
	    request.setAttribute("Id", idToUpdate);
	    request.setAttribute("errorMessage", errorMessage);
	    request.getRequestDispatcher("views/update_record.jsp").forward(request, response);
	}


	private void loadRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String id=request.getParameter("Id");
	        String table = request.getParameter("table");
	        String name=request.getParameter("name");
	        request.setAttribute("table", table);
	        request.setAttribute("name", name);
	        request.setAttribute("Id", id);
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("views/update_record.jsp");
			dispatcher.forward(request, response);
		
	}

	private void addRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String table = request.getParameter("table");
        request.setAttribute("table", table);

        List<String> columns = db.getTableColumns(table);
        Map<String, String> inputData = new HashMap<>();
        
        if (!"courses".equals(table)) {
            String userId = request.getParameter("userId");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (!userId.matches("\\d{7}")) {
                request.setAttribute("errorMessage", "Invalid ID format. ID must be a 7-digit numeric value.");
                request.getRequestDispatcher("views/create_record.jsp").forward(request, response);
            }

            if (db.isIdExists(userId, table)) {
                request.setAttribute("errorMessage", "Error: " + columns.get(0) + " already exists. Please enter a different ID.");
                request.getRequestDispatcher("views/create_record.jsp").forward(request, response);
            }

            inputData.put(columns.get(0), userId);
            inputData.put("username", username);
            String hashedPassword = PasswordHashing.hashPassword(password);
            inputData.put("password", hashedPassword);
        }
        
        else {
            String courseId = request.getParameter("courseId");
            String courseName = request.getParameter("course_name");
            if (!courseId.matches("\\d{7}")) {
                request.setAttribute("errorMessage", "Invalid ID format. ID must be a 7-digit numeric value.");
                request.getRequestDispatcher("views/create_record.jsp").forward(request, response);
            }
            if (db.isIdExists(courseId, table)) {
                request.setAttribute("errorMessage", "Error: Course ID already exists. Please enter a different ID.");
                request.getRequestDispatcher("views/create_record.jsp").forward(request, response);
            }
            inputData.put(columns.get(0), courseId);
            inputData.put("course_name", courseName);
        }
        
        boolean isAdded = db.addRecord(table, inputData);

        if (isAdded) {
            request.setAttribute("successMessage", "Record added successfully");
        } else {
            request.setAttribute("errorMessage", "Record wasn't added; an error occurred");
        }
        
        listRecord(request,response);
        
	}

	private void listRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String table = request.getParameter("table");
        request.setAttribute("table", table);
        List<String> headers = db.getTableColumns(table);
        List<String[]> rowsData = db.getTableContent(table);
        request.setAttribute("headers", headers);
        request.setAttribute("rowsData", rowsData);
        request.getRequestDispatcher("views/crud.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
