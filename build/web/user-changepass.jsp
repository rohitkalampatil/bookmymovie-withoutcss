

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
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
        <h2>Change Password</h2>
        <form action="UserChangePassword" method="POST">
            <label for="old-password">Old Password:</label>
            <input type="password" maxlength="8" id="old-password" name="password" required>

            <label for="new-password">New Password:</label>
            <input type="password" maxlength="8" id="new-password" name="pwd1" required>

            <label for="confirm-new-password">Confirm New Password:</label>
            <input type="password" maxlength="8" id="confirm-new-password" name="pwd2" required>
            <span id="error"><%= session.getAttribute("error") == null ? "" : session.getAttribute("error")%></span>
            <button type="submit">Submit</button>
        </form>

        <script >

            function alertNamefun() {
                var status = '<%= session.getAttribute("status")%>';

                setTimeout(fundiss, 3000);
                function fundiss() {
                    document.getElementById("error").innerHTML = '<% session.setAttribute("error", "");%>';
                }
                if (status === "success") {
                    alert("Password Changed Successfully")
                }
                if (status === "failed") {
                    alert("failed to set New Password");
                }
            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
        <% session.setAttribute("status", null);%>
        <% session.setAttribute("error", null);%>
        <%}%>
    </body>

</html>
