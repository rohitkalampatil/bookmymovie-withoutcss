
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>user register</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="UserRegister" method="post">
            
            <label for="username">Username:</label>
            <input type="text"  name="username" required>
            
            <label for="email">Email:</label>
            <input type="email"  name="email" required>
            
            <label for="phone">Phone:</label>
            <input type="tel"  name="phone">

            <label for="password">Password:</label>
            <input type="password"  name="password" required>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password"  name="confirmPassword" required>

            <button type="submit">Register</button>
        </form>
    </body>
</html>
