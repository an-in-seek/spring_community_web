<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>기본정보</h3>
<script type="text/javascript">
var pic_count = 1;
$(document).ready(function(){
	$("#picture_add").on("click",function(){
		if(pic_count<5) {
			$("<br><input type='file' name='pictureName'>").appendTo("#picture");
			pic_count++;
			alert(pic_count);
		} else {
			alert("사진은 최대 5장까지 첨부할 수 있습니다");
		}
	});
	$("#picture_del").on("click",function(){
		$("#picture").html("<input type='file' name='pictureName'>");
		pic_count = 1;
	});
});
</script>
<table>
<tr>
	<td>업체명</td>
	<td>
		<input type="text" name="restaurantName" maxlength="10">
	</td>
</tr>
<tr>
	<td>업종</td>
	<td>
		<select>
			<option value="default">업종을 선택하세요</option>
			<option>한식</option>
			<option>양식</option>
			<option>중식</option>
			<option>일식</option>
		</select>
	</td>
</tr>
<tr>
	<td>전화번호</td>
	<td>
		<input type="text" name="phoneNo1" maxlength="3" style="width: 50px"> -
		<input type="text" name="phoneNo2" maxlength="4" style="width: 50px"> -
		<input type="text" name="phoneNo3" maxlength="4" style="width: 50px">
	</td>
</tr>
<tr>
	<td>주소</td>
	<td>
		<input type="text" name="address" style="width:500px">
	</td>
</tr>
<tr>
	<td>소개</td>
	<td>
		<textarea name="description" style="width:500px;height:100px"></textarea>
	</td>
</tr>
</table>
<h3>사진첨부&nbsp;&nbsp;
<button id="picture_add">추가</button>
<button id="picture_del">초기화</button></h3>
<div id="picture">
<input type="file" name="pictureName">
</div>
<h3>메뉴</h3>
</body>
</html>