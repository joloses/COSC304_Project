<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
    <style>
        body {
            background-color: #8F9779;
            color: #5D5348;
            font-family: Arial, sans-serif;
            margin: 0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #5D5348;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #5D5348;
            color: #FFFFFF;
        }

        h1, h2 {
            color: #5D5348;
        }

        a {
            color: #5D5348;
            text-decoration: none;
        }


    </style>
</head>
<body>


<%@ include file="header.jsp" %>
<%

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    out.println("<H1>Your shopping cart is empty!</H1>");
    productList = new HashMap<String, ArrayList<Object>>();
} else {
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Update Quantity</th><th>Remove Item</th><th>Price</th><th>Subtotal</th></tr>");

    double total = 0;
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while (iterator.hasNext()) {
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        String productId = entry.getKey();
        ArrayList<Object> product = entry.getValue();

        out.print("<tr><td>" + product.get(0) + "</td>");
        out.print("<td>" + product.get(1) + "</td>");

        out.print("<td align=\"center\">" + product.get(3) + "</td>");
        Object price = product.get(2);
        Object itemqty = product.get(3);
        double pr = 0;
        int qty = 0;

        try {
            pr = Double.parseDouble(price.toString());
        } catch (Exception e) {
            out.println("Invalid price for product: " + product.get(0) + " price: " + price);
        }
        try {
            qty = Integer.parseInt(itemqty.toString());
        } catch (Exception e) {
            out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
        }

        
        out.println("<td align=\"center\">");
        out.println("<form method=\"post\" action=\"updateQuantity.jsp\">");
        out.println("<input type=\"hidden\" name=\"productId\" value=\"" + productId + "\">");
        out.println("<input type=\"number\" name=\"quantity\" value=\"" + qty + "\" min=\"1\" required>");
        out.println("<input type=\"submit\" value=\"Update\">");
        out.println("</form>");
        out.println("</td>");

      
        out.println("<td align=\"center\">");
        out.println("<a href=\"removeItem.jsp?productId=" + productId + "\">Remove</a>");
        out.println("</td>");

        // Display subtotal
        out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");

        total = total + pr * qty;
    }
    out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
            + "<td></td><td></td><td align=\"right\">" + currFormat.format(total) + "</td></tr>");
    out.println("</table>");

    out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>

<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>
