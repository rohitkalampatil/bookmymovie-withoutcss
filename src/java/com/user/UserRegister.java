package com.user;

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

@WebServlet(name = "UserRegister", urlPatterns = {"/UserRegister"})
public class UserRegister extends HttpServlet {

    private Connection c1 = null;
    private PreparedStatement statement = null;
    private HttpSession s1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            String userEmail = request.getParameter("email");
            String userName = request.getParameter("username");
            String password = request.getParameter("password");
            Long userMobile = Long.parseLong(request.getParameter("phone"));
            
            out.println("<h4>"+userEmail+"</h4>");
            out.println("<h4>"+userName+"</h4>");
            out.println("<h4>"+password+"</h4>");
            out.println("<h4>"+userMobile+"</h4>");
            try {
                statement = c1.prepareStatement("insert into users values(?,?,?,?)");
                statement.setString(1, userEmail);
                statement.setString(2, userName);
                statement.setString(3, password);
                statement.setLong(4, userMobile);
              
                int r = statement.executeUpdate();

                if (r > 0) {
                    // using session 
                    s1 = request.getSession(true);
                    s1.setAttribute("status", "success");
                    response.sendRedirect("user-dashboard.jsp");
                }

            } catch (IOException | SQLException e) {

            } finally {
                try {
                    if (statement != null) {
                        statement.close();
                    }
                    if (c1 != null) {
                        c1.close();
                    }
                } catch (SQLException e) {
                }
            }

        }
    }
//    setting up database connection

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
