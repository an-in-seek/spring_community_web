<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	var calcListCount=0;
	
	$("#selectedPicture").prop("src",$("#selectPicture img:first").prop("src"));
	
	$(".isUpload").on("click",function(){
		$("#selectedPicture").prop("src",$(this).prop("src"));
	});
	
	//메뉴판 체크박스 클릭이벤트
	$("input[type=checkbox]").on("click",function(){
		if($(this).is(":checked")){
			if(calcListCount==0){
				$("#calcList").html("<tr class='"+$(this).prop("id")+"'><td align='left' style='padding-left:20px;'></td><td></td><td></td><td></td></tr>");
				$("#calcList tr td:first-child").html($("#menus ."+$(this).prop("id")+" td:first-child").html());
				$("#calcList tr td:nth-child(2)").html("<span class='foodPrice'>"+$("#menus ."+$(this).prop("id")+" td:nth-child(2) .foodPrice").html()+"</span>원");
				$("#calcList tr td:nth-child(3)").html($("#menus ."+$(this).prop("id")+" td:nth-child(4) input").val());
				$("#calcList tr td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr td:nth-child(2) .foodPrice").text()*$("#calcList tr td:nth-child(3)").text()+"</span>원");
				calcListCount++;
			}else{
				$("#calcList").append("<tr class='"+$(this).prop("id")+"'><td align='left' style='padding-left:20px;'></td><td></td><td></td><td></td></tr>");
				$("#calcList tr:last-child td:first-child").html($("#menus ."+$(this).prop("id")+" td:first-child").html());
				$("#calcList tr:last-child td:nth-child(2)").html("<span class='foodPrice'>"+$("#menus ."+$(this).prop("id")+" td:nth-child(2) .foodPrice").html()+"</span>원");
				$("#calcList tr:last-child td:nth-child(3)").html($("#menus ."+$(this).prop("id")+" td:nth-child(4) input").val());
				$("#calcList tr:last-child td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr:last-child td:nth-child(2) .foodPrice").text()*$("#calcList tr:last-child td:nth-child(3)").text()+"</span>원");
				calcListCount++;
			}
		}else{
			if(calcListCount==1){
				$("#calcList").html("<tr><td colspan='4' height='50px'>위 메뉴판에서 메뉴와 수량을 선택하면 편리하게 예산을 짜실 수 있습니다</td></tr>");
				calcListCount--;
			}else{
				$("#calcList tr."+$(this).prop("id")).remove();
				calcListCount--;
			}
		}
		
		var total=0;
		for(var i=1;i<calcListCount+1;i++){
			total=total+eval($("#calcList tr:nth-child("+i+") td:last-child .subTotal").text());
		}
		$("#calcTotal td:last-child").html("총합계 : <span id='total'>"+total+"</span>원");
		$("#totalDiv").text(total/$("#calcTotal input").val());
	});
	
	//수량증가버튼클릭이벤트
	$("#menus button:even").on("click",function(){
		if($("#menus tr."+$(this).prop("class")+" td:last-child input").val()<10){
			$("#menus tr."+$(this).prop("class")+" td:last-child input").val(eval($("#menus tr."+$(this).prop("class")+" td:last-child input").val())+1);
			if($("#menus tr."+$(this).prop("class")+" input:checked").val()=="on"){
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").html($("#menus ."+$(this).prop("class")+" td:nth-child(4) input").val());
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr."+$(this).prop("class")+" td:nth-child(2) .foodPrice").text()*$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").text()+"</span>원");
				
				var total=0;
				for(var i=1;i<calcListCount+1;i++){
					total=total+eval($("#calcList tr:nth-child("+i+") td:last-child .subTotal").text());
				}
				$("#calcTotal td:last-child").html("총합계 : <span id='total'>"+total+"</span>원");
				$("#totalDiv").text(Math.ceil(total/$("#calcTotal input").val()));
			}
		}
	});
	
	//수량감소버튼클릭이벤트
	$("#menus button:odd").on("click",function(){
		if($("#menus tr."+$(this).prop("class")+" td:last-child input").val()>1){
			$("#menus tr."+$(this).prop("class")+" td:last-child input").val(eval($("#menus tr."+$(this).prop("class")+" td:last-child input").val())-1);
			if($("#menus tr."+$(this).prop("class")+" input:checked").val()=="on"){
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").html($("#menus ."+$(this).prop("class")+" td:nth-child(4) input").val());
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr."+$(this).prop("class")+" td:nth-child(2) .foodPrice").text()*$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").text()+"</span>원");
				
				var total=0;
				for(var i=1;i<calcListCount+1;i++){
					total=total+eval($("#calcList tr:nth-child("+i+") td:last-child .subTotal").text());
				}
				$("#calcTotal td:last-child").html("총합계 : <span id='total'>"+total+"</span>원");
				$("#totalDiv").text(Math.ceil(total/$("#calcTotal input").val()));
			}
		}
	});
	
	$("#numofpeopleUp").on("click",function(){
		if($("#calcTotal input").val()<50){
			$("#calcTotal input").val(eval($("#calcTotal input").val())+1);
			$("#totalDiv").text(Math.ceil($("#total").text()/$("#calcTotal input").val()));
		}
	});
	
	$("#numofpeopleDown").on("click",function(){
		if($("#calcTotal input").val()>1){
			$("#calcTotal input").val(eval($("#calcTotal input").val())-1);
			$("#totalDiv").text(Math.ceil($("#total").text()/$("#calcTotal input").val()));
		}
	});
});
</script>
</head>
<body>
<table style="width:100%;">
<tr>

