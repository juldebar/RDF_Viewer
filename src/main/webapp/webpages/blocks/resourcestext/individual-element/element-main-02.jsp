<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Block for displaying textual data of a species --%>
<%-- Monolithic version (Ajax version: element-main-01.jsp --%>

<div id="resources-text">
    <%-- Preferred Label --%>
    <%--<img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>--%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?prefLabel WHERE {     <' + uri + '> skos:prefLabel ?prefLabel . OPTIONAL { FILTER langMatches( lang(?prefLabel), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>

    <s:push value="#resource">
        <s:i18n name="ShowResource">
            <s:iterator value="results">
                <h3>
                    <s:property value="prefLabel.literal" />
                </h3>
                <%--<s:property value="uri" />--%>
            </s:iterator>
        </s:i18n>
    </s:push>

    <%-- Synonyms --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?altLabel WHERE { <' + uri + '> skos:altLabel ?altLabel . FILTER langMatches( lang(?altLabel), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.common.synonyms"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results">
                <s:property value="altLabel.literal"/>
                <br/>
            </s:iterator>
        </s:i18n>
    </s:push>

    <%-- WoRMS classification --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> SELECT DISTINCT ?genus ?family ?order ?class ?phylum ?kingdom WHERE { <' + uri + '> <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?genusUri . ?genusUri <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?familyUri . ?familyUri <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?orderUri . ?orderUri <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?classUri . ?classUri <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?phylumUri . ?phylumUri <http://www.tlo.ics.forth.gr/TLO_entity#belongsTo> ?kingdomUri . BIND( strafter( xsd:string(?genusUri), \"#\") AS ?genus ) . BIND( strafter( xsd:string(?familyUri), \"#\") AS ?family ) . BIND( strafter( xsd:string(?orderUri), \"#\") AS ?order ) . BIND( strafter( xsd:string(?classUri), \"#\") AS ?class ) . BIND( strafter( xsd:string(?phylumUri), \"#\") AS ?phylum ) . BIND( strafter( xsd:string(?kingdomUri), \"#\") AS ?kingdom ) . }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="flod.title"/>
    </h4>
    Waiting for endpoint to be updated
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:iterator value="results" status="state">
                Genus: <s:property value="genus.uri"/><br/>
                Family: <s:property value="family.literal"/><br/>
                Order:  <s:property value="order.literal"/><br/>
            </s:iterator>

        </s:i18n>
    </s:push>

    <%-- Description --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?description WHERE { <' + uri + '> skos:note ?description . FILTER langMatches( lang(?description), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.common.description"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results">
                <s:property value="description.literal"/>
                <br/>
            </s:iterator>

        </s:i18n>
    </s:push>

    <%-- Broader terms --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?broaderTermLabel WHERE {	<'+ uri +'> rdf:type ?broaderTerm . ?broaderTerm skos:prefLabel ?broaderTermLabel }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.common.broaderTerms"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results" status="state">
                <s:property value="broaderTermLabel.literal"/>
                <s:if test="!(#state.last)">, </s:if>
            </s:iterator>

        </s:i18n>
    </s:push>

    <%-- Narrower terms --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?narrowTermLabel WHERE {	<'+ uri +'> rdf:type ?narrowTerm . ?narrowTerm skos:prefLabel ?narrowTermLabel }'" />
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.common.narrowerTerms"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results" status="state">
                <s:property value="narrowTermLabel.literal"/>
                <s:if test="!(#state.last)">, </s:if>
            </s:iterator>

        </s:i18n>
    </s:push>


    <%-- Preys --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?prey ?preyLabel WHERE { <' + uri + '> tlo:usuallyIsPredatorOf ?prey . ?prey skos:prefLabel ?preyLabel } '" />
    <%-- Same with uris --%>
    <%--<s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?prey ?preyLabel WHERE { <' + uri + '> tlo:usuallyIsPredatorOf . ?prey skos:prefLabel ?preyLabel } '" />--%>
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.individual.element.preys"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results" status="state">
                <%-- Link url --%>
                <s:url var="linkUrl" action="ShowResource" escapeAmp="false" >
                    <s:param name="uri"><s:property value="prey.uri"/></s:param>
                    <s:param name="view">individual###element-01</s:param>
                </s:url>
                <a href="<s:url value="%{linkUrl}"/>"><s:property value="preyLabel.literal"/></a><s:if test="!(#state.last)">, </s:if>
            </s:iterator>
        </s:i18n>
    </s:push>

    <%-- Predators --%>
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?predator ?predatorLabel WHERE { <' + uri + '> tlo:usuallyIsPreyOf ?predator . ?predator skos:prefLabel ?predatorLabel } '" />
    <%-- Same with uris --%>
    <%-- <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?predator ?predatorLabel WHERE { <' + uri + '> tlo:usuallyIsPreyOf ?predator . ?predator skos:prefLabel ?predatorLabel } '" />--%>
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <s:param name="query" value="#query"/>
    </s:action>
    <h4>
        <s:text name="resourcestext.individual.element.predators"/>
    </h4>
    <s:push value="#resource"> 
        <s:i18n name="ShowResource">
            <s:if test="results.size < 1">
                n/a
            </s:if>
            <s:iterator value="results" status="state">
                <%-- Link url --%>
                <s:url var="linkUrl" action="ShowResource" escapeAmp="false" >
                    <s:param name="uri"><s:property value="predator.uri"/></s:param>
                    <s:param name="view">individual###element-01</s:param>
                </s:url>
                <a href="<s:url value="%{linkUrl}"/>"><s:property value="predatorLabel.literal"/></a><s:if test="!(#state.last)">, </s:if>
            </s:iterator>
        </s:i18n>
    </s:push>

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
    <s:set var="query" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX worms: <http://www.marinespecies.org/entity#> SELECT DISTINCT ?label  WHERE {	<' + uri + '> ?identifiers ?value . ?identifiers rdfs:subPropertyOf <http://www.tlo.ics.forth.gr/TLO_entity#hasIdentifier> . ?value rdfs:label ?label . FILTER (?identifiers!=<http://www.tlo.ics.forth.gr/TLO_entity#hasIdentifier>) }'" />
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
    </s:push>

    <%-- Links to reference sites --%>
    <%--<s:include value="/webpages/blocks/externallinks/externallinks_main_01.jsp"/>--%>

    <%-- FLOD taxonomy --%>
    <%--<s:include value="/webpages/blocks/flodplugin/flodplugin_main_01.jsp"/>--%>

    <%-- Data sources --%>
    <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@used_data_source]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.sources"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="preferredLabel" />
        </s:a>
    </s:iterator>

    <%-- Alternative labels --%>
    <s:merge id="mergedAltLabels">
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@altLabel]['preferred']}" />
        <%-- Harmful if SKOS-RDF is inferred, because RDFS@label will return all SKOS@prefLabel and SKOS@altLabel --%>
        <%-- Unusefull too now because there's no more RDFS@label in the Ecoscope ontology --%>
        <%--<s:param value="%{properties[@com.hp.hpl.jena.vocabulary.RDFS@label]}" />--%>
    </s:merge>
    <s:iterator value="mergedAltLabels" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.synonyms"/></h4></s:if>
        <s:else><br/></s:else>
        <s:property />
    </s:iterator>

    <%-- Broader terms --%>
    <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.broaderTerms"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="preferredLabel"/>
        </s:a>
    </s:iterator>


    <%-- Description --%>
    <s:merge id="mergedDescriptions">
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@note]['preferred']}" />
        <%-- TODO check if SKOS@note generalize SKOS@xNote --%>
        <%-- If yes, and if the SKOS OWL schema is used, the following lines could be harmful if SKOS-RDF is inferred --%>
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@scopeNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@historyNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@editorialNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@changeNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@definition]['preferred']}" />
        <%-- TODO check the necessity of that with the Ecoscope ontology --%>
        <s:param value="%{properties[@com.hp.hpl.jena.vocabulary.RDFS@comment]['preferred']}" />
    </s:merge>
    <s:iterator value="mergedDescriptions" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.description"/></h4></s:if>
        <s:else><br/></s:else>
        <p class="resources-text"><s:property /></p>
    </s:iterator>

    <%-- Fish oriented properties --%>

    <%-- Color --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@color]['preferred'][0] != null">
        <h4><s:text name="individual.element.color" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@color]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna oriented properties --%>

    <%-- Fauna FAO Family --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoFamily]['preferred'][0] != null">
        <h4><s:text name="individual.element.faoFamily" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoFamily]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna FAO Id --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0] != null">
        <h4><s:text name="individual.element.faoCode" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna FAO Latin name --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoLatinName]['preferred'][0] != null">
        <h4><s:text name="individual.element.faoLatinName" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoLatinName]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna FAO Order --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoOrder]['preferred'][0] != null">
        <h4><s:text name="individual.element.faoOrder" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoOrder]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna GBIF Id --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0] != null">
        <h4><s:text name="individual.element.gbifId" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna Related TAC --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@relatedTAC]['preferred'][0] != null">
        <h4><s:text name="individual.element.relatedTac" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@relatedTAC]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna Trophic level --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@trophic_level]['preferred'][0] != null">
        <h4><s:text name="individual.element.trophicLevel" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@trophic_level]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Fauna Mean length --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@mean_length]['preferred'][0] != null">
        <h4><s:text name="individual.element.meanLength" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@mean_length]['preferred'][0]" default="n/a"/> cm
    </s:if>--%>

    <%-- Fauna Reproduction length --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@reproduction_length]['preferred'][0] != null">
        <h4><s:text name="individual.element.reproductionLength" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@reproduction_length]['preferred'][0]" default="n/a"/> cm
    </s:if>--%>

    <%-- Fauna Minimal capture length --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@minimal_capture_length]['preferred'][0] != null">
        <h4><s:text name="individual.element.minimalCaptureLength" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@minimal_capture_length]['preferred'][0]" default="n/a"/> cm
    </s:if>--%>

    <%-- Fauna IRD Code --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCodeIRD]['preferred'][0] != null">
        <h4><s:text name="individual.element.irdCode" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCodeIRD]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel oriented properties --%>

    <%-- Vessel COST Code --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@costVesselType]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselCostCode" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@costVesselType]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel CTOI Code --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@ctoiId]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselCtoiId" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@ctoiId]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel ICCAT Code --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@iccatId]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselIccatId" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@iccatId]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel Flag --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@flag]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselFlag" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@flag]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel Commercial Identifier --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCommmercialIdentifier]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselCommercialIdentifier" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCommmercialIdentifier]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel National Identifier --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasNationalIdentifier]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselNationalIdentifier" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasNationalIdentifier]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel Class GRT --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassGRT]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselClassGRT" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassGRT]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel Length --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassLength]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselLength" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassLength]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Vessel Power --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassPower]['preferred'][0] != null">
        <h4><s:text name="individual.element.vesselPower" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasVessClassPower]['preferred'][0]" default="n/a"/>
    </s:if>--%>


    <%-- Fishing gear oriented properties --%>

    <%-- ISSCFG Gear Code (FAO) --%>
    <%--<s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCodeISSCFG]['preferred'][0] != null">
        <h4><s:text name="individual.element.gearIsscfgCode" /></h4>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCodeISSCFG]['preferred'][0]" default="n/a"/>
    </s:if>--%>

    <%-- Biotic elements --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasBioticComponent]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.individual.element.bioticComponents"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="preferredLabel" />
        </s:a>
    </s:iterator>--%>

    <%-- Abiotic elements --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasAbioticComponent]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.individual.element.abioticComponents"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="preferredLabel" />
        </s:a>
    </s:iterator>--%>

    <%-- Human elements --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasHumanComponent]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.individual.element.humanComponents"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="preferredLabel" />
        </s:a>
    </s:iterator>--%>

    <%-- Is Primary Topic Of --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@isPrimaryTopicOf]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.relatedData"/></h4></s:if>
        <s:else><br/></s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]" default="Link"/>
        </s:a>
    </s:iterator>--%>

    <%-- Access to RDF fragment --%>
    <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>

</div>