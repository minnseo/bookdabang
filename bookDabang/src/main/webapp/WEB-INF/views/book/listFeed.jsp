<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서평 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<!-- [2. 한줄기록] 시작 -->
	<div id="reviewfeed" class="tab_contents on">
		<div class="content-main container">
		<h2><a href="listReview.do">한 줄 기록 모음집</a></h2>
		<br>
		<c:if test="${count == 0}">
			<div class="result-display">
				한 줄 기록이 존재하지 않습니다.
			</div>		
		</c:if>
		
		<c:if test="${count > 0}">
		<div class="row row-cols-1 row-cols-md-3 g-4"">
		<c:forEach var="review" items="${list}">
  			<div id="review-list" class="col">
    			<div class="card h-100">
    			<br>
    				<div>
         			<c:if test="${!empty review.photo}">
        				<div id="profile" style="float:left;">
           					&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/upload/${review.photo}" width="50" height="50" class="my-photo">
           					<br>
	        			</div>
	        			<div id="profile2" style="float:left; margin-left:10px;"><b>${review.name}</b><p>한 줄 기록&nbsp;&nbsp;·&nbsp;${review.review_date}</div>
	         		</c:if>
	         		<c:if test="${empty review.photo}">
	        		 	<div id="profile">
	            			&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/images/face.png" width="50" height="50" class="my-photo">
	         				<br>
	         			</div>
	         			<div id="profile2"><b>${review.name}</b><p>한 줄 기록&nbsp;&nbsp;·&nbsp;${review.review_date}</div>
	         		</c:if>
	         		</div>
  				<div class="card-body">
  				<p class="card-text"><a href="listReview.do?review_num=${review.review_num}">${review.review_content}</a></p>
    			
    				<div id="bookinfo" style="float:left;"><b>${review.title}</b><p>${review.author}</div>
    				<div id="bookinfo2" style="float:right;"><img src="${pageContext.request.contextPath}/upload/${post.thumbnail}" width="150" class="list-thumbnail"></div>
      			
      			<br>
  				</div>
				</div>
			</div>
		</c:forEach>	
		</div>		
		<div class="align-center">${rePage}</div>
		</c:if>
		</div>
	</div>
	<!-- [2. 한줄기록 모음집] 끝 -->
	</div>
	<!-- 내용 끝 -->
</div>
</body>
</html>