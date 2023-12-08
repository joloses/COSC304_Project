<!DOCTYPE html>
<html>
<head>
    <title>AJ Sports Main Page</title>
    <style>
        body {
            background-color: #8F9779;
            color: #5D5348;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        header {
            background-color: #5D5348;
            padding: 10px;
            text-align: center;
        }

        header a {
            color: #FFFFFF;
            margin: 0 10px;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <a href="index.jsp">Home</a>
    <a href="listprod.jsp">Products</a>
    <a href="showcart.jsp">Cart</a>
    <a href="logout.jsp">Logout</a>
</header>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
if (session.getAttribute("registrationMessage") != null)
    out.println("<p>" + session.getAttribute("registrationMessage").toString() + "</p>");
%>

<h3>Create User Account</h3>

<form name="registrationForm" method="post" action="registerUser.jsp">
    <table>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
            <td><input type="text" name="firstName" size="20" maxlength="40" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
            <td><input type="text" name="lastName" size="20" maxlength="40" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
            <td><input type="text" name="email" size="30" maxlength="50" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
            <td><input type="text" name="phonenum" size="15" maxlength="20" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
            <td><input type="text" name="address" size="30" maxlength="50" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
            <td><input type="text" name="city" size="20" maxlength="40" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
            <td><input type="text" name="state" size="20" maxlength="20" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
            <td><input type="text" name="postalCode" size="10" maxlength="20" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
            <td><input type="text" name="country" size="20" maxlength="40" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
            <td><input type="text" name="username" size="15" maxlength="20" required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
            <td><input type="password" name="password" size="15" maxlength="30" required></td>
        </tr>
    </table>
    <br/>
    <input type="submit" value="Create Account">
</form>
