<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var pictureCount = 0;

$(document).ready(function(){
	// 처음 화면을 띄우면서 테마를 세팅한다
	if(${fn:contains(requestScope.restaurant.theme,'가족') }){
		$("input:checkbox[value=가족]").prop("checked","checked");
	}
	if(${fn:contains(requestScope.restaurant.theme,'연인') }){
		$("input:checkbox[value=연인]").prop("checked","checked");
	}
	if(${fn:contains(requestScope.restaurant.theme,'친구') }){
		$("input:checkbox[value=친구]").prop("checked","checked");
	}
	if(${fn:contains(requestScope.restaurant.theme,'회식') }){
		$("input:checkbox[value=회식]").prop("checked","checked");
	}
	
	// 건물 바뀌면 해당건물의 층수만큼 층 select를 바꾼다
	$("#building").on("change",function(){
		$.ajax({
			url:"${initParam.rootPath}/restaurant/ajax/getFloorsByBuildingName.do",
			type:"post",
			data:"buildingName="+$("#building").val(),
			dataType:"json",
			beforeSend:function(){
				if($("#building").val()=="default"){
					$("#floor").html("<option value='default'>층을 선택하세요</option>");
					return false;
				}
			},
			success:function(floors){
				var temp = "<option value='default'>층을 선택하세요</option>";
				for(var i=0; i<floors.length; i++) {
					temp = temp+"<option>"+floors[i]+"</option>";
				}
				$("#floor").html(temp);
			}
		});
	});
	
	// 줄바꿈 변환
	$("#description").html("${requestScope.restaurant.description }".replace('<br>', '\n'));
	
	// 사진첨부버튼 클릭 이벤트
	$("#pictureName").on("click",function(){
		if(pictureCount==5){
			alert("사진은 최대 5장까지 첨부 가능합니다");
			return false;
		}
	});
	
	// 사진이 추가될때 이벤트
	$("#pictureName").on("change",function(){
		var formData = new FormData();
		formData.append("picture",$(this)[0].files[0]);
		$.ajax({
			url:"${initParam.rootPath}/restaurant/ajax/addPictureTemp.do",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			success:function(fileName){
				if(fileName){
					pictureCount++;
					$("#pictureTemp td:nth-child("+pictureCount+")").html("<img style='width:160px;height:140px' src='${initParam.rootPath}/tempPhoto/"+fileName+"'>");
				}
			}
		});
	});
	
	// 기존에 들어있는 사진갯수를 pictureCount에 저장한다
	pictureCount = ${fn:length(fn:split(requestScope.restaurant.pictureName,',')) };
	
	// 그림 클릭시 이벤트(클릭시 삭제)
	$("#pictureTemp").on("click","img",function(){
		var src = $(this).prop("src");
		$.ajax({
			url:"${initParam.rootPath}/restaurant/ajax/removePictureTemp.do",
			type:"post",
			data:"fileName="+src
		});
		
		$(this).parent().remove();
		$("#pictureTemp").append("<td></td>");
		pictureCount--;
	});
});

</script>
</head>
<body>
<form id="modifyForm" action="${initParam.rootPath }/restaurant/login/admin/modifyRestaurant.do" method="post" enctype="multipart/form-data">
<p><font size="5"><b>기본정보</b></font></p>
<table>
<tr>
	<td>상호명</td>
	<td>
		<input type="text" id="restaurantName" name="restaurantName" maxlength="10" value="${requestScope.restaurant.restaurantName }">
		<font color="red"><span id="nameMessage"></span></font>
	</td>
</tr>
<tr>
	<td>업종</td>
	<td>
		<select id="category" name="category">
			<option value="default">업종을 선택하세요</option>
			<c:choose>
				<c:when test="${requestScope.restaurant.category=='한식' }">
					<option selected="selected">한식</option>
				</c:when>
				<c:otherwise>
					<option>한식</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${requestScope.restaurant.category=='양식' }">
					<option selected="selected">양식</option>
				</c:when>
				<c:otherwise>
					<option>양식</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${requestScope.restaurant.category=='중식' }">
					<option selected="selected">중식</option>
				</c:when>
				<c:otherwise>
					<option>중식</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${requestScope.restaurant.category=='일식' }">
					<option selected="selected">일식</option>
				</c:when>
				<c:otherwise>
					<option>일식</option>
				</c:otherwise>
			</c:choose>
		</select>
		<font color="red"><span id="categoryMessage"></span></font>
	</td>
