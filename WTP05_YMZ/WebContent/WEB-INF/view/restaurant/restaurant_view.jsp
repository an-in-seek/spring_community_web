<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="${initParam.rootPath}/script/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if("${requestScope.isAdmin}"){
		$("#modifyAndDelete").append("<a href='${initParam.rootPath}/restaurant/login/admin/modifyRestaurantForm.do?restaurantNo=${requestScope.restaurant.restaurantNo}'><button>수정</button></a> <button id='btn_delete'>삭제</button>");
		
		$("#btn_delete").on("click",function(){
			if(confirm("삭제하시겠습니까?")){
				$("body").append("<form id='deleteForm' action='${initParam.rootPath}/restaurant/login/admin/removeRestaurant.do' method='post'></form>")
				$("#deleteForm").append("<input type='hidden' name='restaurantNo' value='${requestScope.restaurant.restaurantNo}'>")
				$("#deleteForm").submit();
			}
		});
	}
	
	var calcListCount=0;
	
	$("#selectedPicture").prop("src",$("#selectPicture img:first").prop("src"));
	
	$(".isUpload").hover(function(){
		$("#selectedPicture").prop("src",$(this).prop("src"));
		$(this).parent().css("background-color","red");
	},function(){
		$(this).parent().css("background","none");
	});
	
	//메뉴판 체크박스 클릭이벤트
	$("input[type=checkbox]").on("click",function(){
		if($(this).is(":checked")){
			if(calcListCount==0){
				$("#calcList").html("<tr class='"+$(this).prop("id")+"'><td align='left' style='padding-left:20px;border-left-style:hidden;border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td></tr>");
				$("#calcList tr td:first-child").html($("#menus ."+$(this).prop("id")+" td:first-child").html());
				$("#calcList tr td:nth-child(2)").html("<span class='foodPrice'>"+$("#menus ."+$(this).prop("id")+" td:nth-child(2) .foodPrice").html()+"</span>원");
				$("#calcList tr td:nth-child(3)").html($("#menus ."+$(this).prop("id")+" td:nth-child(4) input").val());
				$("#calcList tr td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr td:nth-child(2) .foodPrice").text()*$("#calcList tr td:nth-child(3)").text()+"</span>원");
				calcListCount++;
			}else{
				$("#calcList").append("<tr class='"+$(this).prop("id")+"'><td align='left' style='padding-left:20px;border-left-style:hidden;border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td><td style='border-right-style:hidden;'></td></tr>");
				$("#calcList tr:last-child td:first-child").html($("#menus ."+$(this).prop("id")+" td:first-child").html());
				$("#calcList tr:last-child td:nth-child(2)").html("<span class='foodPrice'>"+$("#menus ."+$(this).prop("id")+" td:nth-child(2) .foodPrice").html()+"</span>원");
				$("#calcList tr:last-child td:nth-child(3)").html($("#menus ."+$(this).prop("id")+" td:nth-child(4) input").val());
				$("#calcList tr:last-child td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr:last-child td:nth-child(2) .foodPrice").text()*$("#calcList tr:last-child td:nth-child(3)").text()+"</span>원");
				calcListCount++;
			}
		}else{
			if(calcListCount==1){
				$("#calcList").html("<tr><td colspan='4' height='50px' style='border-left-style:hidden;border-right-style:hidden;'>위 메뉴판에서 메뉴와 수량을 선택하면 편리하게 예산을 짜실 수 있습니다</td></tr>");
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
		$("#totalPrint").html("총합계 : <span id='total'>"+total+"</span>원");
		$("#totalDiv").text(Math.ceil(total/$("#calcTotal input").val()));
	});

	$("#menus img").on("mouseover",function(){
		$(this).css("cursor","pointer");
	});
	
	//수량증가버튼클릭이벤트
	$("#menus img:even").on("click",function(){
		if($("#menus tr."+$(this).prop("class")+" td:last-child input").val()<10){
			$("#menus tr."+$(this).prop("class")+" td:last-child input").val(eval($("#menus tr."+$(this).prop("class")+" td:last-child input").val())+1);
			if($("#menus tr."+$(this).prop("class")+" input:checked").val()=="on"){
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").html($("#menus ."+$(this).prop("class")+" td:nth-child(4) input").val());
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr."+$(this).prop("class")+" td:nth-child(2) .foodPrice").text()*$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").text()+"</span>원");
				
				var total=0;
				for(var i=1;i<calcListCount+1;i++){
					total=total+eval($("#calcList tr:nth-child("+i+") td:last-child .subTotal").text());
				}
				$("#totalPrint").html("총합계 : <span id='total'>"+total+"</span>원");
				$("#totalDiv").text(Math.ceil(total/$("#calcTotal input").val()));
			}
		}
	});
	
	//수량감소버튼클릭이벤트
	$("#menus img:odd").on("click",function(){
		if($("#menus tr."+$(this).prop("class")+" td:last-child input").val()>1){
			$("#menus tr."+$(this).prop("class")+" td:last-child input").val(eval($("#menus tr."+$(this).prop("class")+" td:last-child input").val())-1);
			if($("#menus tr."+$(this).prop("class")+" input:checked").val()=="on"){
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").html($("#menus ."+$(this).prop("class")+" td:nth-child(4) input").val());
				$("#calcList tr."+$(this).prop("class")+" td:nth-child(4)").html("<span class='subTotal'>"+$("#calcList tr."+$(this).prop("class")+" td:nth-child(2) .foodPrice").text()*$("#calcList tr."+$(this).prop("class")+" td:nth-child(3)").text()+"</span>원");
				
				var total=0;
				for(var i=1;i<calcListCount+1;i++){
					total=total+eval($("#calcList tr:nth-child("+i+") td:last-child .subTotal").text());
				}
				$("#totalPrint").html("총합계 : <span id='total'>"+total+"</span>원");
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
	$("#numofpeopleUp").on("mouseover",function(){
		$(this).css("cursor","pointer");
	});
	
	$("#numofpeopleDown").on("click",function(){
		if($("#calcTotal input").val()>1){
			$("#calcTotal input").val(eval($("#calcTotal input").val())-1);
			$("#totalDiv").text(Math.ceil($("#total").text()/$("#calcTotal input").val()));
		}
	});
	$("#numofpeopleDown").on("mouseover",function(){
		$(this).css("cursor","pointer");
	});
//송이꺼-----------------------------------------------------------

	$("#registerBtn").click( function() {
		if (!$("#content").val()) {
			$("#content").focus();
			alert("내용을 입력하세요");
			return false;
		}else if($("input[type=radio][name=score]:checked").length<1){
			alert("평점을 선택해");
			return false;
		}
	});

	$("#replyModifyBtn").click(function(){
		if (!$("#ModifyContent").val()) {
			$("#ModifyContent").focus();
			alert("내용을 써주세욤");
			return false;
		}else if($("input[type=radio][name=score]:checked").length<1){
			alert("평점을 선택해");
			return false;
		}
		
	});

	$("#reply_reportButton").on("click", function() {
		alert("로그인을 해야합니다.미구현");
	});
	
});
 	
function modifyReply(number, restaurantNo){
	var isUp=confirm("수정하시겠습니까?")
	if(isUp){
			var con = $("#replyContent"+number).text();
				$("#updateReplyForm").append("<input type='hidden'  name='number' value='"+number+"'>");
				$("#updateReplyForm").append("<input type='hidden'  name='restaurantNo' value='"+restaurantNo+"'>");
				$("#ModifyContent").val(con);	
				$("#dialog").dialog({modal:true, width:400});
		}else{
				return false;
		}
}

//송이꺼
function removeReply(number, restaurantNo){
	var isDel=confirm("삭제할까요?");
	if(isDel){
		document.location.href="${initParam.rootPath}/restaurant/login/removeReply.do?number=" +number+"&restaurantNo="+restaurantNo;
	}else{
		return;
	}
}
</script>

<link type="text/css" href="${initParam.rootPath }/css/jquery-ui.css" rel="stylesheet"/>
<style type="text/css">
#dialog{
width:400px;
display:none;
}
</style>

</head>



<body>
<table style="width:100%;">
<tr>

<td style="width:50%">
<table style="width:100%">
<tr align="center">
<td colspan="5" style="padding:1px;padding-top:5px;border-style:solid;border-color:lightgray;"><img id="selectedPicture" style="width:450px;height:300px;"></td>
</tr>
<tr id="selectPicture" align="center" style="border-style:solid;border-color:lightgray;">
<td style="width:20%;padding:5px;padding-bottom:1px;">
	<c:if test="${!empty requestScope.pic1 }"><img style="width:85px;height:60px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic1}"></c:if>
</td>
<td style="width:20%;padding:5px;padding-bottom:1px;">
	<c:choose>
		<c:when test="${!empty requestScope.pic2 }">
			<img style="width:85px;height:60px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic2}">
		</c:when>
		<c:otherwise>
			<img style="width:85px;height:60px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td style="width:20%;padding:5px;padding-bottom:1px;">
	<c:choose>
		<c:when test="${!empty requestScope.pic3 }">
			<img style="width:85px;height:60px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic3}">
		</c:when>
		<c:otherwise>
			<img style="width:85px;height:60px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td style="width:20%;padding:5px;padding-bottom:1px;">
	<c:choose>
		<c:when test="${!empty requestScope.pic4 }">
			<img style="width:85px;height:60px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic4}">
		</c:when>
		<c:otherwise>
			<img style="width:85px;height:60px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
<td style="width:20%;padding:5px;padding-bottom:1px;">
	<c:choose>
		<c:when test="${!empty requestScope.pic5 }">
			<img style="width:85px;height:60px;" class="isUpload" src="${initParam.rootPath }/uploadPhoto/${requestScope.pic5}">
		</c:when>
		<c:otherwise>
			<img style="width:85px;height:60px;" src="${initParam.rootPath }/uploadPhoto/no-image.png">
		</c:otherwise>
	</c:choose>
</td>
</tr>
</table>
</td>

<td valign="top" style="width:50%">
<table>
<tr>
	<td style="width:100px;" align="center"><b>상호명</b></td>
	<td>${requestScope.restaurant.restaurantName }</td>
</tr>
<tr>
	<td align="center"><b>업종</b></td>
	<td>${requestScope.restaurant.category }</td>
</tr>
<tr>
	<td align="center"><b>전화번호</b></td>
	<td>${requestScope.restaurant.phoneNo }</td>
</tr>
<tr>
	<td align="center"><b>위치</b></td>
	<td>${requestScope.restaurant_location }</td>
</tr>
<tr>
	<td align="center"><b>평점</b></td>
	<td>${requestScope.restaurant.score }</td>
</tr>
<tr>
	<td align="center"><b>테마</b></td>
	<td>${requestScope.restaurant.theme }</td>
</tr>
<tr>
	<td align="center"><b>소개</b></td>
	<td>${requestScope.restaurant.description }</td>
</tr>
</table><p>
<hr>
<p id="modifyAndDelete" align="right"></p>
</td>
</tr>
</table>

<!-- 여기부터 메뉴판 코드 -->
<p><font size="5"><b>메뉴판</b></font></p>
<table border="1" style="width:100%">
<thead>
<tr align="center" style="background-color:lightgray;">
<td rowspan="2"><b>메뉴</b></td>
<td rowspan="2" style="width:15%;"><b>가격</b></td>
<td colspan="2"><b>예산짜기</b></td>
</tr>
<tr align="center" style="background-color:lightgray;">
<td style="width:6%;"><font color="gray">선택</font></td>
<td style="width:15%;"><font color="gray">수량</font></td>
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
		<td style="padding-left:20px;border-left-style:hidden;border-right-style:hidden;">${food.foodName }&nbsp;&nbsp;<font color="gray" size="2">${food.foodDescription }</font></td>
		<td style="border-right-style:hidden;" align="center"><span class="foodPrice">${food.foodPrice }</span>원</td>
		<td style="border-right-style:hidden;" align="center"><input type="checkbox" id="${food.foodName }"></td>
		<td style="border-right-style:hidden;" align="center">
			<table>
			<tr>
			<td style="padding:0px;padding-right:3px;"><input type="number" min="1" max="10" value="1" readonly="readonly" style="width:80px;height:20px;"></td>
			<td style="padding:0px;line-height:13px;">
			<img class="${food.foodName }" src="${initParam.rootPath }/uploadPhoto/up.png"><br>
			<img class="${food.foodName }" src="${initParam.rootPath }/uploadPhoto/down.png"></td>
			</tr>
			</table>
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
<tr align="center" height="50px" style="background-color:lightgray;">
<td><b>메뉴</b></td>
<td style="width:15%;"><b>가격</b></td>
<td style="width:6%;"><b>수량</b></td>
<td style="width:15%;"><b>계</b></td>
</tr>
</thead>
<tbody id="calcList" align="center">
<tr>
<td style="border-left-style:hidden;border-right-style:hidden;" colspan="4" height="50px">위 메뉴판에서 메뉴와 수량을 선택하면 편리하게 예산을 짜실 수 있습니다</td>
</tr>
</tbody>
<tfoot id="calcTotal">
<tr style="background-color:lightgray;">
<td colspan="2" style="padding-left:20px;border:0px;">
	<table>
	<tr>
	<td style="padding:0px;">인원수 별 금액 : <input style="height:20px;" type="number" min="1" max="10" value="1" readonly="readonly"></td>
	<td style="padding:0px;padding-left:3px;padding-right:5px;line-height:13px;">
		<img id="numofpeopleUp" src="${initParam.rootPath }/uploadPhoto/up.png"><br>
		<img id="numofpeopleDown" src="${initParam.rootPath }/uploadPhoto/down.png">
	</td>
	<td style="padding:0px;">명 일 때 약 <span id="totalDiv">0</span>원 씩 지불</td>
	</tr>
	</table>
</td>
<td id="totalPrint" colspan="2" align="right" style="padding-right:20px;border:0px;">총합계 : <span id="total">0</span>원</td>
</tr>
</tfoot>
</table>
<!-- ---------------------------------------------------------------------------------------------------- -->
<hr>
	<p>
		<font size="5"><b>댓글</b></font>
	</p>

	<hr>
	<table align="center" style="width: 700px;" border='1'>
		<c:forEach items="${requestScope.replyList}" var="reply">
				<tr>
					<td>글번호 : ${reply.number }</td>
					<td>작성일 : ${reply.regDate }
					<td>작성자 : ${reply.memberId }</td>
					<td>평점 : ${reply.score }</td>
				</tr>
				<tr>
				내용 :
					<td id="replyContent${reply.number}" colspan="4" height="30px">${reply.content }</td>
				</tr>
				<td align="right" colspan="4">
				<input type="button" id="replyModifyButton${reply.number}" onclick="modifyReply(${reply.number},${requestScope.restaurant.restaurantNo})" value="수정">
				<input type="button" id="replyRemoveButton${reply.number }" onclick="removeReply(${reply.number},${requestScope.restaurant.restaurantNo})" value="삭제">
				<button id="reply_reportButton" style="width: 80px; heigth: 20px;">신고</button>
				</td>
				<tr>
					<td colspan="4"></td>
				</tr>
			</c:forEach>
	</table>

	<hr>
	<p>
		<font size="5"><b>댓글쓰기</b></font>
	</p>
	<form method="post" action="${initParam.rootPath}/restaurant/login/registerReply.do" id="registerReplyForm">
		<table align="center" style="width: 700px;" border='1'>
			<tr >
				<td>	<font size='6'><b>내용</b></font>
					<input type="text" id="content" name="content" style="width: 600px; height: 80px"> 
					<input type="hidden"	id="restaurantNo" name="restaurantNo" value="${requestScope.restaurant.restaurantNo }">
				<p>
				평점주기
					<label for="1">1</label><input type="radio" name="score" value="1" id="score1">
					<label for="2">2</label><input type="radio" name="score" value="2" id="score2">
					<label for="3">3</label><input type="radio" name="score" value="3" id="score3">
					<label for="4">4</label><input type="radio" name="score" value="4" id="score4">
					<label for="5">5</label><input type="radio" name="score" value="5" id="score5">
				</p>
					<input id="registerBtn" type="submit" value="등록">
				</td>
			</tr>
		</table>
	</form>

<div id="dialog" title="댓글 수정">
		<section>
			<header style="text-align: center; font-weight: bolder; font-size: 1.3em; border-bottom: 2px solid black; padding: 5px">댓글을 수정하세요</header>
				<form id="updateReplyForm" method="post" action="${initParam.rootPath}/restaurant/login/updateReply.do"  >
					<article>내용</article>
						<input type="text" id="ModifyContent" name="content" style="width: 300px; height: 40px" autofocus="autofocus">
						<p>
							평점주기
							<label for="1">1</label><input type="radio" name="score" value="1" id="1">
							<label for="2">2</label><input type="radio" name="score" value="2" id="2">
							<label for="3">3</label><input type="radio" name="score" value="3" id="3">
							<label for="4">4</label><input type="radio" name="score" value="4" id="4">
							<label for="5">5</label><input type="radio" name="score" value="5" id="5">
						</p>
				<input id="replyModifyBtn" type="submit" value="등록">
				
		</form>
		</section>
	</div>
	
<p/>
<hr>
<p align="center"><a href="${sessionScope.backURL }"><button style="width:200px;height:50px;">목록으로 돌아가기</button></a></p>
</body>
</html>
