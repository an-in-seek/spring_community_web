<%@ page contentType="text/html;charset=UTF-8"%>

<script type="text/javascript" >
$(document).ready(function(){
	$("#modifyForm").on("submit", function() {
		if (!$("#title").val()) {
			alert("제목을 입력하세요");
			$("#title").focus();
			return false;
		}

		if (!$("#content").val()) {
			alert("내용을 입력하세요");
			$("#content").focus();
			return false;
		}
	});
});
</script>

<style type="text/css">
table#tb thead tr{
	font-weight: bold;
	background: lightgray;
}
article{
	border-bottom: 1px solid black;
	padding: 5px;
	padding-left: 10px;
}
</style>

<h2 align="center">FAQ게시물 수정</h2>


<form id="modifyForm" method="post" action="${initParam.rootPath}/faq/login/modify.do" >
	<input type="hidden" name="number" value="${requestScope.faq.number}">
	<table id="tb" align="center" width="700px" style="border:solid 2px #050099">
		<thead>
			<tr style="text-align: center;">
				<td colspan="4"><font size="bold">글쓰기</font></td>
			</tr>
		</thead>
		<tr height="1" >
			<td colspan="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center">제목</td>
			<td><input type="text" id="title" name="title" size="80" maxlength="100" style="height:20px;" value="${requestScope.faq.title}"></td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center">내용</td>
			<td><textarea id="content" name="content" cols="80" rows="20">${requestScope.faq.content}</textarea></td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr align="center">
			<td>&nbsp;</td>
			<td colspan="2">
			<input type="submit" value="수정"> 
			<input type="button" value="취소" onclick="javascript:history.back(-1);">
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</form>
