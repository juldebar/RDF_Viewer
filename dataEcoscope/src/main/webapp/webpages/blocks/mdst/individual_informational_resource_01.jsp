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
        <h3>
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
        </h3>
    </div>

    <div id="description">
        <h5>Description :</h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred']" status="state">
            <p><s:property /></p>
        </s:iterator>
    </div>

    <div id="coverage">
        <h5>Coverage</h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@coverage]['resource']" status="state">
            <s:if test="#state.first">
                <ul id="ul-coverage">
                </s:if>
                <li class="coverageName">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
                    <ul class="informationalCoverage">
                        <li>
                            <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                                <s:param name="forcedView">individual###mdst-InformationalResource</s:param>
                                <s:param name="resourceUri"><s:property/></s:param>
                            </s:url>
                            <s:property value="url" />
                        </li>
                    </ul>
                </li>
                <s:if test="#state.last">
                </ul>
            </s:if>
        </s:iterator>
    </div>

    <div id="subjects">
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@subject]['resource']" status="state">
            <s:if test="#state.first">
                <ul id="ul-subjects">
                </s:if>
                <li class="subjectName">
                    <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/>
                    <ul class="informationalSubjects">
                        <li>
                            <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                                <s:param name="forcedView">individual###mdst-Element</s:param>
                                <s:param name="resourceUri"><s:property/></s:param>
                            </s:url>
                            <s:property value="url" />
                        </li>
                    </ul>
                    <s:if test="#state.last">
                </ul>
            </s:if>
        </s:iterator>
    </div>

    <div id="authors">
        <h5>
            Authors
        </h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@creator]['resource']" status="state">
            <s:if test="#state.first"><table id="table-authors"></s:if>
                <tr class="tr-author">
                    <td class="informationalAuthors">
                        <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                            <s:param name="forcedView">individual###mdst-Agent</s:param>
                            <s:param name="resourceUri"><s:property/></s:param>
                        </s:url>
                        <s:property value="url" />
                    </td>
                    <td class="authorName">
                        <s:property value="preferredLabel"/>
                    </td>
                </tr>
                <s:if test="#state.last"></table></s:if>
            </s:iterator>
    </div>

    <div id="contributors">
        <h5>Contributors :</h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@contributor]['resource']" status="state">
            <s:if test="#state.first">
                <table id="table-contributors">
                </s:if>
                <tr class="tr-contributor">
                    <td class="informationalContributors">
                        <s:url id="url" action="ShowResource" forceAddSchemeHostAndPort="true"  escapeAmp="false">
                            <s:param name="forcedView">individual###mdst-Agent</s:param>
                            <s:param name="resourceUri"><s:property/></s:param>
                        </s:url>
                        <s:property value="url" />
                    </td>
                    <td class="contributorsName">
                        <s:property value="preferredLabel"/>
                    </td>
                </tr>
                <s:if test="#state.last">
                </table>
            </s:if>
        </s:iterator>
    </div>

    <div id="formats">
        <h5>
            Formats
        </h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@format]['preferred']" status="state">
            <s:if test="#state.first"><table id="table-formats"></s:if>
                <tr class="tr-format">
                    <td class="informationalFormat">
                        <s:property/>
                    </td>
                </tr>
                <s:if test="#state.last"></table></s:if>
            </s:iterator>
    </div>

    <div id="creationDate">
        <h5>
            Date de création :
        </h5>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@date]['preferred']" status="state">
            <s:if test="#state.first"><table id="table-creationdate"></s:if>
                <tr class="tr-creationdate">
                    <td class="creationDate">
                        <s:property/>
                    </td>
                </tr>
                <s:if test="#state.last"></table></s:if>
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
                <s:if test="#state.first" ><table id="table-nicepicture"></s:if>
                    <tr class="tr-nicepicture">
                        <td class="nicedescription">
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
                        <td class="propertynicedescription">
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
                    <s:if test="#state.first" ><table id="table-otherdescription"></s:if>
                        <tr class="tr-otherdescription">
                            <td class="otherPicture">
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
                            <td class="description-otherpicture">
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
