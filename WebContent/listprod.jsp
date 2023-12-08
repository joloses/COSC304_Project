<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>AJ SPORTS</title>
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
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>

    <h1>Search for the products you want to buy:</h1>

    <form method="get" action="listprod.jsp">
        <input type="text" name="productName" size="50">
        <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
    </form>

    <%
	// Get product name to search for
	String name = request.getParameter("productName");
	boolean hasParameter = false;
	String sql = "";

	if (name == null)
		name = "";

	if (name.equals("")) 
	{
		out.println("<h2>All Products</h2>");
		sql = "SELECT productId, productName, productPrice FROM Product";
	} 
	else 
	{
        
		out.println("<h2>Products containing '" + (name) + "'</h2>");
		hasParameter = true;
		sql = "SELECT productId, productName, productPrice FROM Product WHERE productName LIKE ?";
        name = '%' + name + '%';
    }
		
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	try 
	{			
		getConnection();    	

		PreparedStatement pstmt = con.prepareStatement(sql);
		if (hasParameter)
			pstmt.setString(1, name);

		ResultSet rst = pstmt.executeQuery();
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst.next()) 
		{
			out.print("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");
			out.println("<td><a href=\"product.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "\">" + rst.getString(2) + "</a></td>"
					+ "<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		}
		out.println("</table>");
	} 
	catch (SQLException ex) 
	{
		out.println(ex);
	} 	
	finally
	{
		closeConnection();
	}
%>

</body>
</html>
