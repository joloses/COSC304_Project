<!DOCTYPE html>
<html>
<head>
        <title>AJ Sports Main Page</title>
</head>
<body>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null){
		out.println("<h1 align=\"center\">Welcome back to AJ Sports, "+userName+"! </h1>");
		out.println("<h2 align=\"center\"><a href='listprod.jsp'>Begin Shopping</a></h2>");
		out.println("<h2 align=\"center\"><a href='listorder.jsp'>List All Orders</a></h2>");
		out.println("<h2 align=\"center\"><a href='customer.jsp'>Customer Info</a></h2>");
		out.println("<h2 align=\"center\"><a href='admin.jsp'>Administrators</a></h2>");
		out.println("<h2 align=\"center\"><a href='logout.jsp'>Log out</a></h2>");
	} else {
		out.println("<h1 align=\"center\">Welcome to AJ Sports!</h1>");
		out.println("<h2 align=\"center\"><a href='login.jsp'>Login</a></h2>");
		out.println("<h2 align=\"center\"><a href='listprod.jsp'>Begin Shopping</a></h2>");
		out.println("<h2 align=\"center\"><a href='listorder.jsp'>List All Orders</a></h2>");
	}
%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

<style>
	body {
			background-color: #8F9779; 
			color: #5D5348; 
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	}
	</style>

</body>
</head>


