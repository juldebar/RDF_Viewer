<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <div class="row-fluid" style="border-top: 1px solid black; border-bottom:1px solid black;">
        <h3>map</h3>
        <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
            <s:param name="query" value="'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT ?s ?identifier WHERE { <' + uri + '> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?s . ?s dc:identifier ?identifier. FILTER regex(?identifier, \".cml\", \"i\")}'"/>
            <s:param name="view" value="'openlayer'"/>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:url>

        <sj:div id="openlayer" cssClass="row-fluid" href="%{ajaxUrl}" style="width:100%;overflow: hidden;margin-bottom:20px;">
            <div style="text-align: center; ">
                <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
            </div>
        </sj:div>
    </div>

    <%-- highchart de ouf --%>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>
    <h3> indicateurs</h3>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?tuna ?indicator ?identifier WHERE { ?indicator rdf:type <http://www.ecoscope.org/ontologies/resources_def/indicator> . ?indicator dc:subject <http://www.ecoscope.org/ontologies/ecosystems/thunnus_albacares>. ?indicator dc:identifier ?identifier. ?indicator dc:identifier ?identifier. FILTER regex(?identifier, \".json\", \"i\") }'"/>
        <s:param name="view" value="'highchart'"/>
        <s:param name="endpointlocation" value="'ecoscope'"/>
    </s:url>

    <sj:div id="highchartContainer" cssClass="row-fluid" href="%{ajaxUrl}" style="width:100%;overflow: hidden;border-bottom: 1px solid black;">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>

    <!--    <div id="highchartContainer" style="width:100%;overflow: hidden;border-bottom: 1px solid black;">
            <div id="previousHighchart" class="highchartNavigate" style="font-size: 2em;width:20px;height:20px;position:absolute;cursor:pointer;">
                <
            </div>
            <div id="nextHighchart" class="highchartNavigate" style="font-size: 2em;width:20px;height:20px;right:20px;position:absolute;cursor:pointer;">
                >
            </div>
            <ul id="listHighchart" style="margin:0 auto;">
                <li class="individualHighchart" style="width:400px;float:left;display: inline-block;">
                    <div id="container1" style="margin-left:5%;width: 90%; height: auto; float:left;display:inline;"></div>
                </li>
                <li class="individualHighchart" style="width:400px;">
                    <div id="container2" style="margin-left:5%;width: 90%; height: auto; float:left;display:inline;"></div>
                </li>
            </ul>
        </div>-->

</s:i18n>