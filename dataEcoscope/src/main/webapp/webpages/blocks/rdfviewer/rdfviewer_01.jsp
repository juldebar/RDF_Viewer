<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Access to RDF fragment using AJAX --%>
<%-- <s:div cssStyle="text-align:right;padding-top:10px;">
        <s:url id="rdfUrl" action="GetResourceRdf">
            <s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
        </s:url>
        <sj:a id="rdfLink" href="%{rdfUrl}" loadingText=" " showLoadingText="true" targets="resourceRdf" indicator="wait1" onclick="switchDisplay('resourceRdf');">
                <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_rdf_45_45.gif"/>" alt="RDF logo"/>
        </sj:a>
</s:div>
<div id="resourceRdf" style="display:none;"></div> --%>

<%-- Inserting RDF fragment directly --%>
<%--<s:action name="GetResourceRdf" executeResult="false" var="resource">
    <s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
</s:action>--%>

<s:div id="rdf-logo" cssStyle="text-align:right;padding-top:10px;">
    <%--<a id="rdfLink" style="cursor: pointer;">--%>
        <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_rdf_45_45.gif"/>" alt="RDF logo"/>
    <%--</a>--%>
</s:div>

<div id="rdf-for-web-crawlers" style="display: none;">
    <![CDATA[<s:property value="#resource.rdf" escape="false"/>]]>
</div>

<div id="rdf-for-dialog">
    <s:property value="#resource.rdf" escape="true"/>
</div>

<script type="text/javascript">
    $(function() {
        $('#rdf-for-dialog').dialog({ 	autoOpen: false, 
            width: 800, 
            height: 300, 
            title: '<s:text name="rdfviewer.dialogTitle" />', 
            hide: {effect: "fade", duration: 1000}, show: {effect: "fade", duration: 1000}
        })
		
        $('#rdfLink').click(function(event){
            $('#rdf-for-dialog').dialog('open');
        });
	
    });
</script>