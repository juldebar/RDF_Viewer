<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>


<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.resourcestext.resourcestext">

    <div id="resources-text">
        <%--Title --%>
        <h3  style="color: black;">
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
            <img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
        </h3>

        <%-- Links to reference sites --%>
        <s:include value="/webpages/blocks/externallinks/externallinks_main_01.jsp"/>

        <%-- Subject resources --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@subject]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.subjects"/></h4></s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/></s:a>
        </s:iterator>

        <%-- Coverage --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@coverage]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.coverage"/></h4></s:if>
            <s:else><br/></s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/></s:a>
        </s:iterator>

        <%--Publisher --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@publisher]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.publishers"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <%--Description --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.description"/></h4></s:if>
            <s:else><br/></s:else>
            <p class="resources-text"><s:property /></p>
        </s:iterator>

        <%--Creation date --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@date]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.creationDate"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <%--Creators --%>
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

        <%--Contributors --%>
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

        <%--Rights --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@rights]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.copyrights"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <%--Type --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@type]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.type"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <%--Format --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@format]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.format"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property/>
        </s:iterator>

        <%--Links --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.links"/></h4></s:if>
            <s:else><br/></s:else>
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

        <%-- Access to RDF fragment --%>
        <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>
    </div>

</s:i18n>