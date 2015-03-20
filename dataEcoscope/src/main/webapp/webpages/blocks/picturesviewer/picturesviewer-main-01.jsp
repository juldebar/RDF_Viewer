<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <%-- Content --%>

    <sj:div id="picture_viewer_main_01" cssStyle="background-color:white;min-height:300px;"  cssClass="kb-corner-radius-c1">

        <%-- ---------------------------------------- --%>
        <%-- Full-size pictures, in display:none DIVs --%>
        <%-- ---------------------------------------- --%>

        <s:set var="fullSizeCount" value="1"/>

        <div style="height:380px;margin: auto;width:100%;">

            <%-- Depictions --%>
            <s:action name="GetSparqlResult" executeResult="false" var="resource">
                <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT DISTINCT ?url WHERE { { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } '"/>
            </s:action>

            <s:push value="#resource"> 
                <s:i18n name="ShowResource">
                    <s:iterator value="results">
                        <s:if test="#fullSizeCount == 1">
                            <div id="img_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:block;">  
                            </s:if>
                            <s:else>
                                <div id="img_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:none;">
                                </s:else>

                                <div class="pictureCell">
                                    <s:if test="url.literal.startsWith('http')">
                                        <img src="<s:property value="identifier.literal" />" style='width:100%;' alt="[Picture]" />
                                    </s:if>
                                    <s:else>
                                        <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                            <s:param name="filePath"><s:property value="url.literal"/></s:param>
                                            <s:param name="picSize">380x380</s:param>
                                        </s:url>
                                        <img src="<s:property value="picUrl"/>" alt="[Picture]" style='width:100%;'/>
                                    </s:else>
                                </div>
                            </div>
                            <%-- --%>
                            <s:set var="fullSizeCount" value="#fullSizeCount + 1"/>
                        </s:iterator>
                    </s:i18n>
                </s:push>

                <s:if test="#fullSizeCount == 1">
                    <div id="img_<s:property value="#fullSizeCount" />" class="pictureSurroundingCell" style="display:block;">
                        <div class="pictureCell">
                            <s:text name="picturesviewer.main.01.noPicture"/>
                        </div>
                    </div>

                    <script defer="defer" type="text/javascript">
                        var picturesviewer = false;
                    </script>
                </s:if>
                <s:else>
                    <script defer="defer" type="text/javascript">
                        var picturesviewer = true;
                    </script>
                </s:else>
            </div>

            <%-- ------------------- --%>
            <%-- Pictures thumbnails --%>
            <%-- ------------------- --%>

            <s:set var="thumbnailsCount" value="1"/>

            <%-- Using a table instead of divs because ie7 doesn't understand css property "display : table-cell;" --%>
            <s:if test="#fullSizeCount > 1">
                <table cellspacing="10" cellpadding="2">
                    <tr style="height: 79px;">
                    </s:if>

                    <s:action name="GetSparqlResult" executeResult="false" var="resource">
                        <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT DISTINCT ?url WHERE { { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } '"/>
                    </s:action>

                    <s:push value="#resource"> 
                        <s:iterator value="results" status="state">
                            <td style="width:79px; text-align:center; border:solid; border-width:1px;-moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; border-color: gray;">
                                <s:if test="url.literal.startsWith('http')">
                                    <img src="<s:url value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}" />" style="cursor: pointer;" width="75px" onclick="replaceBlocksSequence('img_', 'img_<s:property value="#thumbnailsCount" />');
                            replaceBlocksSequence('imgmeta_', 'imgmeta_<s:property value="#thumbnailsCount" />');" />
                                </s:if>
                                <s:else>
                                    <s:url id="picUrl" action="GetFile" escapeAmp="false">
                                        <s:param name="filePath"><s:property value="url.literal"/></s:param>
                                        <s:param name="picSize">70x70</s:param>
                                    </s:url>
                                    <img style="max-width: 75px; max-height: 75px; cursor: pointer;" src="<s:property value="picUrl"/>" alt="[Thumb]" onclick="replaceBlocksSequence('img_', 'img_<s:property value="#thumbnailsCount" />');
                                            replaceBlocksSequence('imgmeta_', 'imgmeta_<s:property value="#thumbnailsCount" />');" />
                                </s:else>
                            </td>

                            <s:if test="(#thumbnailsCount % 4) == 0">
                            </tr><tr style="height: 79px;">
                            </s:if>

                            <s:set var="thumbnailsCount" value="#thumbnailsCount + 1"/>

                        </s:iterator>
                    </s:push>


                    <%-- Closing the table --%>
                    <s:if test="#fullSizeCount > 1">
                    </tr>
                </table>
            </s:if>
        </sj:div>
    </s:i18n>