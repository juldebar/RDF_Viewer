<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<%-- This block displays contextual links (with logos) to third-party websites --%>
<%-- For each link it accecpts afull url, or constructs a valid url from an id --%>
<%-- TODO : Manage correctly the FAO link and the 3-letters code --%>

<s:div id="external-links">
    <%-- Worms page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wormsId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wormsId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wormsId]['preferred'][0]"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_worms_45_45.png"/>" alt="Worms"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wormsId]['preferred'][0] != null">
        <s:url id="url" value="http://www.marinespecies.org/aphia.php" escapeAmp="false">
            <s:param name="p">taxdetails</s:param>
            <s:param name="id"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wormsId]['preferred'][0].object"/></s:param>
        </s:url>
        <a onclick="javascript:window.open('<s:property value="#url"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_worms_45_45.png"/>" alt="Worms"/>
        </a>
    </s:elseif>

    <%-- Fishbase page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@fishbaseId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@fishbaseId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@fishbaseId]['preferred'][0]"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_fishbase_45_45.png"/>" alt="Fishbase"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@fishbaseId]['preferred'][0] != null">
        <s:url id="url" value="http://www.fishbase.org/Summary/SpeciesSummary.php" escapeAmp="false">
            <s:param name="id"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@fishbaseId]['preferred'][0].object"/></s:param>
        </s:url>
        <a onclick="javascript:window.open('<s:property value="#url"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_fishbase_45_45.png"/>" alt="Fishbase"/>
        </a>
    </s:elseif>

    <%-- Wikipedia page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wikiId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wikiId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wikiId]['preferred'][0]"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_wikipedia_45_45.png"/>" alt="Wikipedia"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wikiId]['preferred'][0] != null">
        <s:set var="url" value="'http://en.wikipedia.org/wiki/' + properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@wikiId]['preferred'][0]" />
        <a onclick="javascript:window.open('<s:property value="#url"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_wikipedia_45_45.png"/>" alt="Wikipedia"/>
        </a>
    </s:elseif>

    <%-- FAO page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0]"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_fao_45_45.png"/>" alt="FAO"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0] != null">
        <%--
        <s:url id="url" value="http://www.fao.org/fi/website/FIRetrieveAction.do">
                <s:param name="dom">species</s:param>
                <s:param name="fid"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0].object"/></s:param>
        </s:url>
        <s:a onclick="javascript:window.open('%{#url}');" style="cursor: pointer;">
                <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_fao_45_45.png"/>" alt="FAO"/>
        </s:a>--%>
    </s:elseif>

    <%-- Sealifebase page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@sealifebaseId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@sealifebaseId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@sealifebaseId]['preferred'][0]}"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_sealifebase_45_45.png"/>" alt="Sealifebase"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@sealifebaseId]['preferred'][0] != null">
        <s:url id="url" value="http://www.sealifebase.org/Summary/SpeciesSummary.php" escapeAmp="false">
            <s:param name="id"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@sealifebaseId]['preferred'][0].object"/></s:param>
        </s:url>
        <a onclick="javascript:window.open('<s:property value="#url"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_sealifebase_45_45.png"/>" alt="Sealifebase"/>
        </a>
    </s:elseif>

    <%-- GBIF page --%>
    <s:if test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0] != null && properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0].object.startsWith('http')">
        <a onclick="javascript:window.open('<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0]}"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_gbif_45_45.png"/>" alt="GBIF"/>
        </a>
    </s:if>
    <s:elseif test="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0] != null">
        <s:url id="url" value="http://data.gbif.org/species/%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0]}" escapeAmp="false" />
        <a onclick="javascript:window.open('<s:property value="#url"/>');" style="cursor: pointer;">
            <img style="margin-right:10px;" src="<s:url value="/webpages/pictures/02_weblinks/logo_gbif_45_45.png"/>" alt="GBIF"/>
        </a>
    </s:elseif>
</s:div>