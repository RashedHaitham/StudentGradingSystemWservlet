<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String table = (String) request.getAttribute("table"); %>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Record to ${table}</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>
<body>
<header>
  <!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-body-tertiary">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <span class="navbar-brand mb-0 h1">Student Grading System</span>
    </div>
    <div class="d-flex align-items-center">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      	<li class="nav-item">
      	    <form action="<%=request.getContextPath()%>/logout" method="GET">
      	       <input type="radio" name="role" value="ADMIN" checked style="display:none;">
 			<button type="submit" class="text-black btn btn-link px-3 me-2">
         		 Logout
        	</button>
            </form>
        </li>
      </ul>
    </div>
  </div>
</nav>
  <div class="p-5 text-center bg-body-tertiary" style="margin-top: 58px;">
    <h3 class="mb-3">add new record to <%= request.getAttribute("table") %></h3>
  </div>
</header>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-6">
<% if (!errorMessage.isEmpty()){ %>
  <div class="row justify-content-center">
    <div class="col-auto">
      <p class="alert alert-danger text-center">${errorMessage}</p>
    </div>
  </div>
<% } %>
    <div class=" justify-content-center mb-3">
        
        <form action="<%=request.getContextPath()%>/crud" method="post">
            

         	<input type="hidden" value="ADD" name="command">        
            <input type="hidden" name="table" value="${table}">
            <% if (!"courses".equals(table)) { %>
            <!-- Student or Instructor Form -->
            <div class="form-outline mb-3">
                <input class="form-control" type="text" id="userId" name="userId" required>
                <label class="form-label" for="userId">Enter User ID</label>
            </div>
            
            
            <div class="form-outline mb-3">
                <input class="form-control" type="text" id="username" name="username" required>            
                <label class="form-label" for="username">Enter Username</label>
            </div>
            
            <div class="form-outline mb-3">
                <input class="form-control" type="password" id="password" name="password" required>            
                <label class="form-label" for="password">Enter Password</label>
            </div>
            <% } else { %>
            <!-- Course Form -->
            <div class="form-outline mb-3">
                <input class="form-control" type="text" id="courseId" name="courseId" required>
                <label class="form-label" for="courseId">Enter Course ID</label>
            </div>
            <div class="form-outline mb-3">
                <input class="form-control" type="text" id="course_name" name="course_name" required>            
                <label class="form-label" for="course_name">Enter Course Name</label>
            </div>
            <% } %>
            <button class="btn btn-primary mb-4" type="submit">Add Record</button>
            <p><a href="<%=request.getContextPath()%>/crud?role=ADMIN&table=${table}">back to list</a></p>
        </form>
    </div>
    
    
</div>
</div>
</div>
</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>

</html>