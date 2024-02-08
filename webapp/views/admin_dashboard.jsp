<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
    <h3 class="mb-3">Hello <strong>Admin ${username}</strong>, this is your dashboard</h3>
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
            <form action="<%=request.getContextPath()%>/crud" method="post">
                <input type="hidden" name ="role" value="ADMIN">
                <input type="hidden" name ="table" value="students">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button class="btn btn-primary" type="submit">Students</button>
            </form>
        </td>
<td class="description">Enables the management and organization of students records, including creating, reading, updating, and deleting details.</td>
    </tr>
    <tr>
        <td class="text-center">
            <form action="<%=request.getContextPath()%>/crud" method="post">
                <input type="hidden" name ="role" value="ADMIN">
                <input type="hidden" name ="table" value="instructors">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button class="btn btn-warning" type="submit">Instructors</button>
            </form>
        </td>
<td class="description">Enables the management and organization of instructor records, including creating, reading, updating, and deleting details.</td>
    </tr>
    <tr>
        <td class="text-center">
            <form action="<%=request.getContextPath()%>/crud" method="post">
                <input type="hidden" name ="role" value="ADMIN">
                <input type="hidden" name ="table" value="courses">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button class="btn btn-success" type="submit">Courses</button>
            </form>
        </td>
<td class="description">Enables the management and organization of courses records, including creating, reading, updating, and deleting details.</td>
    </tr>
</table>
</div>
</div>
</div>
</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>
