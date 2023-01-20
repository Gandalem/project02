<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.sql.*,java.text.*" %>
<%@ include file="connect_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬럼의 특정 레코드를 읽는 페이지 </title>
</head>
<body>

	<!-- JSP 코드 블락 -->
	<%
		//sql 쿼리를 사용할 변수 선언 블락
		String sql = null;
		Statement stmt = null;
		PreparedStatement pstmt = null; //변수를 ?로 처리함 statement 를 확장한 메소드
		ResultSet rs = null;
		
		//get 방식으로 넘어오는 변수 값을 저장
		//String 형식으로 모두 넘어온다 interger.parseint();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		
		
		/* statement 객체를 사용해서 처리
		sql = "select * from freeboard where id =" +id;
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		*/
		
		//preparedStatement 객체를 사용해서 처리, 변수의 들어가는 값을 ?로 처리함.
		sql = "select * from guestlab where idx = ?";
		pstmt = con.prepareStatement(sql); //pstmt 객체 생성시 sql 문을 넣는다.
		pstmt.setInt(1,idx); //1첫번째 물음표, 들어갈 변수 
		rs = pstmt.executeQuery(); //select 문인 경우 executeQuery()
									//insert,update,delete문인경우 : executeupdate()
		
		if(rs.next()){
			
		
	%>
	<table>
			   
			   <tr>
			   	<td> 
			  	이메일 : <%=rs.getString("email") %> </td>
			   </tr>
			   <tr>
			  	 <td>
			   		<table>
			   			<tr>
			   				<td>전화번호 :<%=rs.getString("phone") %> </td>
			   			</tr>
			   			<tr>
			   				<td>성별 :<%=rs.getString("gender") %> </td>
			   				<td>주소 : <%=rs.getString("addr") %> </td>
			   			</tr>
			   		</table>
			   	</td>
			   	</tr>
	 </table>
		<%
		}else{
			out.println("해당 레코드는 존재하지 않습니다.");
		}
		%> 	  
		
   <table width="600" border="0" cellpadding="0" cellspacing="5">
	<tr> 
		<td align="right" width="450"><A href="guestlab_list.jsp?go=<%= request.getParameter("page")%>"><img src="image/list.jpg" border=0></a></td>
		<td width="70" align="right"><A href="guestlab_riwire.jsp?idx=<%= request.getParameter("idx")%>&page=<%=request.getParameter("page") %>"> <img src="image/reply.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_upd.jsp?idx=<%=idx %>&page=<%= request.getParameter("page")%>"><img src="image/edit.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_del.jsp?idx=<%=idx %>&page=<%= request.getParameter("page")%>"><img src="image/del.jpg"  border=0></A></td>
	</tr>
  </table>

</BODY>
</HTML>

