$(function(){
	// 홈 링크
	$(".chatBot_header .btn_TopHome").click(function(){
		$(".chatBot #dim, .chatBot .chatBot_layer#layerNew").addClass('on');
	});

	//닫기 alert
	$(".chatBot_footer .btn_close").click(function(){
		$(".chatBot #dim, .chatBot .chatBot_layer#layerEnd").addClass('on');
	});

	// 새상담 확인
	$(".chatBot .chatBot_layer#layerNew .btn_chatBlue").click(function(){
		$(".chatBot #dim, .chatBot .chatBot_layer#layerNew").removeClass('on');
		/*$(".chatBot .chatBot_ct .chat_main").addClass('on');
		$(".chatBot .chatBot_ct .chat_list").removeClass('on');*/
		$.ajax({
			async : false,
			url : "/ajaxSearch/FR_SVC/chatBotGetInfo.do",
			data: $("#sendForm").serialize()+"&body='처음으로'",
			dataType: 'json',
			type : "POST",
			success: function(data){
				var msdata = JSON.parse(data.replies[0].message);

		    	var check ="<li class='chat_a'><div class='grp'><div class='a_ct'>";
		    	    check +="<p class='txt_a'>"+msdata.title1+msdata.title2+msdata.title3+msdata.title4+msdata.title5+"</p><ul class='txt_aSel'>";
		    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text1+"\")'>"+msdata.text1+"</a></li>";
		    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text2+"\")'>"+msdata.text2+"</a></li>";
		    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text3+"\")'>"+msdata.text3+"</a></li>";
		    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text4+"\")'>"+msdata.text4+"</a></li>";
		    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text5+"\")'>"+msdata.text5+"</a></li>";
		    	    check +="</ul></div></div></li>";

		    	$("#conversationId").val(data.conversationId);
		    	$("#botid").val(data.botId);
		    	$("#msList").html(check);
			}
		});
	});

	//alert 취소
	$(".chatBot .chatBot_layer .btn_chatGray").click(function(){
		$(".chatBot #dim").removeClass('on');
		$(".chatBot .chatBot_layer").removeClass('on');
	});

	//챗봇 닫기
	$(".chatBot .chatBot_layer#layerEnd .btn_chatBlue").click(function(){

		$.ajax({
			async : false,
			url : "/ajaxSearch/FR_SVC/chatBotStop.do",
			data: $("#sendForm").serialize(),
			dataType: 'json',
			success: function(data){
				window.close();
			}
		});

	});
});
