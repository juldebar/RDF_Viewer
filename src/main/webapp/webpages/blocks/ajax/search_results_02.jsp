<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.ajax.search_results">

	<!-- Content -->
	
	<div id="media_5" style="background-color:white;min-height:300px;margin-bottom:10px;padding:10px;display:block;">
	
		<s:if test="!criteriaFound">
			<s:text name="searchResults.01.noCriteriaFound"/>
		</s:if>
		<s:elseif test="resources.size() == 0">
			<s:text name="searchResults.01.noResults"/>
		</s:elseif>
		<s:else>
		
			<%-- Animals --%>
			<h3 class="searchResults">Fiches espèces</h3>
			<hr/>
			
			<s:set var="count1" value="0"/>
			<s:iterator value="resources" status="state">
				
				<s:set var="count2" value="0"/>
				<s:iterator value="resources[#state.index][@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" >
					<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@animal.URI" >
						<s:set var="count1" value="1"/>
						<s:set var="count2" value="1"/>
					</s:if>

				</s:iterator>
				
				<s:if test="#count2 == 1">
					<h4>
						<s:url id="url" action="ShowResource">
							<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
						</s:url>	
						<s:a href="%{url}">
							<s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
						</s:a>
						
						<s:url id="urlNvis" action="GetNetworkVisualization">
					   		<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
					   	</s:url>
						<sx:a id="nvisButton" href="%{urlNvis}" onclick="replaceBlocksSequenceAndSwitchDisplay('nvis_', 'nvis_%{#state.index + 1}');" targets="nvis_%{#state.index + 1}" indicator="nvis_wait_%{#state.index + 1}" >
							<img style="vertical-align:middle;margin-left:10px;" src="<s:url value="/webpages/pictures/05_advanced_search/blue_network_25_25.png"/>" alt="Worms logo"/>
						</sx:a>
						<img style="display:none;vertical-align:middle;margin-left:10px;" id="nvis_wait_<s:property value="#state.index + 1"/>" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
					</h4>
					<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredDescription, 100)"/>
			
					<div id="nvis_<s:property value="#state.index + 1"/>" style="display:none;"></div>
				</s:if>
				<s:if test="#count1 == 0 && #state.last">
					Aucun résultat dans cette catégorie
				</s:if>
				
			</s:iterator>
			
			<%-- Agents --%>
			<h3 class="searchResults">Agents</h3>
			<hr/>
			
			<s:set var="count1" value="0"/>
			<s:iterator value="resources" status="state">

				<s:set var="count2" value="0"/>
				<s:iterator value="resources[#state.index][@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state2">
					<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.FOAF@Agent.URI" >
						<s:set var="count1" value="1"/>
						<s:set var="count2" value="1"/>
					</s:if>
				</s:iterator>
				
				<s:if test="#count2 == 1">
					<h4>
						<s:url id="url" action="ShowResource">
							<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
						</s:url>	
						<s:a href="%{url}">
							<s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
						</s:a>
						
						<s:url id="urlNvis" action="GetNetworkVisualization">
					   		<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
					   	</s:url>
						<sx:a id="nvisButton" href="%{urlNvis}" onclick="replaceBlocksSequenceAndSwitchDisplay('nvis_', 'nvis_%{#state.index + 1}');" targets="nvis_%{#state.index + 1}" indicator="nvis_wait_%{#state.index + 1}" >
							<img style="vertical-align:middle;margin-left:10px;" src="<s:url value="/webpages/pictures/05_advanced_search/blue_network_25_25.png"/>" alt="Worms logo"/>
						</sx:a>
						<img style="display:none;vertical-align:middle;margin-left:10px;" id="nvis_wait_<s:property value="#state.index + 1"/>" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
					</h4>
					<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredDescription, 100)"/>
			
					<div id="nvis_<s:property value="#state.index + 1"/>" style="display:none;"></div>
				</s:if>
				<s:if test="#count1 == 0 && #state.last">
					Aucun résultat dans cette catégorie
				</s:if>
				
			</s:iterator>
			
			<h3 class="searchResults">Photos</h3>
			<hr/>
			
			<s:set var="count1" value="0"/>
			<s:iterator value="resources" status="state">

				<s:set var="count2" value="0"/>
				<s:iterator value="resources[#state.index][@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state2">
					<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture.URI" >
						<s:set var="count1" value="1"/>
						<s:set var="count2" value="1"/>
					</s:if>
				</s:iterator>
				
				<s:if test="#count2 == 1">
					<h4>
						<s:url id="url" action="ShowResource">
							<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
						</s:url>	
						<s:a href="%{url}">
							<s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
						</s:a>
						
						<s:url id="urlNvis" action="GetNetworkVisualization">
					   		<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
					   	</s:url>
						<sx:a id="nvisButton" href="%{urlNvis}" onclick="replaceBlocksSequenceAndSwitchDisplay('nvis_', 'nvis_%{#state.index + 1}');" targets="nvis_%{#state.index + 1}" indicator="nvis_wait_%{#state.index + 1}" >
							<img style="vertical-align:middle;margin-left:10px;" src="<s:url value="/webpages/pictures/05_advanced_search/blue_network_25_25.png"/>" alt="Worms logo"/>
						</sx:a>
						<img style="display:none;vertical-align:middle;margin-left:10px;" id="nvis_wait_<s:property value="#state.index + 1"/>" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
					</h4>
					<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredDescription, 100)"/>
			
					<div id="nvis_<s:property value="#state.index + 1"/>" style="display:none;"></div>
				</s:if>
				<s:if test="#count1 == 0 && #state.last">
					Aucun résultat dans cette catégorie
				</s:if>
			</s:iterator>
			
			
			<%-- Other types of resource, excluded in filters above --%>
			
			<h3 class="searchResults">Autres ressources</h3>
			<hr/>
			
			<s:set var="count1" value="1"/>
			<s:iterator value="resources" status="state">
				
				<s:set var="count2" value="1"/>
				<s:iterator value="resources[#state.index][@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource']" status="state2">
					<s:if test="object == @org.ird.crh.ecoscope.jena.vocabulary.FOAF@Agent.URI
								|| object == @org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@picture.URI
								|| object == @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@animal.URI
								" >
						
						<s:set var="count1" value="0"/>
						<s:set var="count2" value="0"/>
					</s:if>
				</s:iterator>
				
				<s:if test="#count2 == 1">
					<h4>
						<s:url id="url" action="ShowResource">
							<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
						</s:url>	
						<s:a href="%{url}">
							<s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
						</s:a>
						
						<s:url id="urlNvis" action="GetNetworkVisualization">
					   		<s:param name="resourceUri"><s:property value="resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object"/></s:param>
					   	</s:url>
						<sx:a id="nvisButton" href="%{urlNvis}" onclick="replaceBlocksSequenceAndSwitchDisplay('nvis_', 'nvis_%{#state.index + 1}');" targets="nvis_%{#state.index + 1}" indicator="nvis_wait_%{#state.index + 1}" >
							<img style="vertical-align:middle;margin-left:10px;" src="<s:url value="/webpages/pictures/05_advanced_search/blue_network_25_25.png"/>" alt="Worms logo"/>
						</sx:a>
						<img style="display:none;vertical-align:middle;margin-left:10px;" id="nvis_wait_<s:property value="#state.index + 1"/>" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
					</h4>
					<s:property value="subText(resources[#state.index][@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredDescription, 100)"/>
			
					<div id="nvis_<s:property value="#state.index + 1"/>" style="display:none;"></div>
				</s:if>
				<s:if test="#count1 == 1 && #state.last">
					Aucun résultat dans cette catégorie
				</s:if>
				
			</s:iterator>

		</s:else>
	</div>
	
</s:i18n>