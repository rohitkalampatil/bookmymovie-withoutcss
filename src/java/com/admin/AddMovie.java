package com.admin;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Part;

@WebServlet(name = "AddMovie", urlPatterns = {"/AddMovie"})
@MultipartConfig(maxFileSize = 16177216)
public class AddMovie extends HttpServlet {

    private Connection c1 = null;
    private PreparedStatement st = null;
    private HttpSession s1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            String releaseDate = request.getParameter("releaseDate");
            int duration = Integer.parseInt(request.getParameter("duration"));
            String language = request.getParameter("language");
            Part part = request.getPart("photo");
            String filename = part.getSubmittedFileName();
            String uploadpath = "C:/Users/MASTER/Documents/NetBeansProjects/Online Mocie Ticket Booking/web/assets/" + filename;

//            out.print(uploadpath + "<br>");
//          this will upload file inn asset folder
            try {
                FileOutputStream fos = new FileOutputStream(uploadpath);
                InputStream is = part.getInputStream();

                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
            } catch (Exception e) {
                out.print("Exception : " + e);
            }
//      now add file to database
            try {
                st = c1.prepareStatement("insert into movies(Title,Genre,ReleaseDate,Duration,Language,PosterURL) values(?,?,?,?,?,?)");
                st.setString(1, title);
                st.setString(2, genre);
                st.setString(3, releaseDate);
                st.setInt(4, duration);
                st.setString(5, language);
                st.setString(6, filename);
                
                int r = st.executeUpdate();
                if(r>0){
                    response.sendRedirect("admin-addmovie.jsp");
//                    out.print("uploaded");
                }else{
                    out.print("failed");
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

//out.print("hih");
//Part part = request.getPart("posterFile");
// obtains the upload file part in this multipart request
//            out.println("Title: " + title);
//            out.println("<br>Genre: " + genre);
//            out.println("<br>Release Date: " + releaseDate);
//            out.println("<br>Duration: " + duration);
//            out.println("<br>Language: " + language);
            //out.println("Poster File Name: " + filename);
