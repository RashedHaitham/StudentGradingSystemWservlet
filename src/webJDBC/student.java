package webJDBC;

public class student {
	private int id;
	private String firstName;
	private String LastName;
	private String email;
	
	
	public student( String firstName, String lastName, String email) {
		super();
		this.firstName = firstName;
		LastName = lastName;
		this.email = email;
	}
	
	public student(int id, String firstName, String lastName, String email) {
		super();
		this.id = id;
		this.firstName = firstName;
		LastName = lastName;
		this.email = email;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return LastName;
	}
	public void setLastName(String lastName) {
		LastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "student [id=" + id + ", firstName=" + firstName + ", LastName=" + LastName + ", email=" + email + "]";
	}

}
