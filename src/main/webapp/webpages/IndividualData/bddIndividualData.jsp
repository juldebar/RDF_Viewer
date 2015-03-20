<%-- 
    Document   : bddIndividualData
    Created on : 12 janv. 2015, 09:57:11
    Author     : arnaud
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<div class="container" >
    <s:iterator value="results" status="stat">

        
        <s:if test="#stat.first == true">
            <div id="pivot-item-1" class="pivot-item active">
                <style>
                    .carousel-page{
                        width:100%;
                        height:250px;
                        background-color:#5f666d;
                        color:white;
                    }
                    
                </style>
               <h3 style="border-bottom: 1px dashed white;">
                    <%------------%>
                    <%-- titre  --%>
                    <%------------%>
                    <s:if test="Title.literal < 1">
                         n/a
                    </s:if>
                    <s:property value="Title.literal.toUpperCase()"/>
                     <span class="pull-right">
                        <i class="icon-database"></i>
                    </span>
                </h3>
                <br/>
                <div class="row metro">
                    <%----------------------%>
                    <%-- image de la bdd  --%>
                    <%----------------------%>
                    <div class="span3 borderTop">
                        <div class="thumbnail">
                            
                        <s:if test="depiction.uri != null">
                               
                        <s:action name="GetSparqlResult" executeResult="false" var="imageTest">
                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ('<s:property value="depiction.uri"/>' as ?uri) ?Depictions ?identifier WHERE { <<s:property value="uri.literal"/>> foaf:depiction ?Depictions . ?Depictions dc:identifier ?identifier.}</s:param>
                            <s:param name="endpointlocation" value="'ecoscope'"/>
                        </s:action>
                        <s:push value="#imageTest">
                            <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                <div class="carousel-inner">
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
                                                <img onclick="loadPopupData('<s:property value="Depictions.uri"/>','image');" src="<s:property value="picUrl"/>" class="img-responsive" style="margin:0px auto;height:100%;width:100%;cursor:pointer;" />
                                            </div> 
                                            <div class="carousel-caption" style="color:white;">
                                                titre
                                                <button onclick="loadPopupData('<s:property value="Depictions.uri"/>','image');" class="icon-fullscreen pull-right"></button>
                                            </div>
                                        </div>
                                        <%-- fin de caroussel --%>
                                    </s:iterator>
                                </div>
                                <s:if test="results.size <= 1">    
                                    
                                </s:if>
                                <s:else>
                                    <%-- bouton de contrôle --%>
                                    <a class="left carousel-control" href="#my_carousel" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                    </a>
                                    <a class="right carousel-control" href="#my_carousel" data-slide="next">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                    </a>
                                </s:else>
                            </div>
                        </s:push>
                        </s:if>
                        <s:else>
                            <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                <div class="carousel-inner" style="text-align:center;height:200px;">              
                                        <span class="icon icon-database" style="font-size:5em;text-align:center;line-height: 2.5em;"></span>
                                </div>
                            </div>
                        </s:else>
                        </div>
                        <div class="thumbnail">
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

                                    <%-----------------------%>
                                    <%-- lien traitement bdd-%>
                                    <%-----------------------%>
                                    <s:action name="GetSparqlResult" executeResult="false" var="urlDatabase">
                                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?identifier WHERE { <<s:property value="uri.literal"/>> dc:identifier ?identifier }</s:param>
                                        <s:param name="endpointlocation" value="'ecoscope'"/>
                                    </s:action>
                                    <s:push value="#urlDatabase">
                                        <s:iterator value="results">
                                            <a alt="liens vers outils de traitements" href="<s:property value="identifier.uri"/>" target="_blank" class="win-command pull-left win-command-small" >
                                                <button type="" class="btn">
                                                        <i class="icon-database"></i>
                                                </button>
                                            </a>
                                        </s:iterator>
                                    </s:push> 


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
                                <h4 class="leftTitleBand" >Date de création</h4>
                                <s:if test="date.literal != null">
                                    <p><s:property value="date.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                                <!--                            <p><a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a></p>-->
                            </div>

                            <div class="caption">
                                <h4 class="leftTitleBand">Droit d'auteur</h4>
                                <s:if test="rights.literal != null">
                                    <p><s:property value="rights.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                                <!--                            <p><a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a></p>-->
                            </div>

                            <div class="caption">
                                <h4 class="leftTitleBand">Format de la base de donnée</h4>
                                <s:if test="format.literal != null">
                                    <p><s:property value="format.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                                <!--                            <p><a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a></p>-->
                            </div>

                            <div class="caption">
                                <h4 class="leftTitleBand">Type de la base </h4>
                                <s:if test="type.literal != null">
                                    <p><s:property value="type.literal"/></p>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                            </div>
                        </div>
                    </div>
                            
                            
                    <%----------------------%>
                    <%-- liste des sujest --%>
                    <%----------------------%>

                    <div class="span6 borderTop">
                        <div class="thumbnail">
                        <h4 class="middleTitleBand">Description </h4><br/>
                        <s:if test="description.literal != null">
                            <div class="comment contentMiddle"><s:property value="description.literal"/></div>     <br/>               
                        </s:if>
                        <s:else>
                            <p>aucune donnée</p>
                        </s:else>
                            
                        <div class="row-fluid">    
                            <div class="span6">    
                                <h4 class="middleTitleBand">Creator </h4><br/>
                                <s:if test="creator.uri != null">
                                    <ul class="nav nav-tabs nav-stacked contentMiddle">
                                        <s:action name="GetSparqlResult" executeResult="false" var="creator">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('<s:property value="creator.uri"/>' as ?uri)?name ?firstName ?family_name WHERE { <<s:property value="creator.uri"/>> foaf:name ?name . OPTIONAL { <<s:property value="creator.uri"/>> foaf:firstName ?firstName } . OPTIONAL { <<s:property value="creator.uri"/>> foaf:family_name ?family_name }}</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#creator">
                                            <s:iterator value="results">
                                                <li class="individualData" view="contactIndividualData" id="<s:property value="uri.literal"/>">
                                                    <a><s:property value="name.literal"/>
                                                        <span class="pull-right">
                                                            <i class="icon-user-2"></i>
                                                        </span>
                                                    </a>
                                                    
                                                </li>
                                            </s:iterator>
                                        </s:push>
                                    </ul>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                            </div>    

                                <%--view="publicationIndividualData"
                                individualData
                                id="<s:property value="publication.uri"/>"--%>
                            <div class="span6">
                               <h4 class="middleTitleBand">Contributor </h4><br/> 
                                <s:if test="contributor.uri != null">
                                     <ul class="nav nav-tabs nav-stacked contentMiddle">
                                        <s:action name="GetSparqlResult" executeResult="false" var="contributor">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('<s:property value="contributor.uri"/>' as ?uri) ?name ?firstName ?family_name WHERE { <<s:property value="contributor.uri"/>> foaf:name ?name . OPTIONAL { <<s:property value="contributor.uri"/>> foaf:firstName ?firstName } . OPTIONAL { <<s:property value="contributor.uri"/>> foaf:family_name ?family_name } }</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#contributor">
                                            <s:iterator value="results">                                
                                                <li class="individualData" view="contactIndividualData" id="<s:property value="uri.literal"/>">
                                                    <a><s:property value="name.literal"/>
                                                        <span class="pull-right">
                                                            <i class="icon-user-2"></i>
                                                        </span>
                                                    </a>
                                                </li>
                                            </s:iterator>
                                        </s:push>
                                    </ul>
                                </s:if>
                                <s:else>
                                    <p class="contentMiddle">aucune donnée</p>    
                                </s:else>
                            </div>
                        </div>
                       
                        <div class="timeline row-fluid" style="height:auto;margin:0;">
