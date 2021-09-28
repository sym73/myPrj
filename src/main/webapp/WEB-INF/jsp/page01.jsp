<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script language="javascript">
            var csrfToken = $("meta[name='_csrf']").attr("content");
                    	  $.ajaxPrefilter(function(options, originalOptions, jqXHR){

                    	    if (options['type'].toLowerCase() === "post") {
                    	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
                    	    }

                    	  });
        </script>
        <script type="text/javascript">
            $(function () {
               var ob1 = {"A1":"v1", "A2":"v2", "A3":"v3"};

               // 오브젝트 테이블 형식으로 표현 ----------
               console.table(ob1);

               // 걸리는 시간 조회 --------------
               console.time("for loop");
               var tm=10;
               for(let i=0;i<1000;i++) {
                    tm++;
               }
               console.timeEnd("for loop");

               // 호출 횟수 --------------
               function callCnt() {
                console.count("callCnt Count");
               }

               callCnt();
               callCnt();
               callCnt();

               console.countReset("callCnt Count");

               callCnt();

               // console.trace(); -------------


               $(".css_test input[type='checkbox'").click(function() {
                    alert( $(this).val());

                    var txt="";

                    $(":checkbox:checked").each(function() {
                        txt += $(this).val() + "\n";
                    });

                    alert(txt);
               });

               $("#box1").click(function() {
                    alert("box");
                 $(".css_test").css({'border':'5px solid black', 'background-color':'green'});
               });

               $("#box2").click(function() {

                    // $("#chk1").prop("checked", true);
                    //주어진 문자열을 포함하고있는 노드(" [name*=value] ")
                    // var txt=$("input[value*='살찐꼬리']").val() ;
                    var txt=$("#chk1").val();
                    alert( txt );
               });

                $("#box3").click(function() {
                    $("#txta").prop("disabled", true);
                });

                $("#box4").click(function() {
                     $("#target").append("GGGGGGG");
                });

                $("#box5").click(function() {
                      $("#target").empty();
                });

                $("li:eq(0)").css('background', 'black').css('color', 'white');
                $("li").eq(2).css('background', 'black').css('color', 'white');

             });
        </script>
    </head>

    <body>
        <input type="button" id="box1" value="박스"/>
        <input type="button" id="box2" value="북아메리카"/>
        <input type="button" id="box3" value="disable"/>
        <input type="button" id="box4" value="append"/>
        <input type="button" id="box5" value="empty"/>
        <div class="css_test">
            <input type="checkbox" value="굿펠로우 나무타기 캥거루1" />굿펠로우 나무타기 캥거루 222<br>
            <input type="checkbox" value="북아메리카 검은머리 흰죽지 "  id="chk1"/>북아메리카 검은머리 흰죽지 111<br>
            <input type="checkbox" value="살찐꼬리 난장이 여우원숭이" />살찐꼬리 난장이 여우원숭이 aaa <br>
            <br>
            <textarea id="txta"></textarea>
        </div>
        <div id="target">
        </div
        <ul>
            <li> 111 </li>
            <li> 22 </li>
            <li> 333 </li>
            <li> 444 </li>
            <li> 555 </li>
        </ul>
    </body>


</html>