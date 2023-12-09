<%@ page import="java.sql.*, java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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

        .review-container {
            margin-top: 20px;
            border-top: 1px solid #5D5348;
            padding-top: 10px;
        }

        .review {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<%

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

    if (session == null || session.getAttribute("authenticatedUser") == null) {
        out.println("<p>Please log in to submit reviews.</p>");
        %>
        <form action="login.jsp">
            <input type="submit" value="Log In">
        </form>
        <%
    } else {
       
        String loggedInUsername = session.getAttribute("authenticatedUser").toString();

      
        out.println("<h4>Add a Review:</h4>");
        out.println("<form name='reviewForm' method='post' action='submitReview.jsp'>");
        out.println("<input type='hidden' name='productId' value='" + productId + "'>");
        out.println("<input type='hidden' name='reviewerName' value='" + loggedInUsername + "'>");
        out.println("<textarea name='reviewText' rows='4' cols='50' required></textarea><br>");
        out.println("<label for='rating'>Rating (out of 5): </label>");
        out.println("<input type='number' name='rating' min='1' max='5' required><br>");
        out.println("<input type='submit' value='Submit Review'>");
        out.println("</form>");

       
        out.println("<div class='review-container'>");
        out.println("<h4>Product Reviews:</h4>");

        sql = "SELECT * FROM productreviews WHERE productId = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, productId);
        rst = ps.executeQuery();

        while (rst.next()) {
            String reviewerName = rst.getString("reviewerName");
            String reviewText = rst.getString("reviewText");
            int rating = rst.getInt("rating");

            out.println("<div class='review'>");
            out.println("<strong>" + reviewerName + ":</strong> Rating: " + rating + " - " + reviewText);
            out.println("</div>");
        }

        out.println("</div>");
    }

    out.println("<h4><a href='addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice + "'>Add to Cart</a></h4>");
    out.println("<h4><a href='listprod.jsp'>Continue Shopping</a></h4>");

} catch (SQLException ex) {
    out.println(ex);
    try {
        con.rollback();
    } catch (Exception e) {
    }
} finally {
    closeConnection();
}
%>

</body>
</html>
