<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grade Analysis</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/mdb.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-100">

<header>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">Student Grading System</span>
            <div class="d-flex align-items-center">
                <form action="<%=request.getContextPath()%>/logout" method="GET">
                    <input type="hidden" name="role" value="INSTRUCTOR">
                    <button type="submit" class="text-black btn btn-link px-3 me-2">Logout</button>
                </form>
            </div>
        </div>
    </nav>
</header>

<div class="container">
    <!-- Use flexbox to center everything vertically and horizontally -->
    <div class="flex flex-col items-center justify-center min-h-screen">
        <!-- Header -->
        <div class="text-center mb-2">
            <h3 class="text-3xl font-bold">View Statistics in ${courseName}</h3>
        </div>

        <!-- Chart Container -->
        <div class="p-6 bg-white shadow-md rounded-lg my-4">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-bold text-gray-700">Statistics</h2>
                <button onclick="showDetails()" class="bg-blue-500 text-white px-4 py-2 rounded shadow">
                    <i class="fas fa-info-circle"></i> Details
                </button>
            </div>
            <canvas id="myChart" width="400" height="200"></canvas>
        </div>

        <!-- Back to Courses Button -->
        <form action="<%=request.getContextPath()%>/manage" method="post">
            <input type="hidden" name="role" value="INSTRUCTOR">
            <input type="hidden" name="username" value="${username}">
            <input type="hidden" name="user_id" value="${user_id}">
            <input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>">
            <button type="submit" class="btn btn-link">Back to Courses</button>
        </form>
    </div>
</div>


<script src="js/bootstrap.js"></script>
<script src="js/mdb.min.js"></script>
<script>
    var avg = ${average};
    var med = ${median};
    var low = ${lowest};
    var high = ${highest};

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Average', 'Median', 'Lowest', 'Highest'],
            datasets: [{
                label: 'Value',
                data: [avg, med, low, high],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    function showDetails() {
        var data = myChart.data.datasets[0].data;
        var details = 'Average: ' + data[0] + '\n'
                    + 'Median: ' + data[1] + '\n'
                    + 'Lowest: ' + data[2] + '\n'
                    + 'Highest: ' + data[3];
        alert(details);
    }
</script>
</body>
</html>
