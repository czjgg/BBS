<%--
  Created by IntelliJ IDEA.
  User: 高子超
  Date: 2018/2/11
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>Reply</title>
</head>
<body>
<div align="center">
	<form method="post" action="ReplyAction.jsp?
					pid=<%= request.getParameter("id")%>&rootID=<%= request.getParameter("rootID")%>">
		<table border="1">
			<tr>
				<td>标题</td>
				<td><input type="text" name="reTitle" size="88"></td>
			</tr>
			<tr>
				<td>回复</td>
				<td><textarea name="reCont" cols="65" rows="25"></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="sub" value="提交"></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
