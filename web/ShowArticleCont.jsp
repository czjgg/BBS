<%--suppress SqlResolve --%>
<%--
  Created by IntelliJ IDEA.
  User: 高子超
  Date: 2018/2/10
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
	String id = request.getParameter("id");
	String rootID = null;
	Connection connect = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "115051");
		stmt = connect.createStatement();
		rs = stmt.executeQuery("SELECT * FROM article WHERE id = " + id);
	} catch (SQLException | ClassNotFoundException e) {
		e.printStackTrace();
	}
%>

<html>
<head>
	<title>ShowArticleCont</title>
</head>
<body>
<%
	try {
		if(rs != null && rs.next()) {
			rootID = rs.getString("rootid");
%>

<table border="1">
	<tr>
		<td>ID</td>
		<td><%= rs.getString("id")%></td>
	</tr>
	<tr>
		<td>Title</td>
		<td><%= rs.getString("title")%></td>
	</tr>
	<tr>
		<td>Content</td>
		<td><%= rs.getString("cont")%></td>
	</tr>
</table>
<%
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
			
			if(connect != null) {
				connect.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
<a href="Reply.jsp?id=<%= request.getParameter("id")%>&rootID=<%= rootID%>">回复</a>
<a href="DelAction.jsp.jsp?id=<%= request.getParameter("id")%>">删除</a>
</body>
</html>
