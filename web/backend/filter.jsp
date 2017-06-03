<%-- 
    Document   : filter
    Created on : Jun 2, 2017, 5:52:21 PM
    Author     : Michael Mukolwe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("val");
    if (name == null || name.trim().equals("")) {
        out.print("<section class=\"section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp\" style=\"border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;\">"
                                            +"<p style=\"margin-left: 50px;margin-top: 40px;\">Search Result Empty, try <a target=\"_blank\" href=\"http://www.google.com\">www.google.com</a></p>"
                                        +"</section>");
    } else {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmer_sys_db", "root", "");
            PreparedStatement ps = con.prepareStatement("select * from post_epidemic where post_title like '%" + name + "%' or post_desc like'%" + name + "%'");
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>No Record Found!</p>");
            } else {
                out.print("<table class=\"table table-hover\">");
                out.print("<tr><th>#</th><th>Post Title</th><th>Posting</th><th>Action</th></tr>");
                while (rs.next()) {
                    out.print("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>"
                            + "<a class=\"btn btn-default\" href=\"ViewPost.jsp?post_id="+rs.getString(1)+"\">View</a></td></tr>");
                }
                out.print("</table>");
            }//end of else for rs.isBeforeFirst
            con.close();
        } catch (Exception e) {
            out.print(e);
        }
    }//end of else
%>