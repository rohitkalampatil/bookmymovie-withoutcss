
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All movies</title>
        <style>
            .body{
                text-align: center;
                justify-content: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body class="body">
        <%
            // can not store user data on this page ie to prevent back after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            //check session for users email
            if (session.getAttribute("theateremail") == null) {
                out.print("<h1>Your are Logged out Click to <a href='user-login.jsp'>Login</a></h1>");

            } else {
        %>
        <%
            Statement st = null;
            Connection c1 = null;
            String q = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");
                st = c1.createStatement();
            } catch (Exception e) {

            }
        %>
        <h1>All movies</h1>
        <table>
            <thead>
                <tr>
                    <th>Movie ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Release Date</th>
                    <th>Duration</th>
                    <th>Language</th>
                    <th>List to Show</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        q = "select * from Movies";
                        ResultSet r = st.executeQuery(q);

                        while (r.next()) {
                %>
                <tr class="movie-container">
                    <td><%= r.getInt("MovieID")%></td>
                    <td><%= r.getString("Title")%></td>
                    <td><%= r.getString("Genre")%></td>
                    <td><%= r.getDate("ReleaseDate")%></td>
                    <td><%= r.getInt("Duration")%> minutes</td>
                    <td><%= r.getString("Language")%></td>
                    <td><a href="admin-addshows.jsp?movieid=<%= r.getInt("MovieID")%>&moviename=<%= r.getString("Title")%>">Create showe</a></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        // Handle exception
                    }
                %>

            </tbody>
        </table>
        <%}%>
    </body>
</html>
