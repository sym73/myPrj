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
               var ob1 = {"A1":"v1", "A2":"v2", "A3":"v3"};

               // 오브젝트 테이블 형식으로 표현 ----------
               console.table(ob1);

               // 걸리는 시간 조회 --------------
               console.time("for loop");
               var tm=1;
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

               console.assert(1===1, "same");
               console.assert(1===2, "not same");
        </script>
    </head>

    <body>
        <header>
            헤더
        </header>

        <main>
            <article>
                ##article
                <section>
                    <p>##section</p>
                </section>
            </article>
            <section>
                <article>
                    <p>##article1</p>
                </article>
                <article>
                    <p>##article2</p>
                </article>
            </section>
        </main>

        <footer>
            ##footer
        </footer>
    </body>


</html>