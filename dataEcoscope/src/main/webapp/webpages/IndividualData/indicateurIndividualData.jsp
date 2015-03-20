<%-- 
    Document   : bddIndividualData
    Created on : 12 janv. 2015, 09:57:11
    Author     : arnaud
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="container" >
    <s:iterator value="results" status="indicateurStatus">
        <s:if test="#indicateurStatus.first">
            <div id="pivot-item-1" class="pivot-item active">
                <br/>
                <h3 style="border-bottom: 1px dashed white;">
                    <s:if test="Title.literal != null">
                        <s:property value="Title.literal.toUpperCase()"/>
                    </s:if>
                    <s:else>
                        <s:property value="TitlenoLang.literal.toUpperCase()"/>
                    </s:else>
                    <span class="pull-right">
                        <i class="icon-stats-3"></i>
                    </span>
                </h3>
                <br/> 
                <div class="row metro">
                    <div class="span3 borderTop">
                        <div class="thumbnail">
                            <%-- ressource --%>
                            <div class="caption">
                                <h4 class="leftTitleBand" >Ressources</h4>
                                <div class="btn-group" role="group">    
                                    <%--------------------%>
                                    <%-- lien ecoscope- --%>
                                    <%--------------------%>
                                    <a alt="Lien Ecoscope" href="<s:property value="uri.literal"/>" target="_blank" class="win-command pull-left win-command-small" >
                                        <button type="" class="btn ">
                                                <i class="icon-globe-2"></i>
                                        </button>
                                    </a>

                                    <%--------------------%>
                                    <%-- permaliens  -----%>
                                    <%--------------------%>
                                    <a href="#" alt="Permalien" class="win-command pull-left win-command-small" id="permalink">
                                        <button type="" class="btn">
                                                <i class="icon-link"></i>
                                        </button>
                                    </a>
                                </div><br/><br/>
                                
                                <h4 class="leftTitleBand">Description </h4>   
                                <s:if test="description.literal != null">
                                    <p class="contentMiddle"><s:property value="description.literal"/></p><br/><br/>
                                </s:if>
                                <s:else>
                                     <p class="contentMiddle">aucune donnée</p><br/><br/>
                                </s:else>    
                                    
                                    
                                <h4 class="leftTitleBand">Créateur </h4>
                                <s:if test="creators.literal != null">
                                    <s:iterator value='creators.literal.split("#")'>
                                        <li >
                                            <a class="individualData" view="indicateurIndividualData" href="#" id="<s:property/>"><s:property/></a>
                                        </li>
                                    </s:iterator>
                                </s:if>
                                <s:else>
                                    <p class="contentMiddle">aucune donnée</p>
                                </s:else>
                                    <br/>
                                <h4 class="leftTitleBand">Tags  
                                <span class="pull-right">
                                    <i class="icon-tag"></i>
                                </span>
                                </h4><br/>
                                <s:if test="subjects.literal != null">
                                    <ul class="nav nav-tabs nav-stacked listHeight ">
                                        <p>
                                            <s:if test="#request.locale.language=='fr'">
                                                <s:set var="lang" value="FR"/>
                                            </s:if>
                                            <s:if test="#request.locale.language=='en'">
                                                    <s:set var="lang" value="EN"/>
                                            </s:if>
                                            <s:property escape="true" value="#lang" default="a default value"/>
                                        <p>
                                        <s:iterator value='subjects.literal.split("#")'>
                                            <%--<li >
                                                <a class="individualData" view="indicateurIndividualData" href="#" id="<s:property/>"><s:property/></a>
                                            </li>--%>
                                            <s:action name="GetSparqlResult" executeResult="false" var="subject">
                                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property/>' as ?uri) ?Title WHERE { <<s:property/>> skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), "FR")) }</s:param>
                                                <s:param name="endpointlocation" value="'ecoscope'"/>
                                            </s:action>
                                            <s:push value="#subject">
                                                <s:iterator value="results">
                                                    <li onclick="loadPopupData('<s:property value="uri.literal"/>','tags');">
                                                        <a>
                                                            <s:property value="Title.literal"/>                                                        
                                                        <span class="pull-right">
                                                            <i class="icon-tag "></i>
                                                        </span>
                                                        </a>
                                                    </li>
                                                </s:iterator>
                                            </s:push>
                                        </s:iterator> 
                                    </ul>
                                </s:if>
                                <s:else>
                                    <p class="contentMiddle">aucune donnée</p>
                                </s:else>
                                <br/>
                                <h4 class="leftTitleBand">Process  </h4>
                                <ul class="nav nav-tabs nav-stacked listHeight">
                                    <li><a href="<s:property value="process.uri"/>" target="_blank"><s:property value="process.uri"/></a></li>
                                </ul>
                                
                               <button class="btn btn-large" id="showDataTable" style="width:100%;">Tableau de donnée</button>
                                
                                <script type="text/javascript" src="<s:url value="/webpages/tools/loadOnClick.js"/>"></script>

                            </div>
                        </div>
                    </div>
                    <div class="span9 borderTop">
                        <div class="thumbnail" style="text-align:center;">
                            <%--<s:iterator value='identifiers.literal.split("#")'>
                                    <iframe src="<s:property/>" style="width:100%;height:450px;"></iframe>
                            </s:iterator> --%>
                            <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                    <div class="carousel-inner">
                                        <ol class="carousel-indicators">
                                           <%-- bulle --%>
                                                <s:iterator value='identifiers.literal.split("#")' status="itemStatus">
                                                    <s:if test="#itemStatus.first">
                                                        <li data-target="#my_carousel" data-slide-to="0" class="active"></li>
                                                    </s:if>
                                                    <s:else>
                                                       <li data-target="#my_carousel" data-slide-to="0"></li>
                                                    </s:else> 
                                                </s:iterator> 
                                           </ol>
                                    <s:iterator value='identifiers.literal.split("#")' status="itemStatus">
                                        <s:if test="#itemStatus.first">
                                            <div class="item active">
                                                <div class="carousel-page">
                                                    <iframe src="<s:property/>" style="width:100%;height:450px;"></iframe>
                                                </div> 
                                                <%--<div class="carousel-caption" style="color:white;">
                                                    titre
                                                    <button onclick="loadPopupData('<s:property value="uri.literal"/>','image');" class="icon-fullscreen pull-right"></button>
                                                </div>--%>
                                            </div>
                                        </s:if>
                                        <s:else>
                                            <div class="item">
                                                <div class="carousel-page">
                                                    <iframe src="<s:property/>" style="width:100%;height:450px;"></iframe>
                                                </div> 
                                                <%--<div class="carousel-caption" style="color:white;">
                                                    titre
                                                    <button onclick="loadPopupData('<s:property value="uri.literal"/>','image');" class="icon-fullscreen pull-right"></button>
                                                </div>--%>
                                            </div>
                                        </s:else> 
                                    </s:iterator>       
                                </div>
                                <a class="left carousel-control" href="#my_carousel" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left"></span>
                                </a>
                                <a class="right carousel-control" href="#my_carousel" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>
                            </div>

                            <%--<iframe src="<s:property value="identifier.literal"/>" style="width:100%;height:450px;"></iframe>
                            <p>identifier : <s:property value="identifier.literal"/></p>--%>
                        </div>
                        
                        <s:iterator value='tableIdentifiers.literal.split("#")' status="itemStatus">
<!--                            <div id="dataTable" style="position: absolute;width: inherit;height: inherit;top: 0;background-color: white;display: none;">-->
                                <div id="dataTable" class="modal fade" style="width:inherit;margin-left: -25%;display:none;">
                                    <button class='close closeDataTable'></button>
                                    <iframe src="<s:property/>" style="width:100%;height:450px;"></iframe>
                                </div>
<!--                            </div>-->
                        </s:iterator>     
                        <br/>
                    </div>
                </div>
            </div>
        </s:if>
    </s:iterator>
    <div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a  class="closeIndividualData btn btn-success">fermer la vue</a></div>
</div>