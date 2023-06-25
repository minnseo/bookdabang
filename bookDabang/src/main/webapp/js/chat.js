$(function() {
	let chat_num;
	// 채팅방 생성
	$('#make_chat').on('click', function() {
		$('.make-chat').show();
		$('.top-bar,.bottm').empty();
		$('.chatRoom').hide();
		
		let make_chat = '';
		make_chat += '<form id="write_form">';
		make_chat += '<ul>';
		make_chat += '<li>';
		make_chat += '<label for="chat_title">제목</label>';
		make_chat += '<input type="text" name="chat_title" id="chat_title" maxlength="50">';
		make_chat += '</li>';
		make_chat += '<li>';
		make_chat += '<label for="chat_img">파일</label>';
		make_chat += '<input type="file" name="chat_img" id="chat_img" accept="image/gif,image/png,image/jpeg">';
		make_chat += '</li>';
		make_chat += '<ul>';
		make_chat += '<div class="align-center">';
		make_chat += '<input type="submit" value="생성" class="btn btn-outline-secondary">';
		make_chat += '</div>';
		make_chat += '</form>';
		
		$('.make-chat-content').html(make_chat);
	});
	
	// 검색 event 연결		
	$('#search_form').submit(function() {
		if($('#keyword').val().trim() == '') {
			alert('검색어 입력!!');
			$('#keyword').val('').focus();
			return false;
		}
	});
	
	// 닫기버튼
	$('#out_chat').click(function() {
		location.reload();
		$('.make-chat-content').empty();
		$('.make-chat').hide();
	});
	
	// 채팅방 등록
	$(document).on('submit','#write_form',function(event) {
		event.preventDefault();
		if($('#chat_title').val().trim() == '') {
			alert('제목 입력!!');
			$('#chat_title').val('').focus();
			return false;
		}
		
		let form_data = new FormData();
		form_data.append('chat_title', $('#chat_title').val());
		form_data.append('chat_img', $('#chat_img').val());
		$.ajax({
			url:'write.do',
			type:'post',
			data:form_data,
			dataType:'json',
			contentType:false,
			processData:false,
			enctype:'multipart/form-data',
			success:function(param) {
				if(param.result == 'logout') { alert('Login 후 생성 가능!!'); }
				else if(param.result == 'success') { 
					alert('채팅방 생성 완료!!');
					location.reload();
					//$('.make-chat-content').empty();
					//$('.make-chat').hide();
				} else { alert('채팅을 전송할 수 없습니다.'); }
			},
			error:function() { alert('Network Error!!'); }
		});
	});
	
	// 채팅 목록
	function selectList() {
		$.ajax({
			url:'listChat.do',
			type:'post',
			data:{chat_num:chat_num},
			dataType:'json',
			success:function(param) {
				$('.chat-list').empty();
				
				$(param.list).each(function(index, item) {
					let chatList = '';
					if(param.user_num == item.mem_num) {
						chatList += '<div class="chat-message-group writer-user"> ';
						chatList += '<div class="chat-messages">';
						chatList += '<div class="message">' + item.chat_content + '</div>';
						chatList += '<div class="from">' + item.chat_date + '</div>';
						chatList += '</div>';
						chatList += '</div>';
					} else {
						chatList += '<div class="chat-message-group">';
						if(!item.memberVo.photo) { chatList += '<div class="chat-thumb"><img src="../images/face.png" class="chat-photo" width="35" height="35"></div>'; }
						else { chatList += '<div class="chat-thumb"><img src="../upload/' + item.memberVo.photo + '" class="chat-photo" width="35" height="35"></div>'; }
						chatList += '<div class="chat-messages">';
						chatList += '<div class="from">' + item.memberVo.name + '</div>';
						chatList += '<div class="message">' + item.chat_content + '</div>';
						chatList += '<div class="from">' + item.chat_date + '</div>';
						chatList += '</div>';
						chatList += '</div>';
					}
					
					$('.chat-list').append(chatList);
				});
			},
			error:function() { alert('Network Error!!'); }
		});
	}
	
	// 채팅입장
	$(document).on('click', '.into-chat', function() {
		$('.chatRoom').show();
		$('.make-chat-content').empty();
		$('.make-chat').hide();
		
		let chatTitle = '<img src="../upload/' + $(this).attr('data-img') + '" class="chat-photo" width="40" height="40">';
		if(!$(this).attr('data-img')) { chatTitle = '<img src="../images/face.png" class="chat-photo" width="40" height="40">'; }
		chatTitle += '&nbsp;&nbsp;<span>' + $(this).attr('data-title') + '</span>';
		$('#chat_title').html(chatTitle);
	
		chat_num = $(this).attr('data-chatnum');			
				
		selectList();
	});
	
	// 채팅 등록
	$(document).on('submit', '.write-chat', function(event) {
		event.preventDefault();
		
		if($('.chat-content').val().trim() == '') {
			alert('내용 입력!!');
			$('.chat-content').val().focus();
			return false;
		}
		
		let chat_content = $('.chat-content').val();
		
		$.ajax({
			url:'writeChat.do',
			type:'post',
			data:{chat_content:chat_content, chat_num:chat_num},
			dataType:'json',
			success:function(param) {
				if(param.result == 'logout') { alert('Login 후 작성 가능!!'); }
				else if(param.result == 'success') { 
					$('.chat-content').val(''); 
					selectList();
				} else { alert('채팅을 전송할 수 없습니다.'); }
			},
			error:function() { alert('Network Error!!'); }
		});
	});
	
	// 닫기버튼2	
	$('#out_chat2').click(function() {
		$('.top-bar,.bottm').empty();
		$('.chatRoom').hide();
		location.reload();
	});
	
	// 채팅 삭제
	$(document).on('click', '.delete-chat', function() {
		$.ajax({
			url:'deleteChat.do',
			type:'post',
			data:{chat_num:$(this).attr('data-chatNum')},
			dataType:'json',
			success:function(param) {
				if(param.result == 'logout') { alert('Login 후 삭제 가능!!'); }
				else if(param.result == 'success') {
					alert('삭제 완료!!');
					location.reload();
				}
				else if(param.result == 'wrongAccess') { alert('타인의 글 삭제 불가!!'); }
				else { alert('댓글 삭제 오류 발생!!'); }
			},
			error:function() { alert('Network 오류 발생'); }
		});
	});
});