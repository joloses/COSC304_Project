<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%
    String productId = request.getParameter("productId");

    if (productId != null) {
       
        @SuppressWarnings({"unchecked"})
        HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

        if (productList != null && productList.containsKey(productId)) {
            productList.remove(productId); 
            session.setAttribute("productList", productList);
        }
    }

    response.sendRedirect("showcart.jsp");
%>
