<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <%-- Content --%>

    <sj:div id="indicators_main_01" cssStyle="background-color:white;min-height:300px;margin-bottom:10px;padding-top: 20px;"  cssClass="kb-corner-radius-c1">

        <%-- ------------------------------------------ --%>
        <%-- Full-size indicators, in display:none DIVs --%>
        <%-- ------------------------------------------ --%>

        <s:set var="fullSizeCount" value="1"/>

        <div style="height:380px;margin: auto;">

            <s:action name="GetSparqlResult" executeResult="false" var="resource">
                <s:param name="query" value="'PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?o1 ?url WHERE { <' + uri + '> resources_def:has_related_indicator ?o1 . ?o1 dc:identifier ?url }'"/>
            </s:action>

            <%-- Depictions --%>
            <s:push value="#resource">
                <s:i18n name="ShowResource">
                    <s:iterator value="results">

                        <s:if test="#fullSizeCount == 1">
                            <div id="ind_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:block;">  
                            </s:if>
                            <s:else>
                                <div id="ind_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:none;">
                                </s:else>

                                <div class="pictureCell">
                                    <s:if test="url.literal.startsWith('http')">
                                        <img src="<s:property value="url.literal" />" width="380px" alt="[Picture]" />
                                    </s:if>
                                    <s:else>
                                        <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                            <s:param name="filePath"><s:property value="url.literal"/></s:param>
                                            <s:param name="picSize">380x380</s:param>
                                        </s:url>
                                        <img src="<s:property value="picUrl"/>" alt="[Picture]"/>
                                    </s:else>
                                </div>
                            </div>
                            <%-- --%>
                            <s:set var="fullSizeCount" value="#fullSizeCount + 1"/>
                        </s:iterator>
                    </s:i18n>
                </s:push>

                <s:if test="#fullSizeCount == 1">
                    <div id="ind_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:block;">
                        <div class="pictureCell">
                            <s:text name="picturesviewer.main.01.noPicture"/>
                        </div>
                    </div>

                    <script defer="defer" type="text/javascript">
                        var indicatorsviewer = false;
                    </script>
                </s:if>
                <s:else>
                    <script defer="defer" type="text/javascript">
                        var indicatorsviewer = true;
                    </script>
                </s:else>
            </div>

            <%-- --------------------- --%>
            <%-- Indicators thumbnails --%>
            <%-- --------------------- --%>

            <s:push value="#resource"> 
                <s:iterator value="results" status="state">
                    
                    <%-- Initializing the table --%>
                    <s:if test="#state.first">
                        <table cellspacing="10" cellpadding="2">
                            <tr style="height: 79px;">
                            </s:if>

                            <td style="width:79px; text-align:center; border:solid; border-width:1px;-moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; border-color: gray;">
                                <s:if test="url.literal.startsWith('http')">
                                    <img src="<s:url value="url.literal" />" style="cursor: pointer;" width="75px" onclick="replaceBlocksSequence('ind_', 'ind_<s:property value="#state.count" />');
                            replaceBlocksSequence('indmeta_', 'indmeta_<s:property value="#state.count" />');" />
                                </s:if>
                                <s:else>
                                    <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                        <s:param name="filePath"><s:property value="url.literal"/></s:param>
                                        <s:param name="picSize">75x75</s:param>
                                    </s:url>
                                    <img style="max-width: 75px; max-height: 75px; cursor: pointer;" src="<s:property value="picUrl"/>" alt="[Thumb]" onclick="replaceBlocksSequence('ind_', 'ind_<s:property value="#state.count" />');
                            replaceBlocksSequence('indmeta_', 'indmeta_<s:property value="#state.count" />');" />
                                </s:else>
                            </td>

                            <s:if test="(#state.count % 4) == 0">
                            </tr><tr style="height: 79px;">
                            </s:if>

                            <%-- Closing the table --%>
                            <s:if test="#state.last">
                            </tr>
                        </table>
                    </s:if>

                </s:iterator>
            </s:push>


        </sj:div>

    </s:i18n>