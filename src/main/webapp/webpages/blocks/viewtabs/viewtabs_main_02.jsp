<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.viewtabs.viewtabs">

    <!-- Horizontal buttons -->
    <div style="text-align: center;width: 486px;margin: auto;"> <!-- 648px = 3*152(buttons) + 6*5(margins); allows centering -->
        <div id="horizontalMenu_01" class="horizontalMenu1">
            <a onclick="replaceBlocks('media_1', new Array('media_2', 'media_3'));replaceBlocks('meta_1', new Array('meta_2', 'meta_3'));"><s:text name="viewTabs.common.resources"/></a>
        </div>
        <div id="horizontalMenu_02" class="horizontalMenu1">
            <a onclick="replaceBlocks('media_2', new Array('media_1', 'media_3'));replaceBlocks('meta_2', new Array('meta_1', 'meta_3'));"><s:text name="viewTabs.common.cartography"/></a>
        </div>
        <div id="horizontalMenu_03" class="horizontalMenu1">
            <a onclick="replaceBlocks('media_3', new Array('media_1', 'media_2'));replaceBlocks('meta_3', new Array('meta_1', 'meta_2'));"><s:text name="viewTabs.common.network"/></a>
        </div>
        <div style="clear:both;"></div>
    </div>

</s:i18n>