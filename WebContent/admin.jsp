<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
    <style>
        body {
                background-color: #8F9779; 
                color: #5D5348; 
                font-family: Arial, sans-serif;
        }
        </style>
</head>
<body>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<%
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT CONVERT(date, orderDate) AS OrderDay, SUM(totalAmount) AS TotalAmount "
        + "FROM OrderSummary "
        + "GROUP BY CONVERT(date, orderDate) "
        + "ORDER BY OrderDay DESC";
%>

<h1>Administrator Page</h1>

<%
try {
    // TODO: Establish a database connection
    getConnection();

    // TODO: Execute the SQL query
    PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet resultSet = pstmt.executeQuery();
%>

<table border="1">
    <tr>
        <th>Order Day</th>
        <th>Total Amount</th>
    </tr>

    <%
        while (resultSet.next()) {
            String orderDay = resultSet.getString("OrderDay");
            double totalAmount = resultSet.getDouble("TotalAmount");
    %>

    <tr>
        <td><%= orderDay %></td>
        <td><%= totalAmount %></td>
    </tr>

    <%
        }
    %>
</table>

<%
		con.setAutoCommit(false);
	
	String userId = (String) session.getAttribute("authenticatedUser");
// TODO: Print Customer information
	String sql1 = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer";
	PreparedStatement ps = con.prepareStatement(sql1);
	ResultSet rst = ps.executeQuery();

	while (rst.next()) {
%>

		<h1>Customer Profile</h1>
	<table border="1">
        <tr>
            <th>ID</th>
            <td><%= rst.getInt("customerId") %></td>
        </tr>
        <tr>
            <th>First Name</th>
            <td><%= rst.getString("firstName") %></td>
        </tr>
        <tr>
            <th>Last Name</th>
            <td><%= rst.getString("lastName") %></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><%= rst.getString("email") %></td>
        </tr>
        <tr>
            <th>Phone</th>
            <td><%= rst.getString("phonenum") %></td>
        </tr>
        <tr>
            <th>Address</th>
            <td><%= rst.getString("address") %></td>
        </tr>
        <tr>
            <th>City</th>
            <td><%= rst.getString("city") %></td>
        </tr>
        <tr>
            <th>State</th>
            <td><%= rst.getString("state") %></td>
        </tr>
        <tr>
            <th>Postal Code</th>
            <td><%= rst.getString("postalCode") %></td>
        </tr>
        <tr>
            <th>Country</th>
            <td><%= rst.getString("country") %></td>
        </tr>
        <tr>
            <th>User ID</th>
            <td><%= rst.getString("userid") %></td>
        </tr>
    </table>

<%
}
	con.commit();
    %>
<%
} catch (SQLException ex) {
    out.println("Error: " + ex.getMessage());
} finally {
    // TODO: Close the database connection
    closeConnection();
}
%>

</body>
</html>
