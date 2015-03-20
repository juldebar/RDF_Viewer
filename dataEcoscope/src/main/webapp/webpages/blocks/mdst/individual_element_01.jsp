<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%-- 
    Document   : individual_informational_resource_01
    Created on : 15 mars 2013, 11:02:00
    Author     : pcauquil
--%>

<div>
    <div id="name">
        <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
    </div>

    <div id="description">
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
            <s:if test="#state.first"><table id="table-descriptionelement"></s:if>
                <tr>
                    <td class="descriptionelement">
                        <s:property />
                    </td>
                </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    <div id="altLabels">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@altLabel]['preferred']" status="state">
            <s:if test="#state.first"><table id="table-altLabels"></s:if>
                <tr class="tr-altLabel">
                    <td class="altLabel">
                        <s:property />
                    </td>
                </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    <div id="sources">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@used_data_source]['resource']" status="state">
            <s:if test="#state.first"><table id="table-source"></s:if>
                <tr class="tr-source">
                    <td class="source">
                        <s:property value="preferredLabel" />
                    </td>
                </tr>
                <s:if test="#state.last"></table></s:if>
            </s:iterator>
    </div>
    
    <div id="broaderTerms">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state">
            <s:if test="#state.first"><table id="table-broaderTerms"></s:if>
                <tr class="tr-broaderTerms">
                    <td class="broaderTerms">
                        <s:property value="preferredLabel"/>
                    </td>
                </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    <div id="preys">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@is_predator_of]['resource']" status="state">
            <s:if test="#state.first"><table id="table-preys"></s:if>
                <tr class="tr-preys">
                    <td class="informationpreys">
                    <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                        <s:param name="forcedView">individual###mdst-Element</s:param>
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:property value="url" />
                </td>
                <td class="propertiesinformationpreys">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
                </td>
            </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    <div id="predators">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@is_prey_of]['resource']" status="state">
            <s:if test="#state.first"><table id="table-predators"></s:if>
                <tr class="tr-predators">
                    <td class="predators">
                    <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true" escapeAmp="false">
                        <s:param name="forcedView">individual###mdst-Element</s:param>
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:property value="url" />
                </td>
                <td class="informationpredators">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
                </td>
            </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    
    
    <div id="faoFamily">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoFamily]['preferred'][0]" default="n/a"/>
    </div>
        
    <div id="faoId">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoId]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="faoLatinName">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoLatinName]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="faoOrder">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@faoOrder]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="gbifId">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="relatedTac">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@relatedTAC]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="trophicLevel">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@trophic_level]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="meanLength">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@mean_length]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="reproductionLength">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@reproduction_length]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="captureLength">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@minimal_capture_length]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="irdCode">
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@hasCodeIRD]['preferred'][0]" default="n/a"/>
    </div>
    
    <div id="nicePictures">
        <s:set var="niceDepictions" value="properties[@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@niceDepiction]['resource']" />
        <s:if test="#niceDepictions == null">
            <s:set var="niceDepictions" value="{}"/>
        </s:if>

        <s:set var="count" value="1"/>
        <s:iterator value="niceDepictions"  status="state">
            <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0 " >
                <s:if test="#state.first" ><table id="table-nicedepiction"></s:if>
                        <tr class="tr-nicedepiction">
                            <td class="nicedepiction">
                            <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0].object.startsWith('http')">
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}" />
                            </s:if>
                            <s:else>
                                <s:url id="picUrl" action="GetFile" escapeAmp="false" forceAddSchemeHostAndPort="true">
                                    <s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
                                    <s:param name="picSize">380x380</s:param>
                                </s:url>
                                <s:property value="picUrl"/>
                            </s:else>
                        </td>
                        <td class="propertynicedepiction">
                            <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred'][0]}" default="n/a"/>
                        </td>
                    </tr>

                    <s:set var="count" value="#count + 1"/>
                </s:if>

                <s:if test="#state.last"></table></s:if>
            </s:iterator>
    </div>

    <div id="otherPictures">
        <s:set var="otherDepictions" value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource']" />
        <s:if test="#otherDepictions == null">
            <s:set var="otherDepictions" value="{}"/>
        </s:if>

        <%-- Removing nice depictions, which are already supported by the dedicated s:iterator --%>
        <s:if test="!alreadyExistsIn(#niceDepictions, properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object)">
            <s:set var="count" value="1"/>
            <s:iterator value="otherDepictions"  status="state">
                <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0 " >
                    <s:if test="#state.first" ><table id="table-otherpicture"></s:if>
                            <tr class="tr-otherpicture">
                                <td class="otherpictureelement">
                                <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0].object.startsWith('http')">
                                    <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}" />
                                </s:if>
                                <s:else>
                                    <s:url id="picUrl" action="GetFile" escapeAmp="false" forceAddSchemeHostAndPort="true">
                                        <s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
                                        <s:param name="picSize">380x380</s:param>
                                    </s:url>
                                    <s:property value="picUrl"/>
                                </s:else>
                            </td>
                            <td class="propertyotherpicture">
                                <s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred'][0]}" default="n/a"/>
                            </td>
                        </tr>

                        <s:set var="count" value="#count + 1"/>
                    </s:if>

                    <s:if test="#state.last"></table></s:if>
                </s:iterator>
            </s:if>
    </div>    
</div>