<%-- 
    Document   : bddIndividualData
    Created on : 12 janv. 2015, 09:57:11
    Author     : arnaud
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="container" >
    
    <s:if test="#request.locale.language=='fr'">
        <s:set var="lang" value="FR"/>
    </s:if>
    <s:if test="#request.locale.language=='en'">
        <s:set var="lang" value="EN"/>
    </s:if>
    
    
    <s:iterator value="results">
        <div id="pivot-item-1" class="pivot-item active">
            <br/>
            <h3 style="border-bottom: 1px dashed white;">
                <s:if test="Title.literal < 1">
                    n/a
                </s:if>
                <s:property value="Title.literal.toUpperCase()"/>
                <span class="pull-right">
                    <i class="icon-book"></i>
                </span>
                
            </h3>
            <br/>
            <div class="row metro">
                <div class="span3 borderTop">
                    <div class="thumbnail">
                    <div class="thumbnail" style="text-align:center;">
                        <img alt="300x200" data-src="holder.js/300x200" style="width: 300px; height: 200px;" src="data:image/png;base64,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">
                    </div>
                    <%--<s:property value="subjects.literal"/><br/>--%>
                    
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
                        </div>
                    </div>
                    
                    
                    <div class="caption">
                        <s:if test="subjects != null">
                            <h4 class="leftTitleBand">
                                Tags 
                                <span class="pull-right">
                                    <i class="icon-tag "></i>
                                </span>
                            </h4><br/>
                            <ul class="nav nav-tabs nav-stacked ">
                                <s:iterator value='subjects.literal.split("#")'>
                                    <s:action name="GetSparqlResult" executeResult="false" var="subjects">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property/>' as ?uri) ?Title WHERE { <<s:property/>> skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), "EN")) }</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#subjects">
                                        <s:iterator value="results">
                                            <li onclick="loadPopupData('<s:property value="uri.literal"/>','species');">
                                                <a>
                                                    <s:property value="Title.literal"/>
                                                    
                                                </a>
                                            </li>
                                        </s:iterator>
                                    </s:push>
                                </s:iterator>
                            </ul>
                        </s:if>
                        <s:else>

                        </s:else>
                    </div>
                </div>
                </div>
                <div class="span9 borderTop">
                    <div class="thumbnail">
                        <div class="caption">
                            <%-------------------%>
                            <%-- description    --%>
                            <%-------------------%>
                            <h4 class="middleTitleBand">Description </h4><br/>
                            <s:if test="description != null">
                                <p class="contentMiddle"><s:property value="description.literal"/></p>
                            </s:if>
                            <s:else>
                                <p class="contentMiddle">Aucune donnée</p>
                            </s:else>
                            
                                
                            <%-------------------%>
                            <%-- createur      --%>
                            <%-------------------%>
                            
                            <%--view="publicationIndividualData"
                            individualData
                            id="<s:property value="publication.uri"/>"--%>
                            <h4 class="middleTitleBand">Créateur </h4><br/>
                            <ul class="nav nav-tabs nav-stacked contentMiddle">
                            <s:if test="creators.literal != null">
                                <s:iterator value='creators.literal.split("#")'>
                                    <s:action name="GetSparqlResult" executeResult="false" var="creators">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('<s:property/>' as ?uri) ?name ?firstName ?family_name WHERE { <<s:property/>> foaf:name ?name . OPTIONAL { <<s:property/>> foaf:firstName ?firstName } . OPTIONAL { <<s:property/>> foaf:family_name ?family_name }}</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#creators">
                                        <s:iterator value="results">
                                            <li class="individualData" view="contactIndividualData" id="<s:property value="uri.literal"/>">
                                                <a>
                                                    <s:property value="name.literal"/>
                                                    <span class="pull-right">
                                                        <i class="icon-user-2"></i>
                                                    </span>
                                                </a>
                                            </li>
                                        </s:iterator>
                                    </s:push>
                                </s:iterator> 
                            </s:if>
                            </ul>
                            
                            
                            <%-------------------%>
                            <%-- identifier    --%>
                            <%-------------------%>
                            <h4 class="middleTitleBand">Identifier </h4><br/>
                            
                            
                            
                            
                            <ul class="nav nav-tabs nav-stacked contentMiddle">
                            <s:if test="identifiers.literal != null">
                                <s:iterator value='identifiers.literal.split("#")' var="identifierUrl">
                                    <s:if test="%{#identifierUrl.contains('http')}">
                                        <li><a href="<s:property value="identifierUrl"/>" target="_blank">lien vers le fichier</a></li>
                                    </s:if>
                                    <s:else>                                        
                                        <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                            <s:param name="filePath"><s:property value="identifierUrl"/></s:param>
                                        </s:url>
                                        <li><a href="<s:property value="picUrl"/>" target="_blank">lien vers le fichier</a></li>
                                    </s:else>
                                </s:iterator> 
                            </s:if>
                            </ul>
                            
                            <%--<p class="contentMiddle"><s:property value="identifier.literal"/></p>--%>

                            <%--<h4>depiction :</h4>   
                            <p><s:property value="depiction.uri"/></p>

                            <h4>contributor :</h4>   
                            <p><s:property value="contributor.uri"/></p>

                            <h4>rights :</h4>   
                            <p><s:property value="rights.literal"/></p>

                            <h4>type :</h4>   
                            <p><s:property value="type.literal"/></p>

                            <h4>format :</h4>   
                            <p><s:property value="format.literal"/></p>--%>

                            <h4 class="middleTitleBand">Date </h4><br/>   
                            <p class="contentMiddle"><s:property value="date.literal"/></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </s:iterator>
    <div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a class="closeIndividualData btn btn-success">fermer la vue</a></div>
</div>