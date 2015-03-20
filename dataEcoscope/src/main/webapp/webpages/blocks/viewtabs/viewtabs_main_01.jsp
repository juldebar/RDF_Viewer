<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="ShowResource">
    <%-- Horizontal buttons --%>
    <%--<div style="text-align: center;width: 648px;margin: auto;">--%> <%-- 648px = 4*152(buttons) + 8*5(margins); allow centering --%>
    <div style="text-align: center;width: 328px;margin: auto;display:none;"> <%-- 328px = 2*152(buttons) + 8*3(margins); allow centering --%>
        <div id="horizontalMenu_01" class="horizontalMenu1">
            <a onclick="replaceBlocks('media_1', new Array('media_2', 'media_3', 'media_4'));
                                        replaceBlocks('meta_1', new Array('meta_2', 'meta_3', 'meta_4'));"><s:text name="viewTabs.common.pictures"/></a>
        </div>
        <%--<div id="horizontalMenu_02" class="horizontalMenu1">
                <a onclick="replaceBlocks('media_2', new Array('media_1', 'media_3', 'media_4'));replaceBlocks('meta_2', new Array('meta_1', 'meta_3', 'meta_4'));"><s:text name="viewTabs.common.cartography"/></a>
        </div>
        <div id="horizontalMenu_03" class="horizontalMenu1">
                <a onclick="replaceBlocks('media_3', new Array('media_1', 'media_2', 'media_4'));replaceBlocks('meta_3', new Array('meta_1', 'meta_2', 'meta_4'));"><s:text name="viewTabs.common.network"/></a>
        </div>--%>
        <div id="horizontalMenu_04" class="horizontalMenu1">
            <a onclick="replaceBlocks('media_4', new Array('media_1', 'media_2', 'media_3'));
                                        replaceBlocks('meta_4', new Array('meta_1', 'meta_2', 'meta_3'));"><s:text name="viewTabs.common.indicators"/></a>
        </div>
        <div style="clear:both;"></div>
    </div>
</s:i18n>