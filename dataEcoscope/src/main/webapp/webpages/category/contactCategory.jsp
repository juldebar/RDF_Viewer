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
                <s:if test="results.size() < 1">
                    <div class="alert">
                        <button type="button" class="close" data-dismiss="alert"></button>
                        <strong>Warning!</strong> Il semblerait qu'il n'y ait aucune donnée.
                    </div>
                </s:if>
                <s:iterator value="results" status="stat">
                    <s:if test="depiction.uri != null">
                        <s:action name="GetSparqlResult" executeResult="false" var="imageTest">
                             <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT  ('<s:property value="name.literal"/>' as ?name) ('<s:property value="agent.uri"/>' as ?uri) ?identifier WHERE{ <<s:property value="depiction.uri"/>> dc:identifier ?identifier.}</s:param>
                             <s:param name="endpointlocation" value="'ecoscope'"/>
                        </s:action>
                        <s:push value="#imageTest">
                            <s:iterator value="results">
                                <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                     <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                     <s:param name="picSize">380x380</s:param>
                                </s:url>
                                <a class="tile square image individualData" view="contactIndividualData" href="#" id="<s:property value="uri.literal"/>">
                                     <img src="<s:property value="picUrl"/>" alt="" style="max-height: none;">
                                     <div class="textover-wrapper transparent" style="vertical-align: middle;">
                                         <span class="icon  icon-user-2"></span>
                                         <s:property value="name.literal"/>
                                     </div>
                                </a>
                            </s:iterator>
                        </s:push>
                    </s:if>   
                    <s:else>                            
                        <a class="tile app bg-color-blue individualData" href="#" view="contactIndividualData" id="<s:property value="agent.uri"/>">
                            <div class="image-wrapper">
                                <span class="icon  icon-user-2"></span>
                            </div>
                            <div class="textover-wrapper transparent" style="vertical-align: middle;line-height: 30px;width:100%;">
                                <span class="icon  icon-user-2"></span>
                                <s:property value="name.literal"/>
                            </div>
                        </a>
                    </s:else>

                    <%--<s:property value="picture.literal"/>--%>
                </s:iterator>
            </div>
            <div class="panorama-section tile-span-8" style="text-align: center;">
                <div class="pagination"> 
                    <s:if test="results.size() > 19">
                        <ul id="offsetPagination">       
                            <li id="contactCategory" href="#" class="loadLessCategory">
                                <a href="#"><</a>
                            </li> 
                        <s:action name="GetSparqlResult" executeResult="false" var="creator">
                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT (COUNT(?picture) AS ?pictureCount)  WHERE { ?picture rdf:type  <http://xmlns.com/foaf/0.1/Person>}</s:param>
                            <s:param name="endpointlocation" value="'ecoscope'"/>
                        </s:action>
                        <s:push value="#creator">
                            <s:iterator value="results">
                                <li>
                                    <s:set var="totalItem" value="pictureCount.literal" />
                                    <a href="#"><span id="offsetStart">0</span> - <span id="offsetEnd">20</span> / <s:property value="pictureCount.literal"/></a>
                                </li>
                            </s:iterator>
                        </s:push>      
                            <li id="contactCategory" href="#" class="loadMoreCategory" totalItem="<s:property value="totalItem" />">
                                <a href="#">></a>
                            </li>     
                        </ul>
                    </s:if>
                <div class="pagination" style="width:100%;">     
                    <ul class="contactCategory">       
                        <li class="abcPagination"><a href="#">a</a></li>
                        <li class="abcPagination"><a href="#">b</a></li>
                        <li class="abcPagination"><a href="#">c</a></li>
                        <li class="abcPagination"><a href="#">d</a></li>
                        <li class="abcPagination"><a href="#">e</a></li>
                        <li class="abcPagination"><a href="#">f</a></li>
                        <li class="abcPagination"><a href="#">g</a></li>
                        <li class="abcPagination"><a href="#">h</a></li>
                        <li class="abcPagination"><a href="#">i</a></li>
                        <li class="abcPagination"><a href="#">j</a></li>
                        <li class="abcPagination"><a href="#">k</a></li>
                        <li class="abcPagination"><a href="#">l</a></li>
                        <li class="abcPagination"><a href="#">m</a></li>
                        <li class="abcPagination"><a href="#">n</a></li>
                        <li class="abcPagination"><a href="#">o</a></li>
                        <li class="abcPagination"><a href="#">p</a></li>
                        <li class="abcPagination"><a href="#">q</a></li>
                        <li class="abcPagination"><a href="#">r</a></li>
                        <li class="abcPagination"><a href="#">s</a></li>
                        <li class="abcPagination"><a href="#">t</a></li>
                        <li class="abcPagination"><a href="#">u</a></li>
                        <li class="abcPagination"><a href="#">v</a></li>
                        <li class="abcPagination"><a href="#">w</a></li>
                        <li class="abcPagination"><a href="#">x</a></li>
                        <li class="abcPagination"><a href="#">y</a></li>
                        <li class="abcPagination"><a href="#">z</a></li>
                    </ul>   
                </div>
                </div>
                
            
            </div>
        </div>
    </div>