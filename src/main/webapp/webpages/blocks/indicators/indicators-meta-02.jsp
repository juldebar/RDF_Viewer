<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <%-- Content --%>

    <sj:div id="indicators_meta_01" cssStyle="background-color:white;min-height:100px;padding:10px;" cssClass="kb-corner-radius-c1">

        <s:action name="GetSparqlResult" executeResult="false" var="resource">
            <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?resource ?term ?description ?wpsUrl ?dataInput ?process WHERE { <' + uri + '> resources_def:has_related_indicator ?resource . ?resource dc:title ?term . ?resource resources_def:has_WPS_Execute_URL ?wpsUrl . OPTIONAL { ?resource dc:description ?description . ?resource resources_def:has_data_input ?dataInput . ?resource resources_def:usesProcess ?process } } '"/>
        </s:action>

        <s:push value="#resource"> 
            <s:i18n name="ShowResource">
                <s:iterator value="results" status="state">
                    <s:if test="#state.first">
                        <div id="indmeta_<s:property value="#state.count" />" style="display:block;">
                        </s:if>
                        <s:else>
                            <div id="indmeta_<s:property value="#state.count" />" style="display:none;">
                            </s:else>

                            <%-- Label --%>
                            <div class="propertyLabel" style="float:left;"><s:text name="indicatorsviewer.meta.common.indicatorTitle"/>:&nbsp;</div>
                            <s:url id="url" action="ShowResource">
                                <s:param name="uri"><s:property value="resource.uri"/></s:param>
                            </s:url>
                            <s:a href="%{url}">
                                <s:property value="term.literal" default="n/a"/>
                            </s:a>
                            <div style="clear:both;"></div>
                            
                            <%-- Description --%>
                            <div class="propertyLabel" style="float:left;"><s:text name="indicatorsviewer.meta.common.indicatorDescription"/>:&nbsp;</div>
                            <s:property value="description.literal" default="n/a"/>
                            <div style="clear:both;"></div>
                            
                            <%-- Input data --%>
                            <div class="propertyLabel" style="float:left;"><s:text name="indicatorsviewer.meta.common.input"/>:&nbsp;</div>
                            <s:url id="url" action="ShowResource">
                                <s:param name="view">individual###informational-resource-01</s:param>
                                <s:param name="uri"><s:property value="dataInput.uri"/></s:param>
                            </s:url>
                            <s:a href="%{url}">
                                <s:text name="common.clickHere"/>
                            </s:a>
                            <div style="clear:both;"></div>
                            
                            <%-- Process --%>
                            <div class="propertyLabel" style="float:left;"><s:text name="indicatorsviewer.meta.common.process"/>:&nbsp;</div>
                            <s:url id="url" action="ShowResource">
                                <s:param name="view">individual###informational-resource-01</s:param>
                                <s:param name="uri"><s:property value="process.uri"/></s:param>
                            </s:url>
                            <s:a href="%{url}">
                                <s:text name="common.clickHere"/>
                            </s:a>
                            <div style="clear:both;"></div>
                            
                            <%-- WPS link --%>
                            <div class="propertyLabel" style="float:left;"><s:text name="indicatorsviewer.meta.common.wpsLink"/>:&nbsp;</div>
                            <s:url id="url" action="ShowWPS">
                                <s:param name="url"><s:property value="wpsUrl.literal"/></s:param>
                            </s:url>
                            <s:a href="%{url}">
                                <s:text name="common.clickHere"/>
                            </s:a>
                        </div>
                    </s:iterator>
                </s:i18n>
            </s:push>


            <%-- Finishing --%>
            <s:if test="#count == 1">
                <s:div id="picturesviewer-no-metadata" cssStyle="text-align:center;padding-top:40px;">
                    <s:text name="picturesviewer.meta.01.noMetadata"/>
                </s:div>
            </s:if>
        </sj:div>
    </s:i18n>