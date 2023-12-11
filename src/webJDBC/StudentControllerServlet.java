package webJDBC;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

import javax.sql.DataSource;

public class StudentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	private StudentDbUtil studentDbUtil;
	@Resource(name="jdbc/DatabaseApp")
	
	private DataSource dataSource;
	
	@Override
	public void init() throws ServletException {
		super.init();
		
		try {
			studentDbUtil=new StudentDbUtil(dataSource);
		}
		catch(Exception e) {
			throw new ServletException(e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String theCommand=request.getParameter("command");
			if(theCommand==null) {
				theCommand="LIST";
			}
			switch(theCommand) {
			case "LIST":listStudents(request,response);break;
			case "ADD":addStudent(request,response);break;
			case "LOAD":loadStudent(request,response);break;
			case "UPDATE":updateStudent(request,response);break;
			case "DELETE":DeleteStudent(request,response);break;

			default:listStudents(request,response);break;

			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void DeleteStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int id=Integer.parseInt(request.getParameter("studentId"));
		
		studentDbUtil.DeleteStudent(id);
		
		listStudents(request,response);
		
	}

	private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int id=Integer.parseInt(request.getParameter("stdId"));
		String fname=request.getParameter("firstName");
		String lname=request.getParameter("lastName");
		String email=request.getParameter("email");
		
		studentDbUtil.updateStudent(new student(id,fname,lname,email));
		
		listStudents(request,response);
	}

	private void loadStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String id=request.getParameter("studentId");
			student student=studentDbUtil.getStudent(id);
			
			request.setAttribute("THE_STD", student);
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("updateStudent.jsp");
			dispatcher.forward(request, response);
		
	}

	private void addStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fname=request.getParameter("firstName");
		String lname=request.getParameter("lastName");
		String email=request.getParameter("email");
		
		studentDbUtil.addStudent(new student(fname,lname,email));

		listStudents(request,response);
	}

	private void listStudents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<student>stds=studentDbUtil.getStudents();
		request.setAttribute("AllStudents", stds);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("listStudents.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
