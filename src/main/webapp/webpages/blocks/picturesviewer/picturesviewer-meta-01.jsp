<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <%-- Content --%>

    <sj:div id="pictures_viewer_meta_01" cssStyle="background-color:white;min-height:100px;padding:10px;" cssClass="kb-corner-radius-c1">

        <s:action name="GetSparqlResult" executeResult="false" var="resource">
            <s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=http://www.ics.forth.gr/isl/TLObasedDataWarehouse&should-sponge=&format=application/sparql-results+xml&query='" />
            <%-- Filtering with foaf:Document --%>
            <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>  PREFIX owl: <http://www.w3.org/2002/07/owl#>  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?picture ?url ?title ?description WHERE { <http://www.ecoscope.org/ontologies/ecosystems#thunnus_obesus> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://xmlns.com/foaf/0.1/Document> . OPTIONAL { ?picture dc:title ?title . FILTER langMatches( lang(?title), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } . OPTIONAL { ?picture dc:description ?description . FILTER langMatches( lang(?description), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } } '"/>
            <%--<s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT DISTINCT ?picture ?url ?title ?description WHERE { <s:property value=\"uri\"/> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://xmlns.com/foaf/0.1/Document> . OPTIONAL { ?picture dc:title ?title . FILTER langMatches( lang(?title), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } . OPTIONAL { ?picture dc:description ?description . FILTER langMatches( lang(?description), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } } '"/>--%>
        </s:action>

        <s:push value="#resource"> 
            <s:i18n name="ShowResource">
                <s:set var="count" value="1"/>
                <s:iterator value="results">
                    <s:if test="#count == 1">
                        <div id="imgmeta_<s:property value="#count" />" style="display:block;">
                        </s:if>
                        <s:else>
                            <div id="imgmeta_<s:property value="#count" />" style="display:none;">
                            </s:else>

                            <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureTitle"/>:&nbsp;</div>
                            <s:url id="url" action="ShowResource">
                                <s:param name="uri"><s:property value="picture.uri"/></s:param>
                            </s:url>
                            <s:a href="%{url}">
                                <s:property value="title.literal" default="n/a"/>
                            </s:a>
                            <div style="clear:both;"></div>
                            <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureDescription"/>:&nbsp;</div>
                            <s:property value="description.literal" default="n/a"/>
                            <div style="clear:both;"></div>
                        </div>

                        <s:set var="count" value="#count + 1"/>
                    </s:iterator>
                </s:i18n>
            </s:push>

            <%-- Nice depictions first --%>
            <%--<s:iterator value="niceMergedMetas">
                <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0 " >
                    <s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture.URI
                          || properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.FOAF@Image.URI" >
                        <s:if test="#count == 1">
                            <div id="imgmeta_<s:property value="#count" />" style="display:block;">
                            </s:if>
                            <s:else>
                                <div id="imgmeta_<s:property value="#count" />" style="display:none;">
                                </s:else>

                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureTitle"/>:&nbsp;</div>
                                <s:url id="url" action="ShowResource">
                                    <s:param name="resourceUri"><s:property /></s:param>
                                </s:url>
                                <s:a href="%{url}">
                                    <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]}" default="n/a"/>
                                </s:a>
                                <div style="clear:both;"></div>
                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureDescription"/>:&nbsp;</div>
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred'][0]}" default="n/a"/>
                                <div style="clear:both;"></div>
                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureDate"/>:&nbsp;</div>
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@date]['preferred'][0]}" default="n/a"/>
                                <div style="clear:both;"></div>
                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureType"/>:&nbsp;</div>
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@type]['preferred'][0]}" default="n/a"/>
                                <div style="clear:both;"></div>
                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureFormat"/>:&nbsp;</div>
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@format]['preferred'][0]}" default="n/a"/>
                                <div style="clear:both;"></div>
                                <div class="propertyLabel" style="float:left;"><s:text name="picturesviewer.meta.common.pictureSource"/>:&nbsp;</div>
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@source]['resource'][0].properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]}" default="n/a"/>

                            </div>

                            <s:set var="count" value="#count + 1"/>
                        </s:if>
                    </s:if>
                </s:iterator> --%>

            <%-- Then, other depictions --%>
            <%-- removed --%>


            <%-- Finishing --%>
            <s:if test="#count == 1">
                <s:div id="picturesviewer-no-metadata" cssStyle="text-align:center;padding-top:40px;">
                    <s:text name="picturesviewer.meta.01.noMetadata"/>
                </s:div>
            </s:if>
        </sj:div>

    </s:i18n>