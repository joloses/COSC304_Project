<!-- confirmation.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>AJ Grocery Order Confirmation</title>
</head>
<body>

<h1>Order Confirmation</h1>

<p>Please review your order details before final submission:</p>

<!-- Display Order Details -->
<%
    // Retrieve data from the request
    String customerId = request.getParameter("customerId");
    String paymentMethod = request.getParameter("paymentMethod");
    String creditCardNumber = request.getParameter("creditCardNumber");
    String securityCode = request.getParameter("securityCode");
    String expiryDate = request.getParameter("expiryDate");
    String shipmentAddress = request.getParameter("shipmentAddress");
    String shipmentCity = request.getParameter("shipmentCity");
%>

<!-- Display Order Details Table -->
<table border="1">
    <tr>
        <td><b>Customer ID:</b></td>
        <td><%= customerId %></td>
    </tr>
    <tr>
        <td><b>Payment Method:</b></td>
        <td><%= paymentMethod %></td>
    </tr>
    <tr>
        <td><b>Credit Card Number:</b></td>
        <td><%= creditCardNumber %></td>
    </tr>
    <tr>
        <td><b>Security Code:</b></td>
        <td><%= securityCode %></td>
    </tr>
    <tr>
        <td><b>Expiry Date:</b></td>
        <td><%= expiryDate %></td>
    </tr>
    <tr>
        <td><b>Shipment Address:</b></td>
        <td><%= shipmentAddress %></td>
    </tr>
    <tr>
        <td><b>Shipment City:</b></td>
        <td><%= shipmentCity %></td>
    </tr>
</table>

<!-- Confirm or Go Back Buttons -->
<form method="post" action="order.jsp">
    <input type="hidden" name="customerId" value="<%= customerId %>">
    <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">
    <input type="hidden" name="creditCardNumber" value="<%= creditCardNumber %>">
    <input type="hidden" name="securityCode" value="<%= securityCode %>">
    <input type="hidden" name="expiryDate" value="<%= expiryDate %>">
    <input type="hidden" name="shipmentAddress" value="<%= shipmentAddress %>">
    <input type="hidden" name="shipmentCity" value="<%= shipmentCity %>">

    <input type="submit" value="Confirm Order">
</form>
<br>
<a href="checkout.html">Go Back</a>

<style>
    body {
        background-color: #8F9779; 
        color: #5D5348; 
        font-family: Arial, sans-serif;
    }

    table {
        border-collapse: collapse;
        width: 50%;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #5D5348;
        padding: 8px;
        text-align: left;
    }
</style>

</body>
</html>
