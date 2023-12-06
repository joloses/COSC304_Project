<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
    String authenticatedUser = null;
    session = request.getSession(true);

    try {
        authenticatedUser = validateLogin(out, request, session);
    } catch (IOException e) {
        System.err.println(e);
    }

    if (authenticatedUser != null) {
        response.sendRedirect("index.jsp"); // Successful login
    } else {
        response.sendRedirect("login.jsp"); // Failed login - redirect back to the login page with a message
    }
%>

<%!
    String validateLogin(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String retStr = null;

        if (username == null || password == null)
            return null;
        if ((username.length() == 0) || (password.length() == 0))
            return null;

        try {
            getConnection();

            // TODO: Check if userId and password match some customer account in your database
            String sql = "SELECT * FROM Customer WHERE userId = ? AND password = ?";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // If the user exists and the password matches, set retStr to be the username
                    retStr = username;
                }
            }
        } catch (SQLException ex) {
            out.println(ex);
        } finally {
            closeConnection();
        }

        if (retStr != null) {
            session.removeAttribute("loginMessage");
            session.setAttribute("authenticatedUser", username);
        } else {
            session.setAttribute("loginMessage", "Invalid username/password. Please try again.");
        }

        return retStr;
    }
%>
