<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Movie Ticket Booking</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <style>
            .body{
                text-align: center;
                justify-content: center;
            }
        </style>
    </head>
    <body class="body">

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
  <div class="container">
            <br>
            <a href="user-login.jsp">user Login</a>
            <br>
            <a href="admin-login.jsp">Admin Login</a>
        </div>

    </body>
</html>
