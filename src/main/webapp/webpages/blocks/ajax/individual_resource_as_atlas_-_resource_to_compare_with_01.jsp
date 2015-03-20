<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>


<%-- Tuning this view --%>
<%-- Which types of layers do we want to display ? --%>
<s:set var="isDisplayWMC" value="false" />
<s:set var="isDisplayKML" value="true" />
<s:set var="isDisplayWMS" value="true" />

<script defer="defer" type="text/javascript">
<!--
	var map;
	
	<%-- Layers variables declaration. Layers variables must be declared outside any JS function, in order to be called managed asynchronously by the HTML widgets --%>
	<s:merge id="mergedLayers">
		<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
		<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
		<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
		<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
		<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
	</s:merge>
	
	<s:iterator value="mergedLayers" status="state">
		<%-- This layer is a WMS or a KML --%>
		<s:if test="((properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI) && (#isDisplayWMS == true))
					|| ((properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI) && (#isDisplayKML == true))" >
			var another_dynamic_layer_<s:property value="#state.index"/>;
		</s:if>
	</s:iterator>
	
	
	// Add/remove an individual layer
	function displayOrHideAnotherIndividualLayer(elemId) {
		<s:set var="count" value="1"/>
		<s:merge id="mergedLayers">
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
		</s:merge>
		
		<s:iterator value="mergedLayers" status="state">
			<%-- This layer is a WMS --%>
			<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI) && (#isDisplayWMS == true)" >
	
				if (elemId == 'another_layer_<s:property value="#state.index"/>') {
					var elem = document.getElementById(elemId);
					
					if (elem.checked == false) {
						if(!(typeof(another_dynamic_layer_<s:property value="#state.index"/>)=='undefined')) {
							map.removeLayer(another_dynamic_layer_<s:property value="#state.index"/>);
							//another_dynamic_layer_<s:property value="#state.index"/>.destroy();
						}
					} else {
						another_dynamic_layer_<s:property value="#state.index"/> = new OpenLayers.Layer.WMS("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 50)}"/>", "<s:url escapeAmp="false" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/>");
						
						another_dynamic_layer_<s:property value="#state.index"/>.setVisibility(true);
						another_dynamic_layer_<s:property value="#state.index"/>.setIsBaseLayer(false);
						map.addLayer(another_dynamic_layer_<s:property value="#state.index"/>);
					}
				}

				<s:set var="count" value="#count + 1"/>
			</s:if>
			
			<%-- This layer is a KML --%>
			<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI) && (#isDisplayKML == true)">
				
				if (elemId == 'another_layer_<s:property value="#state.index"/>') {			
					var elem = document.getElementById(elemId);
					
					if (elem.checked == false) {
						if(!(typeof(another_dynamic_layer_<s:property value="#state.index"/>)=='undefined')) {
							map.removeLayer(another_dynamic_layer_<s:property value="#state.index"/>);
							//another_dynamic_layer_<s:property value="#state.index"/>.destroy();
						}
					} else {
						<s:url id="kmlUrl" action="GetFile" escapeAmp="false" >
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
						</s:url>
						another_dynamic_layer_<s:property value="#state.index"/> = new OpenLayers.Layer.GML("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 26)}"/>", "<s:property value="kmlUrl" />"
						,{
				      		format: OpenLayers.Format.KML, 
				           	formatOptions: {
								extractStyles: true,
								extractAttributes: true
				        	}
				    	});
						
						another_dynamic_layer_<s:property value="#state.index"/>.setVisibility(true);
						another_dynamic_layer_<s:property value="#state.index"/>.setIsBaseLayer(false);
						map.addLayer(another_dynamic_layer_<s:property value="#state.index"/>);
						// Adding bubbles for KML
						/*selectControl_<s:property value="#state.index"/> = new OpenLayers.Control.SelectFeature(another_dynamic_layer_<s:property value="#count"/>, {onSelect: onFeatureSelect, onUnselect: onFeatureUnselect});
				        map.addControl(selectControl_<s:property value="#state.index"/>);
				        selectControl_<s:property value="#state.index"/>.activate();*/
					}
				}
			
				<s:set var="count" value="#count + 1"/>
			</s:if>
		</s:iterator>
	}
	
// -->
</script>
	
	
<s:div>
	<%-- Resource's layers selector--%>
	<div id="another_layer_chooser_child" style="min-height:100px;padding:0px;">
		
		<s:set var="count" value="1"/>
		
		<%-- Displaying WMC --%>
		<s:merge id="mergedLayers">
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
			<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
		</s:merge>
		
		<s:set var="otherLayersFound" value="false"/>
		<s:iterator value="mergedLayers" status="state">
			<%-- This layer is a WMC --%>
			<s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMC.URI" >
				<s:if test="#isDisplayWMC == true">
					<%-- Displaying the selection widget --%>
					<div style="margin:10px 5px 10px 5px;">
						<s:url id="wmcUrl" action="GetFile" escapeAmp="false" >
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
						</s:url>
						<input type="radio" name="another_layersGroup" onclick="getWMCData('<s:property value="#wmcUrl"/>')" style="vertical-align:middle;" <s:if test="#count == 1">checked="checked"</s:if> />
						<s:url id="url" action="ShowResource">
							<s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]"/></s:param>
						</s:url>
						<s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
							<img src="<s:url value="/webpages/pictures/00_commons/ogc_25_25.png"/>" style="vertical-align:middle;" alt="OpenLayers icon"/>&nbsp;
							<s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>	
						</s:a>
						<div style="clear: both;"></div>
					</div>
					
					<%-- Building the map --%>
					<script defer="defer" type="text/javascript">
					<!--
						//getWMCData('<s:property value="#wmcUrl"/>');
					// -->
					</script>
					<s:set var="count" value="#count + 1"/>
				</s:if>
			</s:if>
			
			<s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI
						|| properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@KML.URI">
				<s:set var="otherLayersFound" value="true"/>
			</s:if>
		</s:iterator>
		
		
		<%-- Displaying WMS & KML --%>
		<s:if test="#otherLayersFound == true">
			<div id="otherLayers" style="margin:10px 5px 10px 5px;">
				<s:if test="#isDisplayWMC == true">
					<input type="radio" name="another_layersGroup" onclick="switchToIndividualLayersMode()" style="vertical-align:middle;" <s:if test="#count == 1">checked="checked"</s:if> />
				</s:if>
				Individual layers
			
				<s:merge id="mergedLayers">
					<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
					<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
					<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
					<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
					<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
				</s:merge>

				<s:iterator value="mergedLayers" status="state">
					<%-- This layer is a WMS --%>
					<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI) && (#isDisplayWMS == true)" >
						<div style="margin:10px 5px 10px 25px;">
							<input type="checkbox" name="another_layer" id="another_layer_<s:property value="#state.index"/>" onclick="displayOrHideAnotherIndividualLayer('another_layer_<s:property value="#state.index"/>')" style="vertical-align:middle;" <s:if test="(#count > 1) && (#isDisplayWMC == true)">disabled="disabled"</s:if> />
							<s:url id="url" action="ShowResource">
								<s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]" /></s:param>
							</s:url>
							<s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
								<img src="<s:url value="/webpages/pictures/00_commons/oo_25_25.png"/>" style="vertical-align:middle;" alt="OpenLayers icon"/>
								&nbsp;<s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>
							</s:a>
							<div style="clear: both;"></div>
						</div>
						<s:set var="count" value="#count + 1"/>
					</s:if>
					
					<%-- This layer is a KML --%>
					<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI) && (#isDisplayKML == true)">
						<div style="margin:10px 5px 10px 25px;">
							<input type="checkbox" name="another_layer" id="another_layer_<s:property value="#state.index"/>" onclick="displayOrHideAnotherIndividualLayer('another_layer_<s:property value="#state.index"/>')" style="vertical-align:middle;" <s:if test="(#count > 1) && (#isDisplayWMC == true)">disabled="disabled"</s:if> />
							<%-- Google Earth link (needs Google Earth to be installed on the user's computer) --%>
							<s:url id="url" action="GetFile" escapeAmp="false">
								<s:param name="filePath"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]"/></s:param>
							</s:url>
							<s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
								<img src="<s:url value="/webpages/pictures/00_commons/google_earth_25_25.gif"/>" style="vertical-align:middle;" alt="Google Earth icon"/>&nbsp;&nbsp;
							</s:a>
							<s:url id="url" action="ShowResource">
								<s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0]"/></s:param>
							</s:url>
							<s:a href="%{url}" cssStyle="height:50px;vertical-align:middle;">
								<s:property value="subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 100)"/>
							</s:a>
							<div style="clear: both;"></div>
						</div>
						<s:set var="count" value="#count + 1"/>
					</s:if>
				</s:iterator>
			</div>
			
		</s:if>

		<%-- No layer where found, wheter WMC nor WMS or KML, so displaying an alternate message --%>
		<s:if test="#count == 1">
			No layer found
		</s:if>
	</div>
	
</s:div>