<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@include file="../includes/header.jsp"%><!-- Register코드복붙 --><div class="row">	<div class="col-lg-12">		<h1 class="page-header">Board Read</h1>	</div>	<!-- /.col-lg-12 --></div><!-- /.row --><div class="row">	<div class="col-lg-12">		<div class="panel panel-default">			<div class="panel-heading">Board Read Page</div>            <!-- /.panel-heading -->			<div class="panel-body">			    <div class="form-group">                    <label>Bno</label>                    <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">			    </div>                <div class="form-group">                    <label>Title</label>                    <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">                </div>                <div class="form-group">                    <label>Text area</label>                    <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>                </div>                <div class="form-group">                    <label>Writer</label>                    <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">                </div>                <!-- 11.5.3 조회페이지에서 form 처리 -->                <!-- 기존코드 -->                <!--                <button data-oper='modify' class="btn btn-default"                    onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>                <button data-oper='list' class="btn btn-info"                    onclick="location.href='/board/list'">List</button>                -->                <!-- 변경코드 -->                <button data-oper='modify' class="btn btn-default">Modify</button>                <button data-oper='list' class="btn btn-info">List</button>                <!-- 14.4.1 조회페이지에서 다시 목록페이지로 이동 - 페이지 번호 유지 -->                <!-- 기존 -->                <!--                <form id='operForm' action="/board/modify" method="get">                    <input type='hidden' id='bno' name ='bno' value='<c:out value="${board.bno}"/>'>                </form>                -->                <!-- 변경 : 히든태그 추가함 -->                <form id='operForm' action="/board/modify" method="get">                    <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>                    <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>                    <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>                    <!-- 15.4.2 조회 페이지에서 검색처리 -->                    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>                    <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>                </form>			</div>			<!-- /.end panel-body -->		</div>		<!-- /.end panel body -->	</div>	<!-- /.end panel --></div><!-- /.row --><!-- 17.5.1 댓글 목록 처리 --><div class='row'>	<div class="col-lg-12">		<!-- /.panel -->		<div class="panel panel-default">		<!-- 17.5.2 새로운 댓글처리 : 새로운 댓글 버튼 추가 -->        <!--        	<div class="panel-heading">				<i class="fa fa-comments fa-fw"></i> Reply			</div>        -->            <div class="panel-heading">                <i class="fa fa-comments fa-fw"></i>Reply                <button id="addReplyBtn" class='btn btn-primary btn-xs pull-right'>New Reply</button>            </div>			<!-- /.panel-heading -->			<div class="panel-body">				<ul class="chat">				</ul>				<!-- ./ end ul -->			</div>			<!-- /.panel .chat-panel -->            <!-- 17.7 댓글 페이지의 화면처리(439p) 하단 영역 추가 -->			<div class="panel-footer">			</div>			<!-- 17.7 댓글 페이지의 화면처리(439p) 추가 끝 -->        </div>    </div>    <!-- ./ end row --></div><!-- 17.5.2 새로운 댓글 처리 : 모달창 추가 --><!-- Modal --><div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">    <div class="modal-dialog">        <div class="modal-content">            <div class="modal-header">                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>            </div>            <div class="modal-body">                <div class="form-group">                    <label>Reply</label>                    <input class="form-control" name='reply' value='New Reply!!!!'>                </div>                <div class="form-group">                    <label>Replyer</label>                    <input class="form-control" name='replyer' value='replyer'>                </div>                <div class="form-group">                    <label>Reply Date</label>                    <input class="form-control" name='replyDate' value='2018-01-01 13:13'>                </div>            </div>            <div class="modal-footer">                <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>                <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>                <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>                <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>            </div>        </div>        <!-- /.modal-content -->    </div>    <!-- /.modal-dialog --></div><!-- /.modal --><!-- 17.4.1 JS의 모듈화 : reply.js 모듈 추가 --><script type="text/javascript" src="/resources/js/reply.js"></script><!-- 17.5.1 댓글 목록 처리 : 이벤트 처리(415p) --><script>    $(document).ready(function() {		var bnoValue = '<c:out value="${board.bno}"/>';		var replyUL = $(".chat");		showList(1);		function showList(page){		    //17.7 댓글페이지의 화면처리 (일부 코드 수정됨)		    console.log("== show list ==" + page);			replyService.getList( {bno:bnoValue, page:page||1},				function(replyCnt, list){				    console.log("replyCnt"+replyCnt);				    console.log("list"+list);				    console.log(list);				    if(page == -1){				        pageNum = Math.ceil(replyCnt/10.0);				        showList(pageNum);				        return;				    }					var str = "";					if(list == null || list.length == 0){						return;					}					for(var i=0, len=list.length || 0; i < len; i++){						str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";						str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";						str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";						str +="<p>"+list[i].reply+"</p></div></li>";					}					replyUL.html(str);					//441p					showReplyPage(replyCnt);				}); //end function		} // end showList		//17.7 댓글 페이지의 화면처리 : <div class="panel-footer"> 에 댓글페이지번호 출력로직        var pageNum = 1;        var replyPageFooter = $(".panel-footer");        function showReplyPage(replyCnt){            var endNum = Math.ceil(pageNum / 10.0) * 10;            var startNum = endNum - 9;            var prev = startNum != 1;            var next = false;            if(endNum * 10 >= replyCnt){                endNum = Math.ceil(replyCnt/10.0);            }            if(endNum * 10 < replyCnt){                next = true;            }            var str = "<ul class='pagination pull-right'>";            if(prev){                str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";            }            for(var i = startNum ; i <= endNum; i++){                var active = pageNum == i? "active":"";                str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";            }            if(next){                str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";            }            str += "</ul></div>";            console.log(str);            replyPageFooter.html(str);        }        //441p        replyPageFooter.on("click","li a", function(e){            e.preventDefault();            console.log("page click");            var targetPageNum = $(this).attr("href");            console.log("targetPageNum: " + targetPageNum);            pageNum = targetPageNum;            showList(pageNum);        });        //17.5.2 새로운 댓글 처리 : 새로운 댓글의 추가버튼 이벤트처리		var modal = $(".modal");        var modalInputReply = modal.find("input[name='reply']");        var modalInputReplyer = modal.find("input[name='replyer']");        var modalInputReplyDate = modal.find("input[name='replyDate']");        var modalModBtn = $("#modalModBtn");        var modalRemoveBtn = $("#modalRemoveBtn");        var modalRegisterBtn = $("#modalRegisterBtn");        $("#modalCloseBtn").on("click", function(e){            modal.modal('hide');        });        $("#addReplyBtn").on("click", function(e){          modal.find("input").val("");          modalInputReplyDate.closest("div").hide();          modal.find("button[id !='modalCloseBtn']").hide();          modalRegisterBtn.show();          $(".modal").modal("show");        });        //17.5.2 새로운 댓글 처리 : 댓글 등록 및 목록갱신(422p)        modalRegisterBtn.on("click",function(e){            var reply = {                reply: modalInputReply.val(),                replyer:modalInputReplyer.val(),                bno:bnoValue            };            replyService.add(reply, function(result){                alert(result);                modal.find("input").val("");                modal.modal("hide");                //17.7 댓글페이지의 화면처리                //showList(1);                showList(-1);            });        });        //17.5.3 특정 댓글의 클릭 이벤트 처리 : 댓글 클릭이벤트 처리        $(".chat").on("click", "li", function(e){            var rno = $(this).data("rno");            replyService.get(rno, function(reply){                modalInputReply.val(reply.reply);                modalInputReplyer.val(reply.replyer);                modalInputReplyDate.val(replyService.displayTime( reply.replyDate))                .attr("readonly","readonly");                modal.data("rno", reply.rno);                modal.find("button[id !='modalCloseBtn']").hide();                modalModBtn.show();                modalRemoveBtn.show();                $(".modal").modal("show");            });        });        //17.5.4 댓글의 수정/삭제 이벤트 처리 : 수정        modalModBtn.on("click", function(e){            var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};            replyService.update(reply, function(result){                alert(result);                modal.modal("hide");                showList(1);            });        });        //17.5.4 댓글의 수정/삭제 이벤트 처리 : 삭제        modalRemoveBtn.on("click", function (e){            var rno = modal.data("rno");            replyService.remove(rno, function(result){                alert(result);                modal.modal("hide");                showList(1);            });        });        //17.7.2 댓글의 수정과 삭제        modalModBtn.on("click", function(e){            var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};            replyService.update(reply, function(result){                alert(result);                modal.modal("hide");                showList(pageNum);            });        });        modalRemoveBtn.on("click", function (e){            var rno = modal.data("rno");            replyService.remove(rno, function(result){                alert(result);                modal.modal("hide");                showList(pageNum);            });        });    });</script><!-- 7.4.1 JS의 모듈화 : 모듈 구성하기(예제코드였음 주석처리!) --><!--<script type="text/javascript">    $(document).ready(function(){        console.log(replyService);    });</script>--><!-- 17.4.3 reply.js 등록 처리(주석) --><!--<script>    console.log("===== JS TEST : add =====");    var bnoValue = '< c:out value="${board.bno}"/>';    replyService.add(        {reply:"add test", replyer:"tester" , bno:bnoValue },        function(result){alert("[ add 실행결과 ] : " + result); }    );</script>--><!-- 17.4.3 댓글의 목록 처리(주석) --><!--<script>    console.log("===== JS TEST : getList =====");    var bnoValue = '< c:out value="${board.bno}"/>';    replyService.getList(        {bno:bnoValue, page:1},        function(list){            for(var i = 0, len = list.length||0 ; i<len ; i++){                console.log(list[i]);            }        }    );</script>--><!-- 17.4.4 댓글 삭제와 갱신 : 12번 댓글(rno = 12)삭제 테스트(주석) --><!--<script>    console.log("===== JS TEST : remove =====");    var bnoValue = '< c:out value="${board.bno}"/>';    replyService.remove(        12,        function(count){            console.log("count... : " + count);            if(count === "success"){ alert('== removed =='); }        },        function(err){ alert('error...');}    );</script>--><!-- 17.4.5 댓글 수정 : 224번(bno)의 11번(rno)댓글수정 --><!--<script>    console.log("===== JS TEST : update =====");    var bnoValue = '< c:out value="${board.bno}"/>';    replyService.update(        {rno:11,        bno:bnoValue,        reply:"17.4.5 update reply"},        function(result){ alert("수정 완료..."); }    );</script>--><!-- 17.4.6 댓글 조회 처리 --><script>    console.log("===== JS TEST : get =====");    replyService.get(        10,        function(data){            console.log(data);        }    );</script><script type="text/javascript">    $(document).ready( function(){        var operForm = $("#operForm");        $("button[data-oper='modify']").on("click", function(e){            operForm.attr("action", "/board/modify").submit();        });        $("button[data-oper='list']").on("click", function(e){            operForm.find("#bno").remove();            operForm.attr("action","/board/list")            operForm.submit();        });    });</script><%@include file="../includes/footer.jsp"%>