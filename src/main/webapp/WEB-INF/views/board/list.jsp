<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><!-- 11.2 목록화면처리 : 최소한의 태그만 추가해주기 --><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@include file="../includes/header.jsp"%><div class="row">    <div class="col-lg-12">        <h1 class="page-header">Tables</h1>    </div>    <!-- /.col-lg-12 --></div><!-- /.row --><div class="row">    <div class="col-lg-12">        <div class="panel panel-default">            <div class="panel-heading">Board List Page                <button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>            </div>            <!-- /.panel-heading -->            <div class="panel-body">                <table class="table table-striped table-bordered table-hover">                    <thead>                        <tr>                            <th>#번호</th>                            <th>제목</th>                            <th>작성자</th>                            <th>작성일</th>                            <th>수정일</th>                        </tr>                    </thead>                    <!-- controller에서 model에 "list"라는 이름으로 담아둔 값을 가져올거고 -->                    <!-- 그 값을 jsp에서는 board라는 이름으로 불러서 사용할거임 -->                    <c:forEach items="${list}" var="board">                        <!-- 11.4.2 목록페이지와 뒤로가기 문제 : 목록에저 조회 페이지로의 이동 -->                        <tr>                            <td> <c:out value="${board.bno}"/> </td>                            <td>                                <a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a>                                <!--                                새 탭으로 열리게 하고싶을경우 target 속성 추가                                <a href='/board/get?bno=<c:out value="${board.bno}"/>' target=’_blank’><c:out value="${board.title}"/></a>                                -->                            </td>                            <td> <c:out value="${board.title}"/> </td>                            <td> <c:out value="${board.writer}"/> </td>                            <td> <fmt:formatDate pattern="yy-mm-dd" value="${board.regdate}"/> </td>                            <td> <fmt:formatDate pattern="yy-mm-dd" value="${board.updateDate}"/> </td>                        </tr>                    </c:forEach>                </table> <!-- table 태그의 끝 -->                <!-- 15.4 화면에서 검색 조건 처리 -->                <div class="row">                    <div class="col-lg-12">                        <form id="searchForm" action="/board/list" method="get">                            <select name="type">                                <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> > -- </option>                                <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>                                <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>                                <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>                                <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>                                <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>                                <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':''}"/>>제목 or 내용 or 작성자</option>                            </select>                            <input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>                            <input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>                            <input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>                            <button class="btn btn-default">Search</button>                        </form>                    </div>                </div>                <!-- 14.3 JSP에서 페이지 번호 출력 -->                <!--  Pagination -->                <div class = "pull-right">                    <ul class="pagination">                        <c:if test ="${pageMaker.prev}">                            <li class = "paginate_button previous">                                <a href="${pageMaker.startPage-1}">Previous</a>                            </li>                        </c:if>                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">                            <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">                                <a href="${num}">${num}</a>                            </li>                        </c:forEach>                        <c:if test ="${pageMaker.next}">                            <li class = "paginate_button next">                                <a href="${pageMaker.endPage+1}">Next</a>                            </li>                        </c:if>                    </ul>                </div>                <form id="actionForm" action="/board/list" method="get">                    <input type = "hidden" name="pageNum" value = "${pageMaker.cri.pageNum}">                    <input type = "hidden" name="amount" value = "${pageMaker.cri.amount}">                    <input type = "hidden" name="type" value = "<c:out value='${pageMaker.cri.type}'/>">                    <input type = "hidden" name="keyword" value = "<c:out value='${pageMaker.cri.keyword}'/>">                </form>                <!--  end Pagination -->                <!-- 14.3 jsp 에서 페이지 번호 출력 끝 -->            </div>            <!-- end panel-body -->            <!-- 11.3.3 modal창 보여주기 -->            <!-- Modal 추가 -->            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">                <div class="modal-dialog">                    <div class="modal-content">                        <div class="modal-header">                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>                        </div>                        <div class="modal-body"> 처리가 완료되었습니다. </div>                        <div class="modal-footer">                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                            <button type="button" class="btn btn-primary">Save changes</button>                        </div>                    </div>                    <!-- /.modal-content -->                </div>                <!-- /.modal-dialog -->            </div>            <!-- /.modal -->        </div>        <!-- end panle : <class="panel panel-default" > -->    </div>    <!-- /.col-lg-12 --></div><!-- /.row --><!-- 11.3.2 재전송 처리 --><script type="text/javascript">	$(document).ready(function() {	    var result = '<c:out value="${result}"/>';	    //11.3.3 모달 창 보여주기 : 모달창을 보여주는 쿼리 추가	    checkModal(result);	    history.replaceState({},null,null); //11.4.2 목록페이지와 뒤로가기 문제 : 뒤로가기의 문제해결을 위한 추가코드	    function checkModal(result){	        if(result === '' || history.state){ //뒤로가기 처리를 위해 "|| history.state" 추가	            return;	        }	        if(parseInt(result) > 0) { //parseInt() : 문자열을 숫자로 변환                //선택한 html코드 : <div class="modal-body">처리가 완료되었습니다.</div>                $(".modal-body").html("게시글 [ " + parseInt(result) + " ] 번이 등록되었습니다.");                //처리 후 html : <div class="modal-body">게시글 [ 19 ] 번이 등록되었습니다.</div>	        }	        $("#myModal").modal("show");	    }	    //11.3.4 목록에서 버튼으로 이동하기 : Register New Board 버튼을 클릭했을때의 동작 정의	    $("#regBtn").on("click", function(){	        self.location = "/board/register";	    });	    //14.3.1 페이지 번호 이벤트 처리	    var actionForm = $("#actionForm");	    $(".paginate_button a").on("click",function(e){	        e.preventDefault();	        console.log('click');	        actionForm.find("input[name='pageNum']").val($(this).attr("href"));	        actionForm.submit();	    });	    //14.4 조회페이지로 이동 : 게시물 조회를 위한 이벤트처리 추가	    $(".move").on("click",function(e){            e.preventDefault();            actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'/>");            actionForm.attr("action","/board/get");            actionForm.submit();	    });	    //15.4.1 목록화면에서의 검색처리 : 검색버튼의 이벤트 처리	    var searchForm = $('#searchForm');        $('#searchForm button').on("click", function(e){            if(!searchForm.find("option:selected").val()){                alert("검색종류를 선택하세요.");                return false;            }            if(!searchForm.find("input[name='keyword']").val()){                alert("키워드를 입력하세요.");                return false;            }            searchForm.find("input[name='pageNum']").val("1");            e.preventDefault();            searchForm.submit();        });    });</script><%@include file="../includes/footer.jsp"%>