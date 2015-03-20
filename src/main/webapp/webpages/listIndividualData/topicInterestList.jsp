<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:iterator value="results"> 
    <%--<s:property value="name.literal"/>
    . FILTER(langMatches(lang(?Title), "<s:property value="#lang"/>"))
    --%>
    <s:if test="topic_interest != null">
        <s:action name="GetSparqlResult" executeResult="false" var="topicInterestSubject">
            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('<s:property value="topic_interest.uri"/>' as ?uri) ?Title WHERE {<<s:property value="topic_interest.uri"/>> skos:prefLabel ?Title}</s:param>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:action>
        <s:push value="#topicInterestSubject">
            <s:iterator value="results">
                <li onclick="loadPopupData('<s:property value="uri.literal"/>','topicInterest');">
                    <a>
                        <s:property value="Title.literal"/>  
                    </a>
                </li>
            </s:iterator>
        </s:push>
    </s:if>
    <s:else>
        <i>Aucune donnée</i>
    </s:else>
</s:iterator>