<%@ page import="java.sql.*, java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>AJ SPORTS - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	body {
			background-color: #8F9779; 
			color: #5D5348; 
			font-family: Arial, sans-serif;
	}

    img {
            width: 25%;
            height: auto;
    }
	</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
    String productId = request.getParameter("id");
    String productName = "";
    double productPrice = 0.0;
    String productImageURL = "";
    String productImage = "";
    String productDesc = "";

    String sql = "";

    try {
        getConnection();    	
        con.setAutoCommit(false);

        sql = "SELECT productName, productId, productDesc, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, productId);
        ResultSet rst = ps.executeQuery();

        if (rst.next()) {
            productId = rst.getString("productId");
            productName = rst.getString("productName");
            productPrice = rst.getDouble("productPrice");
            productImageURL = rst.getString("productImageURL");
            productImage = rst.getString("productImage");
            productDesc = rst.getString("productDesc");
        }

        out.println("<h1>" + productName + "</h1>");

        if (productImageURL != null) {
            out.println("<img src =" + productImageURL + ">");
        }
        if (productImage != null) {
            out.println("<img src= 'displayImage.jsp?id=" + productId + "' ><br>");
        }

        out.println("<br><b> Id:</b> " + productId);
        out.println("<br><b> Description:</b> " + productDesc);
        out.println("<br><b> Price:</b> " + NumberFormat.getCurrencyInstance(Locale.US).format(productPrice) + "<br><br>");
        

        out.println("<h4><a href='addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice + "'>Add to Cart</a></h4>");
        out.println("<h4><a href='listprod.jsp'>Continue Shopping</a></h4>");

    }   catch (SQLException ex) { 
        	out.println(ex);
			try {
                con.rollback();
            }
			catch (Exception e)
            {}
		}	
		finally {
            closeConnection();
        }
        %>

</body>
</html>

