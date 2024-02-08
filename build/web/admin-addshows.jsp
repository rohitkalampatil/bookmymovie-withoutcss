<%--
    Document   : admin-addshows
    Created on : 03-Feb-2024, 19:58:39
    Author     : MASTER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add show Page</title>

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
        <h2>Manage Shows</h2>

        <form action="AdminAddShow" method="post">
            <label for="movie">Movie ID:</label>
            <input type="text" name="movieid" value="<%= request.getParameter("movieid")%>" readonly=""/>

            <label for="moviename">Movie Name:</label>
            <input type="text" name="moviename" value="<%= request.getParameter("moviename")%>" readonly=""/>


            <label for="showtime">Select Showtime:</label>
            <input type="datetime-local" id="showtime" name="showtime" required>

            <button type="submit">Schedule Show</button>
        </form>
        <%}%>
    </body>
</html>
