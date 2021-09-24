<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script language="javascript">

        </script>
    </head>
    <script type="text/javascript">

        $(document).ready(function() {
                    var key = getCookie('key');
                    $("#uid").val(key);
                    //쿠키삭제
                    deleteCookie("name");
         });

        // 쿠키 조회
        function getCookie(name) {
            var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
            return value? unescape(value[2]) : null;
        }

        function deleteCookie(name) {
            document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
        }

        function setCookie(name, value, exp, path, domain) {
            var date = new Date();
            date.setTime(date.getTime() + exp*24*60*60*1000); // 일
            var cookieText=escape(name)+'='+escape(value);
            cookieText+=(exp ? '; EXPIRES='+exp.toGMTString() : '; EXPIRES='+date.toUTCString());
            cookieText+=(path ? '; PATH='+cookiePath : '; PATH=/');
            cookieText+=(domain ? '; DOMAIN='+cookieDomain : '');
            document.cookie=cookieText;
        }

    </script>
    <body>
        테스트 Go go 333
        <br>
        <input type="text" value="${param1}"/>
        <br>
        <input type="text" value="${val1}"/>
        <br>
        <input type="text" id="uid"/>
    </body>
</html>