<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">

    <h3 style="">base de donnée associée</h3>
    <s:if test="results.size < 1">
        n/a
    </s:if>
    <s:set var="counter" value="0"/>
    <s:iterator value="results">
        <s:if test="#counter < 7">
            <s:div  cssClass="row-fluid">
                <s:div cssClass="row-fluid PersTitle" style="width:100%;background-color:black;color:white;height: 30px;">
                    <s:property value="Title.literal" default="n/a"/>
                </s:div>
                <s:div cssClass="row-fluid description" style="display:none;width:100%;height:auto;color:black;">
                    <%-- date --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="">
                            date :
                        </s:div>
                        <s:div cssClass="span8" style="">
                            <s:property value="date.literal" default="n/a"/>
                        </s:div>
                    </s:div>

                    <%-- description --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="background-color:white">
                            description : 
                        </s:div>
                        <s:div cssClass="span8" style="">
                            <s:property value="description.literal" default="n/a"/>
                        </s:div>
                    </s:div>
                </s:div>
            </s:div>
        </s:if>
        <s:set var="counter" value="%{#counter+1}"/>
    </s:iterator>



    <script type="text/javascript">
        var before2;
        $('.PersTitle').hover(function() {
            if (before2) {
                before2.hide();
            }
            $(this).next().show();

            //                $('#arrow_next').animate({
            //                    right: '-1%'
            //                }, 250);
        }, function() {
            before2 = $(this).next();
            //                $(this).next().hide();
            //                $('#arrow_next').animate({
            //                    right: '0%'
            //                }, 250);

        });
    </script>

</s:i18n>