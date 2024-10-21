<!DOCTYPE html>
<html lang="en">
<head>
	<%@include file="/includes/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Admin Dashboard</title>
    <style>
        body {
            background-color: #f8f9fa; /* Light background for better readability */
        }
        .card {
            border: none; /* No border */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        h1, h3 {
            color: #343a40; /* Dark color for headings */
        }
    </style>
</head>
<body>
	<%@include file="/includes/admin-nav.jsp"%>
	
    <div class="container mt-5">
        <h1 class="text-center">Admin Dashboard</h1>

        <!-- Statistics Overview -->
        <div class="row mt-4">
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Users</h5>
                        <p class="card-text">100</p> <!-- Example data -->
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Games</h5>
                        <p class="card-text">50</p> <!-- Example data -->
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Reviews</h5>
                        <p class="card-text">200</p> <!-- Example data -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent User Activity -->
        <h3>Recent User Activity</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Joined Date</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>John Doe</td>
                    <td>john@example.com</td>
                    <td>2023-01-15</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Jane Smith</td>
                    <td>jane@example.com</td>
                    <td>2023-02-20</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Bob Johnson</td>
                    <td>bob@example.com</td>
                    <td>2023-03-05</td>
                </tr>
            </tbody>
        </table>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
