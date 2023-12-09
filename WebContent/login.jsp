<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Screen</title>
    <style>
        body {
            background-color: #8F9779;
            color: #5D5348;
            font-family: Arial, sans-serif;
        }

        

        th, td {
            border: 1px solid #5D5348;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>



<div style="margin:0 auto;text-align:center;display:inline">
    <h3>Please Login to System</h3>

    <%
   
    if (session.getAttribute("loginMessage") != null)
        out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");
    %>

    <br>
    <form name="MyForm" method="post" action="validateLogin.jsp">
        <table style="display:inline">
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
                <td><input type="text" name="username" size="10" maxlength="10"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
                <td><input type="password" name="password" size="10" maxlength="10"></td>
            </tr>
        </table>
        <br/>
        <input class="submit" type="submit" name="Submit2" value="Log In">
    </form>

    <br>
    <form action="createAccount.jsp">
        <input type="submit" value="Sign Up">
    </form>

</div>

</body>
</html>
