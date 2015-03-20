

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:iterator value="results">
    <%-- on relance la requête pour récupérer la fiche espèce --%>
    <%--<s:property value="#lang"/>--%>
    <s:if test="subject != null">
        <s:action name="GetSparqlResult" executeResult="false" var="subject">
            <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="subject.uri"/>' as ?uri) ?Title WHERE { <<s:property value="subject.uri"/>> skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), "<s:property value="#lang"/>")) }</s:param>
            <s:param name="endpointlocation" value="'ecoscope'"/>
        </s:action>
        <s:push value="#subject">
            <s:iterator value="results">
                <%--<li onclick="loadPopupData('<s:property value="uri.literal"/>','species');"><a><s:property value="Title.literal"/></a></li>--%>
                <li class="individualData" view="speciesIndividualData" href="#" id="<s:property value="uri.literal"/>">
                    <a><s:property value="Title.literal"/>
<!--                        <span class="pull-right">
                            <i class="icon-eye-3 "></i>
                        </span>-->
                    </a>
                </li>
            </s:iterator>
        </s:push>
        <s:set var="fullSizeCount2" value="#fullSizeCount2 + 1"/>
    </s:if>
    <s:else>
         Aucune donnée 
          
    </s:else>
</s:iterator>