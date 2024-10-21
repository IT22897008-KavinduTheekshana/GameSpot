package cn.gamespot.model;

public class Game {
    private int id;
    private String title;
    private String genre;
    private double price;
    private String coverImage;
    private String description; // New field for game description
    private String downloadLink; // New field for download link

    // Constructors
    public Game() {
    }

    public Game(int id, String title, String genre, double price, String coverImage) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.price = price;
        this.coverImage = coverImage;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDownloadLink() {
        return downloadLink;
    }

    public void setDownloadLink(String downloadLink) {
        this.downloadLink = downloadLink;
    }
}
