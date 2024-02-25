<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enroll in a Course</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>
<body>
<header>
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
            <c:choose>
    <c:when test="${role == 'INSTRUCTOR'}">
        <form action="<%=request.getContextPath()%>/logout" method="POST">
      	       <input type="radio" name="role" value="INSTRUCTOR" checked style="display:none;">
 			   <button type="submit" class="text-black btn btn-link px-3 me-2">
         		 Logout
        	</button>
            </form>
    </c:when>
    <c:otherwise>
        <form action="<%=request.getContextPath()%>/logout" method="POST">
      	       <input type="radio" name="role" value="STUDENT" checked style="display:none;">
 			   <button type="submit" class="text-black btn btn-link px-3 me-2">
         		 Logout
        	</button>
            </form>
    </c:otherwise>
</c:choose>
            
        </li>
      </ul>
    </div>
  </div>
</nav>
  <div class="p-5 text-center bg-body-tertiary" style="margin-top: 58px;">
        <h3 class="mb-3">Courses you can assign yourself</h3>
  </div>
</header></header>
<div class="container">
  <c:if test="${not empty message}">
               <p class="text-center alert alert-success" >${message}</p>
            </c:if>

    <c:choose>
        <c:when test="${not empty availableCourses}">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <table class="table align-middle mb-0 bg-white">
                        <thead>
                            <tr>
                                <th class="text-center">Course ID</th>
                                <th class="text-center">Course Name</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${availableCourses}" var="course">
                                <tr>
                                    <td class="text-center">${course.key}</td>
                                    <td class="text-center">${course.value}</td>
                                    <td class="text-center">
                                        <form action="<%=request.getContextPath()%>/manage" method="POST">
                                            <input type="hidden" name="user_id" value="${user_id}" />
                                            <input type="hidden" name="role" value="${role}" />
                                            <input type="hidden" name="command" value="ENROLL" />
                                            <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                                            <input type="hidden" name="username" value="${username}" />
                                            <input type="hidden" name="course_id" value="${course.key}" />
                                            <button class="btn btn-primary btn-sm" type="submit">Enroll</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center mt-5">
                <p>There are no courses available for you right now <strong>${username}</strong>, or you have already enrolled in them.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Back to dashboard form -->
    <div class="row justify-content-center mt-3">
        <div class="col-md-4 text-center">
            <c:choose>
    <c:when test="${role == 'INSTRUCTOR'}">
        <form action="<%=request.getContextPath()%>/instructorLogin" method="GET">
            <input type="hidden" name="username" value="${username}">
            <input type="hidden" name="user_id" value="${user_id}">
            <button type="submit" class="btn btn-link">Back to Dashboard</button>
        </form>
    </c:when>
    <c:otherwise>
        <form action="<%=request.getContextPath()%>/studentLogin" method="GET">
            <input type="hidden" name="username" value="${username}">
            <input type="hidden" name="user_id" value="${user_id}">
            <button type="submit" class="btn btn-link">Back to Dashboard</button>
        </form>
    </c:otherwise>
</c:choose>
        </div>
    </div>
</div>

<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</body>
</html>
