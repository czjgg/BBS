<%--
  Created by IntelliJ IDEA.
  User: 高子超
  Date: 2018/2/11
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
	Connection connect = null;
	Statement stmt = null;
	ResultSet rs = null;
	String id = null;
	try {
		id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "115051");
		stmt = connect.createStatement();
		rs = stmt.executeQuery("SELECT * FROM article WHERE id=" + id);
		String pid = null;
		if(rs.next()) {
			pid = rs.getString("pid");
		}
		rs = stmt.executeQuery("SELECT * FROM article WHERE pid=" + pid);
		if(!rs.next()) {
			stmt.executeUpdate("UPDATE article SET isleaf=0 WHERE id=" + pid);
		}
		
	} catch (SQLException | ClassNotFoundException e) {
		e.printStackTrace();
	} finally {
		try {
			if(stmt != null) {
				stmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	deleteTree(connect, id);

	try {
		stmt = connect.createStatement();
		rs = stmt.executeQuery("SELECT * FROM article");
		int thisID = Integer.valueOf(id);
		int maxID = 0;
		int temp;
		while(rs.next()) {
			temp = rs.getInt("id");
			if(thisID != temp && maxID < temp) {
				maxID = temp;
			}
		}
		maxID += 1;
		if(thisID >= maxID) {
			stmt.executeUpdate("ALTER TABLE article AUTO_INCREMENT=" + maxID);
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
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
%>

<%!
	private void deleteTree(Connection connect, String id) {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = connect.createStatement();
			rs = stmt.executeQuery("SELECT * FROM article WHERE pid=" + id);
			while(rs.next()) {
				deleteTree(connect, rs.getString("id"));
			}
			stmt.executeUpdate("DELETE FROM article WHERE id=" + id);
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
%>

<html>
<head>
	<title>DelAction</title>
	<meta http-equiv="refresh" content="3;url=ShowArticleTree.jsp">
</head>
<body>
删除成功，稍后将自动跳转。或者<a href="ShowArticleTree.jsp">点我跳转</a>
</body>
</html>
