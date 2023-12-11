package webJDBC;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.sql.DataSource;

public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Resource(name="jdbc/DatabaseApp")
	private DataSource dataSource;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/plain");
		
		Connection Myconnection=null;
		Statement Mystatement;
		ResultSet myResult=null;
		
		try {
			Myconnection=dataSource.getConnection();
			String sql="select * from student";
			Mystatement=Myconnection.createStatement();
			myResult=Mystatement.executeQuery(sql);
			
			while(myResult.next()) {
				String email=myResult.getString("email");
				out.println(email);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		}

}
