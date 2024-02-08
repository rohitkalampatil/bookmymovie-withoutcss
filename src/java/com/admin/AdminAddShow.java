package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
@WebServlet(name = "AdminAddShow", urlPatterns = {"/AdminAddShow"})
public class AdminAddShow extends HttpServlet {

    private Connection c1 = null;
    private PreparedStatement st = null;
    private HttpSession s1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            String movieID = request.getParameter("movieid");
            String showTimeStr = request.getParameter("showtime");

            try {
                // Convert showTimeStr to a java.sql.Timestamp
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                java.util.Date parsedDate = sdf.parse(showTimeStr);
                java.sql.Timestamp showTime = new java.sql.Timestamp(parsedDate.getTime());

                // Establish a database c1
           

                // Insert into Shows table
                String insertQuery = "INSERT INTO Shows (MovieID, ShowTime) VALUES (?, ?)";
                try (PreparedStatement preparedStatement = c1.prepareStatement(insertQuery)) {
                    preparedStatement.setInt(1, Integer.parseInt(movieID));
                    preparedStatement.setTimestamp(2, showTime);

                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Show scheduled successfully!");
                    } else {
                        out.println("Failed to schedule the show.");
                    }
                }

                // Close the database c1
                c1.close();
            } catch (Exception e) {
                // Handle exceptions
                e.printStackTrace();
            }

        }
    }

    private void databaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");

        } catch (ClassNotFoundException | SQLException e) {

        } finally {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
