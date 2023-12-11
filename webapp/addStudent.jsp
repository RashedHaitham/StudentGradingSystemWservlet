<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add student</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
<link type="text/css" rel="stylesheet" href="css/add-student-style.css">

</head>
<body>

 <div id="wrapper">
 	<div id="header"><h2>University of Dova</h2></div>
 </div>
 
 <div id="container">
 	<h3>Add Student</h3>
 	
 	  <form action="StudentControllerServlet" method="get">
 	  <input type="hidden" value="ADD" name="command">
        <table>
        	<tbody>
        		<tr>
        			<td><label>First name:</label></td>
        			<td><input type="text" name="firstName"></td>
        		</tr>
        		<tr>
        			<td><label>Last name:</label></td>
        			<td><input type="text" name="lastName"></td>
        		</tr>
        		<tr>
        			<td><label>Email:</label></td>
        			<td><input type="email" name="email"></td>
        		</tr>
        		<tr>
        			<td><label></label></td>
        			<td><input type="submit" value="save" class="save"></td>
        		</tr>
        	</tbody>
        </table>
        
    </form>
    
    <p><a href="StudentControllerServlet">back to list</a></p>
 </div>
</body>
</html>