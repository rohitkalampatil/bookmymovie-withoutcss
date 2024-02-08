
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Dashboard</title>
        <style>
            #nav {
                background-color: #333;
                overflow: hidden;
            }

            #nav a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }

            #nav a:hover {
                background-color: #ddd;
                color: black;
            }
            #spanname{
                color: white;
            }
            #nav #spanname {
                float: right;
                margin-right: 20px; /* Adjust the margin as needed */
                color: white;
                margin-top: 10px; /* Optional: Adjust the top margin for better alignment */
            }
        </style>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .movie-container {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 10px;
            }

            .movie-container img {
                max-width: 100px;
            }
        </style>
    </head>
    <body>
        <%
            // can not store user data on this page ie to prevent back after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            //check session for users email
            if (session.getAttribute("email") == null) {
                out.print("<h1>Your are Logged out Click to <a href='user-login.jsp'>Login</a></h1>");

            } else {
        %>
        <div id="nav">
            <a href="user-dashboard.jsp">Dashboard</a>
            <a href="user-profile.jsp">Profile</a>
            <a href="user-booking.jsp">My Booking</a>
            <a href="user-changepass.jsp">Change Password</a>
            <a href="Logout">Log out</a>
            <span id="spanname">Welcome</span>
        </div>
        <%
            try {
                // Establish a database connection (replace with your actual database configuration)
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");
                Statement st = conn.createStatement();

                // Get today's date
                java.util.Date currentDate = new java.util.Date();

                // Query to retrieve shows available from today onward
                String query = "SELECT Movies.*, Shows.ShowID, Shows.ShowTime "
                        + "FROM Movies "
                        + "JOIN Shows ON Movies.MovieID = Shows.MovieID "
                        + "WHERE Shows.ShowTime >= ? "
                        + "ORDER BY Shows.ShowTime";

                PreparedStatement preparedStatement = conn.prepareStatement(query);
                preparedStatement.setTimestamp(1, new Timestamp(currentDate.getTime()));
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    // Format the date and time
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");

                    java.util.Date showTimeDate = new java.util.Date(rs.getTimestamp("ShowTime").getTime());

        %>
    <center>
        <div class="show-container">
            <img src='assets/<%= rs.getString("PosterURL")%>' style="width: 300px" alt='Movie Poster'>
            <h2><%= rs.getString("Title")%></h2>
            <p><strong>Genre:</strong> <%= rs.getString("Genre")%></p>
            <p><strong>Show Time:</strong> <%= dateFormat.format(showTimeDate)%> <%= timeFormat.format(showTimeDate)%></p>
            <a href='book-ticket.jsp?showId=<%= rs.getInt("ShowID")%>'>Book Tickets</a>
        </div>
    </center>
    <%
                }

                // Close resources
                rs.close();
                st.close();
                conn.close();

            } catch (Exception e) {
                // Handle exceptions
                e.printStackTrace();
            }
        }%>
</body>
</html>







