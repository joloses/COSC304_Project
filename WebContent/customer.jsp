<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	body {
			background-color: #8F9779; 
			color: #5D5348; 
			font-family: Arial, sans-serif;
	}
	</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	
%>

<%
	try {
		getConnection();
		con.setAutoCommit(false);
	
	String userId = (String) session.getAttribute("authenticatedUser");
// TODO: Print Customer information
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userId = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, userId);
	ResultSet rst = ps.executeQuery();

	if (rst.next()) {
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
} else {
	out.println("Customer not found");
}
	con.commit();
		} 
// Make sure to close connection
	catch (SQLException ex) {
		out.println(ex);
		try {
			con.rollback();
			}
	catch (Exception e)
	{out.println(e);}
	}	
	finally {
	closeConnection();
}
%>

</body>
</html>

