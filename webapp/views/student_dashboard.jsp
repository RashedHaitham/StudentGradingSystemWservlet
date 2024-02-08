<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>
<body>
<header>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light"> <!-- bg-body-tertiary is not a default Bootstrap class, changed to bg-light -->
        <div class="container-fluid">
            <a class="navbar-brand mb-0 h1" href="#">Student Grading System</a>
            <div class="d-flex align-items-center">
                <form action="<%=request.getContextPath()%>/logout" method="POST">
                    <input type="hidden" name="role" value="STUDENT">
                    <button type="submit" class="btn btn-link text-black px-3 me-2">Logout</button>
                </form>
            </div>
        </div>
    </nav>
    <div class="p-5 text-center bg-light"> <!-- Changed bg-body-tertiary to bg-light for consistency with Bootstrap themes -->
        <h3 class="mb-3">Hello <strong>${username}</strong>, welcome to your dashboard.</h3>
    </div>
</header>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8"> <!-- Adjusted for better centering and responsive layout -->
            <table class="table table-hover border-dark table-bordered table-center">
                <thead>
                    <tr class="text-center">
                        <th>Option</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="text-center">
                        <td>
                            <form action="<%=request.getContextPath()%>/manage" method="GET">
                                <input type="hidden" name="user_id" value="${user_id}">
                                <input type="hidden" name="role" value="STUDENT">
                                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                                <button type="submit" class="btn btn-warning">View Grades & Grades</button>
                            </form>
                        </td>
                        <td class="description">
						See your performance in all enrolled courses. This includes final grades for each course you're taking.
						</td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            <form action="<%=request.getContextPath()%>/manage" method="GET">
                                <input type="hidden" name="user_id" value="${user_id}">
                                <input type="hidden" name="role" value="STUDENT">
                                <input type="hidden" name="command" value="LOADC">
                                <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
                                <button type="submit" class="btn btn-success">Enroll</button>
                            </form>
                        </td>
                        <td class="description">Explore available courses and enroll in new learning opportunities.</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
</html>
