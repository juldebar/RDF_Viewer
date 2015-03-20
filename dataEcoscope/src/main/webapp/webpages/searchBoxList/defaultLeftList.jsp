<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="well" style="max-width: 340px; padding: 8px 0;">
    <ul class="nav metro-nav-list">
        <ul class="nav">
            <s:if test="results.size <= 1">    
                Aucun Résultat
            </s:if>
            <s:else>
            <li class="active titleSearchList"><a href="#">Database</a></li>
            <ul class="nav " style="max-height:200px;height:auto;overflow:hidden;"> 
            <s:iterator value="results">
                <s:action name="GetSparqlResult" executeResult="false" var="databaseCompletion">
                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="uri.uri"/>' as ?uri) ?database ?Title WHERE { ?database rdf:type <http://www.ecoscope.org/ontologies/resources_def/dataBase> . ?database skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), "FR")) . ?database dc:subject <<s:property value="uri.uri"/>>. FILTER(langMatches(lang(?Title), "FR"))}</s:param>
                    <s:param name="endpointlocation" value="'ecoscope'"/>
                </s:action>
                <s:push value="#databaseCompletion">
                    <s:iterator value="results">
                        <s:if test="database.uri != null">    
                            
                        </s:if>    
                        <s:else>
                            Aucune donnée
                        </s:else>
                        <li class="individualData" id="<s:property value="database.uri" />" view="bddIndividualData">
                            <a ><s:property value="Title.literal"/></a>
                        </li>
                    </s:iterator>
                </s:push> 
            </s:iterator>
            </ul>
            <li class="active titleSearchList"><a href="#">Image</a></li>
            <ul class="nav" style="max-height:200px;height:auto;overflow:hidden;"> 
            <s:iterator value="results">
                <s:action name="GetSparqlResult" executeResult="false" var="pictureCompletion">
                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="uri.uri"/>' as ?uri) ?database ?Title WHERE {?database rdf:type <http://www.ecoscope.org/ontologies/resources_def/picture> . ?database dc:title ?Title. FILTER(langMatches(lang(?Title), "FR")) .?database dc:subject <<s:property value="uri.uri"/>>.}                </s:param>
                    <s:param name="endpointlocation" value="'ecoscope'"/>
                </s:action>
                <s:push value="#pictureCompletion">
                    <s:iterator value="results">
                        <li class="individualData" id="<s:property value="database.uri" />" view="pictureIndividualData">
                            <a ><s:property value="Title.literal"/></a>
                        </li>
                    </s:iterator>
                </s:push> 
            </s:iterator>
            </ul>
            <li class="active titleSearchList"><a href="#">publication</a></li>
            <ul class="nav" style="max-height:200px;height:auto;overflow:hidden;"> 
            <s:iterator value="results">
                <s:action name="GetSparqlResult" executeResult="false" var="publicationCompletion">
                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="uri.uri"/>' as ?uri) ?publication ?Title WHERE {?publication rdf:type <http://www.ecoscope.org/ontologies/resources_def/publication> .?publication dc:title ?Title.<<s:property value="uri.uri"/>> foaf:isPrimaryTopicOf ?publication.}</s:param>
                    <s:param name="endpointlocation" value="'ecoscope'"/>
                </s:action>
                <s:push value="#publicationCompletion">
                    <s:iterator value="results">
                        <li class="individualData" id="<s:property value="publication.uri" />" view="publicationIndividualData">
                            <a ><s:property value="Title.literal"/></a>
                        </li>
                    </s:iterator>
                </s:push> 
            </s:iterator>
            </ul>
            <li class="active titleSearchList"><a href="#">Contacts</a></li>
            <ul class="nav" style="max-height:200px;height:auto;overflow:hidden;"> 
                <s:iterator value="results">
                    <s:action name="GetSparqlResult" executeResult="false" var="contactCompletion">
                        <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="uri.uri"/>' as ?uri) ?database ?Title WHERE {?database rdf:type <http://xmlns.com/foaf/0.1/Person> .?database foaf:name ?Title.?database foaf:topic_interest <<s:property value="uri.uri"/>>.}</s:param>
                        <s:param name="endpointlocation" value="'ecoscope'"/>
                    </s:action>
                    <s:push value="#contactCompletion">
                        <s:iterator value="results">
                            <li class="individualData" id="<s:property value="database.uri" />" view="contactIndividualData">
                                <a ><s:property value="Title.literal"/></a>
                            </li>
                        </s:iterator>
                    </s:push> 
                </s:iterator>
            </ul>
            <li class="active titleSearchList"><a href="#">Indicateurs</a></li>
            <ul class="nav" style="max-height:200px;height:auto;overflow:hidden;"> 
            <s:iterator value="results">
                <s:action name="GetSparqlResult" executeResult="false" var="indicateurCompletion">
                    <s:param name="query">PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ('<s:property value="uri.uri"/>' as ?uri) ?indicator ?Title WHERE {?indicator rdf:type <http://www.ecoscope.org/ontologies/resources_def/indicator> .?indicator dc:title ?Title.?indicator dc:subject <<s:property value="uri.uri"/>>.}</s:param>
                    <s:param name="endpointlocation" value="'ecoscope'"/>
                </s:action>
                <s:push value="#indicateurCompletion">
                    <s:iterator value="results">
                        <li class="individualData" id="<s:property value="indicator.uri" />" view="indicateurIndividualData">
                            <a ><s:property value="Title.literal"/></a>
                        </li>
                    </s:iterator>
                </s:push> 
            </s:iterator>
            </ul>
        </ul>
    </ul>
            </s:else>
</div>