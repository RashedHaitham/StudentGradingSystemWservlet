<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login Page</title>
	<link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>
<body>
<header>
  <div class="p-5 text-center bg-body-tertiary" style="margin-top: 58px;">
    <h1 class="mb-3">Admin Page</h1>
  </div>
</header>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
        <form action="<%=request.getContextPath()%>/adminLogin" method="POST">
        <div class="login-fields">
        <c:if test="${not empty errorMessage}">
                <div class="error-message">
                       <p class="text-center alert alert-danger" >${errorMessage}</p>
                </div>
            </c:if>
            
            <div class="form-outline mb-4">
                 <input class="form-control" id="user_id" name="user_id" type="text" required placeholder="Enter ID"/>
                 <label class="form-label" for="user_id">Admin ID:</label>
            </div>
                    
			<div class="form-outline mb-4">
                  <input class="form-control" id="password" name="password" type="password" placeholder="Enter Password" required/>
                  <label class="form-label" for="password">Password:</label>
            </div>     
            
            <button type="submit" class="btn btn-primary btn-block mb-4" />
            Login
            </button>
        </div>
</form>
</div>
</div>
</div>
</body>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>