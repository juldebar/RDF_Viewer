<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:div id="central" cssClass="lightCentral links">
    <h1><s:text name="atlas.entryPage.species.searchBySpeciesTitle"/></h1>
    <p><s:text name="atlas.entryPage.species.searchBySpeciesDescription"/></p>
    <%--<h2><s:text name="webLinks.subtitle1"/></h2>--%>

    <%-- List of certain species only  --%>
    <s:action name="GetSparqlResult" executeResult="false" var="resource">
        <%-- Legacy TLO v1 queries --%>
        
        <%--<s:param name="query" value="' PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT distinct ?species ?label WHERE { ?species rdf:type ecosystems_def:marine_animal . ?species skos:altLabel ?label . FILTER langMatches( lang(?label), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) . FILTER ( ?species = <http://www.fao.org/figis/flod/entities/codedentity/bbb41367-66ad-4541-97b6-a5e75d04f25d> ||  ?species = <http://www.fao.org/figis/flod/entities/codedentity/a1c30dba-51cf-473d-873f-0be0a3a71ce5> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/a1c30dba-51cf-473d-873f-0be0a3a71ce5> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/b490d040-4454-41a0-9e5b-f82b2720096a> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/a181e55b-50e6-4cc7-b7b9-93d3f1e8a4c3> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/2cdc1bc7-6700-47ec-8a43-833fa8bed215> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/5081047b-cca1-429f-96bc-41784207f1ef> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/f320b5be-73ef-4250-b350-2121d54040b5> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/5081047b-cca1-429f-96bc-41784207f1ef> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/65d19f72-8a9f-478a-9ba6-0c0e054601ef> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/48a3b8f4-c57b-454d-b21e-c84277d434bf> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/c3e27cad-83f2-4823-be66-a62090b54826> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/77937cda-0cdb-44cc-aec8-baddf468ba56> || ?species = <http://www.fao.org/figis/flod/entities/codedentity/641f9c7c-6208-4352-bfb4-1241a9c85438>) } '"/>--%>
        <%-- Query for all species --%>
        <%--<s:param name="query" value="' PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT DISTINCT ?species ?label WHERE { ?species rdf:type ecosystems_def:marine_animal . ?species skos:prefLabel ?label . OPTIONAL { FILTER langMatches( lang(?label), \"' + #session['WW_TRANS_RDF_LOCALES'][0] + '\" ) } } ORDER BY DESC(?label) LIMIT 50 '"/>--%>
        <%-- Waiting for the new endpoint to return fao/figis uris. When OK, add filter on uris from previous query --%>
        <%-- <s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=http://www.ics.forth.gr/isl/TLObasedDataWarehouse&should-sponge=&format=application/sparql-results+xml&query='" /> --%>
        <%-- <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def#> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> SELECT distinct ?species ?label WHERE { ?species rdf:type tlo:TLOSpecies . ?species skos:prefLabel ?label } ORDER BY ?label OFFSET 251 LIMIT 8 '"/> --%>

        <%-- TLO v2 queries --%>
        <%--<s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=&format=application/sparql-results+xml&timeout=0&query='" />  --%>
        <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" SELECT DISTINCT  ?species ?label WHERE { ?species <http://ics.forth.gr/Ontology/MarineTLO/imarine#LXrelatedIdentifierAssignment> ?y . ?y rdf:type <http://ics.forth.gr/Ontology/MarineTLO/imarine#ScientificNameAssignment> . ?y <http://ics.forth.gr/Ontology/MarineTLO/imarine#assignedName> ?label . FILTER ( ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_obesus> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/katsuwonus_pelamis> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_alalunga> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/bft> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_albacares> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_tonggol> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_maccoyii> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/thunnus_atlanticus> ||  ?species = <http://www.ecoscope.org/ontologies/ecosystems/xiphias_gladius> ) } '" />
    </s:action>
    
    <s:push value="#resource">  
        <s:iterator value="results" status="state">
            <s:if test="#state.odd">
                <div class="gauche">
                    <table class="common_info_pages_tab_1">
                        <tr>
                            <%-- Link url --%>
                            <s:url var="linkUrl" action="ShowResource" >
                                <s:param name="uri"><s:property value="species.uri"/></s:param>
                                <s:param name="view">individual###element-01</s:param>
                            </s:url>

                            <%-- Picture url --%>
                            <s:action name="GetSparqlResult" executeResult="false" var="resource2">
                                <%-- Legacy TLO v1 queries --%>
                                
                                <%--<s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=http://www.ics.forth.gr/isl/TLObasedDataWarehouse&should-sponge=&format=application/sparql-results+xml&query='" />--%>
                                <%-- Filtering with foaf:Document --%>
                                <%--<s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?picture ?url WHERE { <' + species.uri + '> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://xmlns.com/foaf/0.1/Document> } LIMIT 1 '"/>--%>
                                <%-- Filtering with resources_dev:picture --%>
                                <%--<s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?picture ?url WHERE { <' + species.uri + '> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def#picture> } LIMIT 1 '"/>--%>

                                <%-- TLO v2 queries --%>
                                <%--<s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=&format=application/sparql-results+xml&timeout=0&query='" />--%>
                                <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?url WHERE { { <' + species.uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + species.uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } LIMIT 1'" />
                            </s:action>

                            <s:set var="found" value="false"/>
                            <s:push value="#resource2">
                                <s:iterator value="results" status="state2">
                                    <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                        <s:param name="filePath"><s:property value="url.literal" /></s:param>
                                        <s:param name="picSize">380x380</s:param>
                                    </s:url>
                                    <td class="photo">
                                        <s:a href="%{linkUrl}">
                                            <img src="<s:url value="%{picUrl}"/>" alt="Picture of <s:property value="label.literal"/>" title="<s:property value="label.literal"/>" />
                                        </s:a>
                                    </td>
                                    <s:set var="found" value="true"/>
                                </s:iterator>

                                <s:if test="!#found">
                                    <td class="photo">
                                        <s:a href="%{linkUrl}">
                                            <img style="border: none;" src="<s:url value="/webpages/pictures/14_picto/gallerie.png"/>" alt="Picture of <s:property value="label.literal"/>" title="<s:property value="label.literal"/>" />
                                        </s:a>
                                    </td>
                                </s:if>
                            </s:push>

                            <td class="intro">
                                <h3>
                                    <s:a href="%{linkUrl}">
                                        <s:property value="label.literal"/>
                                    </s:a>
                                </h3>
                                <%--<p>other comment</p>--%>
                            </td>
                        </tr>
                    </table>
                </div>
            </s:if>
        </s:iterator>

        <s:iterator value="results" status="state">
            <s:if test="#state.even">
                <div class="droite">
                    <table class="common_info_pages_tab_1">
                        <tr>
                            <%-- Link url --%>
                            <s:url var="linkUrl" action="ShowResource" >
                                <s:param name="uri"><s:property value="species.uri"/></s:param>
                                <s:param name="view">individual###element-01</s:param>
                            </s:url>

                            <%-- Picture url --%>
                            <s:action name="GetSparqlResult" executeResult="false" var="resource2">
                                <%-- Legacy TLO v1 queries --%>
                                
                                <%--<s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=http://www.ics.forth.gr/isl/TLObasedDataWarehouse&should-sponge=&format=application/sparql-results+xml&query='" />--%>
                                <%-- Filtering with foaf:Document --%>
                                <%--<s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?picture ?url WHERE { <' + species.uri + '> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://xmlns.com/foaf/0.1/Document> } LIMIT 1 '"/>--%>
                                <%-- Filtering with resources_dev:picture --%>
                                <%--<s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouse> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX tlo: <http://www.tlo.ics.forth.gr/TLO_entity#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?picture ?url WHERE { <' + species.uri + '> tlo:isReferencedBy ?picture . ?picture dc:identifier ?url . ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def#picture> } LIMIT 1 '"/>--%>

                                <%-- TLO v2 queries --%>
                                <%--<s:param name="endpointUrl" value="'http://62.217.127.213:8890/sparql?default-graph-uri=&format=application/sparql-results+xml&timeout=0&query='" />--%>
                                <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?url WHERE { { <' + species.uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + species.uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } LIMIT 1'" />
                            </s:action>

                            <s:set var="found" value="false"/>
                            <s:push value="#resource2">
                                <s:iterator value="results" status="state2">
                                    <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                        <s:param name="filePath"><s:property value="url.literal" /></s:param>
                                        <s:param name="picSize">380x380</s:param>
                                    </s:url>
                                    <td class="photo">
                                        <s:a href="%{linkUrl}">
                                            <img src="<s:url value="%{picUrl}"/>" alt="Picture of <s:property value="label.literal"/>" title="<s:property value="label.literal"/>" />
                                        </s:a>
                                    </td>
                                    <s:set var="found" value="true"/>
                                </s:iterator>

                                <s:if test="!#found">
                                    <td class="photo">
                                        <s:a href="%{linkUrl}">
                                            <img style="border: none;" src="<s:url value="/webpages/pictures/14_picto/gallerie.png"/>" alt="Picture of <s:property value="label.literal"/>" title="<s:property value="label.literal"/>" />
                                        </s:a>
                                    </td>
                                </s:if>
                            </s:push>

                            <td class="intro">
                                <h3>
                                    <s:a href="%{linkUrl}">
                                        <s:property value="label.literal"/>
                                    </s:a>
                                </h3>
                                <%--<p>other comment</p>--%>
                            </td>
                        </tr>
                    </table>
                </div>
            </s:if>
        </s:iterator>
        <div style="clear:both;"></div>
    </s:push>

    <%-- Autocompleter --%>
        
    <%-- Autocompleter label --%>
    <div id="autocompleter" style="margin-top: 40px;">

        <div  style="float: left; margin-right: 20px;" class="kb-font-family-f1 kb-font-color-c3 kb-text-size-s3">
            <s:text name="atlas.entryPage.species.autocompleteASpecies"/>
        </div>

        <%-- Species autocompleter --%>
        <div class="ui-widget">
            <%-- A future autocompleter --%>
            <input id="biotic_input" type="text" style="width: 200px; height:23px; vertical-align: middle;" value="<s:property value="preferredLabel"/>" />
            
            <%-- A play button --%>
            <button id="biotic_resource_button" style="vertical-align: middle;/* background: #d4e5dd;*/">
                <span class="ui-icon ui-icon-play"></span>
            </button>
            <s:url id="bioticResourceUrl" action="ShowResource" escapeAmp="false">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <script type="text/javascript">
                <!--
                $(function() {
                    $(function() {
                        $("#biotic_resource_button").button();
                        $("#biotic_resource_button").button("option", "disabled", true);
                    });

                    $("#biotic_resource_button").click(function() {
                        $("#biotic_resource_button").button("option", "disabled", true);
                        window.location.href = $destUrlBiotic;
                    });
                });
                // -->
            </script>

        </div>
        <%-- Autocompleter transformation --%>
        <s:url var="urlJQueryBiotic" action="GetSelectAutocompleterContent" >
            <%--<s:param name="searchType">http://www.tlo.ics.forth.gr/TLO_entity#TLOSpecies</s:param>--%>
            <s:param name="customQuery" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" SELECT DISTINCT  ?subject ?label WHERE { ?subject <http://ics.forth.gr/Ontology/MarineTLO/imarine#LXrelatedIdentifierAssignment> ?y . ?y rdf:type <http://ics.forth.gr/Ontology/MarineTLO/imarine#ScientificNameAssignment> . ?y <http://ics.forth.gr/Ontology/MarineTLO/imarine#assignedName> ?label . FILTER (regex(?label, \"###1###\", \"i\")) }'" />
        </s:url>
        <script type="text/javascript">
            <!--
            $(function() {
                $("#biotic_input").autocomplete({
                    source: "<s:property value="urlJQueryBiotic"/>",
                    minLength: 3,
                    delay: 400,
                    select: function(event, ui) {
                        $("#biotic_resource_button").button("option", "disabled", false);
                        $("#biotic_input").val(ui.item.label);
                        window.$destUrlBiotic = '<s:property value="#urlRedirect" />?view=' + escape("individual###element-01") + '&uri=' + escape(ui.item.uri);
                        window.location.href = window.$destUrlBiotic;
                    }
                });

                $('#biotic_input').click(function() {
                    $(this).focus();
                    $(this).select();
                });
            });
            // -->
        </script>

    </div>

</s:div>
