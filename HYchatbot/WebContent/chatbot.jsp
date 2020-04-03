<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>한양대학교 포털 안내 도우미</title>
<link rel="stylesheet" type="text/css" href="css/chatbot.css" />
<script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="js/chatbot.js"></script>
</head>
<body>

<script type="text/javascript">
$().ready(function(){
	fn_onReady();
});


function fn_goSendMeg(msg){
	if(msg == ''){
		alert("검색어를 입력하세요.");
		$("#sendtxt").focus();
		return;
	}

	$("#sendtxt").val('');
	$("#searchKeyword").val(msg);
	var txt = "<li class='chat_q'><div class='grp'><p>"+msg+"</p></div></li>";
	$("#msList").append(txt);

	$.ajax({
		async : false,
		url : "/ajaxSearch/FR_SVC/chatBotGetInfo.do",
		data: $("#sendForm").serialize()+"&body="+msg,
		dataType: 'json',
		type : "POST",
		success: function(data){
			var check = "";

			for (var i =0; i < data.replies.length; i++){
				check +="<li class='chat_a'><div class='grp'><div class='a_ct'>";
				//alert(data.replies[i].message);
				if(data.replies[i].type == "SMART_CARD"){
				  		var msdata = JSON.parse(data.replies[i].message);
				  		var title="",text1="",text2="",text3="",text4="",text5="";

				  		if(msdata.title != null && typeof msdata.title != "undefined"){
				  			title += msdata.title;
				  		}
				  		if(msdata.title1 != null && typeof msdata.title1 != "undefined"){
				  			title += msdata.title1;
				  		}
				  		if(msdata.title2 != null && typeof msdata.title2 != "undefined"){
				  			title +=msdata.title2;
				  		}
				  		if(msdata.title3 != null && typeof msdata.title3 != "undefined"){
				  			title +=msdata.title3;
				  		}
				  		if(msdata.title4 != null && typeof msdata.title4 != "undefined"){
				  			title +=msdata.title4;
				  		}
				  		if(msdata.title5 != null && typeof msdata.title5 != "undefined"){
				  			title +=msdata.title5;
				  		}

				  		if(title != ""){
				  			check +="<p class='txt_a'>"+title+"</p>";
				  		}

				  		check +="<ul class='txt_aSel'>";
				  	   if(msdata.text1 != null && msdata.text1 !="" && typeof msdata.text1 != "undefined"){
						   text1 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text1+"\")'>"+msdata.text1+"</a></li>";
					   }
					   if(msdata.text2 != null && typeof msdata.text2 != "undefined"){
						   text2 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text2+"\")'>"+msdata.text2+"</a></li>";
					   }
					   if(msdata.text3 != null && typeof msdata.text3 != "undefined"){
						   text3 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text3+"\")'>"+msdata.text3+"</a></li>";
					   }
					   if(msdata.text4 != null && typeof msdata.text4 != "undefined"){
						   text4 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text4+"\")'>"+msdata.text4+"</a></li>";
					   }
					   if(msdata.text5 != null && typeof msdata.text5 != "undefined"){
						   text5 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text5+"\")'>"+msdata.text5+"</a></li>";
					   }
					   if(msdata.button1 != null && msdata.button1 !="" && typeof msdata.button1 != "undefined"){
						   text1 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.button1+"\")'>"+msdata.button1+"</a></li>";
					   }
					   if(msdata.button2 != null && msdata.button2 !="" && typeof msdata.button2 != "undefined"){
						   text2 ="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.button2+"\")'>"+msdata.button2+"</a></li>";
					   }

					   check += text1+text2+text3+text4+text5;


				}else if(data.replies[i].type == "TEXT"){
					check +="<p class='txt_a'>"+data.replies[i].message+"</p><ul class='txt_aSel'>";
				}
				check +="</ul></div></div></li>";
			}

    	    $("#msList").append(check);
    	    $("#msList").scrollTop($(document).height());
    	    $(".chat_area").scrollTop($(".chat_area").prop('scrollHeight'));
		}
	});

}

function fn_goTotalpage(){
	document.totalForm.action =  "/totalSearch.do";
	document.totalForm.target = "_blank";
	document.totalForm.submit();
}

