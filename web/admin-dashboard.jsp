
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
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
        <h1>Hello Admin!</h1>
        <a href="admin-dashboard.jsp">Dashboard</a><br>
        <a href="admin-addmovie.jsp">List New movie</a><br>
        <!--        <a href="admin-addshows.jsp">Add Shows</a><br>-->
        <a href="admin-allmovies.jsp">Movies</a><br>
        <a href="admin-allshows.jsp">Shows</a><br>
        <a href="admin-changepass.jsp">Change Password</a><br>
        <a href="Logout">Log out</a><br>
        <%}%>
    </body>
</html>
