/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.user;

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

/**
 *
 * @author MASTER
 */
@WebServlet(name = "UserChangePassword", urlPatterns = {"/UserChangePassword"})
public class UserChangePassword extends HttpServlet {

    private Connection c1 = null;
    private PreparedStatement st = null;
    private HttpSession s1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            String userEmail = "a@a.com";
            String oldpass = request.getParameter("password");
            String newPass = request.getParameter("pwd1");
            String confPass = request.getParameter("pwd2");
//             out.println("<br>"+oldpass+"<br>"+newPass+"<br>"+confPass);
            s1 = request.getSession(true);
            try {
                st = c1.prepareStatement("select password from users where Email=?");
                st.setString(1, userEmail );

                ResultSet r = st.executeQuery();
                if (r.next()) {
                    if (oldpass.equals(r.getString("password"))) {
                        if (newPass.length() >= 4 && newPass.length() <= 8) {
                            if (newPass.equals(confPass)) {
                                st = c1.prepareStatement("update users set password=? where Email=?");
                                st.setString(1, newPass);
                                st.setString(2, userEmail );
                                int res = st.executeUpdate();
                                if (res > 0) {
                                    s1.setAttribute("status", "success");
                                    response.sendRedirect("user-changepass.jsp");
                                }
                            } else {
                                c1.close();
                                s1.setAttribute("error", "New Password and Confirm Password missmatched");
                                response.sendRedirect("user-changepass.jsp");
                            }
                        } else {
                            c1.close();
                            s1.setAttribute("error", "password must minimum 4 or max 8 charecter long");
                            response.sendRedirect("user-changepass.jsp");
                        }
                    } else {
                        c1.close();
                        s1.setAttribute("error", "Wrong Old Password");
                        response.sendRedirect("user-changepass.jsp");
                    }
                }

            } catch (Exception e) {

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
