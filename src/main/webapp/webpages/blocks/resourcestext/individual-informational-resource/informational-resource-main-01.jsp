<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Block for displaying textual data of a species --%>
<%-- Ajax version (Monolithic version: element-main-02.jsp --%>

<div id="resources-text">
    <%--<s:property value="uri" />--%>
    
    <%-- Preferred Label --%>
    <s:set var="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <' + uri + '> dc:title ?term . OPTIONAL { FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) . } }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="#query"/>
    </s:action>

    <s:push value="#resource">
        <s:i18n name="ShowResource">
            <s:iterator value="results">
                <h3>
                    <s:property value="term.literal" />
                </h3>
            </s:iterator>
        </s:i18n>
    </s:push>

    <%-- Description - Ajax --%>
    <h4>
        <s:text name="resourcestext.common.description"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <' + uri + '> dc:description ?term . OPTIONAL { FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) . } }'"/>
        <s:param name="view" value="'simple-terms-column'"/>
    </s:url>

    <sj:div id="descriptions" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>

    <%-- DC identifier - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.dcIdentifier"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> dc:identifier ?term }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="dcIdentifier" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>

    <%-- Broader terms - Ajax --%>
    <h4>
        <s:text name="resourcestext.common.broaderTerms"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE {	<'+ uri +'> rdf:type ?broaderTerm . ?broaderTerm skos:prefLabel ?term  . FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="broaderTerms" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>

    <%-- Programming language - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.programmingLanguage"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> resources_def:has_programming_language ?term . OPTIONAL { FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="programmingLanguage" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    
    <%-- WPS server - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.wpsServer"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> resources_def:on_WPS_server ?term }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="wpsServer" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    
    <%-- WPS describer - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.wpsDescriber"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> resources_def:has_describe_process ?term }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="wpsDescriber" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    
    <%-- WPS identifier - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.wpsIdentifier"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> resources_def:has_WPS_identifier ?term }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="wpsIdentifier" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>

    <%-- Source code file - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.wpsSourceCodeFile"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?term WHERE { <'+ uri +'> resources_def:has_source_code ?code . ?code dc:identifier ?term}'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="wpsSourceCodeFile" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    
    <%-- Source code creator - Ajax --%>
    <h4>
        <s:text name="resourcestext.individual.informationalResource.wpsSourceCodeCreator"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <%--<s:param name="endpointUrl" value="'http://vmecoscopebc-proto.mpl.ird.fr:8080/joseki/ecoscope?output=xml&query='" />--%>
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?firstname ?lastname WHERE { <'+ uri +'> resources_def:has_source_code ?code . ?code dc:creator ?creator . ?creator foaf:firstName ?firstname . ?creator foaf:family_name ?lastname }'"/>
        <s:param name="view" value="'persons-names-column'"/>
    </s:url>

    <sj:div id="wpsSourceCodeCreator" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    
                    

    <%-- Access to RDF fragment --%>
    <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>

</div>