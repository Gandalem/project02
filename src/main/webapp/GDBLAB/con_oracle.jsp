<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB 연결</title>
</head>
<body>
	<%
	Connection con = null;
	String Driver ="oracle.jdbc.driver.OracleDriver";
	String url ="jdbc:oracle:thin:@localhost:1521:XE";
	Boolean connect = false;
	try{
		Class.forName(Driver);
		con = DriverManager.getConnection(url,"C##HR","1234");
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</body>
</html>