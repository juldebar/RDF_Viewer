<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.resourcestext.resourcestext">

    <div id="resources-text">
        <h3>
            <!-- Title -->
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
            <img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
        </h3>


        <!--Description -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.description"/></h4></s:if>
            <s:else><br/><br/></s:else>
            <p class="resources-text"><s:property /></p>
        </s:iterator>	

        <!-- Subject resources -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@subject]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.subjects"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
        </s:iterator>

        <!--Creators -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@creator]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.creators"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel"/>
            </s:a>
        </s:iterator>

        <!--Contributors -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@contributor]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.contributors"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel"/>
            </s:a>
        </s:iterator>

        <!--Creation date -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@date]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.creationDate"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <!--Type -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@type]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.project.type"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>	

        <!-- Coverage -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@coverage]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.project.coverage"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>	

        <!--Links -->
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.attachedExternalResources"/></h4></s:if>
            <s:else>&nbsp</s:else>
            <s:if test="object.startsWith('http://')">
                <s:url id="url" value="%{object}"/>
            </s:if>
            <s:else>
                <s:url id="url" action="GetFile" escapeAmp="false">
                    <s:param name="filePath"><s:property value="%{object}"/></s:param>
                </s:url>
            </s:else>
            <a style="cursor:pointer;" onclick="javascript:window.open('<s:property value="#url"/>');" >
                <img src="<s:url value="/webpages/pictures/10_icons/bb_dsk_25_25.png"/>" />
            </a>
        </s:iterator>

        <!-- Personal homepage -->
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@homepage]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.homepage"/></h4></s:if>
            <s:else>&nbsp;</s:else>
            <s:url id="url" value="%{object}"/>
            <a style="cursor:pointer;" onclick="javascript:window.open('<s:property value="#url"/>');" >
                <img src="<s:url value="/webpages/pictures/10_icons/bb_home_25_25.png"/>" />
            </a>
        </s:iterator>
        <div style="clear:both;"></div>	

        <%-- Access to RDF fragment --%>
        <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>
    </div>

</s:i18n>