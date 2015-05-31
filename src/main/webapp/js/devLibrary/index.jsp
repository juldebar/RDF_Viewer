<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-2.1.3.js" type="text/javascript"></script>
        <script src='<s:url value="/js/devLibrary/js/script.js"/>' type="text/javascript"></script>
        <style>



        </style>
    </head>
    <body>
        <div id="tuile1"></div>
        <div id="tuile2"></div>
        <div id="tuile3"></div>
        <script type="text/javascript">
            if (document.getElementById && document.createTextNode) {
                window.onload = function () {
                    var initObject = {
                        uri: "http://www.ecoscope.org/ontologies/resources/dbStomac",
                        contentWrapper: "#tuile1",
                        lang: "EN",
                        view: "BDD",
                        viewSize: "small"
                    };
                    var initObject2 = {
                        uri: "http://www.ecoscope.org/ontologies/resources/dbObstuna",
                        contentWrapper: "#tuile2",
                        lang: "EN",
                        view: "BDD",
                        viewSize: "middle"
                    };
                    var initObject3 = {
                        uri: "http://www.ecoscope.org/ontologies/resources/dbAcuity",
                        contentWrapper: "#tuile3",
                        lang: "EN",
                        view: "BDD",
                        viewSize: "wide"
                    };
                    var init1 = new atlasLib;
                    init1.init(initObject);
                    var init2 = new atlasLib;
                    init2.init(initObject2);
                    var init3 = new atlasLib;
                    init3.init(initObject3);
                }
            }
        </script>
    </body>
</html>

