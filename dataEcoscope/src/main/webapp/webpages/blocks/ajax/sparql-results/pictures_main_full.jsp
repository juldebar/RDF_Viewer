<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">
    <s:set var="fullSizeCount" value="1"/>
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
    </s:i18n>