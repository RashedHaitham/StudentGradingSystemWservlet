<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String table = (String) request.getAttribute("table"); %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update ${name}</title>
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
    <h3 class="mb-3">Modify <%= request.getAttribute("name") %></h3>
  </div>
</header>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-6">
        <form action="<%=request.getContextPath()%>/crud" method="post">
        
        <% String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { %>
            <div class="text-center alert alert-danger"><%= errorMessage %></div>
            <% } %>
        
            <input type="hidden" name="table" value="${table}">
            <input type="hidden" value="UPDATE" name="command">
            <input type="hidden" value="${name}" name="name">
            <input type="hidden" value="${Id}" name="Id">
            <div class="form-outline mb-3">
            <input value="${Id}" class="form-control" type="text" name="newId" required>            
            <label class="form-label" for="newId">ID</label>
            </div>
            
            <div class="form-outline mb-3">
                    <input value="${name}" class="form-control" type="text" name="newUsername" required>
                    <label class="form-label" for="newUsername">
                        <c:choose>
                            <c:when test="${table eq 'courses'}">Course Name</c:when>
                            <c:otherwise>Username</c:otherwise>
                        </c:choose>
                    </label>
                </div>
			<input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
            <button class="btn btn-warning mb-4" type="submit">Save changes for ${name}</button>
            
        </form>
        <form action="<%=request.getContextPath()%>/crud" method="post">
              <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <input type="hidden" name="role" value="ADMIN">
                <input type="hidden" name="table" value="${table}">
                <button type="submit" class="btn btn-link">back to list</button>
            </form>
    </div>
</div>
</div>
</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>