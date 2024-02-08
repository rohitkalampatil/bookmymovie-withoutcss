
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Show</title>
    </head>
    <body><%
        // can not store user data on this page ie to prevent back after logout
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        //check session for users email
        if (session.getAttribute("theateremail") == null) {
            out.print("<h1>Your are Logged out Click to <a href='user-login.jsp'>Login</a></h1>");

        } else {
        %>
        <h1>update here</h1>
        <%}%>
    </body>
</html>
