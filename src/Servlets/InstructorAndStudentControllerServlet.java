package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import Database.Database;
import Model.Role;
import Model.StudentGrades;

/**
 * Servlet implementation class InstructorControllerServlet
 */
@WebServlet(urlPatterns = "/manage")
public class InstructorAndStudentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Database db = Database.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  HttpServletRequest httpRequest = (HttpServletRequest) request;
        
	      HttpSession session = httpRequest.getSession(false);
		
		 String sessionCsrfToken = (session != null) ? (String) session.getAttribute("csrfToken") : null;
         String requestCsrfToken = request.getParameter("csrfToken");
         
	     Role role = Role.INSTRUCTOR;	        

       if (sessionCsrfToken == null || !sessionCsrfToken.equals(requestCsrfToken)) {
           // CSRF token validation failed, handle error
           httpRequest.setAttribute("errorMessage", "Please, login to access that page.");
           if(role==Role.INSTRUCTOR)
           httpRequest.getRequestDispatcher("views/instructorLogin.jsp").forward(request, response);
               
           return;
       }	
       session.setAttribute("csrfToken", requestCsrfToken);

		try {
			String theCommand=request.getParameter("command");
			if(theCommand==null) {
				theCommand="LIST";
			}
			switch(theCommand) {
			case "LIST":listRecord(request,response);break;
			case "LOAD":loadRecord(request,response);break;
			case "ANALYSIS":AnalysisRecord(request,response);break;
			case "GRADE":GradeStudent(request,response);break;
			case "LOADC":LoadCourse(request,response);break;
			case "ENROLL":EnrollCourse(request,response);break;

			default:listRecord(request,response);break;

			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	
	private void EnrollCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("user_id"));
        request.setAttribute("user_id", userId);
        String courseId = request.getParameter("course_id");
        String roleParameter = request.getParameter("role");
        Role role = Role.STUDENT;
        request.setAttribute("role", role);

        if ("INSTRUCTOR".equals(roleParameter)) {
            role = Role.INSTRUCTOR;
            request.setAttribute("role", role);

        }
        request.setAttribute("username", db.getDbUsername(role, userId));

        String tableName = role == Role.STUDENT ? "student_course" : "instructor_course";
        boolean isEnrolled = db.enrollCourse(userId, role, tableName, courseId);
        Map<Integer, String> availableCourses = db.getAvailableCourses(userId, role); // Add this line
        request.setAttribute("availableCourses", availableCourses); // And this line
        if (isEnrolled) {
            request.setAttribute("message", "Successfully enrolled in the course!");
        } else {
            request.setAttribute("errorMessage", "Failed to enroll/assign the course. Make sure the course exists.");
        }
        request.getRequestDispatcher("views/enroll_course.jsp").forward(request, response);		
	}


	private void LoadCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int userId = Integer.parseInt(request.getParameter("user_id"));
	        String roleParameter = request.getParameter("role");
	        Role role = Role.STUDENT;
	        if ("INSTRUCTOR".equals(roleParameter)) {
	            role = Role.INSTRUCTOR;
	        }
	        Map<Integer, String> availableCourses = db.getAvailableCourses(userId, role);
	        request.setAttribute("user_id", userId);
	        request.setAttribute("username", db.getDbUsername(role, userId));
	        request.setAttribute("role", role);
	        request.setAttribute("availableCourses", availableCourses);
	        request.getRequestDispatcher("views/enroll_course.jsp").forward(request, response);
	}


	private void GradeStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	int courseId = Integer.parseInt(request.getParameter("course_id"));
	        int studentId = Integer.parseInt(request.getParameter("student_id"));
	        float grade = Float.parseFloat(request.getParameter("grade"));
	        int userId = Integer.parseInt(request.getParameter("user_id"));
	        request.setAttribute("user_id", userId);
	        request.setAttribute("role", Role.INSTRUCTOR);

	        boolean gradeExists = db.gradeExistsForStudent(studentId, courseId);
	        String feedbackMessage = "";
	        boolean success = false;
	       
	            if (!gradeExists) { //add
	                success = db.addOrUpdateStudentGrade(courseId, studentId, grade, "Add");
	                feedbackMessage = success ? "Grade added successfully!" : "Error adding grade. Please try again.";
	            } else {
		            success = db.addOrUpdateStudentGrade(courseId, studentId, grade, "Update");
		            feedbackMessage = success ? "Grade updated successfully!" : "Error updating grade. Please try again.";	     
		            }
	        
	        request.setAttribute("feedbackMessage", feedbackMessage);
	        request.setAttribute("success", success);
	        request.setAttribute("course_id", courseId);
	        request.setAttribute("student_id", studentId);
	        listRecord(request,response);	
	        }


	private void AnalysisRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        
	        int courseId = Integer.parseInt(request.getParameter("courseId"));
			 int userId = Integer.parseInt(request.getParameter("user_id"));
			 String courseName = request.getParameter("courseName");
			 
		        request.setAttribute("courseName", courseName);
		        request.setAttribute("user_id", userId);
		        request.setAttribute("role", Role.INSTRUCTOR);
		        request.setAttribute("course_id", courseId);
		        
		        List<Float> grades = db.getGradesByCourse(courseId);
		        double average = db.getAverage(grades);
		        float median = db.getMedian(grades);
		        float highest = db.getHighestGrade(grades);
		        float lowest = db.getLowestGrade(grades);
		        
		        request.setAttribute("average", average);
		        request.setAttribute("median", median);
		        request.setAttribute("highest", highest);
		        request.setAttribute("lowest", lowest);


	        request.setAttribute("studentsCount", db.getStudentCountForCourses());
	        request.getRequestDispatcher("views/grade_analysis.jsp").forward(request, response);		
	}


	private void loadRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int courseId = Integer.parseInt(request.getParameter("courseId"));
		 int userId = Integer.parseInt(request.getParameter("user_id"));
		 String courseName = request.getParameter("courseName");
	        request.setAttribute("courseName", courseName);
	        request.setAttribute("user_id", userId);


	        Role role = Role.valueOf(request.getParameter("role"));
	        request.setAttribute("username", db.getDbUsername(role, userId));
	        request.setAttribute("stds", db.getAllStudentsForCourse(courseId));
	        request.setAttribute("course_id", courseId);
	        forwardTo(request, response, "/views/grade_student.jsp");
		
	}


	private void listRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	int userId = Integer.parseInt(request.getParameter("user_id"));
	        Role role = Role.valueOf(request.getParameter("role"));	        
	        
	        request.setAttribute("username", db.getDbUsername(role, userId));
	        request.setAttribute("user_id", userId);

	        Map<Integer, String> courses = db.viewCourses(userId, role);
	        request.setAttribute("courses", courses);
	        // if it is instructor get the student count for each course
	        if (role == Role.INSTRUCTOR) {
	           Map<Integer, Integer> studentsCount = db.getStudentCountForCourses();
	            request.setAttribute("studentsCount", studentsCount);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("views/view_course.jsp");
		        dispatcher.forward(request, response);
	        }     
	        else {
	            StudentGrades studentGrades = db.viewGrades(userId);
	            request.setAttribute("username", db.getDbUsername(role, userId));
	            request.setAttribute("studentGrades", studentGrades);
	        	 RequestDispatcher dispatcher = request.getRequestDispatcher("views/view_courses_student.jsp");
	 	        dispatcher.forward(request, response);
	        }
	}
	    private void forwardTo(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
	        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
	        dispatcher.forward(request, response);
	    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
