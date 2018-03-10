<%--
  Created by IntelliJ IDEA.
  User: 高子超
  Date: 2018/2/10
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Connection connect = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs","root", "115051");
	} catch(ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
%>

<%!
	private StringBuilder sb = null;
	private void showTree(Connection connect, int pid, int level) {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM article WHERE pid = " + pid;
			stmt = connect.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				StringBuilder str = new StringBuilder();
				for(int i = 1; i < level; i++) {
					str.append("****");
				}
				sb.append("<tr>\n");
				sb.append("<td>").append(rs.getString("id")).append("</td>\n");
				
				sb.append("<td><a href='ShowArticleCont.jsp?id=").append(rs.getString("id")).append("'>")
						.append(str).append(rs.getString("title"))
						.append("</a></td>\n");
				
				sb.append("<td><a href='Reply.jsp?id=").append(rs.getString("id"))  //<td><a href=='ReplayAction.jsp?id=rs.getString("id")
						.append("&rootID=").append(rs.getString("rootid")).append("'>")     //&rootID=rs.getString("rootid")'>
						.append("回复").append("</a>")                                       //回复</a>
						.append("\t")
						.append("<a href='DelAction.jsp?id=").append(rs.getString("id")).append("'>") //<a href='ReplayAction.jsp?id=rs.getString("id")'>
						.append("删除</a></td>\n");                                          //删除</a></td>
				sb.append("</tr>\n");
				
				if(rs.getInt("isleaf") == 0) {
					showTree(connect, rs.getInt("id"), level + 1);
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				
				if(rs != null) {
					rs.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
%>

<html>
<head>
	<title>ShowArticleTree</title>
</head>
<body>
<%
	sb = new StringBuilder();
	showTree(connect, 0, 1);
%>

<a href="Reply.jsp?id=0&rootID=0">发表新帖</a>
<table border="1">
	<%= sb.toString()%>
</table>
</body>

<%
	try {
		if(connect != null) {
			connect.close();
		}
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>
</html>
