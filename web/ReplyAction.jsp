<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: 高子超
  Date: 2018/2/11
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	Connection connect = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	
	request.setCharacterEncoding("UTF-8");
	String pid = request.getParameter("pid");
	String rootID = request.getParameter("rootID");
	String title = request.getParameter("reTitle");
	String context = request.getParameter("reCont");
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "115051");
		stmt = connect.createStatement();
		
		String sql = "INSERT INTO article VALUES (null, ?, ?, ?, ?, now(), 1)";
		pstmt = connect.prepareStatement(sql , Statement.RETURN_GENERATED_KEYS);
		pstmt.setInt(1, Integer.valueOf(pid));
		pstmt.setInt(2, Integer.valueOf(rootID));
		pstmt.setString(3, title);
		pstmt.setString(4, context);
		pstmt.executeUpdate();
		if(pid.equals("0")) {
			ResultSet rsKey = pstmt.getGeneratedKeys();
			if(rsKey.next()) {
				int key = rsKey.getInt(1);
				stmt.executeUpdate("UPDATE article SET rootid=" + key + " WHERE id=" + key);
			}
		} else {
			stmt.executeUpdate("UPDATE article SET isleaf=0 WHERE id=" + pid);
		}
	} catch (SQLException | ClassNotFoundException e) {
		e.printStackTrace();
	} finally {
		try {
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
<html>
<head>
	<title>ReplyAction</title>
	<meta http-equiv="refresh" content="3;url=ShowArticleTree.jsp">
</head>
<body>
回复成功，稍后将自动跳转。或者<a href="ShowArticleTree.jsp">点我跳转</a>
</body>
</html>
