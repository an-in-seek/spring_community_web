<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript" src="${initParam.rootPath }/script/modernizr.custom.04022.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#myMain a").css("color","black")
		.hover(function(){
			$(this).css("text-decoration","underline");
		},function(){
			$(this).css("text-decoration","none");
		});
});
</script>

<link rel="stylesheet" type="text/css" href="${initParam.rootPath }/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${initParam.rootPath }/css/style.css" />
<style>
#main-title {color:#f8f8f8;font-size:70pt;margin-top:20%;}
.se {font-family: serif;}
.sa {font-family: sans-serif;}
.cu {font-family: cursive;}
.fa {font-family: fantasy;}
#myMain{										/* 메인화면 오른쪽 로그인창 */
	width:780px;
	height:auto;
	font-family: 'Hanna', sans-serif;
	font-weight:normal;
	background-color: #f8f8f8;
	border: solid 1px #b70000;  
	line-height:15px; /*줄 간격 - 메뉴이므로 줄간격을 넓게*/
	-webkit-border-radius: 10px; /* 둥근 모서리 시작 */
	-moz-border-radius: 10px;
	border-radius: 10px;		 /* 둥근 모서리 끝 */
	margin-left: auto;
	margin-right: auto;
}
#memberTable tr td{
	border-top: 1px solid black;
	border-bottom: 1px solid black;
}
#memberTable tr td:first-child{
	text-align: left;
	border-right: 1px solid black;
}
</style>

<div id="myMain">
	<p align="center">&nbsp;▶ <font size="5">나의 정보</font></p>
	<table id="memberTable" align="center" >
		<tr>
			<td>아이디(ID) : </td>
			<td>${requestScope.member.id}</td>
		<tr>
			<td>이름 : </td>
			<td>${requestScope.member.name}</td>
		</tr>
		<tr>
			<td>닉네임 : </td>
			<td>${requestScope.member.nickname}</td>
		</tr>
		<tr>
			<td>생일 : </td>
			<td>${requestScope.member.birth}</td>
		</tr>
		<tr>
			<td>성별 : </td>
			<td>${requestScope.member.sex}</td>
		</tr>
		<tr>
			<td>주소 : </td>
			<td>${requestScope.member.address} ${requestScope.member.detailAddress}</td>
		</tr>
		<tr>
			<td>이메일(Email) : </td>
			<td>${requestScope.member.email}</td>
		</tr>
		<tr>
			<td>핸드폰 : </td>
			<td>${requestScope.member.phoneNo}</td>
		</tr>
		<tr>
			<td>선호음식 : </td>
			<td>${requestScope.member.favoriteFood}</td>
		</tr>
		<tr>
			<td>마일리지 : </td>
			<td>${requestScope.member.mileage}원</td>
		</tr>
		<tr>
			<td>등급 : </td>
			<td>${requestScope.member.grade}</td>
		</tr>
		<tr>
			<td>가입날짜 : </td>
			<td>${requestScope.member.joinDate}</td>
		</tr>
	</table>
	
	<p>

	<div class="container">
		<section class="tabs">
	        <input id="tab-1" type="radio" name="radio-set" class="tab-selector-1" checked="checked" />
	        <label for="tab-1" class="tab-label-1">My게시물</label>
	
	        <input id="tab-2" type="radio" name="radio-set" class="tab-selector-2" />
	        <label for="tab-2" class="tab-label-2">My댓글</label>
	
	        <input id="tab-3" type="radio" name="radio-set" class="tab-selector-3" />
	        <label for="tab-3" class="tab-label-3">My신고 </label>
	
		    <div class="clear-shadow"></div>
			
	        <div class="content">
		        <div class="content-1">
					<h2>About us</h2>
	                <p>You think water moves fast?</p>
			    </div>
		        <div class="content-2">
					<h2>Services</h2>
	                <p>Do you see</p>
			    </div>
		        <div class="content-3">
					<h2>Portfolio</h2>
	                 <p>The path of the alley of darkness</p>
			    </div>
	        </div>
		</section>
	</div>

	
</div>