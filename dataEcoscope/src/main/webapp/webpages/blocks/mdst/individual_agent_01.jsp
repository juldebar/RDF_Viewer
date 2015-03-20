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
    
    <div id="organism">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@fundedBy]['resource']" status="state">
            <s:if test="#state.first"><table id="table-organism"></s:if>
                <tr class="tr-organism">
                    <td class="organism">
                    <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                        <s:param name="forcedView">individual###mdst-Agent</s:param>
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:property value="url" />
                </td>
                <td class="propertyorganism">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/>
                </td>
            </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
        
    </div>
    
    <div id="phone">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@phone]['preferred']" status="state">
            <s:if test="#state.first"><table id="table-phone"></s:if>
                <tr class="tr-phone">
                    <td class="phone">
                        <s:property/>
                    </td>
                </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
    </div>
    
    <div id="teams">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF_EXT@isMemberOf]['resource']" status="state">
            <s:if test="#state.first">
                <table id="table-teams">
            </s:if>
                <tr class="tr-teams">
                    <td class="teams">
                        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/>
                    </td>
                </tr>
            <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
    </div>
    
    <div id="presentProjects">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@currentProject]['resource']" status="state">
            <s:if test="#state.first">
                <table id="table-presentprojects">
            </s:if>
                <tr class="tr-presentprojects">
                    <td class="presentprojects">
                        <s:property value="preferredLabel"/>
                    </td>
                </tr>
            <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
    </div>
    
    <div id="pastProjects">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@pastProject]['resource']" status="state">
            <s:if test="#state.first">
                <table>
            </s:if>
                <tr>
                    <td>
                        <s:property value="preferredLabel"/>
                    </td>
                </tr>
            <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
    </div>
    
    <div id="subjects">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@topic_interest]['resource']" status="state">
            <s:if test="#state.first">
                <table id="table-agentsubject">
            </s:if>
                <tr class="tr-agentsubject">
                    <td class="agentsubject">
                        <s:property value="preferredLabel" />
                    </td>
                </tr>
            <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
    </div>
    
    <div id="collaborators">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@knows]['resource']" status="state">
            <s:if test="#state.first"><table id="table-collaborators"></s:if>
                <tr class="tr-collaborators">
                    <td class="collaborators">
                    <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true" escapeAmp="false">
                        <s:param name="forcedView">individual###mdst-Agent</s:param>
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:property value="url" />
                </td>
                <td class="propertycollaborators">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/>
                </td>
            </tr>
            <s:if test="#state.last"></table></s:if>
        </s:iterator>
        
    </div>
    
    <div id="publications">
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@publications]['resource']" status="state">
            <s:if test="#state.first">
                <table id="table-publications">
            </s:if>
                <tr class="tr-publications">
                    <td class="pubications">
                        <s:property value="preferredLabel" />
                    </td>
                </tr>
            <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
        
    </div>
    
    <div id="nicePictures">
        <s:set var="niceDepictions" value="properties[@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@niceDepiction]['resource']" />
        <s:if test="#niceDepictions == null">
            <s:set var="niceDepictions" value="{}"/>
        </s:if>

        <s:set var="count" value="1"/>
        <s:iterator value="niceDepictions"  status="state">
            <s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0 " >
                <s:if test="#state.first" ><table id="nicedescriptionagent"></s:if>
                        <tr class="tr-nicedescriptionagent">
                            <td class="nicedescriptionagent">
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
                        <td class="propertynicedescriptionagent">
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
                    <s:if test="#state.first" ><table id="table-otherpictureagent"></s:if>
                            <tr class="tr-otherpictureagent">
                                <td class="otherpictureagent">
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
                            <td class="propertyotherpictureagent">
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