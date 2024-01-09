console.log("==== reply module ====");//var replyService = (function(){//    return {name:"AAAA"}; //객체 {name : "AAAA"} 를 즉시반환하게됨//})(); //즉시실행함수//17.4.3 reply.js 등록 처리 : 모듈패턴 예//var replyService = (function(){//    function add(reply, callback){//        console.log("==== reply ====");//    }//    return {add :add};//})();//17.4.3 reply.js 등록 처리var replyService = (function(){    //add함수 구현    function add(reply, callback, error){        console.log("==== reply : add ====");        $.ajax({            type:'POST',            url:'/replies/new',            data:JSON.stringify(reply), //JSON.stringify( ) : 자바스크립트의 값을 JSON 문자열로 변환            contentType:"application/json; charset=utf-8",            success : function(result, status, xhr){                if(callback){ callback(result); }                //전송에 성공하는경우, 주어진 콜백함수에 result를 담아 실행            },            error : function(xhr, status, er){                if(error){ error(er); }            }        })    }    //17.4.3 댓글의 목록 처리 : getJSON()을 사용해 getList() 구현        //17.7.1 댓글페이지 계산과 출력 : 기존의 getList 변경        //callback함수에 해당 게시물의 댓글수()와 페이지에 해당하는 댓글데이터를 전달하도록    function getList(param, callback, error){        console.log("==== reply : getList ====");        var bno = param.bno;        var page = param.page || 1;        $.getJSON(            "/replies/pages/" + bno + "/" + page,            function(data){                if(callback){                    //callback(data); //기존 : 댓글 목록만 가져오는경우                    callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는경우                }            }).fail(function(xhr, status, err){            if(error){                error();            }        });    }    //17.4.4 댓글 삭제와 갱신    function remove(rno, callback, error){        console.log("==== reply : remove ====");        $.ajax({            type : 'delete',            url : '/replies/' + rno,            success : function(deleteResult, status, xhr){                if(callback){ callback(deleteResult); }            },            error : function(xhr, status, er){                if(error){ error(er); }            }        });    }    //17.4.5 댓글 수정    function update(reply, callback, error){        console.log("==== reply : update ====");        console.log("rno... : " + reply.rno);        $.ajax({            type : 'put',            url : '/replies/' + reply.rno ,            data : JSON.stringify(reply),            contentType : "application/json; charset=utf-8",            success : function(result, status, xhr){                if(callback){ callback(result); }            },            error : function(xhr, status, er){                if(error){ error(er); }            }        });    }    //17.4.6 댓글 조회 처리    function get(rno, callback, error){        console.log("==== reply : get ====");        $.get(            "/replies/" + rno,            function(result){                if(callback){ callback(result); }            }).fail(function(xhr, status, err){                if(error){ error(er); }        });    }    function displayTime(timeValue) {        var today = new Date();        var gap = today.getTime() - timeValue;        var dateObj = new Date(timeValue);        var str = "";        if (gap < (1000 * 60 * 60 * 24)) {            var hh = dateObj.getHours();            var mi = dateObj.getMinutes();            var ss = dateObj.getSeconds();            return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,                    ':', (ss > 9 ? '' : '0') + ss ].join('');        } else {            var yy = dateObj.getFullYear();            var mm = dateObj.getMonth() + 1; // getMonth() is zero-based            var dd = dateObj.getDate();            return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',                    (dd > 9 ? '' : '0') + dd ].join('');        }    }    return {        add :add,        getList : getList,        remove : remove,        update : update,        get : get,        displayTime : displayTime    }; //위에서 구현한 함수를 담은 객체 리턴})();//add함수 구현 끝