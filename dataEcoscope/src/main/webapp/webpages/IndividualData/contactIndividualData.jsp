<%-- 
    Document   : bddIndividualData
    Created on : 12 janv. 2015, 09:57:11
    Author     : arnaud
--%>
<%-- 

//à finir la mise en forme
topic_interests
publicationss


#knowss (done)
##prefGeoGraphicObjects
#fundedBys (done)
#imgs
#currentProjects (done)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="container" >
    <s:iterator value="results">
        <div id="pivot-item-1" class="pivot-item active">
            <br/>
            <h3 style="border-bottom: 1px dashed white;">
                <%---------%>
                <%--titre--%>
                <%----OK---%>
                <s:if test="name.literal < 1">
                    n/a
                </s:if>
                <s:property value="name.literal.toUpperCase()"/>
                <span class="pull-right">
                    <i class="icon-user-2"></i>
                </span>
                
            </h3>
            <br/>
            <div class="row metro">
                <div class="span3 borderTop">
                    <div class="thumbnail">
                        <%---------%>
                        <%--image--%>
                        <%---------%>
                        
                        <%-- rajouter un test pour savboir si on met les flèches ou pas--%>
                        <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                <s:if test="imgs.literal != null">
                                    <div class="carousel-inner">
                                    <%-- on compte le nombre d'image --%>
                                    <s:set var="numberImage" value="0"/>
                                    <s:iterator value='imgs.literal.split("#")' var="split" status="imageCount">
                                       
                                        <%--split size :<s:property value ="#imageCount.getIndex()"/>--%>
                                        <%--<s:property value="split"/>--%>
                                        <s:if test="#imageCount.first == true">
                                            <div class="item active"> 
                                        </s:if>
                                        <s:else>
                                             <div class="item">
                                         </s:else>
                                        <%--<li><a href='<s:property/>'>split : '<s:property value="split"/>'</a></li>--%>
                                        <s:if test="#split != null">
                                            <s:action name="GetSparqlResult" executeResult="false" var="images">
                                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT ('<s:property value="split"/>' as ?uri) ?identifier WHERE{ <<s:property value="split"/>> dc:identifier ?identifier.}</s:param>
                                                <s:param name="endpointlocation" value="'ecoscope'"/>
                                            </s:action>
                                            <s:push value="#images">
                                                <s:iterator value="results" >
                                                    <s:if test="identifier == null">hello wolrd it's null</s:if>
                                                    <%--identifier literal : <s:property value="identifier.literal"/>
                                                    uri : <s:property value="uri.literal"/><br/>--%>
                                                    <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                                        <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                                        <s:param name="picSize">380x380</s:param>
                                                    </s:url>
                                                    <div class="carousel-page">
                                                        <img <%--onclick="loadPopupData('<s:property value="uri.literal"/>','image');"--%> src="<s:property value="picUrl"/>" class="img-responsive" style="margin:0px auto;height:100%;width:100%;cursor:pointer;" />
                                                    </div> 
                                                    <div class="carousel-caption" style="color:white;">
                                                        <button onclick="loadPopupData('<s:property value="uri.literal"/>','image');" class="icon-fullscreen pull-right"></button>
                                                    </div>
                                                    </div>
                                                </s:iterator>
                                            </s:push>
                                        </s:if>
                                        <s:set var="numberImage" value="#numberImage + 1"/>
                                    </s:iterator>
                                </div>
                                <s:if test="#numberImage > 1">
                                    <%-- puce de navigation entre image --%>
                                    <ol class="carousel-indicators">
                                         <%-- bulle --%>
                                        <s:iterator value='imgs.literal.split("#")' status="imageStatus">
                                            <s:if test="#imageStatus.first == true">
                                                 <li data-target="#my_carousel" data-slide-to="0" class="active"></li>
                                            </s:if>
                                            <s:else>
                                                 <li data-target="#my_carousel" data-slide-to="0"></li>
                                            </s:else>
                                        </s:iterator>
                                    </ol>
                                    
                                    <%-- bouton de contrôle --%>
                                    <a class="left carousel-control" href="#my_carousel" data-slide="prev" >
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                    </a>
                                    <a class="right carousel-control" href="#my_carousel" data-slide="next" >
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                    </a>

                                </s:if>            
                            </s:if>
                            <s:else>
                                <s:action name="GetSparqlResult" executeResult="false" var="niceDepiction">
                                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?niceDepiction ?identifier WHERE { <http://www.ecoscope.org/ontologies/agents/florenceGalletti> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction .?niceDepiction dc:identifier ?identifier.}</s:param>
                                    <s:param name="endpointlocation" value="'ecoscope'"/>
                                </s:action>
                                <s:push value="#niceDepiction">
                                    <s:if test="results.size <= 1">
                                        <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                            <div class="carousel-inner" style="text-align:center;height:200px;">              
                                                    <span class="icon icon-tag" style="font-size:5em;text-align:center;line-height: 2.5em;"></span>
                                            </div>
                                        </div>
                                    </s:if>
                                    <s:else>
                                        <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                            <div class="carousel-inner" style="text-align:center;height:200px;">              
                                                    <ol class="carousel-indicators">
                                                        <%-- bulle --%>
                                                        <s:iterator value="results" status="imageStatus">
                                                            <s:if test="#imageStatus.first == true">
                                                                 <li data-target="#my_carousel" data-slide-to="0" class="active"></li>
                                                            </s:if>
                                                            <s:else>
                                                                 <li data-target="#my_carousel" data-slide-to="0"></li>
                                                            </s:else>
                                                        </s:iterator>
                                                    </ol>
                                                    <s:iterator value="results" status="imageStatus">
                                                        <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                                            <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                                        </s:url>
                                                        <%-- page contenant la photo --%>
                                                        <s:if test="#imageStatus.first == true">
                                                           <div class="item active"> 
                                                        </s:if>
                                                        <s:else>
                                                            <div class="item">
                                                        </s:else>
                                                            <div class="carousel-page">
                                                                <img onclick="loadPopupData('<s:property value="uri.literal"/>','image');" src="<s:property value="picUrl"/>" class="img-responsive" style="margin:0px auto;height:100%;width:100%;cursor:pointer;" />
                                                            </div> 
                                                            <div class="carousel-caption" style="color:white;">
                                                                titre
                                                                <button onclick="loadPopupData('<s:property value="uri.literal"/>','image');" class="icon-fullscreen pull-right"></button>
                                                            </div>
                                                        </div>
                                                        <%-- fin de caroussel --%>
                                                    </s:iterator>
                                            </div>
                                        </div>
                                    </s:else>
                                </s:push>
                                
                            </s:else>
                            
                        </div>
                                 
                        <%--------------------%>
                        <%-- bloc de gauche --%>
                        <%--------------------%>
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
                                <br/><br/>
                                
                           
                            
                                
                            
                            
                            <%--------------------%>
                            <%-- nom de famille --%>
                            <%--------OK----------%>
                            <h4 class="leftTitleBand">Nom :</h4>    
                            <s:if test="family_name != null">
                                <p><s:property value="family_name"/></p>
                            </s:if>
                            <s:else>
                                <p>
                                    <i>Aucune donnée disponible</i>
                                </p>
                            </s:else>    
                                
                                
                                
                            <%------------%>
                            <%-- prénom --%>
                            <%-----OK-----%>
                            <h4 class="leftTitleBand">Prénom : </h4>
                            <s:if test="firstName != null">
                                <p><s:property value="firstName.literal"/></p>
                            </s:if>
                            <s:else>
                                <p>
                                    <i>Aucune donnée disponible</i>
                                </p>
                            </s:else>    
                                
                                
                                
                            <%---------------%>
                            <%-- téléphone --%>
                            <%-------OK------%>
                            <h4 class="leftTitleBand">Téléphone : </h4>
                            <s:if test="phone != null">
                                <p><s:property value="phone.literal"/></p>
                            </s:if>
                            <s:else>
                                <p>
                                    <i>Aucune donnée disponible</i>
                                </p>
                            </s:else>    
                                
                                
                                
                            <%---------------%>
                            <%-- logo --%>
                            <%-----OK--------%>
                            <h4 class="leftTitleBand">institut : </h4>
                            <s:if test="logos != null">
                                <s:iterator value='logos.literal.split("#")'> 
                                    <s:action name="GetSparqlResult" executeResult="false" var="images">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT ('<s:property/>' as ?uri) ?identifier WHERE{ <<s:property/>> dc:identifier ?identifier.}</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#images">
                                    <s:iterator value="results" >
                                            <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                                <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                                <s:param name="picSize">380x380</s:param>
                                            </s:url>
                                            <div style="height:50px;width:100%;">  
                                                <img src="<s:property value="picUrl"/>" class="img-responsive" style="width:auto;margin:0px auto;height:100%;cursor:pointer;" />                                
                                            </div>  
                                    </s:iterator>
                                </s:push>
                                    
                                    
                                    
                                </s:iterator>
                            </s:if>
                            <s:else>
                                <p>
                                    <i>Aucune donnée disponible</i>
                                </p>
                            </s:else> 
                            
                               
                            <br/>    
                                
                            <%--------------%>
                            <%-- fundedBy --%> 
                            <%------OK------%>
                            <h4 class="leftTitleBand">fundedBy : </h4>
                            <s:if test="fundedBys != null">
                                <s:iterator value='fundedBys.literal.split("#")'> 
                                    <%--<a href="<s:property/>"><s:property/></a>    --%>
                                    <s:action name="GetSparqlResult" executeResult="false" var="fundedBy">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title WHERE {<<s:property/>> foaf:name ?Title }</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#fundedBy">
                                        <s:iterator value="results" >
                                            <a><s:property value="Title.literal"/></a>
                                        </s:iterator>
                                    </s:push>
                                </s:iterator>
                            </s:if>
                            <s:else>
                                <p>
                                    <i>Aucune donnée disponible</i>
                                </p>
                            </s:else>   
                        </div>
                    </div>
                </div>
                            
                            
                <%--------------------%>
                <%-- bloc du centre---%>
                <%--------------------%>
                <div class="span6 borderTop">
                    <div class="thumbnail">
                        
                        
                        <%-------------------%>
                        <%-- liste de lien --%>
                        <%-------------------%>
                        <ul class="nav nav-tabs nav-stacked">

                            <%-------------------%>
                            <%-- is member of ---%>
                            <%-------------------%>
                            <h4 class="middleTitleBand"> is member of : </h4><br/>
                            <s:if test="isMemberOf != null">
                                <ul class="nav nav-tabs nav-stacked contentMiddle">
                                    <%--<li><a href="<s:property value="isMemberOf.uri"/>" target="_blank">is member of</a></li>--%>
                                    <s:action name="GetSparqlResult" executeResult="false" var="isMemberOf">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property value="isMemberOf.uri"/>' as ?uri) ?Title WHERE {<<s:property value="isMemberOf.uri"/>> foaf:name ?Title }</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#isMemberOf">
                                        <s:iterator value="results" >
                                            <li><a href="<s:property value="uri.literal"/>" target="_blank"><s:property value="Title.literal"/></a></li>
                                        </s:iterator>
                                    </s:push>
                                </ul>
                            </s:if>
                            <s:else>
                                <p>
                                    <i class="contentMiddle" >Aucune donnée disponible</i>
                                </p>    
                            </s:else> 
                                                        
                            <%-------------------%>
                            <%---currentproject--%>
                            <%--------OK--------%>
                            
                            <h4 class="middleTitleBand">currentProject : </h4><br/>
                            
                            <s:if test="currentProjects.literal != null">
                                <ul class="nav nav-tabs nav-stacked contentMiddle">
                                    <s:iterator value='currentProjects.literal.split("#")'> 
                                        <%--<li><a href='<s:property/>'><s:property/></a></li>--%>

                                        <s:action name="GetSparqlResult" executeResult="false" var="images">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title WHERE {<<s:property/>> foaf:name ?Title }</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#images">
                                            <s:iterator value="results" >
                                                <li><a href="<s:property value="uri.literal"/>" target="_blank"><s:property value="Title.literal"/></a></li>
                                            </s:iterator>
                                        </s:push>
                                    </s:iterator>
                                </ul>
                            </s:if>
                            <s:else>
                                <p>
                                    <i class="contentMiddle">Aucune donnée disponible</i>
                                </p>
                            </s:else>    
                            
                                
                             
                            <h4 class="middleTitleBand"> liens : </h4><br/>     
                            <%---------------%>
                            <%-- home page --%>
                            <%---------------%>
                            <ul class="nav nav-tabs nav-stacked contentMiddle">
                            <s:if test="homepage != null">
                                <li><a href="<s:property value="homepage.uri"/>" target="_blank">home page</a></li>
                            </s:if> 
                               
                            <%-----------------------%>
                            <%-- workspaceHomepage --%>
                            <%-----------------------%>
                            
                            <s:if test="workplaceHomepage != null">
                                
                                    <li><a href="<s:property value="workplaceHomepage.uri"/>" target="_blank">workplaceHomepage</a></li>
                               
                            </s:if>
                                
                                
                            <%----------------------%>
                            <%-- workInfoHomepage --%>
                            <%----------------------%>
                            <s:if test="workInfoHomepage != null">
                                    <li><a href="<s:property value="workInfoHomepage.uri"/>" target="_blank"> workInfoHomepage </a> </li>
                            </s:if>
                            </ul>    
                             
                            <%-----------%>
                            <%-- knows --%>
                            <%-----OK----%>
                            
                            <h4 class="middleTitleBand">knows : </h4><br/>
                            
                            <s:if test="knowss.literal != null">
                                <ul class="nav nav-tabs nav-stacked contentMiddle">
                                    <s:iterator value='knowss.literal.split("#")'> 
                                        <%--<li><a href="<s:property/>"><s:property/></a></li>--%>
                                        <s:action name="GetSparqlResult" executeResult="false" var="creator">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('<s:property/>' as ?uri) ?name ?firstName ?family_name WHERE { <<s:property/>> foaf:name ?name . OPTIONAL { <<s:property/>> foaf:firstName ?firstName } . OPTIONAL { <<s:property/>> foaf:family_name ?family_name }}</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#creator">
                                            <s:iterator value="results">                                            
                                                <li>
                                                    <a class="individualData" href="#" view="contactIndividualData" id="<s:property value="uri.literal"/>">
                                                        <s:property value="name.literal"/>
                                                        <span class="pull-right">
                                                            <i class="icon-user-2"></i>
                                                        </span>
                                                    </a>
                                                <li>
                                            </s:iterator>
                                        </s:push>
                                    </s:iterator>
                                </ul>
                            </s:if>
                            <s:else>
                                <p>
                                    <i class="contentMiddle">Aucune donnée disponible</i>
                                </p>
                            </s:else>
                        </ul>  

                        <%--<h4>prefGeoGraphicObject : </h4>
                        <p><s:property value="prefGeoGraphicObject.uri"/></p>--%>

                    </div>
                </div>
                <div class="span3 borderTop">

                    <div class="thumbnail" >
                        <%--------------------------------%>
                        <%------ topic interest-----------%>
                        <%--------------------------------%>
                        
                        <h4 class="middleTitleBand">topic_interest : 
                            <span class="pull-right">
                                 <i class="icon-thumbs-up-2 "></i>
                            </span>
                        </h4><br/>
                        <ul class="niceList" id="topicInterestList" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:auto;margin-left:10px;">
                            <%--<s:iterator value='topic_interests.literal.split("#")'> 
                                <s:action name="GetSparqlResult" executeResult="false" var="topicInterest">
                                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title  WHERE {<<s:property/>> skos:prefLabel ?Title }</s:param>
                                    <s:param name="endpointlocation" value="'ecoscope'"/>
                                </s:action>
                                <s:push value="#topicInterest">
                                    <s:iterator value="results">                                
                                        <li onclick="loadPopupData('<s:property value="uri.literal"/>','publication');"><a><s:property value="Title.literal"/></a></li>
                                    </s:iterator>
                                </s:push>
                            </s:iterator>--%>
                            
                            
                            <%-- topic interest mise en forme --%>

                            <%--<s:action name="GetSparqlResult" executeResult="false" var="topicInterest">
                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?publications WHERE {<<s:property value="uri.literal"/>> foaf:name ?name .OPTIONAL { <<s:property value="uri.literal"/>> foaf:publications ?publications } }</s:param>
                                <s:param name="endpointlocation" value="'ecoscope'"/>
                            </s:action>
                            <s:push value="#topicInterest">
                                <s:iterator value="results">                                
                                    <s:action name="GetSparqlResult" executeResult="false" var="topicInterestSubject">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property value="publications.uri"/>' as ?uri) ?Title WHERE {<<s:property value="publications.uri"/>> dc:title ?Title }</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#topicInterestSubject">
                                        <s:iterator value="results">
                                            <li onclick="loadPopupData('<s:property value="uri.literal"/>','publication');"><a><s:property value="Title.literal"/></a></li>
                                        </s:iterator>
                                    </s:push>
                                </s:iterator>
                            </s:push>--%>
                        </ul>
                    
                    <br/>
                    
                        <%--------------------------------%>
                        <%------ publication -------------%>
                        <%--------------------------------%>
                        <h4 class="middleTitleBand">Publication : 
                            <span class="pull-right">
                                <i class="icon-book "></i>
                            </span>
                        </h4><br/>
                        <%--<ul class="niceList" uri="<<s:property value="uri.literal"/>" style="height:250px;overflow-y:scroll;">--%>
                            <%--<s:iterator value='publicationss.literal.split("#")'> 
                                <%--<s:property/>--%>
                                <%--<s:action name="GetSparqlResult" executeResult="false" var="publication">
                                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title  WHERE {<<s:property/>> dc:title ?Title }</s:param>
                                    <s:param name="endpointlocation" value="'ecoscope'"/>
                                </s:action>
                                <s:push value="#publication">
                                    <s:iterator value="results">                                
                                        <li onclick="loadPopupData('<s:property value="uri.literal"/>','publication');"><a><s:property value="Title.literal"/></a></li>
                                    </s:iterator>
                                </s:push>
                            </s:iterator>--%>
<!--                        </ul>-->
                        <ul class="niceList" id="publicationList" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:auto;margin-left:10px;">
                            <%----%>
                        </ul>
                    </div>
                    <script type="text/javascript" src="<s:url value="/webpages/tools/loadOnClick.js"/>"></script>
                </div>
            </div>
        </div>

    </s:iterator>
</div>
<div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a class="closeIndividualData btn btn-success">fermer la vue</a></div>