</tr>
<tr>
	<td>전화번호</td>
	<td>
		<input type="text" id="phoneNo1" name="phoneNo1" maxlength="3" style="width: 50px" value="${fn:split(requestScope.restaurant.phoneNo,'-')[0] }"> -
		<input type="text" id="phoneNo2" name="phoneNo2" maxlength="4" style="width: 50px" value="${fn:split(requestScope.restaurant.phoneNo,'-')[1] }"> -
		<input type="text" id="phoneNo3" name="phoneNo3" maxlength="4" style="width: 50px" value="${fn:split(requestScope.restaurant.phoneNo,'-')[2] }">
		<font color="red"><span id="phoneMessage"></span></font>
	</td>
</tr>
<tr>
	<td>주소</td>
	<td>
		<input type="text" id="address" name="address" style="width:500px" value="${requestScope.restaurant.address }">
		<font color="red"><span id="addressMessage"></span></font>
	</td>
</tr>
<tr>
	<td>테마</td>
	<td>
		<label><input type="checkbox" name="theme" value="가족">가족</label>
		<label><input type="checkbox" name="theme" value="연인">연인</label>
		<label><input type="checkbox" name="theme" value="친구">친구</label>
		<label><input type="checkbox" name="theme" value="회식">회식</label>
		<font color="red"><span id="themeMessage"></span></font>
	</td>
</tr>
<tr>
	<td>위치</td>
	<td>
		<select id="building" name="building">
			<option value="default">건물을 선택하세요</option>
			<c:forEach items="${requestScope.buildingNames }" var="buildingName">
				<c:choose>
					<c:when test="${requestScope.currentBuildingName==buildingName }">
						<option selected="selected">${buildingName }</option>
					</c:when>
					<c:otherwise>
						<option>${buildingName }</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<select id="floor" name="floor">
			<option value="default">층을 선택하세요</option>
			<c:forEach items="${requestScope.floors }" var="floor">
				<c:choose>
					<c:when test="${requestScope.currentFloor==floor }">
						<option selected="selected">${floor }</option>
					</c:when>
					<c:otherwise>
						<option>${floor }</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<font color="red"><span id="locationMessage"></span></font>
	</td>
</tr>
<tr>
	<td>소개</td>
	<td>
		<textarea id="description" name="description" style="width:500px;height:100px"></textarea>
		<font color="red"><span id="infoMessage"></span></font>
	</td>
</tr>
</table>

<hr>

<p><font size="5"><b>사진첨부</b></font>&nbsp;&nbsp;(최대 5장 첨부 가능)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="pictureName" name="pictureName">
<font color="red"><span id="pictureMessage"></span></font></p>
<table id="picture_table">
<tr id="pictureTemp">
<c:forEach items="${fn:split(requestScope.restaurant.pictureName,',') }" var="picture">
	<td><img style="width:160px;height:140px;" src="${initParam.rootPath }/uploadPhoto/${picture}"></td>
</c:forEach>
<c:forEach begin="${fn:length(fn:split(requestScope.restaurant.pictureName,','))+1 }" end="5">
<td></td>
</c:forEach>
</tr>
</table>

<hr>

<p><font size="5"><b>메뉴</b></font>&nbsp;&nbsp;(최대 10개 등록 가능)</p>
<table style="width:100%;">
<thead>
<tr align="center">
<td>메뉴명</td>
<td>가격</td>
<td>설명</td>
<td></td>
</tr>
</thead>
<tbody id="menu_table">
<c:forEach items="${requestScope.menus }" var="menu">
<tr>
	<td><input type="text" name="foodName" maxlength="10" value="${menu.foodName }"></td>
	<td><input type="number" name="foodPrice" min="0" max="99999999" value="${menu.foodPrice }">원</td>
	<td><input type="text" name="foodDescription" maxlength="30" style="width:300px" value="${menu.foodDescription }"></td>
</tr>
</c:forEach>
<c:forEach begin="${fn:length(requestScope.menus)+1 }" end="10">
<tr>
	<td><input type="text" name="foodName" maxlength="10"></td>
	<td><input type="number" name="foodPrice" min="0" max="99999999">원</td>
	<td><input type="text" name="foodDescription" maxlength="30" style="width:300px"></td>
</tr>
</c:forEach>
</tbody>
</table>
<hr>
<p align="center">
<input type="submit" value="등록" style="width:100px;height:50px;">
<button id="btn_cancel" style="width:100px;height:50px;">취소</button>
</p>
</form>

</body>
</html>