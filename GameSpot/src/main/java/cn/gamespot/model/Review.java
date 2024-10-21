package cn.gamespot.model;

public class Review {
    private int id;
    private int userId; // Add userId
    private String userName; // Assume this is the user who wrote the review
    private String reviewText;
    private int gameId; // The ID of the game being reviewed

    // No-argument constructor
    public Review() {
    }

    // Constructor with parameters
    public Review(int id, int userId, String userName, String reviewText, int gameId) {
        this.id = id;
        this.userId = userId; // Initialize userId
        this.userName = userName;
        this.reviewText = reviewText;
        this.gameId = gameId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId; // Add getter for userId
    }

    public void setUserId(int userId) {
        this.userId = userId; // Add setter for userId
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }
}
