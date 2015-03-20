<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.ajax.search_results">

	<%-- Content --%>
	
	<div id="media_5" style="background-color:white;margin-bottom:10px;padding:10px;display:block;">
		
		<script language="javascript" type="text/javascript">
			//alert("outside the jQuery ready");
	        $(function() {
	                //alert("inside the jQuery ready");
	        });
	    </script>
		
		<script type="text/javascript">
			$(function() {
				$("#tabs").tabs({
					ajaxOptions: {
						error: function(xhr, status, index, anchor) {
							$(anchor.hash).html("<s:text name="searchResults.01.tabError"/>");
						}
					},
					select: function(event, ui) {
						$(ui.panel).html("<s:text name="searchResults.01.loading"/>");
						return true;
					}
				});

				<%-- Selecting the tab displayed by default, according to the type of the "best answer" --%>
				<s:if test="resources.size == 0">
				$("#tabs").tabs( "option", "selected", 0 );
				</s:if>
				<s:else>
					<s:set var="found" value="false"/>
					<s:iterator value="resources" status="state">
						<s:if test="#found == false">
							<s:iterator value="resources[#state.index][@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" >
								<s:if test="#found == false">
									<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@animal.URI" >
										<s:if test="#found == false">
											$("#tabs").tabs( "option", "selected", 0 );
											<s:set var="found" value="true"/>
										</s:if>
									</s:if>
	
									<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.FOAF@Agent.URI" >
										<s:if test="#found == false">
											$("#tabs").tabs( "option", "selected", 1 );
											<s:set var="found" value="true"/>
										</s:if>
									</s:if>
	
									<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture.URI" >
										<s:if test="#found == false">
											$("#tabs").tabs( "option", "selected", 2 );
											<s:set var="found" value="true"/>
										</s:if>
									</s:if>

									<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@spatialGeometry.URI" >
										<s:if test="#found == false">
											$("#tabs").tabs( "option", "selected", 3 );
											<s:set var="found" value="true"/>
										</s:if>
									</s:if>

									<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@ecosystem.URI" >
										<s:if test="#found == false">
											$("#tabs").tabs( "option", "selected", 4 );
											<s:set var="found" value="true"/>
										</s:if>
									</s:if>
								</s:if>
							</s:iterator>
						</s:if>
					</s:iterator>
	
					<s:if test="#found == false">
						$("#tabs").tabs( "option", "selected", 5 );
					</s:if>
				</s:else>
			});
			
			<%-- Setting up a waiting text, used while loading a tab's remote content --%>
			//$('#tabs').bind('tabsselect', function(event, ui) {
			//	$(ui.panel).html("<s:text name="searchResults.01.loading"/>");
			//	return true;
			//});
		</script>
	
		<%-- Defining the urls for each tab --%>
		<s:url id="speciesTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">1</s:param>
			<s:param name="resultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@animal}"/></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		<s:url id="agentsTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">2</s:param>
			<s:param name="resultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.FOAF@Agent}" /></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		<s:url id="depictionsTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">3</s:param>
			<s:param name="resultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture}" /></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		<s:url id="geometriesTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">4</s:param>
			<s:param name="resultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@spatialGeometry}" /></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		<s:url id="ecosystemsTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">5</s:param>
			<s:param name="resultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@ecosystem}" /></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		<s:url id="othersTabUrl" action="GetTabbedSearchResults" escapeAmp="false">
			<s:param name="forcedView">multi###advancedSearch-TabContent</s:param>
			<s:param name="tabNo">6</s:param>
			<s:param name="notResultsTypes"><s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@animal}"/>###<s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.FOAF@Agent}"/>###<s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture}"/>###<s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@spatialGeometry}"/>###<s:property value="%{@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@ecosystem}"/></s:param>
			<s:param name="offset">0</s:param>
			<s:param name="limit">10</s:param>
		</s:url>
		
		<%-- Defining the tabs and their remote urls --%>
		<div id="tabs">
			<ul>
				<%--<li><a href="#tabs-1">Species</a></li> --%>
				<li><a href="<s:property value="#speciesTabUrl" />">Species</a></li>
				<li><a href="<s:property value="#agentsTabUrl" />">Agents</a></li>
				<li><a href="<s:property value="#depictionsTabUrl" />">Pictures</a></li>
				<li><a href="<s:property value="#geometriesTabUrl" />">Geometries</a></li>
				<li><a href="<s:property value="#ecosystemsTabUrl" />">Ecosystems</a></li>
				<li><a href="<s:property value="#othersTabUrl" />">Others</a></li>
			</ul>
		</div>
	</div>
	
</s:i18n>