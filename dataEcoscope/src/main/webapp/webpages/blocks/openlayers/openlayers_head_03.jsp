<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:include value="/webpages/tools/openlayers/include_openlayers.jsp"/>

<style type="text/css">
    .olControlPanel div { 
      display:block;
      width:  18px;
      height: 18px;
      margin: 5px;
      background-color:red;
    }
    
    .olControlPanel .olControlMouseDefaultsItemActive {
      background-color: blue;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_pan_on.png");
    }
    .olControlPanel .olControlMouseDefaultsItemInactive {
      width:  18px;
      height: 18px;
      background-color: orange;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_pan_off.png");
    }
    .olControlPanel .olControlDrawFeatureItemActive {
      width:  18px;
      height: 18px;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_polygon_on.png");
    }
    .olControlPanel .olControlDrawFeatureItemInactive { 
      width:  18px;
      height: 18px;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_polygon_off.png");
    }
    .olControlPanel .olControlZoomBoxItemInactive { 
      width:  18px;
      height: 18px;
      background-color: orange;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_lens_off.png");
    }
    .olControlPanel .olControlZoomBoxItemActive { 
      width:  18px;
      height: 18px;
      background-color: blue;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_lens_on.png");
    }
    .olControlPanel .olControlZoomToMaxExtentItemInactive { 
      width:  18px;  
      height: 18px;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_max_extent.png");
    }
    .olControlPanel .resetButtonItemInactive { 
      width:  18px;  
      height: 18px;
      background-color:transparent;
      background-image: url("webpages/blocks/openlayers/00_icons/oo_cancel.png");
    }
</style>

<script defer="defer" type="text/javascript">
<!--
	var map, vectors;
	
	function init(){
		var options = {minResolution: "auto",
				minExtent: new OpenLayers.Bounds(-20, -10, 20, 10),
				maxResolution: "auto",
				maxExtent: new OpenLayers.Bounds(-180, -90, 180, 90), controls: [] /* Suppresses controls on the left */
		};
		
		map = new OpenLayers.Map('map', options);

		// -----------
		// Base layers
		// -----------

                var wms_osgeo = new OpenLayers.Layer.WMS( "OSGeo WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?", {layers: 'basic'} );
                map.addLayer(wms_osgeo);
                
		/*var wms_mtc = new OpenLayers.Layer.WMS("&#160;Metacarta (simple)", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'});
		map.addLayer(wms_mtc);

		var wms_lz_bmng_summer = new OpenLayers.Layer.WMS( "&#160;Lizardtech Blue Marble", "http://demo.lizardtech.com/lizardtech/iserv/ows",
				{layers: 'bmng.200410.topobathy', exceptions:"application/vnd.ogc.se_xml"},
				{tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
		map.addLayer(wms_lz_bmng_summer);*/
		
		//var wms_nasa_bmng = new OpenLayers.Layer.WMS( "&#160;NASA BM (slow)", "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=BMNG&styles=&srs=EPSG:4326&format=image/jpeg");
		//map.addLayer(wms_nasa_bmng);
		//var wms_nasa_modis = new OpenLayers.Layer.WMS( "&#160;NASA Modis (slow)",   "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=modis&styles=&srs=EPSG:4326&format=image/jpeg");
		//map.addLayer(wms_nasa_modis);
		
		//var wms_nasagm = new OpenLayers.Layer.WMS( "&#160;NASA Global Mosaic", "http://t1.hypercube.telascience.org/cgi-bin/landsat7", {layers: "landsat7"},{attribution:"Provided by Telascience"});
		//map.addLayer(wms_nasagm);
		//var wms_modis = new OpenLayers.Layer.WMS( "&#160;Modis", "http://nsidc.org/cgi-bin/atlas_north?", {layers: 'blue_marble_01', projection: new OpenLayers.Projection("EPSG:4326")});
		//map.addLayer(wms_modis);
		
		// ----------
		// Draw layer
		// ----------
		
		vectors = new OpenLayers.Layer.Vector("Vector", {isBaseLayer: false, displayInLayerSwitcher: false});
 		map.addLayer(vectors);
		
		polygonControl = new OpenLayers.Control.DrawFeature(vectors,
                                OpenLayers.Handler.Polygon,
                                {
                                    featureAdded: function(f) {
                                        document.getElementById('geom').value = f.geometry;
                                        document.getElementById('srid').value = vectors.projection.getCode().replace(/[a-zA-Z]*:/, '');
                                        polygonControl.deactivate();
                                        sendData();
                                        document.getElementById('geom').value = '';
                                        document.getElementById('srid').value = '';
                                    },
                                    title:'Draw a feature'
                                });
        
		// -------------------
		// Customizing the map
		// -------------------
		
		// Custom controls
		var zb = new OpenLayers.Control.ZoomBox( {title:"Zoom box: Selecting it you can zoom on an area by clicking and dragging."} );
		var pan = new OpenLayers.Control.MouseDefaults( {title:'You can use the default mouse configuration'} );
		var toMaxExtent = new OpenLayers.Control.ZoomToMaxExtent({title:"Zoom to the max extent"});
		var resetButton = new OpenLayers.Control.Button({
		    displayClass: "resetButton", trigger: destroyDraw
		});
		
        var panel = new OpenLayers.Control.Panel({defaultControl: polygonControl});
        panel.addControls([polygonControl, resetButton, pan, zb, toMaxExtent]);
        map.addControl(panel);

        // Standard controls
		map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':true}));
		//map.addControl(new OpenLayers.Control.PanZoomBar());
		//map.setCenter(new OpenLayers.LonLat(0, 0), 1);
		map.zoomToMaxExtent();
	}

	// -----------
	// Draw events
	// -----------
	
    function beginDrawing() {
        document.getElementById('geom').value = '';
        document.getElementById('srid').value = '';
        vectors.destroyFeatures();
        polygonControl.activate();
    }

    function destroyDraw() {
    	vectors.destroyFeatures();
    	polygonControl.activate();
    	document.getElementById('geom').value = '';
        document.getElementById('srid').value = '';
        sendData();
    }

    <s:url id="url" action="GetSearchResults">
    	<s:param name="forcedView">multi###graph</s:param>
    </s:url>
	
    function sendData() {
	    OpenLayers.Request.POST({
	        url: '<s:property value="#url" />',
	        data: OpenLayers.Util.getParameterString({
	            geom: document.getElementById('geom').value,
	            srid: document.getElementById('srid').value
	        }),
	        headers: {
	            "Content-Type": "application/x-www-form-urlencoded"
	        },
	        success: function(request) {
	            document.getElementById('media_1').style.display = 'block';
	            document.getElementById('media_1').innerHTML = ''; // necessary for IE7 to reload the applet just after it has been closed
	            document.getElementById('media_1').innerHTML = request.responseText;
	        },
	        failure: function(request) {
	            document.getElementById('msg').style.display = "block";
	            document.getElementById('msg').innerHTML = "The server is temporarily unavailable. Please try again later.";
	        }
	    });
	}
// -->
</script>