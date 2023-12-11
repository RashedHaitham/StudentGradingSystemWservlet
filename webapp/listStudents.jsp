<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>students list</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>

<div id="wrapper">
  <div id="header">
     <h2>University of Dova</h2>
  </div>
  
  <div id="container">
     <div id="content">
     	<input type="button" value="add student" onclick="window.location.href='addStudent.jsp';return false"
     	class="add-student-button">
          <table border=1>
          <tr>
             <th>First Name</th>
             <th>Last Name</th>
             <th>Email</th>
             <th>Action</th>
          </tr>
          
          <c:forEach var="std" items="${AllStudents}">
          
          <c:url var="tempLink" value="StudentControllerServlet">
           		<c:param name="command" value="LOAD"/>
           		<c:param name="studentId" value="${std.id}"/>
          </c:url>
          
          <c:url var="DelLink" value="StudentControllerServlet">
           		<c:param name="command" value="DELETE"/>
           		<c:param name="studentId" value="${std.id}"/>
          </c:url>
          
          <tr>
             <td>${std.firstName}</td>
             <td>${std.lastName}</td>
             <td>${std.email}</td>
             <td>
             <a href="${tempLink}">Update</a>
             |
             <a href="${DelLink}" onclick="if(!(confirm('are you sure you want to delete this user?'))) return false">Delete</a></td>
          </tr>
          </c:forEach>
          </table>
     </div>
  </div>
</div>
</body>
</html>