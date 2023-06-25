<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>담소마당</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/chat.js"></script>
	
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- 내용 s -->
		<hr size="1" noshade width="100%">
		<div class="content-main">
			<div class="chat-left">
				<!-- 검색창 S -->
				<form id="search_form" action="list.do" method="get">
					<ul class="search">
						<li>
							<select name="keyfield">
								<option value="1" <c:if test="${param.keyfield == 1}">SELECTED</c:if>>제목</option>
							</select>
						</li>
						<li>
							<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
						</li>
						<li>
							<input type="submit" value="검색" class="btn btn-outline-secondary">
						</li>
					</ul>
				</form>
				<!-- 검색창 E -->
				<div class="list-space align-right">
					<input type="button" value="생성" class="btn btn-outline-secondary" id="make_chat">
				</div>
				<c:if test="${count == 0}">
				<div class="result-display">
					표시할 게시물 없음
				</div>
				</c:if>
				<c:if test="${count > 0}">
				<!-- <div class="chatroom"></div> -->
				<ul class="list-group list-group-flush">
					<c:forEach var="chat" items="${list}">
					<li class="list-group-item">
						<div class="chatlist">
							<div class="chatlist-img">
								<!-- 파일 업로드 X : 기본 이미지 -->
								<c:if test="${empty chat.chat_img}">
								<img src="${pageContext.request.contextPath}/images/face.png" width="200" height="200" class="my-photo">
								</c:if>
								<!-- 파일 업로드!! -->
								<c:if test="${!empty chat.chat_img}">
								<img src="${pageContext.request.contextPath}/upload/${chat.chat_img}" width="200" height="200" class="my-photo">
								</c:if>
							</div>
							<div class="chatlist-title align-center">
								<span><b>${chat.chat_num} | ${chat.chat_title}</b></span>
							</div>
							<div class="chatlist-btn align-center">
								<input type="button" value="open" class="btn btn-outline-secondary into-chat" data-chatnum="${chat.chat_num}" data-title="${chat.chat_title}" data-img="${chat.chat_img}">
								<c:if test="${user_num == chat.mem_num}">
								<input type="button" value="삭제" class="btn btn-outline-secondary delete-chat" data-chatNum="${chat.chat_num}">
								</c:if>
							</div>
						</div>
					</li>
					</c:forEach>
				</ul>
				<div class="align-center">${page}</div>
				</c:if>
			</div>
			<div class="chat-right">
				<%-- 채팅생성 div --%>
				<div class="make-chat" style="display:none;">
					<div class="align-right"><input type="button" value="close" id="out_chat" class="btn btn-outline-secondary"></div>
					<div class="make-chat-content"></div>
				</div>
				<%-- 채팅방 div --%>
				<div class="chatRoom" style="display:none;">
					<div class="align-right"><input type="button" value="close" id="out_chat2" class="btn btn-outline-secondary"></div>
					<div class="top-bar">
						<div id="chat_title"></div>
					</div>
					<div class="bottom">
						<div class="chat-list scrollBar" style="overflow-y:scroll; height:500px;"></div>
						<div class="chat-input">
							<form class="write-chat">
								<textarea rows="2" cols="75" name="chat_content" class="chat-content" placeholder="내용을 입력하세요" style="width:80%"></textarea>
								<input type="submit" value="send" class="btn btn-outline-secondary" style="width:15%">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 내용 e -->
	</div>
</body>
</html>