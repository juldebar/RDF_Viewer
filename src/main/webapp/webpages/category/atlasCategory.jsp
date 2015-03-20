<%-- 
    Document   : picturesCategory
    Created on : 9 janv. 2015, 12:12:25
    Author     : arnaud
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<div style="height: 883px;" class="metro panorama">      
    <div style="width: 2390px; height: 981px; margin-left: 0px;" class="panorama-sections">
        <div class="panorama-section">
            <div class="panorama-section tile-span-8">
                <h2>atlas thonier</h2>
          
                <s:iterator value="results">
                    <s:action name="GetSparqlResult" executeResult="false" var="atlasSpecies">
                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ('<s:property value="label.literal"/>' as ?uri) ('<s:property value="species.uri"/>' as ?species) ?niceDepiction ?identifier WHERE { <<s:property value="species.uri"/>> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction .?niceDepiction dc:identifier ?identifier.}</s:param>
                        <s:param name="endpointlocation" value="'ecoscope'"/>
                    </s:action>
                    <s:push value="#atlasSpecies">
                        <s:if test="%{results.size < 1}">
                            <a class="tile square image individualData" view="speciesIndividualData" href="#" id="<s:property value="species.uri"/>">
                                <img src="" alt="No picture">
                                <div class="textover-wrapper transparent">
                                    <div class="text2"><s:property value="label.literal"/></div>
                                </div>
                            </a>
                        </s:if>
                        <s:iterator value="results">
                            <s:if test="identifier.literal != null">
                                <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                    <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                    <s:param name="picSize">380x380</s:param>
                                </s:url>
                                
                                <a class="tile square image individualData" view="speciesIndividualData" href="#" id="<s:property value="species.literal"/>">
                                    <img src="<s:property value="picUrl"/>" alt="">
                                    <div class="textover-wrapper transparent">
                                        <div class="text2"><s:property value="uri.literal"/></div>
                                    </div>
                                </a>
                            </s:if>
                            <s:else>
                                No data
                            </s:else>
                        </s:iterator>
                    </s:push>
                </s:iterator>
            </div>
        </div>
    </div>