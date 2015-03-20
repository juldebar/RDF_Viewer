<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%-- Tuning this view --%>
<%-- Which types of layers do we want to display ? --%>
<s:set var="isDisplayOnlyWMCIfExists" value="true" />	<%-- GBIF layers are independent from this flag --%>
<s:set var="isDisplayWMC" value="true" />
<s:set var="isDisplayKML" value="true" />
<s:set var="isDisplayWMS" value="true" />
<s:set var="isDisplayGBIF" value="true" />

<s:include value="/webpages/tools/openlayers/include_openlayers.jsp"/>

<%-- Here add optional Google, Bing & Yahoo! declarations --%>

<%--Merged layers from the ontology --%>
<s:merge id="mergedLayers">
	<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
	<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
	<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
	<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
	<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
	<s:param value="#{'preferred':#p}" />
</s:merge>

<%-- Initializing the map --%>
<script defer="defer" type="text/javascript">
<!--
	var map;

	function init(){	
		var options = {minResolution: "auto",
				minExtent: new OpenLayers.Bounds(-5, -2.5, 5, 2.5),
				maxResolution: "auto",
				maxExtent: new OpenLayers.Bounds(-180, -90, 180, 90)
		};
		
		map = new OpenLayers.Map('map', options);

		/*var wms_lz_bmng_winter = new OpenLayers.Layer.WMS( "&#160;Lizardtech BM (january)", "http://demo.lizardtech.com/lizardtech/iserv/ows",
				{layers: 'bmng.200401.topobathy', exceptions:"application/vnd.ogc.se_xml"},
				{tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
		map.addLayer(wms_lz_bmng_winter);*/

		//var wms_lz_bmng_summer = new OpenLayers.Layer.WMS( "&#160;Lizardtech BM (october)", "http://demo.lizardtech.com/lizardtech/iserv/ows",
		//		{layers: 'bmng.200410.topobathy', exceptions:"application/vnd.ogc.se_xml"},
		//		{tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
		//map.addLayer(wms_lz_bmng_summer);
		
		//var wms_mtc = new OpenLayers.Layer.WMS("&#160;Metacarta (simple)", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'});
		//map.addLayer(wms_mtc);
                
                var wms_osgeo = new OpenLayers.Layer.WMS( "OSGeo WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?", {layers: 'basic'} );
                map.addLayer(wms_osgeo);

		//var wms_nasa_bmng = new OpenLayers.Layer.WMS( "&#160;NASA BM (slow)", "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=BMNG&styles=&srs=EPSG:4326&format=image/jpeg");
		//map.addLayer(wms_nasa_bmng);
		//var wms_nasa_modis = new OpenLayers.Layer.WMS( "&#160;NASA Modis (slow)",   "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=modis&styles=&srs=EPSG:4326&format=image/jpeg");
		//map.addLayer(wms_nasa_modis);
		//var wms_nasagm = new OpenLayers.Layer.WMS( "&#160;NASA Global Mosaic", "http://t1.hypercube.telascience.org/cgi-bin/landsat7", {layers: "landsat7"},{attribution:"Provided by Telascience"});
		//map.addLayer(wms_nasagm);
		//var wms_modis = new OpenLayers.Layer.WMS( "&#160;Modis", "http://nsidc.org/cgi-bin/atlas_north?", {layers: 'blue_marble_01', projection: new OpenLayers.Projection("EPSG:4326")});
		//map.addLayer(wms_modis);

		<s:set var="count" value="1"/>
		<s:iterator value="mergedLayers">
			<s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0">
				<s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMS.URI" >
					<s:if test="#isDisplayWMS == true">
						var dynamic_layer_<s:property value="#count"/> = new OpenLayers.Layer.WMS("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 26)}"/>", "<s:url escapeAmp="false" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/>");
	
						<s:if test="#count < 3">
							dynamic_layer_<s:property value="#count"/>.setVisibility(true);
						</s:if>
						<s:else>
							dynamic_layer_<s:property value="#count"/>.setVisibility(false);
						</s:else>
						dynamic_layer_<s:property value="#count"/>.setIsBaseLayer(false);
						// Adding layer
						map.addLayer(dynamic_layer_<s:property value="#count"/>);
	
						// TODO - Adding bubbles for WMS
						
						<s:set var="count" value="#count + 1"/>
					</s:if>
		        </s:if>

		        <s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@geometryKML.URI" >
		        	<s:if test="#isDisplayKML == true">
			        	<s:url id="kmlUrl" action="GetFile" escapeAmp="false" >
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
						</s:url>
						var dynamic_layer_<s:property value="#count"/> = new OpenLayers.Layer.GML("&#160;<s:property value="%{subText(properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0], 26)}"/>", "<s:property value="kmlUrl" />"
						,{
			          		format: OpenLayers.Format.KML, 
			               	formatOptions: {
								extractStyles: true,
								extractAttributes: true
			            	}
			        	});
			        	
						<s:if test="#count < 3">
							dynamic_layer_<s:property value="#count"/>.setVisibility(true);
						</s:if>
						<s:else>
							dynamic_layer_<s:property value="#count"/>.setVisibility(false);
						</s:else>
						
						dynamic_layer_<s:property value="#count"/>.setIsBaseLayer(false);
						
						// Adding layer
						map.addLayer(dynamic_layer_<s:property value="#count"/>);
						
						// Adding bubbles for KML
			    		selectControl_<s:property value="#count"/> = new OpenLayers.Control.SelectFeature(dynamic_layer_<s:property value="#count"/>, {onSelect: onFeatureSelect, onUnselect: onFeatureUnselect});
			            map.addControl(selectControl_<s:property value="#count"/>);
			            selectControl_<s:property value="#count"/>.activate();
	
			            <s:set var="count" value="#count + 1"/>
					</s:if>
		        </s:if>
	    	</s:if>
		</s:iterator>
		
		addGBIFLayers();

		map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':true}));
		//map.addControl(new OpenLayers.Control.MousePosition());
		//map.addControl(new OpenLayers.Control.OverviewMap());	//Doesn't work correctly with Yahoo & Google
		//map.addControl(new OpenLayers.Control.ScaleLine());
		//map.addControl(new OpenLayers.Control.PanZoomBar());
		map.setCenter(new OpenLayers.LonLat(0, 0), 1);
		//map.zoomToMaxExtent();
		//map.zoomToExtent(new OpenLayers.Bounds(-112.306698,36.017792,-112.03204,36.18087));
		
		
		<%-- Managing WMC --%>
		<s:if test="#isDisplayWMC == true">
			<s:merge id="mergedLayers">
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@prefGeoGraphicObject]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@altGeoGraphicObject]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@relatedLayer]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@part_of_layer]['resource']}" />
				<s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']}" />
				<s:param value="#{'preferred':#p}" />
			</s:merge>
			
			<s:iterator value="mergedLayers">
				<s:if test="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'].size > 0">
					<s:if test="properties[@com.hp.hpl.jena.vocabulary.RDF@type]['resource'][0].object == @org.ird.crh.ecoscope.jena.vocabulary.GEOGRAPHIC_OBJECTS_DEF@WMC.URI" >
						<s:url id="wmcUrl" action="GetFile" escapeAmp="false" >
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
						</s:url>
						getWMCData('<s:property value="wmcUrl" />');
					</s:if>
		    	</s:if>
			</s:iterator>
		</s:if>
	}
	
	// GBIF layers
	function addGBIFLayers() {
		<s:if test="#isDisplayGBIF == true">
			<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@gbifId]['preferred']">
				var dynamic_layer_<s:property value="#count"/> = new OpenLayers.Layer.WMS(
					'GBIF',
					'http://geoserver.gbif.org/wms?', 
					{
						layers: 'gbif:gbifDensityLayer', 
						version: '1.0.0', 
						transparent: 'true', 
						format: 'image/png', 
						filter:'<Filter><And><PropertyIsEqualTo><PropertyName>type</PropertyName><Literal>1</Literal></PropertyIsEqualTo><PropertyIsEqualTo><PropertyName>concept</PropertyName><Literal><s:property /></Literal></PropertyIsEqualTo></And></Filter>'
					}
				);
				
				map.addLayer(dynamic_layer_<s:property value="#count"/>);
				<s:if test="#count < 3">
					dynamic_layer_<s:property value="#count"/>.setVisibility(true);
				</s:if>
				<s:else>
					dynamic_layer_<s:property value="#count"/>.setVisibility(false);
				</s:else>
			
				<s:set var="count" value="#count + 1"/>
			</s:iterator>
		</s:if>
	}
	
	// AJAX function for WMC retrieval
	function getWMCData(wmcUrl) {
		var format = new OpenLayers.Format.WMC({'layerOptions': {buffer: 0}});
		
	    OpenLayers.Request.POST({
	        url: wmcUrl,
	        headers: {
	            "Content-Type": "application/x-www-form-urlencoded"
	        },
	        success: function(request) {
	        	var text = request.responseText;

	        	<s:if test="#isDisplayOnlyWMCIfExists == false">
	                try {
	                    map = format.read(text, {map: map});
	                } catch(err) {
	                    //document.getElementById("wmc").value = err;
	                    //alert(err);
	                }
	            </s:if>
	            <s:else>
		            try {
		            	map.destroy();
		            	var jsonFormat = new OpenLayers.Format.JSON();
		                var mapOptions = jsonFormat.read('{"div": "map", "allOverlays": true}');
		                map = format.read(text, {map: mapOptions});
		                addGBIFLayers();
		                map.addControl(new OpenLayers.Control.LayerSwitcher());
		            } catch(err) {
		                //document.getElementById("error").value = err;
		            	//alert(err);
		            }
	            </s:else>
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