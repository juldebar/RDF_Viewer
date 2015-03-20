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
                <h2>Images</h2>
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
                            <a class="tile square image individualData" view="pictureIndividualData" href="#" id="<s:property value="picture.uri"/>">
                                <img src="<s:property value="picUrl"/>" alt="">
                                <div class="textover-wrapper transparent">
                                    <div class="text2"><s:property value="Title.literal"/></div>
                                </div>
                            </a>
                        </s:iterator>
                    </s:push>
                </s:iterator>
            </div>
            <div class="panorama-section tile-span-8" style="text-align: center;">
                <div class="pagination">     
                    <ul>       
                        <li id="picturesCategory" href="#" class="loadLessCategory">
                            <a href="#"><</a>
                        </li> 
                            <s:action name="GetSparqlResult" executeResult="false" var="creator">
                               <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT (COUNT(?picture) AS ?pictureCount)  WHERE { ?picture rdf:type  <http://www.ecoscope.org/ontologies/resources_def/picture>}</s:param>
                               <s:param name="endpointlocation" value="'ecoscope'"/>
                           </s:action>
                           <s:push value="#creator">
                               <s:iterator value="results">
                                   <s:set var="totalItem" value="pictureCount.literal" />
                                   <li>
                                       <a href="#"><span id="offsetStart">0</span> - <span id="offsetEnd">20</span> / <s:property value="pictureCount.literal"/></a>
                                   </li>
                               </s:iterator>
                           </s:push>      
                        <li id="picturesCategory" href="#" class="loadMoreCategory" totalItem="<s:property value="totalItem" />">
                            <a href="#">></a>
                        </li>     
                    </ul>   
                </div>
                
            
            </div>
        </div>
    </div>