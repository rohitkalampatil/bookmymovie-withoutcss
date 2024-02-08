
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <style>
            body {
                font-family: Arial, sans-serif;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px auto;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }
            /* Style for past shows */
            .past-show {
                background-color: grey; /* Light gray for past shows */
            }
        </style>

        <title>Shows List</title>
    </head>
    <body>
        <%
            // can not store user data on this page ie to prevent back after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            //check session for users email
            if (session.getAttribute("theateremail") == null) {
                out.print("<h1>Your are Logged out Click to <a href='user-login.jsp'>Login</a></h1>");

            } else {
        %>
        <h2>Shows List</h2>

        <table id="showslist">
            <thead>
                <tr>
                    <th>Show ID</th>
                    <th>Movie ID</th>
                    <th>Movie Name</th>
                    <th>Show Time</th>
                    <th>Update show</th>
                    <th>Delete show</th>

                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        // Establish a database connection (replace with your actual database configuration)
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");
                        Statement st = conn.createStatement();

                        // Query to retrieve show details along with movie name
                        String query = "SELECT Shows.ShowID, Shows.MovieID, Movies.title, Shows.ShowTime "
                                + "FROM Shows "
                                + "JOIN Movies ON Shows.MovieID = Movies.MovieID";

                        ResultSet rs = st.executeQuery(query);

                        while (rs.next()) {
                            // Get the show time from the result set
                            Timestamp showTime = rs.getTimestamp("ShowTime");
                            // Get the current time
                            Timestamp currentTime = new Timestamp(System.currentTimeMillis());

                            // Check if the show is in the past
                            boolean isPastShow = showTime.before(currentTime);
                %>
                <tr <% if (isPastShow) { %>class="past-show" id="expiredshows"<% }%>>
                    <td><%= rs.getInt("ShowID")%></td>
                    <td><%= rs.getInt("MovieID")%></td>
                    <td><%= rs.getString("title")%></td>
                    <td><%= showTime%></td>
                    <td></td>
                    <td></td>
                </tr>
            <script>
                // Move the rows with id="expiredshows" to the end of the table
                $(document).ready(function () {
                    var expiredRows = $('#expiredshows').closest('tr');
                    expiredRows.detach().appendTo('#showslist');
                });
            </script>
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
            %>
        </tbody>
    </table>
    <%}%>
</body>
</html>
