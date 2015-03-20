<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.viewtabs.viewtabs">

    <%-- Horizontal buttons --%>
    <div style="text-align: center;width: 648px;margin: auto;"> <!-- 648px = 4*152(buttons) + 8*5(margins); allow centering -->
        <div id="horizontalMenu_01" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://www.ecoscope.org/ontologies/ecosystems_def/ecosystem</s:param>
                <s:param name="forcedView">class###glossary-Ecosystem</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.glossary.ecosystem"/></s:a>
            </div>
            <div id="horizontalMenu_02" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://www.ecoscope.org/ontologies/ecosystems_def/abiotic_element</s:param>
                <s:param name="forcedView">class###glossary-AbioticElement</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.glossary.abioticElement"/></s:a>
            </div>
            <div id="horizontalMenu_03" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://www.ecoscope.org/ontologies/ecosystems_def/biotic_element</s:param>
                <s:param name="forcedView">class###glossary-BioticElement</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.glossary.bioticElement"/></s:a>
            </div>
            <div id="horizontalMenu_04" class="horizontalMenu1">
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri">http://www.ecoscope.org/ontologies/ecosystems_def/human_element</s:param>
                <s:param name="forcedView">class###glossary-HumanElement</s:param>
            </s:url>
            <s:a href="%{url}"><s:text name="viewTabs.glossary.humanElement"/></s:a>
            </div>
            <div style="clear:both;"></div>
        </div>

</s:i18n>