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

                    $("#btnPost").click(function() {
                        $("#addFrm").attr("action", "api08");
                        $("#addFrm").attr("method", "post");
                        $("#addFrm").submit();
                    });

                });
         </script>
    </head>

    <body>
        <form id="addFrm" method="get" action="/api07" >
                    <input type="text" name="userId" id="input-name" placeholder="이름">
                    <br>
                    <textarea id="tx-content" name="userNm" placeholder="내용을 입력해 주세요."></textarea>
                    <br>
                    <input id="input-submit" type="submit" value="보내기" />
        </form>

        <input type="button" id="btnPost" value="POST"/>

        <input type="text" value="${par1}">
        <input type="text" value="${parTap.col1}">

        <table border="1">
            <tr><td>ID</td><td>이름1</td></tr>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td> ${item.userId} </td>
                    <td> <c:out value="${item.userNm}"/>   </td>
                </tr>
            </c:forEach>
        </table>
    </body>


</html>