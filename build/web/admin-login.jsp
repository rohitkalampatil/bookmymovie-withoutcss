
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin-login</title>
    </head>
    <body>
        <form action="AdminLogin" method="post">
            <label for="username">Theater Email:</label>
            <input type="email" value="<%= session.getAttribute("useremail") == null ? "" : session.getAttribute("useremail")%>" name="email" required>

            <label for="password">Password:</label>
            <input type="password"  name="password" required><br>
            <span  id="error" ><%= session.getAttribute("error") == null ? "" : session.getAttribute("error")%></span>
            <br>
            <button type="submit">Login</button>

        </form>
        <script >

            function alertNamefun() {
                setTimeout(fundiss, 3000);
                function fundiss() {
                    document.getElementById("error").innerHTML = '<% session.setAttribute("error", "");%>';
                }
            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
    </body>
</html>
