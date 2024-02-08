<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instructor Login Page</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>
<body>
<header>
  <div class="p-5 text-center bg-body-tertiary" style="margin-top: 58px;">
    <h1 class="mb-3">Instructor Page</h1>
  </div>
</header>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="<%=request.getContextPath()%>/instructorLogin" method="POST" class="mt-5">
                <div class="login-fields">
                <c:if test="${not empty errorMessage}">
                        <p class="text-center alert alert-danger" >${errorMessage}</p>
                    </c:if>
                    <input type="radio" id="instructor" name="role" value="INSTRUCTOR" checked style="display:none;">

                    <div class="form-outline mb-4">
                    <input class="form-control" id="user_id" name="user_id" type="text" required placeholder="Enter ID"/>
                    <label class="form-label" for="user_id">Instructor ID:</label>
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
