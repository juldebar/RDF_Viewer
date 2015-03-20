<%-- 
    Document   : testMDSTGet.jsp
    Created on : 5 mars 2015, 12:05:17
    Author     : arnaud
--%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-2.1.3.js" type="text/javascript"></script>
        <script type="text/javascript" src="<s:url value='/webpages/tools/xdomain.min.js'/>"   slave="http://mdst-macroes.ird.fr/tmp/proxy.html" debug="true"></script>  
    </head>
    <body>


        <h1>Hello World!</h1>

        <script type="text/javascript">
            $.ajaxSetup({
                error: function (jqXHR, exception) {
//                  
                    console.log(JSON.stringify(exception));
                    if (jqXHR.status === 0) {
                        console.log('Not connect.\n Verify Network.');
                    } else if (jqXHR.status == 404) {
                        console.log('Requested page not found. [404]');
                    } else if (jqXHR.status == 500) {
                        console.log('Internal Server Error [500].');
                    } else if (exception === 'parsererror') {
                        console.log('Requested JSON parse failed.');
                    } else if (exception === 'timeout') {
                        console.log('Time out error.');
                    } else if (exception === 'abort') {
                        console.log('Ajax request aborted.');
                    } else {
                        console.log('Uncaught Error.\n' + jqXHR.responseText);
                    }
                }
            });
            $(document).ready(function () {
                var workspace = "";
                createWorkspace();
                function createWorkspace() {
                    $.ajax({
                        url: "http://mdst-macroes.ird.fr/MDSTWebClientNG/main.action",
                        type: "post",
                        data: {
//                        query: queryHome.queryCount,
//                        view: queryHome.view,
//                        endpointlocation: queryHome.endpointlocation
                        },
                        beforeSend: function (xhr) {

                        },
                        success: function (data)
                        {

                            //$("body").append(data);
                            console.log("workspace :" + data);
                            initPage();
                        },
                        error: function (error)
                        {

                        }
                    });
                }

                function initPage() {
                    console.log("enter initPage")
                    $.ajax({
                        url: "http://mdst-macroes.ird.fr/MDSTWebClientNG/MDST/addWorkspace.action",
                        type: "post",
                        data: {
//                        query: queryHome.queryCount,
//                        view: queryHome.view,
//                        endpointlocation: queryHome.endpointlocation
                        },
                        beforeSend: function (xhr) {

                        },
                        success: function (data)
                        {
                            console.log(data);

                            initPage2();
                        },
                        error: function (error)
                        {
                            alert("bad request");
                        }
                    });
                }
                  function initPage2() {
                    console.log("enter initPage2")
                    $.ajax({
                        url: "http://mdst-macroes.ird.fr/MDSTWebClientNG/MDST/workspaces.action",
                        type: "post",
                        data: {
//                        query: queryHome.queryCount,
//                        view: queryHome.view,
//                        endpointlocation: queryHome.endpointlocation
                        },
                        beforeSend: function (xhr) {
                            
                        },
                        success: function (data)
                        {
                            console.log(data);
//                            $(data).find("")
                            $("body").append(data);
                        },
                        error: function (error)
                        {
                            alert("bad request");
                        }
                    });
                }
            });
        </script>
    </body>
</html>
