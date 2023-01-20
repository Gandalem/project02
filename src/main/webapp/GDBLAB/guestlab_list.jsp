<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>


<!-- 클래스 import,DB connect 객체 -->
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<%@ include file="connect_oracle.jsp" %>

<HTML>
<HEAD><TITLE>게시판</TITLE>
<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
</SCRIPT>
</HEAD>
<BODY>



<P>
<P align=center><FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT></P> 
<P>
<CENTER>
 <TABLE border=0 width=600 cellpadding=4 cellspacing=0>
  <tr align="center"> 
   <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr align="center" bgcolor="#87E8FF"> 
   <td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
   <td width="240" bgcolor="#DFEDFF"><font size="2">이메일</font></td>
   <td width="184" bgcolor="#DFEDFF"><font size="2">폰</font></td>
   <td width="78" bgcolor="#DFEDFF"><font size="2">성별</font></td>
   <td width="49" bgcolor="#DFEDFF"><font size="2">주소</font></td>
  </tr>
  <tr align="center"> 
   <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
  </tr>

<!-- JSP 코드 블락 : DB의레코드를 가져와서 루프 :시작 -->
	<%
	
	Vector email = new Vector(); //name 컬럼의 모든 값을 저장하는 vector
	Vector phone = new Vector();
	Vector gender = new Vector();
	Vector addr = new Vector();
	Vector keyid = new Vector(); //DB의 id 컬럼의 값을 저장하는 vector

	int where = 1; //현재 위치한 페이징 변수

	int totalgroup = 0;	// 출력할 페이징의 총그룹수
	int maxpages = 5;	//출력할 최대 페이지(row,행,레코드)수
	int startpage = 1;	
	int endpage = startpage + maxpages +1;
	int wheregroup = 1;	//현제 위치한 페이징 그룹
	
	//go 변수를 넘겨 받아서 wheregroup, startpage, endpage 정보를 알아낼수 있다.
			//코드 블락
			
	if(request.getParameter("go")!=null){ //freeboard_list03.jsp?go=3
		where = Integer.parseInt(request.getParameter("go")); //go 변수의 값을 where 변수의 할당
		wheregroup =(where -1) / maxpages + 1;//현제 내가 속한 그룹을 알수 있다.
		startpage = (wheregroup -1 ) * maxpages + 1;
		endpage = startpage + maxpages -1;
		
		//gogroup변수를 넘겨 받아서 startpage, endpage, where 의 정보를 알아낼수 있다.
		//코드 블락
	}else if(request.getParameter("gogroup")!=null){//freeboard_list03.jsp?gogroup=
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage = (wheregroup - 1) * maxpages +1;
		where = startpage;
		endpage = startpage + maxpages -1;
	}
	
	int nextgroup = wheregroup +1;
	int priorgroup = wheregroup -1;

	int nextpage = where +1; //where : 현재 내가위치한 페이지
	int priorpage = where -1;
	int startrow = 0; 	//하나의 page에서 레코드 시작 번호
	int endrow = 0; 	//하나의 page에서 레코드 마지막 번호
	int maxrow = 10; 	//한페이지 내에서 출력할 행의 갯수(row,행,레코드 갯수)
	int totalrows = 0; 	//DB에서 select한 총 레코드 갯수
	int totalpages = 0; //총 페이지 갯수
	
	int idx = 0; //DB의 idx 컬럼의 값을 가져오는 변수
	String em = null;  //DB의 email 주소를 가져와서 처리하는 변수
	
	
		//sql 쿼리를 보낼 객체 변수 선언
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		sql = "select * from guestlab order by idx desc";
		
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);
		if(!rs.next()){
			out.println("페이지가 없습니다.");	
		}else{
			do{
			keyid.addElement(new Integer(rs.getString("idx")));
			email.addElement(rs.getString("email"));
			phone.addElement(rs.getString("phone"));
			gender.addElement(rs.getString("gender"));
			addr.addElement(rs.getString("addr"));
			}while(rs.next());
		}
		totalrows = email.size(); //DB에서 가져온 총레코드 갯수
		totalpages = (totalrows-1)/maxrow +1;
		startrow = (where -1 ) * maxrow; //해당 페이지에서 Vector의 시작방번호
		endrow = startrow + maxrow -1; //해당 페이지에서 Vector의 끝 방번호
		
		//
		totalgroup = (totalpages -1)/maxpages -1;
			//전체 페이지 그룹, 하단에 출력할 페이지갯수 (5개)의 그룹핑
			//endrow 가 totalrows보다 크면 totalrows -1로 처리해야함.
		if(endrow >= totalrows) {
			endrow = totalrows -1;
		}if(endpage > totalpages){
			endpage = totalpages;
		}
		//if(true) return; //프로그램 멈춤
		//해당 페이지를 처리하면서 해당 페이지에 대한 내용을 출력(rs의 값을 vector에 저장했을므로 for)
		for(int j = startrow; j <= endrow; j++ ){
	%>
	<tr align="center">
	<td><%=keyid.elementAt(j) %></td>
	<td><a href="guestlab_read.jsp?idx=<%=keyid.elementAt(j)%>&page=<%= where %>"><%=email.elementAt(j) %></a></td>
	<td><%=phone.elementAt(j) %></td>
	<td><%=gender.elementAt(j) %></td>
	<td><%=addr.elementAt(j) %></td>	
	</tr>
	<%
		}
	%>
<!-- jsp 코드블럭 : DB 레코드를 가져와서 루프 :끝 -->
 </TABLE>
 <%
if(wheregroup > 1){ //현제 나의 그룹이 1이상일때 처음
 		out.println("[<a href='guestlab_list.jsp?gogroup=1'>처음</a>]");
 		out.println("[<a href='guestlab_list.jsp?gogroup=1"+priorgroup+"'>이전</a>]");
 	}else{	//현재 나의 페이지 그룹이 1 이상일때 처음
 		out.println("[처음]");
 		out.println("[이전]");
 	}
	 //페이징 갯수를 출력 : 1 2 3 4 5
	 if(email.size()!=0){ //name.size() : 총 레코드의 갯수 가 0이 아니라면 
		 
		 for(int jj = startpage; jj < endpage; jj++){
			 if(jj == where){ //i가 자신의 페이지 번호하면 링크 없이 출력
			 	out.println("["+jj+"]");
			 }else{ //i가 현재 자신의 페이지 번호가 아니하면 링크를 걸어서 출력
				 out.println("[<a href='guestlab_list.jsp?go="+jj+"'>"+jj+"</a>]");
		 	}
	 	}
 	}
	 
	if(wheregroup < totalgroup){ //링크를 처리
		out.println("[<a href='guestlab_list.jsp?gogroup="+nextgroup+"'>다음</a>]");
		out.println("[<a href='guestlab_list.jsp?gogroup="+totalgroup+"'>마지막</a>]");
	}else{ //마지막 페이지에 왔을때 링크를 해지
		out.println("[다음]");
		out.println("[마지막]");
	}
	 
	 
	out.println("전체 글수 : "+totalrows); 
 %>
<FORM method="post" name="msgsearch" action="guestlab_search.jsp">
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >이름
    <OPTION value=2 >제목
    <OPTION value=3 >내용
    <OPTION value=4 >이름+제목
    <OPTION value=5 >이름+내용
    <OPTION value=6 >제목+내용
    <OPTION value=7 >이름+제목+내용
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117"><A href="guestlab_write.jsp"><img src="image/write.gif" border="0"></A></TD>
 </TR>
</TABLE>
</FORM>
</BODY>
</HTML>