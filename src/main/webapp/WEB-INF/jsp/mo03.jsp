<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta name="_csrf" content="${_csrf.token}"/>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script language="javascript">

        </script>
    </head>
    <script type="text/javascript">
        $(function () {

        jQuery.fn.serializeObject = function() {
            var obj = null;
            try {
                if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
                    var arr = this.serializeArray();
                    if (arr) {
                        obj = {};
                        jQuery.each(arr, function() {
                            obj[this.name] = this.value;
                        });
                    }
                }
            } catch (e) {
                alert(e.message);
            } finally {
                return obj;
            }

            return obj;
        };

        var csrfToken = $("meta[name='_csrf']").attr("content");
        	  $.ajaxPrefilter(function(options, originalOptions, jqXHR){
        	    if (options['type'].toLowerCase() === "post") {
        	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        	    }
        	  });

        /**
             $("#add-form").submit( function(event){
                         alert( $("#input-name").val() );
                         return false;
             });
        **/


             // 테이블 리스트 조회
             $('#input-submit').click(function() {
                var serializedValues = $('#add-form').serializeObject();
                //alert(JSON.stringify(serializedValues));
                $.ajax({
                    url: "/api02",
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(serializedValues),
                    contentType : "application/json; charset=utf-8",
                    success: function(result){
                        var list = result.list;

                        console.log(list.length);

                        var chk= "<td><input type='checkbox' /></td>"
                        var chtml = "<table border='1px'>";

                        $.each(list, function (i, item) {

                            chtml+="<tr>" + chk +"<td>" +  item.userId + "</td><td>" + item.userNm + "</td></tr>"
                        });
                        chtml+="</table>"
                        $("#tab1").html(chtml);
                    },
                    error:function(request,status,error){
                             alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                     }

                }) //$.ajax({

             });  //$('#input-submit').click(function()


             // 테이블 정보 전송
             $("#btn1").click(function() {
                var plist = {};
                plist.userVo = [];

                console.log("눌러");

                plist.status = "SUCCESS";

                $("#tab1 tr").each(function(i, item) {
                   console.log("@@@@@@ :" + i);
                   //var len =  $(this).find("td").length;
                   //console.log("len:" + len);
                   console.log("@@@@@@ :" + $(this).find("td").eq(0).text() );

                   var row = {};
                   row.userId = $(this).find("td").eq(1).text();
                   row.userNm = $(this).find("td").eq(2).text();
                   console.log("row" + JSON.stringify(row) );
                   plist.userVo[i] = row;
                   // plist.userVo.push(row);


                });

                console.log(plist);

                console.log ("@@@@@ JASON : " + JSON.stringify(plist) );

                $.ajax({
                                    url: "/api06",
                                    type: "POST",
                                    dataType: "json",
                                    data: JSON.stringify(plist),
                                    contentType : "application/json; charset=utf-8",
                                    success: function(result){

                                    },
                                    error:function(request,status,error){
                                             alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                                     }

                   }) //$.ajax({


             });


        }); //$(function ()

    </script>

    <body>

        <form id="add-form" method="post">
            <input type="text" name="name" id="input-name" placeholder="이름">
            <br>
            <textarea id="tx-content" name="content" placeholder="내용을 입력해 주세요."></textarea>
            <br>
            <input id="input-submit" type="button" value="보내기" />
        </form>

        <div id="tab1">
        </div>
        <br>
        <input type="button", id="btn1" value="눌러"  />

    </body>
</html>