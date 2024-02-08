
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add movie Page</title>
        <style>
            body{
                text-align: center;
            }
        </style>
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
        <h2>Add Movie</h2>
        <form action="AddMovie" method="post" enctype="multipart/form-data">
            <label>Title:</label>
            <input type="text" name="title" required/><br><br>

            <label>Genre:</label>
            <input type="text" name="genre" required/><br><br>

            <label>Release Date:</label>
            <input type="date" name="releaseDate" required/><br><br>

            <label>Duration (in minutes):</label>
            <input type="number" name="duration" required/><br><br>

            <label>Language:</label>
            <input type="text" name="language" required/><br><br>

            <label>Poster Image:</label>
            <input type="file" name="photo"  /><br><br>


            <input type="submit" value="Add Movie"/>
        </form>
        <%}%>
    </body>
</html>
