<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

</script>

<style>
@import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
#main-title {color:#f8f8f8;font-size:70pt;margin-top:20%;}
.se {font-family: serif;}
.sa {font-family: sans-serif;}
.cu {font-family: cursive;}
.fa {font-family: fantasy;}
#main2{										/* 메인화면 오른쪽 로그인창 */
	width:700px;
	height:auto;
	font-family: 'Hanna', sans-serif;
	background-color: lightgray;
	border: solid 1px #b70000;   
	line-height:20px; /*줄 간격 - 메뉴이므로 줄간격을 넓게*/
	text-align:center;
	-webkit-border-radius: 10px; /* 둥근 모서리 시작 */
	-moz-border-radius: 10px;
	border-radius: 10px;		 /* 둥근 모서리 끝 */
	margin-top: 2%;
	margin-left: auto;
	margin-right: auto;
}
.btn input {			/* 버튼 */
  width: 90px;
  height: 30px;
  border: 0;
  border-radius: 0;
  background: #808080;
  font-size: 12px;
  line-height: 55px\9;
  color:white; 
  -webkit-appearance: none;
  cursor: pointer;
  font-family: 'Hanna', sans-serif;
}
</style>

<div id="main2">
	<table class="bestMonthTB" style="width:500px">
					<thead>
						<tr>
							<td colspan="2" align="center">
							이달의 추천 Best 5
							</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.monthBest }" var="review" varStatus="status">
						<tr>
							<c:choose>
							<c:when test="${status.index+1 == 1}">
								<th align="center" width="100px"><font color="#B70000">${status.index+1}위</font></th>
								<td align="left" id="title">
								<a href="${initParam.rootPath}/review/reviewView.do?reviewNo=${review.reviewNo}&pageNo=${pagingBean.currentPage}" class="list">
								<font color="#B70000">${review.title}</font>
								</a>
								</td>
							</c:when>
							<c:otherwise>
								<th align="center" width="100px">${status.index+1}위</th>
								<td align="left" id="title">
								<a href="${initParam.rootPath}/review/reviewView.do?reviewNo=${review.reviewNo}&pageNo=${pagingBean.currentPage}" class="list">
								${review.title}
								</a>
								</td>
							</c:otherwise>
							</c:choose>
						</tr> 
						</c:forEach>
						<c:forEach begin="${fn:length(requestScope.monthBest)}" end="4" varStatus="status">
								<tr>
									<td align="center">${status.index+1}위</td>
									<td align="left" id="title">&nbsp;</td>
								</tr> 
						</c:forEach>
					</tbody>
				</table>
</div>