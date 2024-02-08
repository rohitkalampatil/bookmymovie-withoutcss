
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile page</title>
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

                // Retrieve user information from the database based on the logged-in user's email
                String query = "SELECT * FROM users WHERE Email = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, userEmail);
                ResultSet resultSet = preparedStatement.executeQuery();

                // Display user information
                if (resultSet.next()) {
                    String username = resultSet.getString("Username");

                    String phone = resultSet.getString("Phone");
        %>

        <h2>User Profile</h2>
        <form action="UserUpdateProfile" method="post">
            <label>Email:</label> <%= userEmail%><br>
            <label>Username:</label> <input type="text" name="username" value="<%= username%>"><br>

            <label>Phone:</label> <input type="text" name="phone" value="<%= phone%>"><br>
            <input type="submit" value="Update Profile">
        </form>

        <%
                } else {
                    out.println("User not found");
                }
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
