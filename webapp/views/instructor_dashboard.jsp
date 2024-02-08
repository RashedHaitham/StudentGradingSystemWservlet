<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Instructor Dashboard</title>
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
      	       <input type="radio" name="role" value="INSTRUCTOR" checked style="display:none;">
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
    <h3 class="mb-3">Hello <strong>${username}</strong>, welcome to your dashboard</h3>
  </div>
</header>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-8">
<table class="table table-hover border-dark table-bordered">
    <tr>
        <th>Option</th>
        <th>Description</th>
    </tr>
    <tr>
        <td class="text-center">
            <form action="<%=request.getContextPath()%>/manage" method="post">                
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="hidden" name ="role" value="INSTRUCTOR">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button class="btn btn-primary" type="submit">Manage Courses</button>
            </form>
        </td>
		<td class="description">Access a comprehensive list of courses you are currently instructing, allowing for easy management,where you can 
		adjust students' grades for their coursework, and review detailed statistical analyses of student performance, including averages, medians, and the distribution of grades.</td>
    </tr>
    <tr>
        <td>
            <form action="<%=request.getContextPath()%>/manage" method="post">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="hidden" name="role" value="INSTRUCTOR">
                <input type="hidden" name ="command" value="LOADC">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button class="btn btn-danger" type="submit">Course Enrollment</button>
            </form>
        </td>
        <td class="description">Select from available courses to expand your teaching portfolio, allowing you to engage with more students and diversify your instructional expertise.</td>
    </tr>
</table>
</div>
</div>
</div>

</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>
