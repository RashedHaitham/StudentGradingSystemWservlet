<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add/Update Grade</title>
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
                            <button type="submit" class="text-black btn btn-link px-3 me-2">Logout</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="p-5 text-center bg-body-tertiary" style="margin-top: 58px;">
        <h3 class="mb-3">Grade Students In ${courseName}</h3>
    </div>
</header>
<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-center">
                <table class="table table-responsive text-center">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student Username</th>
                            <th>Grade</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${stds}" var="entry">
                        <c:url var="DelGrade" value="manage">
					           		<c:param name="command" value="DGRADE"/>
					           		<c:param name="courseId" value="${course_id}"/>
					           		<c:param name="std_id" value="${entry.key}"/>
					         		<c:param name="user_id" value="${user_id}"/>
					                <c:param name="role" value="INSTRUCTOR"/>	
									<c:param name="csrfToken" value="${sessionScope.csrfToken}" />
					          </c:url>
                            <tr>
                                <td>${entry.value.studentId}</td>
                                <td>${entry.value.studentName}</td>  
                                <form action="<%=request.getContextPath()%>/manage" method="post">
                                <td>
                                        <input type="hidden" name="user_id" value="${user_id}"/>
                                        <input type="hidden" name="role" value="INSTRUCTOR"/>
                                        <input type="hidden" name="command" value="GRADE"/>
                                        <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                                        <input type="hidden" name="student_id" value="${entry.value.studentId}"/>
                                        <input type="hidden" name="course_id" value="${course_id}"/>
                                        <input class="text-center " style="width:5rem" type="number" step="0.1" name="grade" value="${entry.value.courseGrades[0].grade}"/>
                                </td>
                                <td>
                                    <button type='submit' class='btn btn-${entry.value.courseGrades[0].grade != "" ? "success" : "info"} btn-sm'>
                                        ${entry.value.courseGrades[0].grade != "" ? "Update" : "Add"}
                                    </button>  
                                     <a href="${DelGrade}" class="btn btn-danger btn-sm ">Delete</a>
                                </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Form placed outside the div that contains the table but inside the container div -->
    <div class="row">
        <div class="col-12">
            <form action="<%=request.getContextPath()%>/manage" method="post" class="text-center mt-3">
                <input type="hidden" name="role" value="INSTRUCTOR">
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="user_id" value="${user_id}">
                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                <button type="submit" class="btn btn-link">back to courses</button>
            </form>
        </div>
    </div>
</div>

<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>

</html>
