<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<sj:head debug="false" compressed="true" jqueryui="true" loadAtOnce="true" loadFromGoogle="false" jquerytheme="redmond" />

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.ajax.search_results">

	<%-- Content --%>
	
	<div id="tabs-1">
		<%-- Prev/next navigation --%>
		<div style="text-align:center;margin-bottom:10px;">
			<s:if test="previous">
				<s:url var="firstUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">first</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'first0_'+randomNumber}"  href="%{firstUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_bback_25_25.png"/>" />
				</sj:a>
				
				<s:url var="prevUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">previous</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'previous0_'+randomNumber}"  href="%{prevUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_back_25_25.png"/>" />
				</sj:a>
			</s:if>
			
			<s:if test="next">
				<s:url var="nextUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">next</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'next0_'+randomNumber}" href="%{nextUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_forward_25_25.png"/>" />
				</sj:a>
				
				<s:url var="lastUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">last</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'last0_'+randomNumber}" href="%{lastUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_fforward_25_25.png"/>" />
				</sj:a>
			</s:if>
		</div>
		
		<s:iterator value="resources" status="state">
			<s:if test="#state.index < resourcesToHighlight">
				<div class="highlightedResult">
			</s:if>
			<s:else>
				<div style="padding-left:5px;padding-right:5px;">
			</s:else>
				<h4>
					<s:url id="url" action="ShowResource">
						<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
					</s:url>
					<s:a href="%{url}">
						<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel, 70)"/>
					</s:a>
					<s:url id="urlNvis" action="GetNetworkVisualization" escapeAmp="false">
				   		<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
				   		<s:param name="forcedView">searchResult</s:param>
				   	</s:url>
					<sj:a id="nvisButton_%{#state.index + 1}" href="%{urlNvis}" onclick="replaceBlocksSequenceAndSwitchDisplay('nvis_', 'nvis_%{#state.index + 1}');" targets="nvis_%{#state.index + 1}" indicator="nvis_wait_%{#state.index + 1}" >
						<img style="vertical-align:middle;margin-left:10px;" src="<s:url value="/webpages/pictures/05_advanced_search/blue_network_25_25.png"/>" alt="Network"/>
					</sj:a>
					<img style="display:none;vertical-align:middle;margin-left:10px;" id="nvis_wait_<s:property value="#state.index + 1"/>" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
				</h4>
				<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredDescription, 100)"/>
		
				<div id="nvis_<s:property value="#state.index + 1"/>" style="display:none;margin-top:10px;"></div>
			</div>
		</s:iterator>

		<s:if test="resources.size == 0">
			<s:text name="searchResults.01.noResultInThisCategory"/>
		</s:if>
		
		<div style="text-align:center;margin-top:10px;">
			<s:if test="previous">
				<s:url var="firstUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">first</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'first1_'+randomNumber}"  href="%{firstUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_bback_25_25.png"/>" />
				</sj:a>
				
				<s:url var="prevUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">previous</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'previous1_'+randomNumber}"  href="%{prevUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_back_25_25.png"/>" />
				</sj:a>
			</s:if>
			
			<s:if test="next">
				<s:url var="nextUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">next</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'next1_'+randomNumber}" href="%{nextUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_forward_25_25.png"/>" />
				</sj:a>
				
				<s:url var="lastUrl" action="GetTabbedSearchResults" escapeAmp="false">
					<s:param name="navigation">last</s:param>
					<s:param name="tabNo"><s:property value="tabNo"/></s:param>
				</s:url>
				<sj:a id="%{'last1_'+randomNumber}" href="%{lastUrl}" loadingText="Chargement..." targets="%{'ui-tabs-'+tabNo}">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_fforward_25_25.png"/>" />
				</sj:a>
			</s:if>
		</div>
	</div>
	
</s:i18n>