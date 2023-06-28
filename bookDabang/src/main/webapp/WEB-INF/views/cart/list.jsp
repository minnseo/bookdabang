<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>장바구니</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/cart.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		var total = 0;
		let btn_status = false;
		$('#check_all').click(function(){
			if(btn_status == false){
				$('.book-check').prop('checked', true);
				btn_status = true;
				check();
			}else{
			$('.book-check').prop('checked', false);
				btn_status = false;
				total = 0;
				$('#total').text(total);
			}
		});//전체 체크, 전체 체크 취소		
	});
	function check(){
		let list = $('.book-check');
		let total = 0;
			for(let i=0;i<list.length;i++){
				if(list[i].checked){
					total += Number(list[i].value);
				}
			}
		if(total <= 30000 && total != 0){//3만원 이하 구매시 3000원 택배비 추가
			total += 3000;
		}
		$('#total').text(total);
	}
	
	</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- 내용 S -->
		<div class="content-main">
			<hr size="1" noshade width="100%">
			<h3>장바구니</h3>
			<%-- 구매할 도서 선택 및 삭제 --%>
			<div class="member-info">
				<c:forEach var="cart" items="${list}" begin="0" end="0">
				<img src="${pageContext.request.contextPath}/images/gpsIcon.png">
				<h5>${cart.memberVO.name} (${cart.memberVO.address1} ${cart.memberVO.address2})</h5>
				</c:forEach>
			</div>
			<c:if test="${empty list}">
			<div class="cartlist-empty">
				<h4>장바구니에 담긴 상품이 없습니다.</h4>
				<p>원하는 상품을 장바구니에 담아보세요!</p>
				<input type="button" value="도서목록" onclick="location.href='${pageContext.request.contextPath}/book/list.do'">
			</div>
			</c:if>
				
			<c:if test="${!empty list}">
			<form id="cart_order" action="${pageContext.request.contextPath}/order/orderForm.do" method="post">
				<div class="cart-table">
				<ul class="list-group">
					<li class="list-group-item">
						<ul>
							<li><div class="cart-check"><input type="checkbox" id="check_all" class="form-check-input me-1"></div></li>
							<li><div class="cart-bookimg">도서사진</div></li>
							<li><div class="cart-booktitle">도서명</div></li>
							<li><div class="cart-bookprice">가격</div></li>
							<li><div class="cart-orderquantity input-group mb-3">수량	</div></li>
						</ul>
					</li>
					<c:forEach var="cart" items="${list}">
					<li class="list-group-item">
						<ul class="cart-booklist">
							<li><div class="cart-check"><input type="checkbox" name="selectBook" class="book-check" value="${cart.bookVO.price * cart.order_quantity}" onClick="check()"></div></li>
							<li><div class="cart-bookimg"><img src="${pageContext.request.contextPath}/upload/${cart.bookVO.thumbnail}" width="100" height="100"></div></li>
							<li><div class="cart-booktitle">${cart.bookVO.title}</div></li>
							<li><div id="cart-bookprice" class="cart-bookprice">${cart.bookVO.price}</div></li>
							<li>
								<div class="cart-orderquantity input-group mb-3">
									<input type="number" class="form-control" name="order_quantity" min="1" max="${cart.bookVO.stock}" autocomplete="off" value="${cart.order_quantity}">
									<input type="button" value="변경" class="cart-modify btn btn-outline-secondary" data-cartnum="${cart.cart_num}" data-bknum="${cart.bk_num}">
								</div>
							</li>
							<li><div class="cart-deletebtn"><input type="button" value="삭제" class="cart-del btn btn-outline-secondary" data-cartnum="${cart.cart_num}"></div></li>
						</ul>
					</li>
					</c:forEach>
				</ul>
				</div>
				<div class="book-buy">  
					<div class="book-buy-list align-center" >
						  주문금액 | <!-- ${select_price}--><br><br>
						 <div id="total">0</div>원
						<input type="submit" value="Buy">
					</div>
				</div>
			</form>
			</c:if>
		</div>
		<!-- 내용 E -->
	</div>
</body>
</html>