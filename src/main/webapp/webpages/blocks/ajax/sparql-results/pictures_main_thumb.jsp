<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:set var="thumbnailsCount" value="1"/>
<%--<s:if test="#fullSizeCount > 1">--%>
    <div id="previousThumb" class="" style="font-size: 2em;width: 10px;height: 79px;position: absolute;cursor: pointer;background-color: black;z-index: 10;">
        <
    </div>
    <div id="nextThumb" class="" style="font-size: 2em;width:30px;height:20px;position:absolute;cursor:pointer;background-color:black;z-index:10;">
        >
    </div>
    <table cellspacing="10" cellpadding="2" style="float: left;">
        <tr style="height: 79px;">
        <%--</s:if>--%>

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
                <!--                            </tr><tr style="height: 79px;">-->
            </s:if>

            <s:set var="thumbnailsCount" value="#thumbnailsCount + 1"/>

        </s:iterator>

        <s:if test="#fullSizeCount > 1">
        </tr>
    </table>
</s:if>