<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 필요한 라이브러이 등록 -->
<%@ page import = "java.sql.*,java.util.*" %>

<%@include file="connect_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출력 페이지</title>
<style>
	div{
	/*
		border :1px solid red;
		height : 300px;
		*/
		width : 600px;
		margin : 0 auto;
	}
	
	table, tr, td{
		padding: 5px;
		border-collapse: collapse;
	}
</style>
</head>
<body>
<!-- DataBase 에서 Select 한결과를 담는 변수 선언 : 컬랙션 : 방이자동으로 늘어난다.-->
<%
	ArrayList idx = new ArrayList();
	ArrayList ename = new ArrayList();
	ArrayList phone = new ArrayList();
	ArrayList gender = new ArrayList();
	ArrayList addr = new ArrayList();

	//사용할 변수 선언
	String sql= null; //SQL 쿼리를 담는 변수
	Statement stmt =null;
		//DBMS에 sql 쿼리를 보내는 객체 Connecrion 객체로 생성
	ResultSet rs = null; //select 한 결과 레코드 셋을 담은 객체
	
	//sql 쿼리를 변수에 할당
	sql = "select * from guestlab ORDER by ename desc";
	
	//connection(conn) 객체를 사용해서 statment객체를 생성
	stmt = con.createStatement(); 
	
	//stmt 객체를 실행, 
	rs = stmt.executeQuery(sql);
	
	//rs에 담긴 값을 루프를 돌리면서 출력
		//rs.next() : 커서의 위치를 다음 레코드로 이동
			//레코드가 존재하면 rs.next : true/레코드가 존재하지 않으면 false
	if(rs.next()){ //rs에 레코드가 있을때
		do{
			idx.add(rs.getString("idx"));
			ename.add(rs.getString("ename"));
			phone.add(rs.getString("phone"));
			gender.add(rs.getString("gender"));
			addr.add(rs.getString("addr"));
		}while(rs.next());
	}
	for(int i =0;i<idx.size();i++){
%>
<!-- rs에 담긴 내용을 출력할 테이블 생성 -->
	<!--  rs.getString("컬럼명")-->
<div>
	<table width="600px" border = "1px">
	<tr>
		<td colspan="2" align="center"><h3> 이름 : <%= ename.get(i) %></h3></td>
	</tr>
	<tr>
		<td>id : <%= idx.get(i) %></td>
		<td>phone : <%= phone.get(i) %></td>
	</tr>
	<tr>
		<td colspan="2">성별 : <%= gender.get(i) %></td>
	</tr>
	<tr>
		<td colspan="2" width="600px">주소 : <%= addr.get(i) %></td>
	</tr>
	
	</table>
	<p/> <p/>
	
	<%

		} 
	
	%>
	
</div>

</body>
</html>