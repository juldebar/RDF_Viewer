<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">

    <h3 style="">publication associée</h3>
    <s:if test="results.size < 1">
        n/a
    </s:if>
    <s:set var="counter" value="0"/>
    <s:iterator value="results">
        <s:if test="#counter < 7">
            <s:div  cssClass="row-fluid">
                <s:div cssClass="row-fluid PubliTitle" style="font-family:Verdana,Arial,Helvetica,sans-serif;text-align:justify;font-size: 15px;border-top:1px solid black;width:100%;background-color:black;color:white;padding: 10px;background-color: rgb(46, 110, 158);">
                    - <b><s:property value="Title.literal" default="n/a"/></b>
                </s:div>
                <s:div cssClass="row-fluid description" style="display:none;width:100%;height:auto;color:black;border-left:1px solid black;">
                    <%-- nom de l'auteur --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="">
                            description :
                        </s:div>
                        <s:div cssClass="span8" style="">
                            <s:property value="description.literal" default="n/a"/>
                        </s:div>
                    </s:div>

                    <%-- date de publication --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="height:40px;">
                            date de publication : 
                        </s:div>
                        <s:div cssClass="span8" style="height:40px;">
                            <s:property value="date.literal" default="n/a"/>
                        </s:div>
                    </s:div>
                </s:div>
            </s:div>
        </s:if>
        <s:set var="counter" value="%{#counter+1}"/>
    </s:iterator>



    <script type="text/javascript">
        var before3;
        $('.PubliTitle').hover(function() {
            if (before3) {
                before3.hide();
            }
            $(this).next().show();

//                $('#arrow_next').animate({
//                    right: '-1%'
//                }, 250);
        }, function() {
            before3 = $(this).next();
//                $(this).next().hide();
//                $('#arrow_next').animate({
//                    right: '0%'
//                }, 250);

        });
    </script>

</s:i18n>