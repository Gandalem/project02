<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*,java.util.*,java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "connect_oracle.jsp" %>

<%
	String em = request.getParameter("email");
	String ph = request.getParameter("phone");
	String gen = request.getParameter("gender");
	String addr = request.getParameter("addr");
	
	int idx = 1;

	String sql = null; 
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
	stmt = con.createStatement();
	sql = "select max(idx) from guestlab";
	rs = stmt.executeQuery(sql);
	
	if(!(rs.next())){
		idx = 1;
	}else{
		idx = rs.getInt(1)+1;
	}
	
	
	sql = "insert into guestlab (idx,email,phone,gender,addr)";
	sql +="values(?,?,?,?,?)";
	
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1,idx);
	pstmt.setString(2,em);
	pstmt.setString(3,ph);
	pstmt.setString(4,gen);
	pstmt.setString(5,addr);
	
	
	//out.println(sql);
	
	//int cnt = 0;//sql 쿼리가 잘 처리되엇는지 확인 변수
	
	
	//Statement 객체가 sql 쿼리를 실행해서 DB에 저장
	pstmt.executeUpdate(); //Statment 객체의 excuteUpdate(sql) : insert, upsate, delete
	//stmt.executeQuery(sql); //Statment 객체의 excuteUpdate(sql) : select
								//recordset객체로 리턴을 시켜줌 : select한 결과를 담은객체
				
	}catch(Exception e){
		out.println("예상치 못한 오류가 발생했습니다.<p/>");
		 out.println("고객센터 : 02-1111-1111 <p/>");
		 e.printStackTrace();
	}finally{
		 if(con != null){
			 con.close();
		 }
		 if(stmt != null){
			 stmt.close();
		 }
		 if(rs != null){
			 rs.close();
		 }
	 }
	//statement 객체나 preparedStatement 객체를 사용해서 insert/update/delete
		//저장할 경우 commit는 자동으로 처리
	/*
	out.println(cnt);
	if(cnt>0){
		out.println("DB에 잘 insert 했습니다");
		
	}else{
		out.println("DB에 저장을 실패 했습니다.");
	}
	*/
%>
<jsp:forward page ="guestlab_list.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 저장</title>
</head>
<body>

</body>
</html>