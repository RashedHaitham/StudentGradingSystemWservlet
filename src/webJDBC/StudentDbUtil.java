package webJDBC;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;

public class StudentDbUtil {

	DataSource dataSource;
	
	public StudentDbUtil(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<student> getStudents() throws Exception{
		List<student>students=new ArrayList<>();

		Connection connect=null;
		Statement statement=null;
		ResultSet result=null;
		
		try {
			String sql="select * from student order by last_name"; 
			connect=dataSource.getConnection();
			statement=connect.createStatement();
			result=statement.executeQuery(sql);
			
			while(result.next()) {
				int id=result.getInt("id");
				String first=result.getString("first_name");
				String last=result.getString("last_name");
				String email=result.getString("email");
				
				students.add(new student(id,first,last,email));

			}
		}
		finally {
			close(connect,statement,result);
		}
		return students;
	}
	private void close(Connection connect, Statement statement, ResultSet result) {
		
		try {
			if(result!=null)result.close();
			if(statement!=null)statement.close();
			if(connect!=null)connect.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	public void addStudent(student student) throws SQLException {
		
		Connection connect=null;
		PreparedStatement prestatement=null;
		
		try {
			String sql="insert into student " +
					"(first_name,last_name,email) "
					+"values (?,?,?)"; 
			connect=dataSource.getConnection();
			prestatement=connect.prepareStatement(sql);
			
			prestatement.setString(1, student.getFirstName());
			prestatement.setString(2, student.getLastName());
			prestatement.setString(3, student.getEmail());
			
			prestatement.execute();
			

		}
		finally {
			close(connect,prestatement,null);

		}
	}
	public student getStudent(String id) throws Exception {
		student std=null;
		Connection connect=null;
		PreparedStatement preState=null;
		ResultSet result=null;
		int stdId;
		
		try {
			stdId=Integer.parseInt(id);
			connect=dataSource.getConnection();
			
			String sql="select * from student where id=?";
			preState=connect.prepareStatement(sql);
			preState.setInt(1,stdId);
			
			result=preState.executeQuery();
			if(result.next()) {
				String first=result.getString("first_name");
				String last=result.getString("last_name");
				String email=result.getString("email");
				
				std=new student(stdId,first,last,email);
			}
			else {
				throw new Exception("couldnt find this id "+stdId);
			}
			return std;
		}
		finally {
			close(connect,preState,result);
		}
	}
	public void updateStudent(student student) throws SQLException {
		Connection connect=null;
		PreparedStatement pre=null;
			try {
				 connect=dataSource.getConnection();
				String sql="update student "+
				 "set first_name=?, last_name=?, email=? "
				 +"where id=?";
				
				pre=connect.prepareStatement(sql);
				
				pre.setString(1, student.getFirstName());
				pre.setString(2, student.getLastName());
				pre.setString(3, student.getEmail());
				pre.setInt(4, student.getId());
				
				pre.execute();
			}
			finally {
				close(connect,pre,null);
			}
	}
	public void DeleteStudent(int Id) throws SQLException {
		
		Connection connect=null;
		PreparedStatement pre=null;
			try {
				 connect=dataSource.getConnection();
				String sql="delete from student where id=?";
				
				pre=connect.prepareStatement(sql);
				
				pre.setInt(1, Id);
				
				pre.execute();
			}
			finally {
				close(connect,pre,null);
			}
		
	}


}
