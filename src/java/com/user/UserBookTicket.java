package com.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UserBookTicket", urlPatterns = {"/UserBookTicket"})
public class UserBookTicket extends HttpServlet {

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
            String userEmail = (String) s1.getAttribute("useremail");
            int showId = Integer.parseInt(request.getParameter("showId"));
            String paymentMethod = request.getParameter("paymentMethod");
            String cardHolderName = request.getParameter("cardHolderName");
            String cardNumber = request.getParameter("cardNumber");
            String expirationDate = request.getParameter("expirationDate");
            String cvv = request.getParameter("cvv");
            String selectedSeatsParam = request.getParameter("selectedSeats");
            String[] selectedSeatsArray = selectedSeatsParam.split(",");

            // Convert each element to an integer
            int[] selectedSeatsInt = Arrays.stream(selectedSeatsArray)
                    .mapToInt(Integer::parseInt)
                    .toArray();

// Now, selectedSeatsList contains the seat numbers as integers
//            out.println("Show ID: " + showId);
//            out.println("<br>Payment Method: " + paymentMethod);
//            out.println("<br>Card Holder Name: " + cardHolderName);
//            out.println("<br>Card Number: " + cardNumber);
//            out.println("<br>Expiration Date: " + expirationDate);
//            out.println("<br>CVV: " + cvv);
//            out.println("<h1>Servlet UserBookTicket at " + request.getContextPath() + "</h1>");
            try {
                String insertQuery = "INSERT INTO booking (ShowID, SeatNumber, PaymentMethod, CardHolderName, CardNumber, ExpirationDate, CVV, Email) VALUES (?,?, ?, ?, ?, ?, ?, ?)";

                for (int seatNumber : selectedSeatsInt) {
                    st = c1.prepareStatement(insertQuery);
                    st.setInt(1, showId);
                    st.setInt(2, seatNumber);
                    st.setString(3, paymentMethod);
                    st.setString(4, cardHolderName);
                    st.setString(5, cardNumber);
                    st.setString(6, expirationDate);
                    st.setString(7, cvv);
                    st.setString(8, "a@a.com");
                    st.executeUpdate();

                }

                // Close the database connection
                c1.close();

                // Respond to the client
                out.println("<html><body><h1>Booking successful!</h1></body></html>");

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
