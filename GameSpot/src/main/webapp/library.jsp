<%@page import="cn.gamespot.model.Library"%>
<%@page import="cn.gamespot.model.Game"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.GameDao"%>
<%@page import="cn.gamespot.dao.UserLibraryDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%
Integer userId = (Integer) session.getAttribute("userId");
List<Library> libraryEntries = new ArrayList<>();
List<Game> games = new ArrayList<>();

if (userId != null) {
	try (Connection conn = DbCon.getConnection()) {
		UserLibraryDao userLibraryDao = new UserLibraryDao(conn);
		libraryEntries = userLibraryDao.getLibraryEntries(userId);

		GameDao gameDao = new GameDao(conn);
		for (Library entry : libraryEntries) {
	games.add(gameDao.getGameById(entry.getGameId())); // Fetch game details for each library entry
		}
	} catch (SQLException e) {
		e.printStackTrace();
		request.setAttribute("errorMessage", "An error occurred while fetching your library: " + e.getMessage());
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/includes/head.jsp"%>
<title>Your Library - GameSpot</title>
<style>
body {
	background-color: #121212; /* Dark background */
	color: #e0e0e0; /* Light text color */
	font-family: 'Arial', sans-serif; /* Font family for the page */
}

h1 {
	font-size: 2.5rem; /* Increased font size for the main heading */
	margin-bottom: 20px; /* Margin below the heading */
}

.card {
	background-color: #1e1e1e; /* Darker card background */
	border: none; /* No border for cards */
	border-radius: 10px; /* Rounded corners */
	overflow: hidden; /* Ensures content does not overflow */
	transition: transform 0.3s, box-shadow 0.3s; /* Smooth hover effect */
	box-shadow: 0 2px 15px rgba(0, 0, 0, 0.5);
	/* Subtle shadow for cards */
}

.card:hover {
	transform: translateY(-5px); /* Lift effect on hover */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6); /* Deeper shadow on hover */
}

.card-img-top {
	height: 200px; /* Fixed height for images */
	object-fit: cover;
	/* Ensures images cover the area without distortion */
}

.btn {
	background-color: #007bff; /* Primary button color */
	color: #ffffff; /* Button text color */
	border-radius: 5px; /* Slightly rounded buttons */
	transition: background-color 0.3s;
	/* Smooth transition for hover effect */
}

.btn:hover {
	background-color: #0056b3; /* Darker shade on hover */
}

.btn-danger {
	background-color: #dc3545; /* Danger button color */
}

.btn-danger:hover {
	background-color: #c82333;
	/* Darker shade on hover for danger button */
}

.alert {
	background-color: #dc3545; /* Danger alert background color */
	color: white; /* Alert text color */
	border-radius: 5px; /* Rounded alert corners */
	padding: 15px; /* Padding for alert */
	margin-bottom: 20px; /* Margin below alert */
}

.row {
	margin-bottom: 30px; /* Space between rows */
}

.text-center {
	margin: 20px 0; /* Margin above and below centered text */
}
</style>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container mt-5">
		<h1 class="text-center">Your Library</h1>
		<div class="row mt-4">
			<%
			if (games.isEmpty()) {
			%>
			<div class="col text-center">
				<p>Your library is empty.</p>
			</div>
			<%
			} else {
			%>
			<%
			for (Game game : games) {
			%>
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="game-images/<%=game.getCoverImage()%>"
						class="card-img-top" alt="<%=game.getTitle()%>">
					<div class="card-body">
						<h5 class="card-title"><%=game.getTitle()%></h5>
						<p class="card-text">
							Genre:
							<%=game.getGenre()%></p>
						<p class="card-text">
							Price: $<%=game.getPrice()%></p>
						<div class="d-flex justify-content-between">
							<a href="game-details.jsp?gameId=<%=game.getId()%>"
								class="btn btn-primary me-2">View Details</a>
							<form action="remove-from-library" method="post">
								<input type="hidden" name="gameId" value="<%=game.getId()%>">
								<button type="submit" class="btn btn-danger">Remove
									from Library</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
			<%
			}
			%>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>
