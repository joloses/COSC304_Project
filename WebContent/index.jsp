<%@ page import="java.sql.*, java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <title>AJ Sports Main Page</title>
    <style>
        body {
            background-color: #8F9779;
            color: #5D5348;
            font-family: Arial, sans-serif;
            margin: 0; 
        }

        header {
            background-color: #5D5348;; 
            padding: 10px; 
            text-align: center;
            color: #fff; 
        }

        nav a {
            display: inline-block;
            margin: 0 10px; 
            color: #fff; 
            text-decoration: none;
			font-weight: bold;
        }
		
    </style>
</head>

<body>

<header>
    <p>
        <%
            String userName = (String) session.getAttribute("authenticatedUser");
            if (userName != null){
        %>
        </p>
        <nav>
            <a href='listprod.jsp'>Begin Shopping</a>
            <a href='listorder.jsp'>List All Orders</a>
            <a href='customer.jsp'>Customer Info</a>
            <a href='admin.jsp'>Administrators</a>
            <a href='logout.jsp'>Log out</a>
        </nav>
        <%
		out.println("<h2>" +"Welcome back to AJ Sports, " + userName + "!" + "</h2>");
            } else {
        %>
        <nav>
            <a href='login.jsp'>Login</a>
            <a href='createAccount.jsp'>Sign Up</a>
            <a href='listprod.jsp'>Begin Shopping</a>
            <a href='listorder.jsp'>List All Orders</a>
        </nav>
		<h2>Welcome to AJ Sports!</h2>
        <%
            }
        %>
</header>

<div style="text-align: center; margin-top: 20px;">
    <img src="img/logo1.png" alt="Logo">
</div>

<%
String productName = "";
Double productPrice = 0.0;
String productImageURL = "";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try {
	getConnection();

String productId = "3";
String sql = "SELECT productId, productName, productPrice, productImageURL FROM product WHERE productId = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, productId);
ResultSet rst = ps.executeQuery();

if (rst.next()) {
	productId = rst.getString("productId");
	productName = rst.getString("productName");
	productPrice = rst.getDouble("productPrice");
	productImageURL = rst.getString("productImageURL");
}

out.println("<div style=\"text-align: center;\">"
	+ "Random Item of the Day!"
	+ "<br/>"
	+ "<a href=\"product.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "\">" 
	+ rst.getString(2) + "</a>"
	+ "<br/>"
	+ currFormat.format(rst.getDouble(3)) 
	+ "</div>");


if (productImageURL != null) {
    out.println("<div style=\"text-align: center;\">"
		+ "<img src=\"" + productImageURL + "\" style=\"width: 15%; height: auto;\">"
		+ "</div>");

}

}catch (SQLException ex) 
	{
		out.println(ex);
	} 	
	finally
	{
		closeConnection();
	}

%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>
<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>

</html>
