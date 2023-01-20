<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %> 
<%@ include file="connect_oracle.jsp" %>

<%
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	/*
	out.println(id + "<p/>");
	out.println(p + "<p/>");
	*/
	try{
		
		sql="select * from guestlab where idx =?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1,idx);
		rs=pstmt.executeQuery();
		
		//rs의 값이 잘 가져왔을때
		
		if(!(rs.next())){
			//값이 없을때
			out.println("해당내용이 DB에 존재하지 않습니다.");
		}else{
			//값이 있을때
%>
<HTML>
<HEAD>
<SCRIPT language="javascript">
function check() {
 with(document.guestwrite){			
  if(email.value.length == 0){
   alert("제목을 입력해 주세요!!");
   subject.focus();
   return false;
  }
  if(phone.value.length == 0){
   alert("이름을 입력해 주세요!!");
   name.focus();
   return false;
  }
  if(gender.value.length == 0){
   alert("비밀번호를 입력해 주세요!!");
   password.focus();
   return false;
  }
  if(addr.value.length == 0){
   alert("내용을 입력해주세요!!");
   content.focus();
   return false;
  }
  document.guestwrite.submit();
 }
}
</SCRIPT> 
</HEAD>
<BODY>


<P>

<FORM name="guestwrite" method=POST action="guestlab_upddb.jsp">
	<input type="hidden" name = "idx" value="<%= idx %>">
	<input type="hidden" name = "page" value="<%= request.getParameter("page") %>">
 <table width="600" cellspacing="0" cellpadding="2" align = "center">
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font size="2">글 수정하기</font></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td width="124" height="30" align="center" bgcolor="#f4f4f4">이메일</td>
   <td width="494"  style="padding:0 0 0 10"> 
    <input type=text name=email value="<%=rs.getString("email") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">전화번호</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=phone value="<%=rs.getString("phone") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">성별</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=gender size="60" value="<%=rs.getString("gender") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">주소</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=addr size="60" value="<%=rs.getString("addr") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td colspan="2" align="right"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
     <tr> 
      <td width="64%">&nbsp;</td>
      <td width="12%"><a href="#" onClick="check();"><img src="image/ok.gif" border="0"></a></td>
      <td width="12%"><a href="#" onClick="history.go(-1)"><img src="image/cancle.gif"  border="0"></td>
      <td width="12%"><A href="guestlab_list.jsp?go=<%=request.getParameter("page")%>"> <img src="image/list.jpg" border=0></a></td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</FORM>
<%
		} //if 문종료
		
}catch(Exception e){
	out.println("업데이트 실패");
	e.printStackTrace(); //잘작동될경우 주석처리할 디버깅코드
}finally{
	if(con != null){con.close();}
	if(stmt != null){stmt.close();}
	if(pstmt != null){pstmt.close();}
	if(rs != null){rs.close();}
}

%>

</BODY>
</HTML>