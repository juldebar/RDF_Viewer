<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="ShowResource">
    <%-- Building the request --%>

    <%-- Debug --%>
    <%-- Size: <s:property value="resources.size()" /> --%>

    <s:if test="!criteriaFound">
        <s:set var="request" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> CONSTRUCT {?sourceSpecie ?property ?targetSpecie . ?sourceSpecie rdf:type <http://www.w3.org/2002/07/owl#Thing> . } WHERE {?sourceSpecie ?property ?targetSpecie . FILTER (?property = ecosystems_def:is_prey_of || ?property = ecosystems_def:is_predator_of)}'"/>
    </s:if>
    <s:elseif test="resources.size() > 0">
        <s:set var="request" value="'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>  PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> '"/>
        <s:set var="request" value="#request + 'CONSTRUCT { ?sourceSpecie ?property ?targetSpecie . ?sourceSpecie rdf:type <http://www.w3.org/2002/07/owl#Thing> } '"/>
        <s:set var="request" value="#request + 'WHERE { ?sourceSpecie ?property ?targetSpecie . FILTER (?property = ecosystems_def:is_prey_of || ?property = ecosystems_def:is_predator_of) . '"/>
        <s:set var="request" value="#request + 'FILTER ('"/>
        <s:iterator value="resources" status="state">
            <s:set var="request" value="#request + '?sourceSpecie = <' + resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object + '>'" />
            <s:if test="!#state.last">
                <s:set var="request" value="#request + ' || '"/>
            </s:if>
            <!-- Debug -->
            <!--<s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object" /><br/>-->
        </s:iterator>
        <s:set var="request" value="#request + ') . FILTER ('" />
        <s:iterator value="resources" status="state">
            <s:set var="request" value="#request + '?targetSpecie = <' + resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object + '>'" />
            <s:if test="!#state.last">
                <s:set var="request" value="#request + ' || '"/>
            </s:if>
        </s:iterator>
        <s:set var="request" value="#request + ')}'" />
    </s:elseif>
    <s:else>
        <s:set var="request" value="null" />
    </s:else>

    <%-- Content --%>

    <s:if test="#request != null">
        <s:url id="resourceUriPrefix" action="ShowResource" forceAddSchemeHostAndPort="true" escapeAmp="false" />
        <s:url id="ontologyUrl" action="GetOntologyAsGraphOrTreeML" escapeAmp="false"/>

        <object codetype="application/java" classid="java:org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" archive="<s:url forceAddSchemeHostAndPort="true" value="/webpages/tools/prefuseSparql_20091210.jar"/>" width="100%" height="600px">
            <param name="documentType" value="graph"/>
            <param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
            <param name="httpParameterName" value="resourceUri"/>
            <param name="mode" value="oneshot"/>

            <param name="queryString" value="<s:property value="#request"/>"/>
            <param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
            <param name="visualizationName" value="radial"/>
            <param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
            <param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
            <param name="inferenceEngine" value="OWL_MEM"/>
            <param name="recursiveRequest" value="false"/>
            <param name="noResultLabel" value="<s:text name="graphResults.trophicNetwork.noResults"/>"/>
            <param name="bgColor" value="255;255;255"/>
            <%--<param name="mayscript" value="yes"/>--%>
            <param name="scriptable" value="true"/>
            <%-- For Netscape --%>
            <param name="name" value="jsapplet"/>

            <%-- For IE --%>
            <applet <%--MAYSCRIPT--%> name="jsapplet" archive="<s:url forceAddSchemeHostAndPort="true" value="/webpages/tools/prefuseSparql_20091210.jar"/>" code="org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" width="100%" height="600px">
                <param name="documentType" value="graph"/>
                <param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
                <param name="httpParameterName" value="resourceUri"/>
                <param name="mode" value="oneshot"/>
                <param name="recursiveRequest" value="false"/>
                <param name="queryString" value="<s:property value="#request"/>"/>
                <param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
                <param name="visualizationName" value="radial"/>
                <param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
                <param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
                <param name="inferenceEngine" value="OWL_MEM"/>
                <param name="noResultLabel" value="<s:text name="graphResults.01.noResults"/>"/>
                <param name="bgColor" value="255;255;255"/>
                <s:text name="common.java.notInstalled"/>
            </applet>

        </object>
    </s:if>
    <s:else>
        <s:div cssStyle="position:relative;top:290px;text-align:center;">
            <s:text name="graphResults.trophicNetwork.noResults"/>
        </s:div>
    </s:else>
</s:i18n>