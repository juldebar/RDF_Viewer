<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Block for displaying textual data of a species --%>
<%-- Ajax version (Monolithic version: element-main-02.jsp) --%>

<div id="resources-text" class="container-fluid" style="margin-bottom:20px;">
    <%-- Preferred Label --%>
    <%--<s:property value="uri" />--%>

    <%--nom du poisson
    <s:action name="GetSparqlResult" executeResult="false" var="resource">--%>
    <%--<s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE {     <' + uri + '> skos:prefLabel ?term . OPTIONAL { FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } }'" />--%>
    <%--<s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" SELECT DISTINCT  ?term WHERE { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/imarine#LXrelatedIdentifierAssignment> ?y . ?y rdf:type <http://ics.forth.gr/Ontology/MarineTLO/imarine#ScientificNameAssignment> . ?y <http://ics.forth.gr/Ontology/MarineTLO/imarine#assignedName> ?term } LIMIT 1 '"/>
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
    
    --%>

    <%-- Links to reference sites --%>
    <%--<s:include value="/webpages/blocks/externallinks/externallinks_main_01.jsp"/>--%>

    <%-- Description - Ajax --%>
    <h4>
        <s:text name="resourcestext.common.description"/> (endpoint fao)
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE { <' + uri + '> skos:note ?term . FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) }'"/>
        <s:param name="view" value="'simple-terms-column'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="descriptions" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>


    <%-- Synonyms (still Ecoscope style query) - Ajax --%>
   <%-- <h4>
        test de requête écoscope : (ecoscope endpoint)
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE { <http://www.ecoscope.org/ontologies/ecosystems/xiphias_gladius> rdf:type ?broaderTerm . ?broaderTerm skos:prefLabel ?term }'"/>
        <s:param name="view" value="'simple-terms-column'"/>
        <s:param name="endpointlocation" value="'ecoscope'"/>
    </s:url>

    <sj:div id="synonyms" cssStyle="width: 100%;" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>--%>




    <%-- Scientific names from other sources - Ajax --%>
    <%--
    <h4>
        <s:text name="resourcestext.common.synonyms"/>  test
    </h4>



    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV3Rules> DEFINE input:same-as \"yes\" SELECT ?commonName ?commonNameLanguage ?country WHERE { <'+uri+'> <http://ics.forth.gr/Ontology/MarineTLO/imarine#LXrelatedIdentifierAssignment> ?y1. ?y1 rdf:type <http://ics.forth.gr/Ontology/MarineTLO/imarine#CommonNameAssignment> . ?y1 <http://ics.forth.gr/Ontology/MarineTLO/imarine#assignedName> ?commonName . OPTIONAL { ?y1 <http://ics.forth.gr/Ontology/MarineTLO/imarine#hasLanguage> ?commonNameLanguage. } OPTIONAL { ?y1 <http://ics.forth.gr/Ontology/MarineTLO/imarine#isUsedIn> ?country . ?country rdf:type <http://ics.forth.gr/Ontology/MarineTLO/imarine#Country> . } }'"/>
        <s:param name="view" value="'worms2'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="scnamesfromothers" cssStyle="width: 100%;" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    --%>
    
    

    <%-- Broader terms - Ajax --%>
    <%--
    <h4>
        <s:text name="resourcestext.common.broaderTerms"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE {	<'+ uri +'> rdf:type ?broaderTerm . ?broaderTerm skos:prefLabel ?term  . FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="broaderTerms" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    --%>


    <%-- Narrower terms - Ajax --%>
    <%--<h4>
        <s:text name="resourcestext.common.narrowerTerms"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?term WHERE {	<'+ uri +'> rdf:type ?narrowerTerm . ?narrowerTerm skos:prefLabel ?term  . FILTER langMatches( lang(?term), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" )  }'"/>
        <s:param name="view" value="'simple-terms-inline'"/>
    </s:url>

    <sj:div id="narrowerTerms" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div> --%>


    <%-- Preys - Ajax --%>
    <%--
    <h4>
        <s:text name="resourcestext.individual.element.preys"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://ics.forth.gr/Ontology/MarineTLO/core#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?resource ?term FROM <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> WHERE { <http://www.ecoscope.org/ontologies/ecosystems/thunnus_albacares> tlo:LTusuallyIsPredatorOf ?resource . ?resource skos:prefLabel ?term } '"/>
        <s:param name="view" value="'linked-terms-inline'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="preys" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    --%>


    <%-- Predators - Ajax --%>
    <%--
    <h4>
        <s:text name="resourcestext.individual.element.predators"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
    --%>
        <%--<s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?resource ?term WHERE { <' + uri + '> tlo:usuallyIsPreyOf ?resource . ?resource skos:prefLabel ?term } '"/>--%>
        <%--
        <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> PREFIX tlo: <http://ics.forth.gr/Ontology/MarineTLO/core#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?resource ?term FROM <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> WHERE { <http://www.ecoscope.org/ontologies/ecosystems/katsuwonus_pelamis> tlo:LTusuallyIsPreyOf ?resource . ?resource skos:prefLabel ?term }'"/>
        <s:param name="view" value="'linked-terms-inline'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="predators" cssStyle="width: 100%;" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
        --%>


    <%-- WoRMS code --%>
    <%-- Waiting for the mapping fao/ecoscope/worms --%>
    <%-- <s:set var="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX worms: <http://www.marinespecies.org/entity#> SELECT DISTINCT ?label WHERE {	<' + uri + '> ?identifiers ?value . ?identifiers rdf:type <http://www.marinespecies.org/entity#WoRMSIdentifier> . ?value rdfs:label ?label }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.common.standardCodes"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results">
                <s:property value="label.literal"/>
                <br/>
            </s:iterator>
        </s:i18n>
    </s:push> --%>

    <%-- Standard codes (unclassified) --%>
    <%--
    <h4>
        <s:text name="resourcestext.common.standardCodes"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX worms: <http://www.marinespecies.org/entity#> SELECT DISTINCT ?term  WHERE {	<' + uri + '> ?identifiers ?value . ?identifiers rdfs:subPropertyOf <http://www.tlo.ics.forth.gr/TLO_entity#hasIdentifier> . ?value rdfs:label ?term . FILTER (?identifiers!=<http://www.tlo.ics.forth.gr/TLO_entity#hasIdentifier>) }'"/>
        <s:param name="view" value="'simple-terms-column'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="standardCodes" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    --%>

    <%-- FAO code --%>
    <%-- Marche pas - a arranger à la reprise --%>
    <%--<h4>
        <s:text name="resourcestext.common.FAOCode"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" SELECT DISTINCT ?term FROM <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> WHERE { <' + uri + '>  <http://ics.forth.gr/Ontology/MarineTLO/core#LX1isIdentifiedBy> ?term . ?term <http://ics.forth.gr/Ontology/MarineTLO/imarine#LXhasCodeType> <http://ics.forth.gr/Ontology/MarineTLO/imarine#FAOCode>}'"/>
        <s:param name="view" value="'simple-terms-column'"/>
    </s:url>

    <sj:div id="standardCodes" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>--%>

    <%-- Biblio - Ajax --%>
    <%--
    <h4>
        <s:text name="resourcestext.common.biblio"/>
    </h4>
    <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
        <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?uri ?term WHERE { <' + uri + '> foaf:isPrimaryTopicOf ?uri . ?uri dc:title ?term . FILTER langMatches(lang(?term), \"en\")}'"/>
        <s:param name="view" value="'simple-terms-column'"/>
        <s:param name="endpointlocation" value="'fao'"/>
    </s:url>

    <sj:div id="biblio" href="%{ajaxUrl}">
        <div style="text-align: center; ">
            <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
        </div>
    </sj:div>
    --%>
</div>