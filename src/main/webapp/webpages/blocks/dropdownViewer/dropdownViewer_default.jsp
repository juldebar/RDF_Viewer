<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">
    <%-- BDD associées --%>
    <s:div cssClass="span4" cssStyle="height: 300px;overflow:hidden;">
        <%--<s:include value="/webpages/blocks/dropdownViewer/dropdownViewer_01.jsp"/>--%>
        <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
            <s:param name="query" value="'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?database ?Title ?date ?description  WHERE { ?database rdf:type <http://www.ecoscope.org/ontologies/resources_def/dataBase> . ?database dc:subject <' + uri + '> . ?database skos:prefLabel  ?Title . ?database dc:date ?date.?database dc:description ?description . FILTER(langMatches(lang(?Title), \"FR\")) . FILTER(langMatches(lang(?Title), \"FR\")) . FILTER(langMatches(lang(?description), \"FR\"))}'"/>
            <s:param name="view" value="'dropdownViewer_02'"/>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:url>

        <sj:div id="BDD" cssClass="row-fluid" href="%{ajaxUrl}" style="text-align:center:">
            <div style="text-align: center; ">
                <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
            </div>
        </sj:div>
    </s:div>
    <%-- personne associé --%>
    <s:div cssClass="span4" cssStyle="overflow:hidden;">
        <%--<s:include value="/webpages/blocks/dropdownViewer/dropdownViewer_01.jsp"/>--%>
        <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
            <s:param name="query" value="'PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT  Distinct ?agent ?name  ?depiction ?identifier WHERE { ?publication rdf:type <http://www.ecoscope.org/ontologies/resources_def/publication> . ?publication dc:subject <' + uri + '>. ?publication dc:title ?Title. ?publication dc:creator ?agent. ?agent foaf:name ?name. ?agent foaf:depiction ?depiction. ?depiction dc:identifier ?identifier.}'"/>
            <s:param name="view" value="'dropdownViewer_01'"/>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:url>


        <sj:div id="personne" cssClass="row-fluid" href="%{ajaxUrl}" style="text-align:center:">
            <div style="text-align: center; ">
                <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
            </div>
        </sj:div>
    </s:div>
    <%-- publication associé --%>
    <s:div cssClass="span4" cssStyle="overflow:hidden;">
        <%--<s:include value="/webpages/blocks/dropdownViewer/dropdownViewer_01.jsp"/>--%>
        <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult" >
            <s:param name="query" value="'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT  ?publication ?Title ?date ?description WHERE { ?publication rdf:type <http://www.ecoscope.org/ontologies/resources_def/publication> . ?publication dc:subject <' + uri + '>. ?publication dc:title ?Title. ?publication dc:date ?date. ?publication dc:description ?description. }'"/>
            <s:param name="view" value="'dropdownViewer_03'"/>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:url>

        <sj:div id="publication" cssClass="row-fluid" href="%{ajaxUrl}" style="text-align:center:">
            <div style="text-align: center; ">
                <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
            </div>
        </sj:div>
    </s:div>

</s:i18n>