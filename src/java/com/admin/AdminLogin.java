
package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminLogin", urlPatterns = {"/AdminLogin"})
public class AdminLogin extends HttpServlet {


    private Connection c1 = null;
    private PreparedStatement st = null;
    private HttpSession s1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            s1 = request.getSession(true);
            String theaterEmail = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                st = c1.prepareStatement("select password from theaters where theateremail=?;");
                st.setString(1, theaterEmail);
                ResultSet r = st.executeQuery();
                
                if (r.next()) {
                    if (password.equals(r.getString("password"))) {
                        s1.setAttribute("theateremail", theaterEmail);
                        response.sendRedirect("admin-dashboard.jsp");
                    } else {
                        s1.setAttribute("error", "Invalid Password");
                        s1.setAttribute("useremail", theaterEmail);
                        response.sendRedirect("admin-login.jsp");
                    }
                } else {
                    s1.setAttribute("error", "Invalid Email");
                    response.sendRedirect("admin-login.jsp");
                }
                c1.close();
            } catch (Exception e) {
                s1.setAttribute("error", e);
                response.sendRedirect("admin-login.jsp");
            }
        }
    }
   private void databaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");
        } catch (ClassNotFoundException | SQLException e) {
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
