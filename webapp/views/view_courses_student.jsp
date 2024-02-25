<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Courses</title>
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
      	    <form action="<%=request.getContextPath()%>/logout" method="POST">
      	       <input type="radio" name="role" value="STUDENT" checked style="display:none;">
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
    <h3 class="mb-3">Hello again <strong>${username}</strong>, here is a list of the courses you are enrolled in, as well as the grades</h3>
  </div>
</header>
<div class="container">
    <div class="row">
        <div class="col-12">
        <c:if test="${not empty message}">
               <p class="text-center alert alert-success" >${message}</p>
            </c:if>
            <div class="d-flex justify-content-center">
            
<table class="table align-middle mb-0 bg-white">
  <thead class="bg-light">
    <tr class="text-center">
      <th>Course ID</th>
      <th>Course Name</th>
      <th>Your Grade</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${courses.entrySet()}" var="course">
        <tr class="text-center">
        <c:url var="Drop" value="manage">
				<c:param name="command" value="DROP"/>
				<c:param name="user_id" value="${user_id}"/>
				<c:param name="role" value="STUDENT"/>
				<c:param name="courseId" value="${course.key}"/>
				<c:param name="csrfToken" value="${sessionScope.csrfToken}" />
		</c:url>
            <td>${course.key}</td>
            <td>${course.value}</td>
            <td>
                <c:set var="foundGrade" value="false"/>
                <c:forEach items="${studentGrades.courseGrades}" var="courseGrade">
                    <c:if test="${courseGrade.courseId == course.key}">
                        <span class="badge ${courseGrade.grade >= 50 ? 'badge-success' : 'badge-danger'} rounded-pill d-inline">
                            ${courseGrade.grade}
                        </span>
                        <c:set var="foundGrade" value="true"/>
                    </c:if>
                </c:forEach>
                <c:if test="${not foundGrade}">
                    <span class="badge badge-secondary rounded-pill d-inline">Not Graded</span>
                    <a type="button" class="btn btn-link btn-sm btn-rounded"  href="${Drop}">
				        Drop
			        </a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
  </tbody>
</table>


            </div>            
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-4 text-center"> <!-- Adjust the column size as needed -->
            <form action="<%=request.getContextPath()%>/studentLogin" method="GET">
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button type="submit" class="btn btn-link">back to dashboard</button>
            </form>
        </div>
    </div>
</div>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</body>
</html>
