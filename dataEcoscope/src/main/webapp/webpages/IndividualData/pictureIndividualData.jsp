<%-- 
    Document   : bddIndividualData
    Created on : 12 janv. 2015, 09:57:11
    Author     : arnaud
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="container" >
    <s:iterator value="results">
        <div id="pivot-item-1" class="pivot-item active">
            <br/>
            <h3 style="border-bottom: 1px dashed white;">
                <s:if test="Title.literal < 1">
                    n/a
                </s:if>
                <s:property value="Title.literal.toUpperCase()"/>
                <span class="pull-right">
                    <i class="icon-images"></i>
                </span>
            </h3>
            <br/>
            <div class="row metro">
                <div class="span4 borderTop">
<!--                    <div class="thumbnail">-->
                <div class="thumbnail">
                <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                    <div class="carousel-inner">
                    <%------------------------%>
                    <%--       images      ---%>
                    <%------------------------%> 
                    <s:action name="GetSparqlResult" executeResult="false" var="imageTest">
                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT ('<s:property value="uri.literal"/>' as ?uri) ?identifier WHERE{ <<s:property value="uri.literal"/>> dc:identifier ?identifier.}</s:param>
                        <s:param name="endpointlocation" value="'ecoscope'"/>
                    </s:action>
                    <s:push value="#imageTest">
                        <s:iterator value="results">
                            <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                <s:param name="picSize">380x380</s:param>
                            </s:url>
                                <%--<img alt="300x200" onclick="loadPopupData('<s:property value="uri.literal"/>','image');" data-src="holder.js/300x200" style="cursor:pointer;width: 300px; height: 200px;" src="<s:property value="picUrl"/>">--%>
                            <div class="item active">
                              <div class="carousel-page">
                                  <img onclick="loadPopupData('<s:property value="uri.literal"/>','image');" src="<s:property value="picUrl"/>" class="img-responsive" style="margin:0px auto;height:100%;width:100%;cursor:pointer;" />
                              </div> 
                              <div class="carousel-caption" style="color:white;">
<!--                                  titre-->
                                  <button onclick="loadPopupData('<s:property value="uri.literal"/>','image');" class="icon-fullscreen pull-right"></button>
                              </div>
                            </div> 
                        </s:iterator>
                    </s:push>
                    
                             
                    </div>   
                </div>
                </div>        
                    
                    <div class="thumbnail">
                            <div class="caption">
                                <h4 class="leftTitleBand"> Ressources  </h4>
                                <div class="btn-group" role="group">
                                    <a href="#" class="win-command win-command-small" id="permalink">
                                        <button type="" class="btn ">
                                                <i class="icon-link"></i>
                                        </button>
                                    </a>

                                    <a href="<s:property value="uri.literal"/>" target="_blank" class="win-command win-command-small" >
                                       <button type="" class="btn ">
                                                <i class="icon-globe-2"></i>
                                        </button>
                                    </a>
                                </div>    
                            </div>
                            
                            
                            <%------------------------%>
                            <%--       droits      ---%>
                            <%------------------------%>
                            <div class="caption">
                                <h4 class="leftTitleBand">Droits </h4>
                                <s:if test="rights.literal != null">
                                    <p><s:property value="rights.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>Aucune donnée</p>
                                </s:else>
                            </div>
                            
                                
                            
                            
                            <%------------------------%>
                            <%--       format      ---%>
                            <%------------------------%>
                            <div class="caption">
                                <h4 class="leftTitleBand">Format </h4>   
                                <s:if test="format.literal != null">
                                    <p><s:property value="format.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>Aucune donnée</p>
                                </s:else>
                            </div>
                            <%------------------------%>
                            <%-- date de création  ---%>
                            <%------------------------%>
                            <div class="caption">
                                <h4 class="leftTitleBand">Date de création </h4> 
                                <s:if test="date.literal != null">
                                    <p><s:property value="date.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>Aucune donnée</p>
                                </s:else>
                            </div>
                            
                            <%-------------------%>
                            <%-- Créator      ---%>
                            <%-------------------%>
                            <div class="caption">
                                <h4 class="leftTitleBand">Creator :</h4>
                                <s:if test="creator.literal != null">
                                    <p><s:property value="creator.literal"/></p>
                                </s:if>
                                <s:else>
                                     <p>Aucune donnée</p>
                                </s:else>    
                            </div>
                        
                    </div>
                </div>
                <div class="span4 borderTop">
                    <div class="thumbnail">
                        
                        <%-------------------%>
                        <%-- description  ---%>
                        <%-------------------%>
                        <h4 class="middleTitleBand">Description : </h4>
                        <s:if test="description.literal != null">
                            <p class="contentMiddle"><s:property value="description.literal"/></p>
                        </s:if>
                        <s:else>
                            <p class="contentMiddle>Aucune donnée</p>
                        </s:else>
                    </div>
                </div>
                <div class="span4 borderTop">
                    <div class="thumbnail">
                        <%------------------------%>
                        <%--       sujets      ---%>
                        <%------------------------%> 
                        <div class="caption">
                            <s:if test="#request.locale.language=='fr'">
                                <s:set var="lang" value="FR"/>
                            </s:if>
                            <s:if test="#request.locale.language=='en'">
                                <s:set var="lang" value="EN"/>
                            </s:if>
                            <%--<s:property value="subjects.literal"/>--%>
                            <s:if test="subjects.literal != null">
                                <h4 class="leftTitleBand">Tags 
                                <span class="pull-right">
                                <i class="icon-tag "></i>
                            </span>
                                </h4>
                                <ul class="niceList" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:scroll;margin-left:10px;">
                                    <s:iterator value='subjects.literal.split("#")'> 
                                        <%--<a href="<s:property/>" target="_blank">property : <s:property/></a><br/> --%>
                                        <s:action name="GetSparqlResult" executeResult="false" var="subject">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ('<s:property/>' as ?uri) ?Title WHERE { <<s:property/>> skos:prefLabel ?Title}</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#subject">
                                                <s:iterator value="results" >
                                                        <li class="individualData" view="speciesIndividualData" href="#" id="<s:property value="uri.literal"/>">
                                                            <a><s:property value="Title.literal"/>
                                                                <span class="pull-right">
                                                                    <i class="icon-tag "></i>
                                                                </span>
                                                            </a>
                                                        </li>
                                                    <%--<a href="<s:property value="Title.literal"/>" target="_blank"><s:property value="Title.literal"/></a>--%>
                                                </s:iterator>
                                        </s:push>
                                    </s:iterator>
                                </ul>
                            </s:if>
                            <s:else>
                                aucune donnée
                            </s:else>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </s:iterator>
    <div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a class="closeIndividualData btn btn-success">fermer la vue</a></div>
</div>
<script type="text/javascript" src="<s:url value="/webpages/tools/loadOnClick.js"/>"></script>