<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="well" style="max-width: 340px; padding: 8px 0;">
    <ul class="nav metro-nav-list">
        <ul class="nav">
            <s:iterator value="results">
                <s:action name="GetSparqlResult" executeResult="false" var="imageTest">
                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT ?identifier WHERE{ <<s:property value="picture.uri"/>> dc:identifier ?identifier.}</s:param>
                    <s:param name="endpointlocation" value="'ecoscope'"/>
                </s:action>
                <s:push value="#imageTest">
                    <s:iterator value="results">
                        <s:url id="picUrl" action="GetFile" escapeAmp="false">
                            <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                            <s:param name="picSize">380x380</s:param>
                        </s:url>
                        <li class="active individualData" id="<s:property value="picture.uri" />">
                            <a href="#"><s:property value="Title.literal"/></a>
                        </li>
                    </s:iterator>
                </s:push>
            </s:iterator>
        </ul>
    </ul>