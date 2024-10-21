<%@page import="cn.gamespot.model.User"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.UserDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%
    List<User> users = null;
    try (Connection conn = DbCon.getConnection()) {
        UserDao userDao = new UserDao(conn);
        users = userDao.getAllUsers();
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching users: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>Admin - Manage Users</title>
</head>
<body>
    	<%@include file="/includes/admin-nav.jsp"%>

    <div class="container mt-5">
        <h1 class="text-center">Manage Users</h1>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th> <!-- Consider removing or hashing this for security -->
                    <th>Action</th> <!-- New column for action -->
                </tr>
            </thead>
            <tbody>
                <% if (users != null && !users.isEmpty()) { %>
                    <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getId() %></td>
                            <td><%= user.getName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPassword() %></td> <!-- Display cautiously -->
                            <td>
                                <form action="remove-user" method="post" style="display:inline;">
                                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="5" class="text-center">No users found.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
