<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Game</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Add New Game</h2>
        <form action="add-game" method="post">
            <div class="form-group">
                <label for="title">Game Title</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="genre">Genre</label>
                <input type="text" class="form-control" id="genre" name="genre" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="coverImage">Cover Image URL</label>
                <input type="text" class="form-control" id="coverImage" name="coverImage" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description" required></textarea>
            </div>
            <div class="form-group">
                <label for="downloadLink">Download Link</label>
                <input type="text" class="form-control" id="downloadLink" name="downloadLink" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Game</button>
        </form>
    </div>
</body>
</html>
