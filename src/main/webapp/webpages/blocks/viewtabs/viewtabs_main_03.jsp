<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.viewtabs.viewtabs">

    <!-- Horizontal buttons -->
    <div style="text-align: center;width: 810px;margin: auto;"> <!-- 810px = 5*152(buttons) + 10*5(margins); allow centering -->
        <div id="horizontalMenu_01" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://xmlns.com/foaf/0.1/Person</s:param>
                <s:param name="forcedView">class###addressBook-Person</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.addressBook.persons"/></s:a>
            </div>
            <div id="horizontalMenu_02" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://xmlns.com/foaf/0.1/Group</s:param>
                <s:param name="forcedView">class###addressBook-Group</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.addressBook.groups"/></s:a>
            </div>
            <div id="horizontalMenu_03" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://xmlns.com/foaf/0.1/Project</s:param>
                <s:param name="forcedView">class###addressBook-Project</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.addressBook.projects"/></s:a>
            </div>
            <div id="horizontalMenu_04" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://xmlns.com/foaf/0.1/Organization</s:param>
                <s:param name="forcedView">class###addressBook-Organization</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.addressBook.organizations"/></s:a>
            </div>
            <div id="horizontalMenu_05" class="horizontalMenu1">
                <a onclick="replaceBlocks('media_2', new Array('media_1'));"><s:text name="viewTabs.addressBook.network"/></a>
        </div>
        <div style="clear:both;"></div>
    </div>

</s:i18n>