<td style="width:50%">
<table border="1" style="width:100%">
<tr align="center">
<td colspan="5"><img id="selectedPicture" style="width:390px;height:260px;"></td>
</tr>
<tr id="selectPicture" align="center">
<td>
	<c:if test="${!empty requestScope.pic1 }"><img style="width:70px;height:50px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic1}"></c:if>
</td>
<td>
	<c:choose>
		<c:when test="${!empty requestScope.pic2 }">
			<img style="width:70px;height:50px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic2}">
		</c:when>
		<c:otherwise>
			<img style="width:70px;height:50px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td>
	<c:choose>
		<c:when test="${!empty requestScope.pic3 }">
			<img style="width:70px;height:50px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic3}">
		</c:when>
		<c:otherwise>
			<img style="width:70px;height:50px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td>
	<c:choose>
		<c:when test="${!empty requestScope.pic4 }">
			<img style="width:70px;height:50px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic4}">
		</c:when>
		<c:otherwise>
			<img style="width:70px;height:50px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td>
	<c:choose>
		<c:when test="${!empty requestScope.pic5 }">
			<img style="width:70px;height:50px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic5}">
		</c:when>
		<c:otherwise>
			<img style="width:70px;height:50px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
</tr>
</table>
</td>

<td valign="top" style="width:50%">
<table>
<tr>
	<td style="width:100px" align="center">상호명</td>
	<td>${requestScope.restaurant.restaurantName }</td>
</tr>
<tr>
	<td align="center">업종</td>
	<td>${requestScope.restaurant.category }</td>
</tr>
<tr>
	<td align="center">전화번호</td>
	<td>${requestScope.restaurant.phoneNo }</td>
</tr>
<tr>
	<td align="center">위치</td>
	<td>${requestScope.restaurant_location }</td>
</tr>
<tr>
	<td align="center">평점</td>
	<td>${requestScope.restaurant.score }</td>
</tr>
<tr>
	<td align="center">테마</td>
	<td>${requestScope.restaurant.theme }</td>
</tr>
<tr>
	<td align="center">소개</td>
	<td>${requestScope.restaurant.description }</td>
</tr>
</table><p>
<hr>
<p align="right"><button>수정</button> <button>삭제</button></p>
</td>
</tr>
</table>

<!-- 여기부터 메뉴판 코드 -->
<p><font size="5"><b>메뉴판</b></font></p>
<table border="1" style="width:100%">
<thead>
<tr align="center">
<td rowspan="2">메뉴</td>
<td rowspan="2"  style="width:15%;">가격</td>
<td colspan="2">예산짜기</td>
</tr>
<tr align="center">
<td style="width:6%;">선택</td>
<td style="width:20%;">수량</td>
</tr>
</thead>
<tbody id="menus">
<c:choose>
<c:when test="${empty requestScope.foods }">
<tr>
<td colspan="4" align="center" height="50px">등록된 메뉴가 없습니다</td>
</tr>
</c:when>
<c:otherwise>
<c:forEach items="${requestScope.foods }" var="food">
	<tr class="${food.foodName }">
		<td style="padding-left:20px;">${food.foodName }&nbsp;&nbsp;<font color="gray" size="2">${food.foodDescription }</font></td>
		<td align="center"><span class="foodPrice">${food.foodPrice }</span>원</td>
		<td align="center"><input type="checkbox" id="${food.foodName }"></td>
		<td align="center">
			<input type="number" min="1" max="10" value="1" readonly="readonly">
			<button class="${food.foodName }">↑</button>
			<button class="${food.foodName }">↓</button>
		</td>
	</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</tbody>
</table>
<!-- ---------------------------------------------------------------------------------------------------- -->

<!-- 여기부터 예산 코드 -->
<p><font size="5"><b>예산짜기</b></font></p>
<table border="1" style="width:100%">
<thead>
<tr align="center">
<td>메뉴</td>
<td style="width:15%;">가격</td>
<td style="width:6%;">수량</td>
<td style="width:20%;">계</td>
</tr>
</thead>
<tbody id="calcList" align="center">
<tr>
<td colspan="4" height="50px">위 메뉴판에서 메뉴와 수량을 선택하면 편리하게 예산을 짜실 수 있습니다</td>
</tr>
</tbody>
<tfoot id="calcTotal">
<tr>
<td colspan="2" style="padding-left:20px;border:0px;">인원수 별 금액 :
	<input type="number" min="1" max="10" value="1" readonly="readonly">
	<button id="numofpeopleUp">↑</button>
	<button id="numofpeopleDown">↓</button> 명 일 때 약 <span id="totalDiv">0</span>원 씩 지불
</td>
<td colspan="2" align="right" style="padding-right:20px;border:0px;">총합계 : <span id="total">0</span>원</td>
</tr>
</tfoot>
</table>
<!-- ---------------------------------------------------------------------------------------------------- -->

</body>
</html>