function fn_onReady(){
	$.ajax({
		async : false,
		url : "/ajaxSearch/FR_SVC/chatBotMain.do",
		dataType: 'json',
		success: function(data){

			var msdata = JSON.parse(data.replies[0].message);

	    	var check ="<li class='chat_a'><div class='grp'><div class='a_ct'>";
	    	    check +="<p class='txt_a'>"+msdata.title1+msdata.title2+msdata.title3+msdata.title4+msdata.title5+"</p><ul class='txt_aSel'>";
	    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text1+"\")'>"+msdata.text1+"</a></li>";
	    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text2+"\")'>"+msdata.text2+"</a></li>";
	    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text3+"\")'>"+msdata.text3+"</a></li>";
	    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text4+"\")'>"+msdata.text4+"</a></li>";
	    	    check +="<li><a href='#;' onclick='fn_goSendMeg(\""+msdata.text5+"\")'>"+msdata.text5+"</a></li>";
	    	    //check +="<li><a href='#none'>"+msdata.text6+"</a></li>";
	    	    check +="</ul></div></div></li>";

	    	$("#conversationId").val(data.conversationId);
	    	$("#botid").val(data.botId);

	    	$("#msList").html(check);
		}
	});
}
</script>
<!-- chatbot -->
<section class="chatBot">
	<div class="chatBot_header">
		<h1><span></span>한양대학교 포털 안내 도우미</h1>
		<a href="#none" class="btn_TopHome">챗봇 메인</a>
	</div>
	<div class="chatBot_ct">
		<div class="chat_area">
			<div class="chat_main"><div>
				<p class="tit">
					<span class="sTit">한양대학교 포털 안내 도우미</span>
					<span class="mTit">챗봇</span>
					<span class="txt">
						쉽고 빠른 정보를 제공하며<br />
						스마트한 학교 생활을 도와 드립니다.
					</span>
				</p>
			</div></div>
			<div class="chat_list on">
				<ul id="msList">
				</ul>
			</div>
		</div>

		<form id="totalForm" name="totalForm" method="post" onsubmit="return false">
			<input type="hidden" name="searchKeyword" id="searchKeyword" value=""/>
		</form>
		<!-- 질문입력 -->
		<form id="sendForm" name="sendForm" method="post" onsubmit="return false">
			<input type="hidden" name="conversationId" id="conversationId" value=""/>
			<input type="hidden" name="botid" id="botid" />
			<div class="chat_inp">
				<fieldset>
					<legend>상담도우미</legend>
					<label class="inpT_label">물어볼 내용 입력창</label>
					<input type="text" class="inp_t" placeholder="무엇이든 물어보세요." id="sendtxt" onFocus="if(this.placeholder !='')this.placeholder='무엇이든 물어보세요.';"  onkeyPress="if (event.keyCode==13){fn_goSendMeg(this.value);return false;}"/>
					<button type="button" class="btn_qSend" onclick="fn_goSendMeg($('#sendtxt').val())" >전송</button>
				</fieldset>
			</div>
		</form>
		<!-- //질문입력 -->
	</div>

	<div class="chatBot_footer">
		<div id="dim"></div>
		<button class="btn_close" type="button">챗봇창 닫기</button>
		<!-- 레이어 팝업 스타일은 동일하며, type은 bg이미지 별로 class 분리
			- typeDot3 :  말풍선 안에 점 3개
			- typeX :  말풍선 안에 X
		-->
		<div class="chatBot_layer typeSpeech" id="layerNew">
			<p class="txt">상담을 새로 시작하시겠습니까?</p>
			<div class="layer_btn">
				<button type="button" class="btn_chatGray" >취소</button>
				<button type="button" class="btn_chatBlue">확인</button>
			</div>
		</div>

		<div class="chatBot_layer typeX" id="layerEnd">
			<p class="txt">상담을 종료하시겠습니까?</p>
			<div class="layer_btn">
				<button type="button" class="btn_chatGray">취소</button>
				<button type="button" class="btn_chatBlue">확인</button>
			</div>
		</div>
		<!-- //레이어 팝업 -->
	</div>
</section>
</body>
</html>
