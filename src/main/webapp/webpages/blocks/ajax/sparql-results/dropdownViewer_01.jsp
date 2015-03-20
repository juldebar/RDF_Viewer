<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">
   
        <h3 style="">personne associé</h3>
        <s:if test="results.size < 1">
            n/a
        </s:if>
        <s:iterator value="results">
            <s:div  cssClass="row-fluid">
                <s:div cssClass="row-fluid BDDTitle" style="width:100%;height:30px;background-color:black;color:white;">
                    <s:property value="name.literal" default="n/a"/>
                </s:div>
                <s:div cssClass="row-fluid description" style="display:none;width:100%;height:auto;background-color:red;color:black;">
                    <%-- image correspondante --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="height:70px;background-color:white">
                            image :
                        </s:div>
                        <s:div cssClass="span8" style="height:70px;background-color:yellow;">
                            <h3>top chef</h3>
                        </s:div>
                    </s:div>


                    <%-- nom de l'auteur --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="height:40px;background-color:white">
                            auteur :
                        </s:div>
                        <s:div cssClass="span8" style="height:40px;background-color:yellow;">
                            <s:property value="y.uri" default="n/a"/>
                        </s:div>
                    </s:div>

                    <%-- date de publication --%>
                    <s:div cssClass="row-fluid">
                        <s:div cssClass="span4" style="height:40px;background-color:white">
                            date de publication : 
                        </s:div>
                        <s:div cssClass="span8" style="height:40px;background-color:yellow;">
                            17 novembre 2018
                        </s:div>
                    </s:div>
                </s:div>
            </s:div>
        </s:iterator>


        <script type="text/javascript">
            var before1;
            $('.BDDTitle').hover(function() {
                if (before1) {
                    before1.hide();
                }
                $(this).next().show();

                //                $('#arrow_next').animate({
                //                    right: '-1%'
                //                }, 250);
            }, function() {
                before1 = $(this).next();
                //                $(this).next().hide();
                //                $('#arrow_next').animate({
                //                    right: '0%'
                //                }, 250);

            });
        </script>
</s:i18n>