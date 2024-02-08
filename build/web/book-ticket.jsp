<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .booking-container {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 10px;
            }

            #seating-layout {
                overflow: auto;
            }

            #firstDiv,
            #secondDiv,
            #thirdDiv {
                display: grid;
                grid-template-columns: repeat(18, 1fr);
                gap: 10px;
                margin-top: 20px;
            }

            .seat {
                width: 30px;
                height: 30px;
                background-color: transparent;
                border: 1px solid #ffc107;
                cursor: pointer;
            }

            .selected {
                background-color: #ffc107;
                /* border: 1px solid #fff; */
            }

            #screen {
                width: 100%;
                height: 10px;
                background-color: #ffc107;
                margin: 20px 0;
            }
            .booked {
                background-color: grey;
                cursor: not-allowed;
            }
        </style>

        <title>Book Tickets</title>
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
        <h2>Book Tickets</h2>
        <%!
            int showId;
            ArrayList<Integer> bookedSeatsList; // To store booked seat numbers
            Statement st = null;
            Connection conn = null;
        %>
        <%
            try {

                // Establish a database connection (replace with your actual database configuration)
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmymovie", "root", "root");
                st = conn.createStatement();

                showId = Integer.parseInt(request.getParameter("showId"));

                // Query to retrieve show details
                String query = "SELECT Movies.*, Shows.ShowID, Shows.ShowTime "
                        + "FROM Movies "
                        + "JOIN Shows ON Movies.MovieID = Shows.MovieID "
                        + "WHERE Shows.ShowID = " + showId;

                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {

        %>
    <center>
        <div class="booking-container">
            <img src='assets/<%= rs.getString("PosterURL")%>' style="width: 300px" alt='Movie Poster'>
            <h2><%= rs.getString("Title")%></h2>
            <p><strong>Genre:</strong> <%= rs.getString("Genre")%></p>
            <p><strong>Show Time:</strong> <%= rs.getTimestamp("ShowTime")%></p>
        </div>
    </center>
    <%
            }

            // Close resources
            rs.close();
            // now checking how many seats are already booked
            String bookedSeatsQuery = "SELECT SeatNumber FROM Booking WHERE ShowID = " + showId;
            ResultSet bookedSeatsResult = st.executeQuery(bookedSeatsQuery);

            bookedSeatsList = new ArrayList<>();
            while (bookedSeatsResult.next()) {
                bookedSeatsList.add(bookedSeatsResult.getInt("SeatNumber"));
            }

            // Close the result set for booked seats
            bookedSeatsResult.close();

        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();
        }

    %>
    <center>
        <form action="UserBookTicket" method="post">
            <table>
                <tr>
                    <td>
                        <input type="hidden" name="showId" value="<%= showId%>">
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" name="selectedSeats" id="selectedSeatsInput" value="">
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="seats">Enter Seats to Book</label>
                    </td>
                    <td>
                        <input type="number" name="seats" min="1" value="1" required="">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong>Selected Seats:</strong> <span id="selectedSeatsCount">0</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="seating-layout" class="text-center">
                            <div id="firstDiv"></div><br>
                            <div id="secondDiv"></div><br>
                            <div id="thirdDiv"></div><br>
                        </div>
                        <div id="screen">
                            <hr>screen
                        </div><br>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h4>Payment</h4>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div>
                            <div>
                                <input type="radio" name="paymentMethod" value="credit card" required="">
                                <label>Credit card</label>
                            </div>
                            <div>
                                <input type="radio" name="paymentMethod" value="debit card" required="">
                                <label>Debit card</label>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="cc-name">Name on card</label>
                        <input type="text" name="cardHolderName" required="">
                        <small>Full name as displayed on card</small>
                    </td>
                    <td>
                        <label for="cc-number">Credit card number</label>
                        <input type="text" name="cardNumber" required="">
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="cc-expiration">Expiration</label>
                        <input type="text" name="expirationDate" required="">
                    </td>
                    <td>
                        <label for="cc-cvv">CVV</label>
                        <input type="text" name="cvv" required="">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr>
                        <button type="submit">Confirm Booking</button>
                    </td>
                </tr>
            </table>
        </form>

    </center>

    <script>
        const seatingLayout = document.getElementById('seating-layout');
        const firstdiv = document.getElementById('firstDiv');
        const seconddiv = document.getElementById('secondDiv');
        const thirddiv = document.getElementById('thirdDiv');
        const selectedSeatsCount = document.getElementById('selectedSeatsCount');
        const selectedSeatsInput = document.getElementById('selectedSeatsInput');

        const screen = document.getElementById('screen');
        const selectedSeats = [];

        const bookdseat = <%= bookedSeatsList%>;
        console.log(bookdseat);
        function generateSeatingLayout() {
            for (let i = 1; i <= 180; i++) {
                const seat = document.createElement('div');
                seat.className = 'seat';
                seat.textContent = i;
                seat.onclick = () => selectSeat(i);
                // Check if the seat is booked and mark it accordingly
                if (bookdseat.includes(i)) {
                    seat.classList.add('booked');
                }

                if (i <= 72) {
                    firstdiv.appendChild(seat);
                }
                if (i >= 73) {
                    seconddiv.appendChild(seat);
                }
                if (i >= 127) {
                    thirddiv.appendChild(seat);
                }
            }
        }

        function selectSeat(seatNumber) {
            const seatIndex = selectedSeats.indexOf(seatNumber);

            if (bookdseat.includes(seatNumber)) {
                // If the seat is already selected or booked, do nothing
                return;
            }
            if (seatIndex !== -1) {
                selectedSeats.splice(seatIndex, 1);
            } else {
                if (selectedSeats.length >= parseInt(document.getElementById('seats').value)) {
                    selectedSeats.shift(); // Remove the first seat if the limit is reached
                }
                selectedSeats.push(seatNumber);
            }

            updateUI();
        }

        function updateUI() {
            const seats = document.querySelectorAll('.seat');

            seats.forEach((seat, index) => {
                seat.classList.remove('selected');

                if (selectedSeats.includes(index + 1)) {
                    seat.classList.add('selected');
                }
            });

            // Update the displayed count of selected seats
            selectedSeatsCount.textContent = selectedSeats.length;

            // Update the value of the hidden input for selected seats
            selectedSeatsInput.value = selectedSeats.join(',');
        }

        generateSeatingLayout();
    </script>
    <%}%>
</body>
</html>
