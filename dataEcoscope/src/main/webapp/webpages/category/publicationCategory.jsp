<%-- 
    Document   : bddCategory
    Created on : 9 janv. 2015, 15:46:35
    Author     : arnaud
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<div style="" class="metro panorama">      
    <div style=" margin-left: 0px;" class="panorama-sections">
        <div class="panorama-section tile-span-8">
            <h2>Publication</h2>
            <s:iterator value="results" status="stat">
                <div class="listview-item bg-color-blue individualData" view="publicationIndividualData" href="#" id="<s:property value="publication.uri"/>" style="height:100px !important;margin-top:0px !important;">      
                    <div class="pull-left" href="#">         
                        <div class="listview-item-object icon-book" data-src="holder.js/60x60"></div>      
                    </div>      
                    <div class="listview-item-body">         
                        <h4 class="listview-item-heading"><s:property value="Title.literal" /></h4>         
                        <!--                            <p class="two-lines">Body text that wraps over two lines. Vivamus elementum semper nisi.</p>     -->
                    </div>   
                </div>
            </s:iterator>
            <div class="panorama-section tile-span-8" style="text-align: center;">
                <div class="pagination">     
                    <ul>       
                        <li id="publicationsCategory" href="#" class="loadLessCategory">
                            <a href="#"><</a>
                        </li> 
                            <s:action name="GetSparqlResult" executeResult="false" var="creator">
                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT (COUNT(?picture) AS ?pictureCount)  WHERE { ?picture rdf:type  <http://www.ecoscope.org/ontologies/resources_def/publication>}</s:param>
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
                        <li id="publicationsCategory" href="#" class="loadMoreCategory" totalItem="<s:property value="totalItem" />">
                            <a href="#">></a>
                        </li>     
                    </ul>   
                </div>
            </div>
        </div>
    </div>
</div>
