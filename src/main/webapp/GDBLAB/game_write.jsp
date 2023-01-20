<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<script language="javascript">
function check(){
	with(document.guest_file){
		if(email.value.length == 0){
			alert("이메일을 입력해주세요");
			ename.focus();
			return false;
		}
		if(phone.value.length == 0){
			alert("전화번호를 입력해주세요");
			phone.focus();
			return false;
		}
		if(gender.value.length == 0){
			alert("성별를 입력해주세요");
			gender.focus();
			return false;
		}
		if(addr.value.length == 0){
			alert("주소를 입력해주세요");
			addr.focus();
			return false;
		}
		document.guest_file.submit();	
	}
}
</script>
</head>
<body>
	<div>
	<form name="guest_file" method="post" action="guestlab_save.jsp">
	<table>
	<tr>
		<td>이메일 : </td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>전화번호 : </td>
		<td><input type="text" name="phone"></td>
	</tr>
	<tr>
		<td>성별 : </td>
		<td><input type="text" name="gender"></td>
	</tr>
	<tr>
		<td>주소 : </td>
		<td><input type="text" name="addr"></td>
	</tr>
	<tr>
	<td><a href="#" onclick="history.go(-1)">취소</a></td>
	<td><a href="#" onclick="check();">확인</a></td>
	</tr>
	</table>
	</form>
	</div>
</body>
</html>