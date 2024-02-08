<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("table") %> list</title>
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
    <h3 class="mb-3">Make necessary operations for <%= request.getAttribute("table") %></h3>
  </div>
</header>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-8">

<table class="table align-middle mb-0 bg-white">
  <thead class="bg-light">
    <tr class="text-center">
       <% List<String> headers = (List<String>) request.getAttribute("headers");
                if (headers != null) {
                    for (String header : headers) { %>
            <th><%= header %></th>
            <%     }
            } %>
      <th>Actions</th>
    </tr>
  </thead>
  
  <tbody>
      <% List<String[]> rowsData = (List<String[]>) request.getAttribute("rowsData");
            if (rowsData != null) {
                for (String[] row : rowsData) { %>
  		<c:url var="tempLink" value="crud">
           		<c:param name="command" value="LOAD"/>
           		<c:param name="Id" value="<%=row[0]%>"/>
           		<c:param name="name" value="<%=row[1]%>"/>
    			<c:param name="table" value="${table}"/>
          </c:url>
          
          <c:url var="DelLink" value="crud">
           		<c:param name="command" value="DELETE"/>
           		<c:param name="Id" value="<%=row[0]%>"/>
   				<c:param name="table" value="${table}"/>
          </c:url>
          
 
            <% for (String cell : row) { %>
            <td class="text-center">
             <div class="ms-3">
            <p class="fw-bold mb-1"><%= cell %></p>
          </div>
            </td>
            <% } %>
            <td>
        <div class="text-center">
        <a type="button" class="btn btn-link btn-sm btn-rounded"  href="${tempLink}">
          Edit
        </a> |  
        <a type="button" class="btn btn-link btn-sm btn-rounded"  href="${DelLink}"
        onclick="if(!(confirm('are you sure you want to delete this record?'))) return false">
          Delete
        </a>
        </div>
      </td>
        </tr>
        <%     }
        } %>
    
  </tbody>
</table>
		<a type="button" onclick="window.location.href='<%=request.getContextPath()%>/addRecord?role=ADMIN&table=${table}';return false"
     	class="btn btn-info mt-3">add ${table}</a>
     	
     	<p class="mt-3">
     	<a href="<%=request.getContextPath()%>/adminLogin">
     		back to dashboard
     	</a>
     	</p>
</div>
</div>
</div>



</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>