<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Tuning this view --%>
<%-- Which types of layers do we want to display ? --%>
<s:set var="isDisplayOnlyWMCIfExists" value="true" />
<s:set var="isDisplayWMC" value="true" />
<s:set var="isDisplayKML" value="true" />
<s:set var="isDisplayWMS" value="true" />

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.openlayers.openlayers">

    <sj:div id="openlayers_meta_01" cssStyle="background-color:white;min-height:100px;padding:5px;" cssClass="kb-corner-radius-c1">

        <%-- Displaying WMC --%>
        <s:merge id="mergedLayers">
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
            <s:param value="#{'preferred':#p}" />
        </s:merge>

        <s:set var="count" value="1"/>
        <s:set var="isWMCFound" value="false"/>
        <s:iterator value="mergedLayers" status="state">
            <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0">
                <%-- This layer is a WMC --%>
                <s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMC.URI" >
                    <s:if test="#isDisplayWMC == true">
                        <div style="margin:10px 5px 10px 5px;">
                            <%--<s:url id="url" action="ShowResource">
                                    <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]" /></s:param>
                                    <s:param name="forcedView">individual###atlas</s:param>
                            </s:url> --%>
                            <s:url id="url" action="ShowResource">
                                <s:param name="resourceUri"><s:property value="resourceUri" /></s:param>
                                <s:param name="forcedView">individual###resourceAsAtlas</s:param>
                            </s:url>
                            <s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
                                <span style="float:right;width: 330px;">
                                    <s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>
                                </span>
                                <img src="<s:url value="/webpages/pictures/00_commons/ogc_25_25.png"/>" style="vertical-align:middle;" alt="OpenLayers icon"/>
                            </s:a>
                            <div style="clear: both;"></div>
                        </div>
                        <s:set var="count" value="#count + 1"/>
                        <s:set var="isWMCFound" value="true"/>
                    </s:if>
                </s:if>
            </s:if>
        </s:iterator>

        <%-- Conditionnaly displaying WMS & KML --%>
        <s:merge id="mergedLayers">
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
            <s:param value="#{'preferred':#p}" />
        </s:merge>

        <s:if test="((#isDisplayOnlyWMCIfExists == false) || ((#isWMCFound == false) && (#isDisplayOnlyWMCIfExists == true))) && ((#isDisplayKML == true) || (#isDisplayWMS == true))">
            <s:iterator value="mergedLayers" status="state">
                <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0">
                    <%-- This layer is a KML --%>
                    <s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI">
                        <s:if test="#isDisplayKML == true">
                            <div style="margin:10px 5px 10px 5px;">
                                <s:url id="url" action="ShowResource">
                                    <%--<s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]"/></s:param> --%>
                                    <s:param name="resourceUri"><s:property value="resourceUri" /></s:param>
                                    <s:param name="forcedView">individual###resourceAsAtlas</s:param>
                                </s:url>
                                <div style="float:right;width: 330px;">
                                    <s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
                                        <s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>
                                    </s:a>
                                </div>
                                <s:url id="url" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}" />
                                <s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
                                    <img src="<s:url value="/webpages/pictures/00_commons/google_earth_25_25.gif"/>" style="vertical-align:middle;" alt="Google Earth icon"/>
                                </s:a>
                                <div style="clear: both;"></div>
                            </div>
                            <s:set var="count" value="#count + 1"/>
                        </s:if>
                    </s:if>

                    <%-- This layer is a WMS --%>
                    <s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI" >
                        <s:if test="#isDisplayWMS == true">
                            <div style="margin:10px 5px 10px 5px;">
                                <s:url id="url" action="ShowResource">
                                    <%-- <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]" /></s:param> --%>
                                    <s:param name="resourceUri"><s:property value="resourceUri" /></s:param>
                                    <s:param name="forcedView">individual###resourceAsAtlas</s:param>
                                </s:url>
                                <s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
                                    <div style="float:right;width: 330px;">
                                        <s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>
                                    </div>
                                    <img src="<s:url value="/webpages/pictures/00_commons/oo_25_25.png"/>" style="vertical-align:middle;" alt="OpenLayers icon"/>
                                </s:a>
                                <div style="clear: both;"></div>
                            </div>
                            <s:set var="count" value="#count + 1"/>
                        </s:if>
                    </s:if>
                </s:if>
            </s:iterator>
        </s:if>

        <s:if test="#count == 1">
            <s:div id="openlayers-no-metadata" cssStyle="text-align:center;padding-top:40px;">
                <s:text name="openlayers.meta.01.noMetadata"/>
            </s:div>
        </s:if>
    </sj:div>

</s:i18n>