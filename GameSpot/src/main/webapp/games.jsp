<%@page import="cn.gamespot.model.Game"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.GameDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%
    List<Game> games = null;
    try (Connection conn = DbCon.getConnection()) {
        GameDao gameDao = new GameDao(conn);
        games = gameDao.getAllGames();
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching games: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>Admin - Manage Games</title>
</head>
<body>
    <%@include file="/includes/admin-nav.jsp"%>

    <div class="container mt-5">
        <h1 class="text-center">Manage Games</h1>
		<a href="add-game.jsp" class="btn btn-success mb-3">Add Game</a>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Price</th>
                    <th>Cover Image</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if (games != null && !games.isEmpty()) { %>
                    <% for (Game game : games) { %>
                        <tr>
                            <td><%= game.getId() %></td>
                            <td><%= game.getTitle() %></td>
                            <td><%= game.getGenre() %></td>
                            <td>$<%= game.getPrice() %></td>
                            <td><img src="game-images/<%= game.getCoverImage() %>" alt="<%= game.getTitle() %>" width="50"></td>
                            <td><%= game.getDescription() %></td>
                            <td>
                                <form action="remove-game" method="post" style="display:inline;">
                                    <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                </form>
                                <a href="edit-game.jsp?gameId=<%= game.getId() %>" class="btn btn-warning btn-sm">Edit</a>

                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="7" class="text-center">No games found.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
