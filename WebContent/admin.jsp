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
} catch (SQLException ex) {
    out.println("Error: " + ex.getMessage());
} finally {
    // TODO: Close the database connection
    closeConnection();
}
%>

</body>
</html>
