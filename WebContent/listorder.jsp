<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<head>
		<title>Order List</title>
		<style>
			body {
				background-color: #8F9779; 
				color: #5D5348; 
				font-family: Arial, sans-serif;
			}
	
			table {
				border: 1px solid #5D5348; 
				border-collapse: collapse;
				width: 100%;
				margin-top: 20px;
			}
	
			th, td {
				border: 1px solid #5D5348; 
				padding: 10px;
				text-align: left;
			}
	
			th {
				background-color: #8F9779;
				color: white;
			}
	
			h1 {
				color: #5D5348; 
				font-size: 1.6em; 
			}
		</style>
	</head>
<body>

<%@ include file="header.jsp" %>
<h1>Order List</h1>

<%
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
} catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
}

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);
     Statement stmt = con.createStatement()) {

    String query = "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount, op.productId, op.quantity, op.price " +
            "FROM ordersummary os " +
            "JOIN customer c ON os.customerId = c.customerId " +
            "JOIN orderproduct op ON os.orderId = op.orderId " +
            "ORDER BY os.orderDate, os.orderId, op.productId";

    ResultSet resultSet = stmt.executeQuery(query);

    int currentOrderId = 0;

    while (resultSet.next()) {
        int orderId = resultSet.getInt("orderId");
        Timestamp orderDate = resultSet.getTimestamp("orderDate");
        int customerId = resultSet.getInt("customerId");
        String firstName = resultSet.getString("firstName");
        String lastName = resultSet.getString("lastName");
        double totalAmount = resultSet.getDouble("totalAmount");
        int productId = resultSet.getInt("productId");
        int quantity = resultSet.getInt("quantity");
        double price = resultSet.getDouble("price");

       
        String fullName = firstName + " " + lastName;

       
        if (orderId != currentOrderId) {
          
            if (currentOrderId != 0) {
                out.println("</table>");
            }

            out.println("<h1>Order ID: " + orderId + "</h1>");
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>Order ID</th>");
            out.println("<th>Order Date</th>");
            out.println("<th>Customer Id</th>");
            out.println("<th>Customer Name</th>");
            out.println("<th>Total Amount</th>");
            out.println("<th>Product Id</th>");
            out.println("<th>Quantity</th>");
            out.println("<th>Price</th>");
            out.println("</tr>");

            out.println("<tr>");
            out.println("<td>" + orderId + "</td>");
            out.println("<td>" + orderDate + "</td>");
            out.println("<td>" + customerId + "</td>");
            out.println("<td>" + fullName + "</td>");
            out.println("<td>" + NumberFormat.getCurrencyInstance().format(totalAmount) + "</td>");
            out.println("<td>" + productId + "</td>");
            out.println("<td>" + quantity + "</td>");
            out.println("<td>" + NumberFormat.getCurrencyInstance().format(price) + "</td>");
            out.println("</tr>");
        } else {
           
            out.println("<tr>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
			out.println("<td></td>");
			out.println("<td>" + productId + "</td>");
			out.println("<td>" + quantity + "</td>");
            out.println("<td>" + NumberFormat.getCurrencyInstance().format(price) + "</td>");
            out.println("</tr>");
        }

        currentOrderId = orderId;
    }

   
    if (currentOrderId != 0) {
        out.println("</table>");
    }

} catch (Exception e) {
    out.println("Exception: " + e);
}
%>

</body>
</html>
