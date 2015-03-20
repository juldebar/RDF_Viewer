<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>


<div id="resources-text" style="position:relative;">
    <%-- Preferred Label --%>
    <h3>
        <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
        <img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
    </h3>

    <%-- Data sources --%>
    <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@used_data_source]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.sources"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}">
            <%-- TODO : To be improved with DC, FOAF, SKOS RDF definitions and retrieved with superProperty RDFS.label --%>
            <%--<s:a href="%{url}"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/></s:a> --%>
            <s:a href="%{url}"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]"/></s:a>
            <s:a href="%{url}"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/></s:a>
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

    <%-- Direct broader term --%>
    <%-- <s:merge id="mergedBroadersTerms">
            <s:param value="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource']" />
            <s:param value="properties[@com.hp.hpl.jena.vocabulary.RDFS@subClassOf]['resource']"/>
    </s:merge>
    <s:iterator value="mergedBroadersTerms" status="state">
            <s:if test="#state.first"><h4>Direct broader term</h4></s:if>
            <s:else><br/></s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}">
                    <s:a href="%{url}"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/></s:a>
            </s:a>
    </s:iterator>--%>

    <%-- All roader terms, retrieving directly from this view --%>
    <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.broaderTerms"/></h4></s:if>
        <s:else>, </s:else>
        <s:url id="url" action="ShowResource">
            <s:param name="resourceUri"><s:property /></s:param>
        </s:url>
        <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
    </s:iterator>

    <%-- All broader terms, calling another view using AJAX --%>
    <%-- <h4><s:text name="resourcestext.common.broaderTerms"/></h4>
    <s:url var="url2" action="ShowResource" escapeAmp="false">
            <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object" /></s:param>
            <s:param name="forcedView">class###factsheet-Superclasses</s:param>
    </s:url>
<sj:div href="%{url2}">
    <s:text name="addressBook.common.loading"/>
</sj:div> --%>

    <%-- Narrower terms --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@superClassOf]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.narrowerTerms"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
    </s:iterator>--%>

    <h4><s:text name="resourcestext.common.narrowerTerms"/></h4>
    <s:url var="url2" action="ShowResource" escapeAmp="false">
        <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object" /></s:param>
        <s:param name="forcedView">class###factsheet-Subclasses</s:param>
    </s:url>

    <sj:div href="%{url2}">
        <s:text name="addressBook.common.loading"/>
    </sj:div>

    <%-- Instances --%>
    <%--<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.instances"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property /></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
    </s:iterator>--%>

    <h4><s:text name="resourcestext.common.instances"/></h4>
    <s:url var="url2" action="ShowResource" escapeAmp="false">
        <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object" /></s:param>
        <s:param name="forcedView">class###factsheet-Individuals</s:param>
    </s:url>

    <sj:div href="%{url2}">
        <s:text name="addressBook.common.loading"/>
    </sj:div>

    <%-- Description --%>
    <s:merge id="mergedDescriptions">
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@note]['preferred']}" />
        <!-- TODO check if SKOS@note generalize SKOS@xNote -->
        <!-- If yes, and if the SKOS OWL schema is used, the following lines could be harmful if SKOS-RDF is inferred -->
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@scopeNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@historyNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@editorialNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@changeNote]['preferred']}" />
        <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@definition]['preferred']}" />
        <!-- TODO check the necessity of that with the Ecoscope ontology -->
        <s:param value="%{properties[@com.hp.hpl.jena.vocabulary.RDFS@comment]['preferred']}" />
    </s:merge>

    <s:iterator value="mergedDescriptions" status="state">
        <s:if test="#state.first"><h4><s:text name="resourcestext.common.description"/></h4></s:if>
        <s:else></s:else>
        <p class="resources-text"><s:property /></p>
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

    <%-- Access to RDF fragment --%>
    <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>

</div>