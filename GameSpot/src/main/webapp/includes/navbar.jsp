<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <span style="font-family: 'Press Start 2P', cursive; font-size: 24px;">GameSpot</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <% if (session.getAttribute("auth") != null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="library.jsp">Library</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">
                            <i class="bi bi-person-circle" style="font-size: 24px;"></i> <!-- User icon -->
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
