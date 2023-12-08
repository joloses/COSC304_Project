<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="jdbc.jsp" %>

<%
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String email = request.getParameter("email");
String phonenum = request.getParameter("phonenum");
String address = request.getParameter("address");
String username = request.getParameter("username");
String password = request.getParameter("password");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalCode = request.getParameter("postalCode");
String country = request.getParameter("country");


try {
    getConnection();

   
    if (firstName == null || lastName == null || email == null || phonenum == null || address == null || username == null || password == null ||
        firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || phonenum.isEmpty() || address.isEmpty() || username.isEmpty() || password.isEmpty()) {
        session.setAttribute("registrationMessage", "Please fill in all required fields.");
        response.sendRedirect("createAccount.jsp");
    } else {
       
		String insertQuery = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

PreparedStatement insertStmt = con.prepareStatement(insertQuery);
insertStmt.setString(1, firstName);
insertStmt.setString(2, lastName);
insertStmt.setString(3, email);
insertStmt.setString(4, phonenum);
insertStmt.setString(5, address);
insertStmt.setString(6, city);
insertStmt.setString(7, state);
insertStmt.setString(8, postalCode);
insertStmt.setString(9, country);
insertStmt.setString(10, username);
insertStmt.setString(11, password);
insertStmt.executeUpdate();

        session.setAttribute("registrationMessage", "Account created successfully. You can now log in.");
        response.sendRedirect("login.jsp");
    }
} catch (SQLException e) {
    e.printStackTrace();
    session.setAttribute("registrationMessage", "Error processing registration. Please try again.");
    response.sendRedirect("createAccount.jsp");
} finally {
    closeConnection();
}
%>
