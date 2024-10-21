<%@page import="cn.gamespot.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="cn.gamespot.dao.GameDao"%>
<%@page import="cn.gamespot.connection.DbCon"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Game> games = new ArrayList<>();

    try (Connection conn = DbCon.getConnection()) {
        GameDao gameDao = new GameDao(conn);
        games = gameDao.getAllGames();
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching games. Please try again later.");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Database driver not found.");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>GameSpot - Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
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
            background-color: #1e1e1e; /* Dark card background */
            border: none; /* Remove card border */
            transition: transform 0.2s, box-shadow 0.2s; /* Smooth hover effect */
        }
        .card:hover {
            transform: scale(1.05); /* Scale effect on hover */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); /* Add shadow on hover */
        }
        .btn-primary {
            background-color: #6200ea; /* Custom button color */
            border: none; /* Remove border */
        }
        .btn-primary:hover {
            background-color: #3700b3; /* Darker shade on hover */
        }
    </style>
</head>
<body>
    <%@include file="/includes/navbar.jsp"%>

    <div class="container mt-5">
        <h1 class="text-center">Welcome to GameSpot</h1>

        <div class="row mt-4">
            <% if (games.isEmpty()) { %>
                <div class="col text-center">
                    <p>No games available at the moment.</p>
                </div>
            <% } else { %>
                <% for (Game game : games) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm">
                            <img src="game-images/<%= game.getCoverImage() %>" class="card-img-top game-image" alt="<%= game.getTitle() %>">
                            <div class="card-body">
                                <h5 class="card-title"><%= game.getTitle() %></h5>
                                <p class="card-text">Genre: <%= game.getGenre() %></p>
                                <p class="card-text">Price: $<%= game.getPrice() %></p>
                                <a href="game-details.jsp?gameId=<%= game.getId() %>" class="btn btn-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
