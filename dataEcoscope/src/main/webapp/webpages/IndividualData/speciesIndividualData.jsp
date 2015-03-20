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
                    <s:if test="prefLabel.literal < 1">
                         n/a
                    </s:if>
                    <s:property value="prefLabel.literal.toUpperCase()"/>
                    <span class="pull-right">
                        <i class=" icon-button "></i>
                    </span>
                </h3>
                <br/>
                <div class="row metro">
                    <%----------------------%>
                    <%-- image de la bdd  --%>
                    <%----------------------%>
                    <div class="span3 borderTop">
                        <div class="thumbnail">
                           
                        
                           
                        
                        <s:action name="GetSparqlResult" executeResult="false" var="imageTest">
                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ('<s:property value="depiction.uri"/>' as ?uri) ?Depictions ?identifier WHERE { <<s:property value="uri.literal"/>> foaf:depiction ?Depictions . ?Depictions dc:identifier ?identifier.}</s:param>
                            <s:param name="endpointlocation" value="'ecoscope'"/>
                        </s:action>
                        <s:push value="#imageTest">
                            <s:if test="results.size <= 1">    
                                <s:action name="GetSparqlResult" executeResult="false" var="niceDepiction">
                                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?niceDepiction ?identifier WHERE { <<s:property value="uri.literal"/>> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction .?niceDepiction dc:identifier ?identifier.}</s:param>
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
                            </s:if>
                            <s:else>
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
                            </s:else>
                        </s:push>
                        
                        <%--<s:else>
                            <div id="my_carousel" class="carousel slide" data-ride="carousel" style="border: 1px solid #DDD;">
                                <div class="carousel-inner" style="text-align:center;height:200px;">              
                                        <span class="icon icon-eye-3" style="font-size:5em;text-align:center;line-height: 2.5em;"></span>
                                </div>
                            </div>
                        </s:else>--%>
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
                                <h4 class="leftTitleBand">synonymes :</h4>
                                <s:iterator value='altLabels.literal.split("#")'>
                                    <s:property/><br/>
                                </s:iterator> 
                            </div>
                            
                            
                            
                        </div>
                    </div>
                            
                            
                    
                    <div class="span6 borderTop">
                        <div class="thumbnail">
                            <%----------------------%>
                            <%-- description -------%>
                            <%----------------------%>
                            <h4 class="middleTitleBand">description :</h4><br/>
                            <s:if test="description.literal != null">
                                <div class="comment contentMiddle"><s:property value="description.literal"/></div>     <br/>               
                            </s:if>
                            <s:else>
                                <p class="contentMiddle">aucune donnée</p>
                            </s:else>


                            <%---------------------------------%>
                            <%-- liste des personnes associé --%>
                            <%---------------------------------%>    
                            <h4 class="middleTitleBand">personnes associées :</h4><br/>
                            <s:if test="persons.literal != null">
                                <ul class="nav nav-tabs nav-stacked listHeight contentMiddle">
                                    <s:iterator value='persons.literal.split("#")'>
                                        <s:action name="GetSparqlResult" executeResult="false" var="creator">
                                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('<s:property/>' as ?uri) ?name ?firstName ?family_name WHERE { <<s:property/>> foaf:name ?name . OPTIONAL { <<s:property/>> foaf:firstName ?firstName } . OPTIONAL { <<s:property/>> foaf:family_name ?family_name }}</s:param>
                                            <s:param name="endpointlocation" value="'ecoscope'"/>
                                        </s:action>
                                        <s:push value="#creator">
                                            <s:iterator value="results">                                            
                                                <li><a class="individualData" href="#" view="contactIndividualData" id="<s:property value="uri.literal"/>"><s:property value="name.literal"/></a><li>
                                            </s:iterator>
                                        </s:push>
                                    </s:iterator> 
                                </ul>
                            </s:if>
                            <s:else>
                                <p class="contentMiddle">aucune donnée</p>
                            </s:else>
                            
                                
                            <div class="row-fluid">    
                                <div class="span6">     
                                <%---------------------------------%>
                                <%-- base de donnée associé -------%>
                                <%---------------------------------%>     
                                <h4 class="middleTitleBand">base de donnée associé :</h4><br/>
                                <s:if test="relatedDatabases.literal != null">
                                    <ul class="nav nav-tabs nav-stacked listHeight contentMiddle">
                                        <s:iterator value='relatedDatabases.literal.split("#")'>
                                            <s:action name="GetSparqlResult" executeResult="false" var="creator">
                                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title WHERE { <<s:property/>> skos:prefLabel ?Title }</s:param>
                                                <s:param name="endpointlocation" value="'ecoscope'"/>
                                            </s:action>
                                            <s:push value="#creator">
                                                <s:iterator value="results">                                            
                                                    <li><a class="individualData" href="#" view="bddIndividualData" id="<s:property value="uri.literal"/>"><s:property value="Title.literal"/></a><li>
                                                </s:iterator>
                                            </s:push>
                                        </s:iterator> 
                                    </ul>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                                </div>
                                
                                
                                <div class="span6">
                                <%---------------------------------%>
                                <%------------- indicateurs -------%>
                                <%---------------------------------%>    
                                <h4 class="middleTitleBand">indicateurs :</h4><br/>
                                <s:if test="indicators.literal != null">
                                    <ul class="nav nav-tabs nav-stacked listHeight contentMiddle">
                                        <s:iterator value='indicators.literal.split("#")'>
                                            <s:action name="GetSparqlResult" executeResult="false" var="indicateurs">
                                                <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX dct: <http://purl.org/dc/terms/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def/> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property/>' as ?uri) ?Title WHERE {<<s:property/>> dc:title ?Title}</s:param>
                                                <s:param name="endpointlocation" value="'ecoscope'"/>
                                            </s:action>
                                            <s:push value="#indicateurs">
                                                <s:iterator value="results">                                            
                                                    <li class="individualData" view="indicateurIndividualData" href="#" id="<s:property value="uri.literal"/>">
                                                        <a><s:property value="Title.literal"/></a>
                                                    <li>
                                                </s:iterator>
                                            </s:push>
                                        </s:iterator> 
                                    </ul>
                                </s:if>
                                <s:else>
                                    <p>aucune donnée</p>
                                </s:else>
                                <br/>
                            </div>
                        </div>
                        </div>
                            
                            
                        <%---------------------------------%>
                        <%------------- openlayer -------%>
                        <%---------------------------------%>  
                        <s:action name="GetSparqlResult" executeResult="false" var="openlayer">
                            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT ?s ?identifier WHERE { <<s:property value="uri.literal"/>> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?s . ?s dc:identifier ?identifier. FILTER regex(?identifier, ".cml", "i")}</s:param>
                            <s:param name="endpointlocation" value="'ecoscope'"/>
                        </s:action>
                        <s:push value="#openlayer">
                            <s:iterator value="results">
                                <s:if test="identifier.literal != null">
                                    <s:url id="pathtoopenlayer" action="GetFile" escapeAmp="false">
                                        <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
                                    </s:url>
                                    <div id="mapa" class="row-fluid" style='height: 450px;' path="<s:property value="pathtoopenlayer"/>"></div>
                                </s:if>
                            </s:iterator>
                        </s:push>
                    </div>
                        
                        
                        
                    <div class="span3 borderTop">
                        <div class="thumbnail">
                            <%--------------------------------%>
                            <%------ publication -------------%>
                            <%--------------------------------%>
                            <h4 class="middleTitleBand">
                                Publication : 
                            <span class="pull-right">
                                <i class="icon-book "></i>
                            </span>
                            </h4><br/>
                            <ul class="niceList" id="publicationSpeciesList" uri="<s:property value="uri.literal"/>" style="height:250px;overflow-y:auto;margin-left:10px;">
                                <%----%>
                            </ul>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </s:if>
    </s:iterator>
    <div style="width:100%;height:50px;font-size:3em;text-align:center;margin-top:50px;"><a class="closeIndividualData btn btn-success">fermer la vue</a></div>
</div>
<script type="text/javascript" src="<s:url value="/webpages/tools/loadOnClick.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var map = new OpenLayers.Map('mapa');
        var openlayerfile = "<s:property value="pathtoopenlayer"/>";
        getWMCData(openlayerfile);

        function getWMCData(wmcUrl) {
            var format = new OpenLayers.Format.WMC({'layerOptions': {buffer: 0}});
            OpenLayers.Request.POST({
                url: wmcUrl,
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                success: function(request) {
                    var text = request.responseText;
                    try {
                        map.destroy();
                        var jsonFormat = new OpenLayers.Format.JSON();
                        var mapOptions = jsonFormat.read('{"div": "mapa", "allOverlays": true}');
                        map = format.read(text, {map: mapOptions});
                        map.addControl(new OpenLayers.Control.LayerSwitcher());
                    } catch (err) {
                    }
                },
                failure: function(request) {
                    document.getElementById('msg').style.display = "block";
                    document.getElementById('msg').innerHTML = "The server is temporarily unavailable. Please try again later.";
                }
            });
        }
    });


</script>