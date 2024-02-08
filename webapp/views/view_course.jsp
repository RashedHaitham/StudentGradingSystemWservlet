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
    <h3 class="mb-3">Hello again <strong>${username}</strong>, here is a list of the courses you are enrolled in. Please proceed with grading or viewing the analysis as required.</h3>
  </div>
</header>
<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-center">
                <table class="table table-responsive text-center">
                    <thead>
                        <tr>
                            <th>Course ID</th>
                            <th>Course Name</th>
                            <c:if test="${not empty studentsCount}">
                                <th>Students Count</th>
                            </c:if>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${courses}" var="entry">
                            <tr>
							 <c:url var="GradeLink" value="manage">
					           		<c:param name="command" value="LOAD"/>
					           		<c:param name="courseId" value="${entry.key}"/>
					           		<c:param name="courseName" value="${entry.value}"/>
					           		<c:param name="user_id" value="${user_id}"/>
					                <c:param name="role" value="INSTRUCTOR"/>	
									<c:param name="csrfToken" value="${sessionScope.csrfToken}" />
					          </c:url>
          
					          <c:url var="AnalysisLink" value="manage">
					           		<c:param name="command" value="ANALYSIS"/>
					           		<c:param name="user_id" value="${user_id}"/>
					           		<c:param name="role" value="INSTRUCTOR"/>
					       			<c:param name="courseId" value="${entry.key}"/>
					           		<c:param name="courseName" value="${entry.value}"/>
									<c:param name="csrfToken" value="${sessionScope.csrfToken}" />
					          </c:url>
					          
                                <td>${entry.key}</td>
                                <td>${entry.value}</td>
                                <c:if test="${not empty studentsCount}">
                                    <td>${studentsCount[entry.key]}</td>
                                </c:if>
                                <td>
                                <c:if test="${not empty studentsCount}">
			                        <div class="text-center">
								        <a type="button" class="btn btn-link btn-sm btn-rounded"  href="${GradeLink}">
								          Grade Students
								        </a> |  
								        <a type="button" class="btn btn-link btn-sm btn-rounded"  href="${AnalysisLink}">
								          View Analysis
								        </a>
							        </div>
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
            <form action="<%=request.getContextPath()%>/instructorLogin" method="GET">
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="user_id" value="${user_id}">
                <button type="submit" class="btn btn-link">back to dashboard</button>
            </form>
        </div>
    </div>
</div>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</body>
</html>
