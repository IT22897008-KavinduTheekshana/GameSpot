<%@page import="cn.gamespot.model.Game"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.GameDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%
int gameId = Integer.parseInt(request.getParameter("gameId"));
Game game = null;

try (Connection conn = DbCon.getConnection()) {
	GameDao gameDao = new GameDao(conn);
	game = gameDao.getGameById(gameId);
} catch (SQLException e) {
	e.printStackTrace();
	request.setAttribute("errorMessage", "An error occurred while fetching game details: " + e.getMessage());
}

if (game == null) {
	response.sendRedirect("games.jsp"); // Redirect if the game is not found
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/includes/head.jsp"%>
<title>Edit Game</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container mt-5">
		<h1 class="text-center">Edit Game</h1>

		<form action="edit-game" method="post" >
			<input type="hidden" name="id" value="<%=game.getId()%>">

			<div class="mb-3">
				<label for="title" class="form-label">Title</label> <input
					type="text" class="form-control" id="title" name="title"
					value="<%=game.getTitle()%>" required>
			</div>

			<div class="mb-3">
				<label for="genre" class="form-label">Genre</label> <input
					type="text" class="form-control" id="genre" name="genre"
					value="<%=game.getGenre()%>" required>
			</div>

			<div class="mb-3">
				<label for="price" class="form-label">Price</label> <input
					type="number" class="form-control" id="price" name="price"
					value="<%=game.getPrice()%>" step="0.01" required>
			</div>

			<div class="mb-3">
				<label for="cover_image" class="form-label">Cover Image</label> <input
					type="text" class="form-control" id="cover_image"
					name="cover_image" value="<%=game.getCoverImage()%>" required>
			</div>

			<div class="mb-3">
				<label for="description" class="form-label">Description</label>
				<textarea class="form-control" id="description" name="description"
					rows="5" required><%=game.getDescription()%></textarea>
			</div>

			<div class="mb-3">
				<label for="download_link" class="form-label">Download Link</label>
				<input type="text" class="form-control" id="download_link"
					name="download_link" value="<%=game.getDownloadLink()%>" required>
			</div>

			<button type="submit" class="btn btn-primary">Update Game</button>
		</form>

	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>
