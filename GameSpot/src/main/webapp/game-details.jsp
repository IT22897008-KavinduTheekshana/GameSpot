<%@page import="cn.gamespot.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.GameDao"%>
<%@page import="cn.gamespot.dao.ReviewDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%
    String gameIdParam = request.getParameter("gameId");
    Game game = null;
    List<Review> reviews = new ArrayList<>();

    if (gameIdParam != null) {
        try {
            int gameId = Integer.parseInt(gameIdParam);
            try (Connection conn = DbCon.getConnection()) {
                GameDao gameDao = new GameDao(conn);
                game = gameDao.getGameById(gameId);

                // Fetch reviews for the game
                ReviewDao reviewDao = new ReviewDao(conn);
                reviews = reviewDao.getReviewsByGameId(gameId);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "An error occurred while fetching game details: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database driver not found.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid game ID.");
        }
    } else {
        request.setAttribute("errorMessage", "Game ID is required.");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>GameSpot - <%= game != null ? game.getTitle() : "Game Details" %></title>
    <style>
        body {
            background-color: #121212; /* Dark background */
            color: #ffffff; /* Light text color */
        }
        .game-image {
            height: 200px; /* Set a fixed height for the images */
            object-fit: cover; /* Ensures images cover the area without distortion */
        }
        .card {
            background-color: #1e1e1e; /* Darker card background */
            border: 1px solid #343a40; /* Dark border for cards */
            transition: transform 0.2s; /* Smooth hover effect */
        }
        .card:hover {
            transform: scale(1.05); /* Scale effect on hover */
        }
        .review {
            border: 1px solid #343a40; /* Dark border for each review */
            border-radius: 5px; /* Rounds the corners of the review */
            padding: 10px; /* Adds space inside the review */
            background-color: #2c2c2c; /* Slightly lighter background for reviews */
        }
        .alert {
            background-color: #dc3545; /* Danger alert background color */
            color: white; /* Alert text color */
        }
        .btn {
            background-color: #007bff; /* Button background color */
            color: #ffffff; /* Button text color */
        }
        .btn-success {
            background-color: #28a745; /* Success button background */
        }
        .btn-primary {
            background-color: #007bff; /* Primary button background */
        }
    </style>
</head>
<body>
    <%@include file="/includes/navbar.jsp"%>

    <div class="container mt-5">
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <div class="alert alert-danger"><%= errorMessage %></div>
        <%
            }
        %>

        <%
            if (game == null) {
        %>
        <h2 class="text-center">Game not found.</h2>
        <%
            } else {
        %>
        <h1 class="text-center"><%= game.getTitle() %></h1>
        <div class="row mt-4">
            <div class="col-md-6">
                <img src="game-images/<%= game.getCoverImage() %>" class="img-fluid game-image" alt="<%= game.getTitle() %>">
            </div>
            <div class="col-md-6">
                <h5>Genre: <%= game.getGenre() %></h5>
                <h5>Price: $<%= game.getPrice() %></h5>
                <p>Description: <%= game.getDescription() %></p>
                <form action="add-to-library" method="post">
                    <input type="hidden" name="gameId" value="<%= game.getId() %>">
                    <button type="submit" class="btn btn-success">Add to Library</button>
                </form>
                <a href="<%= game.getDownloadLink() %>" class="btn btn-primary mt-2">Download Now</a>
            </div>
        </div>

        <h3 class="mt-5">Reviews</h3>
        <div id="reviews">
            <%
                if (reviews.isEmpty()) {
            %>
            <p>No reviews yet. Be the first to review!</p>
            <%
                } else {
                    for (Review r : reviews) {
            %>
            <div class="review mb-3">
                <strong><%= r.getUserName() %></strong>
                <p><%= r.getReviewText() %></p>
            </div>
            <%
                    }
                }
            %>
        </div>

        <h4 class="mt-5">Add a Review</h4>
        <form action="submit-review" method="post">
            <input type="hidden" name="gameId" value="<%= game.getId() %>">
            <div class="form-group">
                <label for="reviewText">Review:</label>
                <textarea id="reviewText" name="reviewText" class="form-control" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit Review</button>
        </form>

        <%
            }
        %>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
