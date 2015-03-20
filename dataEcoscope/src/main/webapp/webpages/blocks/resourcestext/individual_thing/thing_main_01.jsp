<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.resourcestext.resourcestext">

    <div id="resources-text">
        <%-- Preferred Label --%>
        <h3>
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
            <img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
        </h3>

        <%-- Links to reference sites --%>
        <s:include value="/webpages/blocks/externallinks/externallinks_main_01.jsp"/>

        <%-- Data sources --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@used_data_source]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.subjects"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel" />
                <%-- TODO : To be improved with DC, FOAF, SKOS RDF definitions and retrieved with superProperty RDFS.label --%>
                <%--<s:a href="%{url}"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]"/></s:a>
                <s:a href="%{url}"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/></s:a>--%>
            </s:a>
        </s:iterator>

        <%-- Alternative labels --%>
        <s:merge id="mergedAltLabels">
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@altLabel]['preferred']}" />
            <!-- Harmful if SKOS-RDF is inferred, because RDFS@label will return all SKOS@prefLabel and SKOS@altLabel -->
            <!-- Unusefull too now because there's no more RDFS@label in the Ecoscope ontology -->
            <!--<s:param value="%{properties[@com.hp.hpl.jena.vocabulary.RDFS@label]}" />-->
        </s:merge>
        <s:iterator value="mergedAltLabels" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.synonyms"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property />
        </s:iterator>

        <%-- Direct broader term --%>

        <s:merge id="mergedBroadersTerms">
            <s:param value="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource']" />
            <s:param value="properties[@com.hp.hpl.jena.vocabulary.RDFS@subClassOf]['resource']"/>
        </s:merge>

        <%--<s:iterator value="mergedBroadersTerms" status="state">
                <s:if test="#state.first"><h4>Direct broader term</h4></s:if>
                <s:else><br/></s:else>
                <s:url id="url" action="ShowResource">
                    <s:param name="resourceUri"><s:property /></s:param>
                </s:url>
                <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
                </s:a>
        </s:iterator>--%>

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

        <%-- Narrower terms --%>
        <%-- useless for an individual --%>

        <%-- Instances -->
        <%-- useless for an individual --%>

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
            <s:else><br/><br/></s:else>
            <s:property />
        </s:iterator>

        <%-- Preys --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@is_predator_of]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.element.preys"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
            </s:a>
        </s:iterator>

        <%-- Predators --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@is_prey_of]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.element.predators"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
            </s:a>
        </s:iterator>

        <%-- Is Primary Topic Of --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@isPrimaryTopicOf]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.relatedData"/></h4></s:if>
            <s:else><br/></s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]" default="Link"/>
            </s:a>
        </s:iterator>

        <%-- Country ISO-2 code --%>
        <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@codeISO2]['preferred'][0] != null">
            <h4><s:text name="individual.thing.countryCodeISO2"/></h4>
            <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@codeISO2]['preferred'][0]" default="n/a"/>
        </s:if>

        <%-- Country ISO-3 code --%>
        <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@codeISO3]['preferred'][0] != null">
            <h4><s:text name="individual.thing.countryCodeISO3"/></h4>
            <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@codeISO3]['preferred'][0]" default="n/a"/>
        </s:if>

        <%-- Location LOCODE --%>
        <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasLoCode]['preferred'][0] != null">
            <h4><s:text name="individual.thing.loCode"/></h4>
            <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasLoCode]['preferred'][0]" default="n/a"/>
        </s:if>

        <%-- Access to RDF fragment --%>
        <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>
    </div>

</s:i18n>