<!--                            <ul class="events">
                                <li style="width: 99.5%; left: 0;">Période couverte par le jeu de données <em></em></li>
                            </ul>  end .events -->
                            <h4 class="middleTitleBand">Période couverte par le jeu de données</h4><br/>
                            <ul class="intervals container-fluid">
                                <li class="first" id="startDate"><s:property value="startDate.literal"/></li>
                                <li class="last" id="endDate"><s:property value="endDate.literal"/></li>
                            </ul>  
                        </div>
                        <br/>
                        <div class="timeline " style="height:auto">
<!--                            <ul class="events">
                                <li style="width: 99.5%; left: 0;">Couverture spatiale du jeu de données<em></em></li>
                            </ul>-->
                            <h4 class="middleTitleBand">Couverture spatiale du jeu de données</h4><br/>
                        </div>
                        
                        <div id="mapa" style="height:450px"></div>
                        </div>
                        <%-- openlayer--%>
                        <div class="thumbnail" style="width:50%;margin-left:25%;">
                            <%--<s:property value="uri.literal"/>--%>
                            <s:action name="GetSparqlResult" executeResult="false" var="contributor">
                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dct: <http://purl.org/dc/terms/> SELECT ?spatial WHERE { <<s:property value="uri.literal"/>> dct:spatial ?spatial }</s:param>
                                <s:param name="endpointlocation" value="'ecoscope'"/>
                            </s:action>
                            <s:push value="#contributor">
                                <s:iterator value="results">                                
                                    <%--<p><s:property value="spatial.literal"/></p>--%>
                                    <script type="text/javascript">
                                        var wkt = "<s:property value="spatial.literal"/>";
                                    </script>
                                </s:iterator>
                            </s:push>
              
                            <script type="text/javascript">
                                $(document).ready(function() {
                                    var map = new OpenLayers.Map('mapa');
                                    var wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
                                        "http://vmap0.tiles.osgeo.org/wms/vmap0", {layers: 'basic'} );
                                    map.addLayer(wms);
                                    map.zoomToMaxExtent(); 
                                    console.log(wkt);
                                    var boundingBoxLayer = new OpenLayers.Layer.Vector("boundingBoxLayer");//localisation des resultats
                                    var wktReader = new OpenLayers.Format.WKT();
                                    var boundingBoxfeatures = wktReader.read(wkt);
                                    boundingBoxLayer.addFeatures(boundingBoxfeatures);
                                    map.addLayer(boundingBoxLayer);
                                });


                            </script>
                        </div>
                    </div>
                    <div class="span3 borderTop">
                        <div class="thumbnail">
                            <h4 class="middleTitleBand">Tags 
                            <span class="pull-right">
                                <i class="icon-tag "></i>
                            </span>
                            </h4><br/>
                            <ul class="niceList" id="subjectList" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:scroll;margin-left:10px;">
                                
                            </ul>
                          
                            <h4 class="middleTitleBand">Documents associés 
                            <span class="pull-right">
                                <i class="icon-tag "></i>
                            </span>
                            </h4><br/>
                            <ul class="niceList" id="" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:scroll;margin-left:10px;">
                                
                            </ul>
                            <br/>
                        </div>  
                    </div>    
                </div>
            </div>
        </s:if>
    </s:iterator>
    <div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a class="closeIndividualData btn btn-success">fermer la vue</a></div>
     
</div>
<script type="text/javascript" src="<s:url value="/webpages/tools/loadOnClick.js"/>"></script>