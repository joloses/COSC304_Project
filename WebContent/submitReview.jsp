<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="jdbc.jsp" %>

<%
String productId = request.getParameter("productId");
String reviewerName = request.getParameter("reviewerName"); // Get the reviewer's name from the form input
String reviewText = request.getParameter("reviewText");
int rating = Integer.parseInt(request.getParameter("rating")); // Parse the rating parameter

try {
    getConnection();

    // Insert the review into the database
    String insertReviewQuery = "INSERT INTO productreviews (productId, reviewerName, reviewText, rating) VALUES (?, ?, ?, ?)";
    PreparedStatement insertReviewStmt = con.prepareStatement(insertReviewQuery);
    insertReviewStmt.setString(1, productId);
    insertReviewStmt.setString(2, reviewerName);
    insertReviewStmt.setString(3, reviewText);
    insertReviewStmt.setInt(4, rating);
    insertReviewStmt.executeUpdate();

    // Redirect back to the product information page
    response.sendRedirect("product.jsp?id=" + productId);
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<p>Error submitting review. Please try again.</p>");
} finally {
    closeConnection();
}
%>
