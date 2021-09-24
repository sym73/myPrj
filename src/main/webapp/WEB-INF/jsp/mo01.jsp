<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.js"></script>

        <style>
            .title {
                color: red;
                font-size: 50px;
            }

            span {
                background-color:blue;
            }

            #checkboxTestTbl tr.selected{background-color: navy;color: #fff; font-weight: bold;}
        </style>
    </head>
    <script type="text/javascript">
       $(document).ready(function() {
            var tbl = $("#checkboxTestTbl");

            // 테이블 헤더에 있는 checkbox 클릭시
            $(":checkbox:first", tbl).click(function(){
                if( $(this).is(":checked") ){
                    $(".chkList").prop("checked", true);
                }else{
                    $(".chkList").prop("checked", false);
                }
            });

            // 헤더에 있는 체크박스외 다른 체크박스 클릭시
            $("input:checkbox:not(:first)", tbl).click(function(i){
                var allCnt = $(":checkbox:not(:first)", tbl).length;
                var checkedCnt = $(":checkbox:not(:first)", tbl).filter(":checked").length;
                var td=$(this).parent().parent().children().eq(1).text();
                alert(td);

            }).change(function(){
                              if( $(this).is(":checked") ){
                                  // 체크박스의 부모 > 부모 니까 tr 이 되고 tr 에 selected 라는 class 를 추가한다.
                                  $(this).parent().parent().addClass("selected");
                              }
                              else{
                                  $(this).parent().parent().removeClass("selected");
                              }
             });


            $("#btn1").click(function() {
                //alert( $("input:checkbox[name=pointCheck]").is(":checked") );
                var str = [];
                $(".check").each(function() {
                    if( $(this).is(":checked")) {
                       str.push( $(this).val() );
                    }
                });
                alert( str);
            });

            $("#btn2").click(function() {
                //$(".check").removeAttr("checked");
                //attr 속성보다 prop 속성을 사용해야 동작이 됨
                //$(".check").attr("checked",true);
                $(".check").prop("checked", true);
            });


            $("#sel1").on("change", function() {
              //alert(  $("#sel1 option:selected").text() );
              setSel2();
            });

            function setSel2() {
                var cls=$("#sel1 option:selected").text();

                if( cls.indexOf("이마트") >=0 ) {
                    $("#sel2").find("option[value=1]").prop("selected", true);
                }else{
                    $("#sel2").find("option[value=2]").prop("selected", true);
                }

            }

            $("span[name='tog_ctl'").click(function() {
                $("#selTab").toggle();;
                $("span[name='tog_ctl'").toggle();
            });

            $("#btn3").click(function() {
                var ob1 = {"A1":"v1", "A2":"v2", "A3":"v3"};
                var ob2 = ["s1", "s2", "s3"]

                //객체 Key
                console.log( "keys1 :" + Object.keys(ob1) );
                ob1.stat="aaa";
                console.log( "keys2 :" + Object.keys(ob1) );
                console.log( "A3 :" + ob1.A3 );
                console.log( "values :" + Object.values(ob1) );
                for( k1 in ob1) {
                    console.log( k1 + "::" + ob1[k1] );
                }
                console.log("ob1.A3-->" + ob1.A3);
                console.log( ob2.toString() );
                console.log( ob2.join());
                console.log( ob2.join(':'));
                console.log( ob2.join(''));
                //객체 복제 : Object.assign({}, ob1)
                var ob3 = Object.assign({}, ob1);
                console.log( "객체 복제 :" + Object.values(ob3));
                // 객체->배열
                console.log( "entries :" + Object.entries(ob3));
                // 배열->객체 Object.fromEntries
                var ar1 = [
                            ["k1","v1"],
                            ["k2","v2"]
                           ];
                var ob4 = Object.fromEntries(ar1);
                console.log( "배열->객체 :" + Object.values(ob4));
                // 어레이여부 체크
                console.log( "어레이여부 체크 :" + Array.isArray(ar1) );
                console.log( "어레이여부 체크 :" + Array.isArray(ob1) );




            });

        });

    </script>

    <body>

    <input type="button" id="btn1" value="체크버튼값"/>
    <input type="button" id="btn2" value="AllCheck"/>

    <div class="title">
            bskyvision
    </div>

     <label>
     <input type="checkbox" class="check"  name="pointCheck" id = "pointCheck" value="A0" checked='checked'/>
                벨류 0 체크박스
     </label>
     <label>
     <input type="checkbox" class="check"  name="pointCheck" id = "pointCheck" value="A1" checked='checked'/>
                벨류 1 체크박스
      </label>
      <label>
      <input type="checkbox" class="check"  name="pointCheck" id = "pointCheck" value="A2" />
                 벨류 2 체크박스
      </label>

      <table id="checkboxTestTbl" border="1px">
              <caption>체크박스 전체선택 테스트</caption>
              <colgroup>
                  <col width="40px;"/>
                  <col width="200px;"/>
                  <col width="100px;"/>
              </colgroup>
              <tr>
                  <th><input type="checkbox" class="chkList" /></th>
                  <th>제목</th>
                  <th>날짜</th>
              </tr>
              <tr>
                  <td><input type="checkbox" class="chkList"  /></td>
                  <td>제목1</td>
                  <td>날짜1</td>
              </tr>
              <tr>
                  <td><input type="checkbox" class="chkList"  /></td>
                  <td>제목2</td>
                  <td>날짜2</td>
              </tr>
      </table>

      <span name="tog_ctl"> 접기</span>
      <span name="tog_ctl" style="display:none;"> 펼치기</span>

      <table id="selTab">
        <tr>
            <td>
                <select id="sel1">
                    <option value="01">이마트1</option>
                    <option value="02">이마트2</option>
                    <option value="03">이마트3</option>
                    <option value="04" selected="selected">전자랜드4</option>
                    <option value="05">전자랜드5</option>
                    <option value="06">전자랜드6</option>
                </select>
            </td>
            <td>
                <select id="sel2">
                    <option value="1">이마트</option>
                    <option value="2">전자랜드</option>
                </select>
            </td>
        </tr>
      </table>

        <input type="button"  id="btn3" value="버튼"/>






    </body>

    <script>
            $('.title').click(function(){
                $('.title').css({"color": "blue", "font-size": "20px"});
            });
    </script>
</html>