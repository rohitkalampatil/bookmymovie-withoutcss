
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking History Page</title>
    </head>
    <body>
        <%
            // can not store user data on this page ie to prevent back after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            //check session for users email
            if (session.getAttribute("email") == null) {
                out.print("<h1>Your are Logged out Click to <a href='user-login.jsp'>Login</a></h1>");

            } else {
                String userEmail = (String) session.getAttribute("email");
        %>
        <h1>Booking History</h1>
        <%
            // Define your database connection parameters
            String url = "jdbc:mysql://localhost:3306/bookmymovie";
            String user = "root";
            String password = "root";

            // Establish the database connection
            Connection connection = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, password);

                // Retrieve the user's booking history from the database
                String query = "SELECT movies.Title, shows.ShowTime, booking.SeatNumber, booking.BookingID  "
                        + "FROM booking "
                        + "INNER JOIN shows ON booking.ShowID = shows.ShowID "
                        + "INNER JOIN movies ON shows.MovieID = movies.MovieID "
                        + "WHERE booking.Email = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, userEmail);
                ResultSet resultSet = preparedStatement.executeQuery();
        %>

        <h2>Booking History for <%= userEmail%></h2>
        <table border="1">
            <tr>
                <th>Booking ID</th>
                <th>Movie Name</th>
                <th>Show Time</th>
                <th>seat number</th>
            </tr>
            <% while (resultSet.next()) {%>
            <tr>
                <td><%= resultSet.getInt("BookingID")%></td>
                <td><%= resultSet.getString("Title")%></td>
                <td><%= resultSet.getTimestamp("ShowTime")%></td>
                <td><%= resultSet.getInt("SeatNumber")%></td>
            </tr>
            <%
                }
            %>
        </table>

        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the database connection
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        <%}%>
    </body>
</html>
