<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>AJ SPORTS Shipment Processing</title>
<style>
	body {
			background-color: #8F9779; 
			color: #5D5348; 
			font-family: Arial, sans-serif;
	}
	</style>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
    int oId;
	try {
		oId = Integer.parseInt(request.getParameter("orderId"));
	} catch (NumberFormatException e) {
		out.println("<h2>Invalid Order ID. Please Provide a valid order ID. </h2>");
		%><h2><a href="shop.html">Back to Main Page</a></h2><%
		return;
	}

	// TODO: Check if valid order id in database
	boolean isValidOrder = false;
	
	try {
		getConnection();
		String checkOrderQuery = "SELECT orderId FROM ordersummary WHERE orderId = ?";
		PreparedStatement checkOrderPs = con.prepareStatement(checkOrderQuery);
		checkOrderPs.setInt(1, oId);
		ResultSet orderResult = checkOrderPs.executeQuery();
		isValidOrder = orderResult.next();
	} catch (SQLException e) {
		out.println("Error checking the validity of the order: " + e.getMessage());
		%><h2><a href="shop.html">Back to Main Page</a></h2><%
		return;
	} finally {
		closeConnection();
	}

	// TODO: Start a transaction (turn-off auto-commit)
	try {
		getConnection();
		con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id
	String getOrderItemsQuery = "SELECT orderId, productId, quantity FROM orderproduct WHERE orderId = ?";
	PreparedStatement getOrderItemsStmt = con.prepareStatement(getOrderItemsQuery);
	getOrderItemsStmt.setInt(1, oId);
	ResultSet orderItemsResult = getOrderItemsStmt.executeQuery();

	// TODO: Create a new shipment record.
	String insertShipmentQuery = "INSERT INTO shipment (shipmentDate) VALUES (?)";
	PreparedStatement insertShipmentStmt = con.prepareStatement(insertShipmentQuery, Statement.RETURN_GENERATED_KEYS);
	insertShipmentStmt.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
	insertShipmentStmt.executeUpdate();
	ResultSet generatedKeys = insertShipmentStmt.getGeneratedKeys();
	int shipmentId = 0;
	if (generatedKeys.next()) {
		shipmentId = generatedKeys.getInt(1);
	}

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	while (orderItemsResult.next()) {
		int productId = orderItemsResult.getInt("productId");
		int quantity = orderItemsResult.getInt("quantity");

		// Check inventory in warehouse 1
		String checkInventoryQuery = "SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = 1";
		PreparedStatement checkInventoryStmt = con.prepareStatement(checkInventoryQuery);
		checkInventoryStmt.setInt(1, productId);
		ResultSet inventoryResult = checkInventoryStmt.executeQuery();

		if (inventoryResult.next()) {
			int currentInventory = inventoryResult.getInt("quantity");
			if (currentInventory >= quantity) {
				// Sufficient inventory, update inventory and proceed
				int newInventory = currentInventory - quantity;

				// Update inventory
				String updateInventoryQuery = "UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = 1";
				PreparedStatement updateInventoryStmt = con.prepareStatement(updateInventoryQuery);
				updateInventoryStmt.setInt(1, newInventory);
				updateInventoryStmt.setInt(2, productId);
				updateInventoryStmt.executeUpdate();

				// Print information about the shipment
				out.println("<br> <h4> Ordered product: " + productId + " Qty: " + quantity +
				" Previous inventory: " + currentInventory +
				" New inventory: " + newInventory + "</h4>");

			} else {
				// Insufficient inventory, cancel transaction and rollback
				con.rollback();
				out.println("<h3>Shipment incomplete: Insufficient inventory for product id: " + productId + "</h3>");
				%><h2><a href="index.jsp">Back to Main Page</a></h2><%
				return;
			}
		} else {
			// Product not found in warehouse 1, cancel transaction and rollback
			con.rollback();
			out.println("Error: Product " + productId + " not found in warehouse 1");
			%><h2><a href="index.jsp">Back to Main Page</a></h2><%
			return;
		}
	}

	// TODO: Auto-commit should be turned back on
	con.commit();
        con.setAutoCommit(true);

        out.println("<h3>Shipment successfully processed.<h3></h3>");
    } catch (SQLException e) {
        // Error occurred, rollback and display error message
        try {
            con.rollback();
        } catch (SQLException ex) {
            out.println("Error rolling back transaction: " + ex.getMessage());
        }
        out.println("Error processing shipment: " + e.getMessage());
    } finally {
        closeConnection();
    }
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
