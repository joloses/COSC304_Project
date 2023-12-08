<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%
    String productId = request.getParameter("productId");
    String quantityString = request.getParameter("quantity");

    if (productId != null && quantityString != null) {
        try {
            int quantity = Integer.parseInt(quantityString);

           
            @SuppressWarnings({"unchecked"})
            HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

            if (productList != null && productList.containsKey(productId)) {
                ArrayList<Object> product = productList.get(productId);
                product.set(3, quantity); 
                session.setAttribute("productList", productList);
            }
        } catch (NumberFormatException e) {
           
            response.sendRedirect("showcart.jsp");
            return;
        }
    }

    response.sendRedirect("showcart.jsp");
%>
