<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%-- Tuning this view --%>
<%-- Which types of layers do we want to display ? --%>
<s:set var="isDisplayWMC" value="true" />
<s:set var="isDisplayKML" value="true" />
<s:set var="isDisplayWMS" value="true" />

<s:include value="/webpages/tools/openlayers/include_openlayers.jsp"/>

<%-- Here add optional Google, Bing & Yahoo! declarations --%>

<%-- Initializing the map --%>
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
			var dynamic_layer_<s:property value="#state.index"/>;
		</s:if>
	</s:iterator>
	
	function init() {
		map = new OpenLayers.Map('map');

		<%-- Managing the first WMC --%>
		<s:set var="WMCFound" value="false"/>
		<s:if test="#isDisplayWMC == true">
			<s:merge id="mergedLayers">
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
			</s:merge>

			<s:iterator value="mergedLayers">
				<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMC.URI) && (#WMCFound == false)" >
					<s:url id="wmcUrl" action="GetFile" escapeAmp="false" >
						<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
					</s:url>
					getWMCData('<s:property value="#wmcUrl" />');
					<s:set var="WMCFound" value="true"/>
				</s:if>
			</s:iterator>
		</s:if>
		
		<s:if test="#WMCFound == false">
			switchToIndividualLayersMode();
		</s:if>
	}
	
	// Rebuild map from individual layers after being destroyed by the WMC
	function switchToIndividualLayersMode() {
		// Managing radios & checkboxes
		var elem = document.getElementsByName("layer");
		enableRadioOrChecboxesGroup(elem);
		
		// Managing checkboxes of 'another layer'
		var elem = document.getElementsByName("another_layer");
		for (var i=0; i<elem.length; i++) elem[i].checked = false;
		
		map.destroy();
		
		var options = {minResolution: "auto",
				minExtent: new OpenLayers.Bounds(-5, -2.5, 5, 2.5),
				maxResolution: "auto",
				maxExtent: new OpenLayers.Bounds(-180, -90, 180, 90)
		};
		map = new OpenLayers.Map('map', options);
		
                var wms_osgeo = new OpenLayers.Layer.WMS( "OSGeo WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?", {layers: 'basic'} );
                map.addLayer(wms_osgeo);
                
		/*var wms_lz_bmng_winter = new OpenLayers.Layer.WMS( "&#160;Lizardtech BM (january)", "http://demo.lizardtech.com/lizardtech/iserv/ows",
				{layers: 'bmng.200401.topobathy', exceptions:"application/vnd.ogc.se_xml"},
				{tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
		map.addLayer(wms_lz_bmng_winter);
		
		var wms_mtc = new OpenLayers.Layer.WMS("&#160;Metacarta (simple)", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'});
		map.addLayer(wms_mtc);*/
		
		//map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':true}));
		map.setCenter(new OpenLayers.LonLat(0, 0), 1);
	}
	
	// Add/remove an individual layer
	function displayOrHideIndividualLayer(elemId) {
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
	
				if (elemId == 'layer_<s:property value="#state.index"/>') {
					var elem = document.getElementById(elemId);
					
					if (elem.checked == false) {
						if(!(typeof(dynamic_layer_<s:property value="#state.index"/>)=='undefined')) {
							map.removeLayer(dynamic_layer_<s:property value="#state.index"/>);
							//dynamic_layer_<s:property value="#state.index"/>.destroy();
						}
					} else {
						dynamic_layer_<s:property value="#state.index"/> = new OpenLayers.Layer.WMS("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 50)}"/>", "<s:url escapeAmp="false" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/>");
						
						dynamic_layer_<s:property value="#state.index"/>.setVisibility(true);
						dynamic_layer_<s:property value="#state.index"/>.setIsBaseLayer(false);
						map.addLayer(dynamic_layer_<s:property value="#state.index"/>);
					}
				}

				<s:set var="count" value="#count + 1"/>
			</s:if>
			
			<%-- This layer is a KML --%>
			<s:if test="(properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI) && (#isDisplayKML == true)">
				
				if (elemId == 'layer_<s:property value="#state.index"/>') {			
					var elem = document.getElementById(elemId);
					
					if (elem.checked == false) {
						if(!(typeof(dynamic_layer_<s:property value="#state.index"/>)=='undefined')) {
							map.removeLayer(dynamic_layer_<s:property value="#state.index"/>);
							//dynamic_layer_<s:property value="#state.index"/>.destroy();
						}
					} else {
						<s:url id="kmlUrl" action="GetFile" escapeAmp="false" >
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
						</s:url>
						dynamic_layer_<s:property value="#state.index"/> = new OpenLayers.Layer.GML("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 26)}"/>", "<s:property value="kmlUrl" />"
						,{
				      		format: OpenLayers.Format.KML, 
				           	formatOptions: {
								extractStyles: true,
								extractAttributes: true
				        	}
				    	});
						
						dynamic_layer_<s:property value="#state.index"/>.setVisibility(true);
						dynamic_layer_<s:property value="#state.index"/>.setIsBaseLayer(false);
						map.addLayer(dynamic_layer_<s:property value="#state.index"/>);
						// Adding bubbles for KML
						/*selectControl_<s:property value="#state.index"/> = new OpenLayers.Control.SelectFeature(dynamic_layer_<s:property value="#count"/>, {onSelect: onFeatureSelect, onUnselect: onFeatureUnselect});
				        map.addControl(selectControl_<s:property value="#state.index"/>);
				        selectControl_<s:property value="#state.index"/>.activate();*/
					}
				}
			
				<s:set var="count" value="#count + 1"/>
			</s:if>
		</s:iterator>
	}
	
	// AJAX function for WMC retrieval
	function getWMCData(wmcUrl) {
		// Managing radios & checkboxes
		var elem = document.getElementsByName("layer");
		for (var i=0; i<elem.length; i++) elem[i].checked = false;
		disableRadioOrChecboxesGroup(elem);
		
		// Managing checkboxes of 'another layer'
		var elem = document.getElementsByName("another_layer");
		for (var i=0; i<elem.length; i++) elem[i].checked = false;
		
		var format = new OpenLayers.Format.WMC({'layerOptions': {buffer: 0}});
		
	    OpenLayers.Request.POST({
	        url: wmcUrl,
	        headers: {
	            "Content-Type": "application/x-www-form-urlencoded"
	        },
	        success: function(request) {
	        	var text = request.responseText;

	            try {
	            	map.destroy();
	            	var jsonFormat = new OpenLayers.Format.JSON();
	                var mapOptions = jsonFormat.read('{"div": "map", "allOverlays": true}');
	                map = format.read(text, {map: mapOptions});
	                //map.addControl(new OpenLayers.Control.LayerSwitcher());
	            } catch(err) {
	                //document.getElementById("error").value = err;
	            	//alert(err);
	            }
	        },
	        failure: function(request) {
	            document.getElementById('msg').style.display = "block";
	            document.getElementById('msg').innerHTML = "The server is temporarily unavailable. Please try again later.";
	        }
	    });
	}

	// Bubbles functions
	function onFeatureSelect(feature) {
        selectedFeature = feature;
        popup = new OpenLayers.Popup.FramedCloud("chicken", 
                                 feature.geometry.getBounds().getCenterLonLat(),
                                 new OpenLayers.Size(100,100),
                                 "<div style=\"margin-right:50px;\" class=\"contributorName\">"+feature.attributes.name + "</div>" + feature.attributes.description,
                                 null, true, onPopupClose);
        feature.popup = popup;
        map.addPopup(popup);
    }
    function onFeatureUnselect(feature) {
        map.removePopup(feature.popup);
    }
    function onPopupClose(evt) {
        onFeatureUnselect(selectedFeature);
    }
    
    // Javascript general functions
    function enableRadioOrChecboxesGroup(elem) {
		var length = elem.length;
		for (var i=0; i<length; i++) {
			elem[i].disabled = false;
		}
	}
	
	function disableRadioOrChecboxesGroup(elem) {
		var length = elem.length;
		for (var i=0; i<length; i++) {
			elem[i].disabled = true;
		}
	}

// -->
</script>
				
<s:if test="#count == 1">
	<script defer="defer" type="text/javascript">
		var openlayers = false;
	</script>
</s:if>
<s:else>
	<script defer="defer" type="text/javascript">
		var openlayers = true;
	</script>
</s:else>