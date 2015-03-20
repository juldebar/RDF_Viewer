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

        position:absolute;
        left:12px;
    }

    .olControlPanel .olControlNavigationItemActive {
        background-color: blue;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_pan_on.png");
        /*custom position*/
        top:230px;
    }
    .olControlPanel .olControlNavigationItemInactive {
        width:  18px;
        height: 18px;
        background-color: orange;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_pan_off.png");
        /*custom position*/
        top:230px;
    }
    .olControlPanel .olControlDrawFeatureItemActive {
        width:  18px;
        height: 18px;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_polygon_on.png");
        top:180px;
    }
    .olControlPanel .olControlDrawFeatureItemInactive { 
        width:  18px;
        height: 18px;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_polygon_off.png");
        top:180px;
    }
    .olControlPanel .olControlZoomBoxItemInactive { 
        width:  18px;
        height: 18px;
        background-color: orange;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_lens_off.png");
        top:255px;
    }
    .olControlPanel .olControlZoomBoxItemActive { 
        width:  18px;
        height: 18px;
        background-color: blue;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_lens_on.png");
        top:255px;
    }
    /*  .olControlPanel .olControlZoomToMaxExtentItemInactive { 
          width:  18px;  
          height: 18px;
          background-image: url("webpages/blocks/openlayers/00_icons/oo_max_extent.png");
          top:255px;
        }*/
    .olControlPanel .resetButtonItemInactive { 
        width:  18px;  
        height: 18px;
        background-color:transparent;
        background-image: url("webpages/blocks/openlayers/00_icons/oo_cancel.png");
        top:205px;
    }
</style>

<script defer="defer" type="text/javascript">
    <!--
    var map, vectors;
	
    function init(){

        // Map initialization
		
        var options = {minResolution: "auto",
            minExtent: new OpenLayers.Bounds(-20, -10, 20, 10),
            maxResolution: "auto",
            maxExtent: new OpenLayers.Bounds(-180, -90, 180, 90)
        };
		
        map = new OpenLayers.Map('map', options);

        // Base layers
		
        var wms_osgeo = new OpenLayers.Layer.WMS( "OSGeo WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?", {layers: 'basic'} );
        map.addLayer(wms_osgeo);
                
        /*var wms_lz_bmng_summer = new OpenLayers.Layer.WMS( "&#160;Lizardtech Blue Marble", "http://demo.lizardtech.com/lizardtech/iserv/ows",
                                {layers: 'bmng.200410.topobathy', exceptions:"application/vnd.ogc.se_xml"},
                                {tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
                map.addLayer(wms_lz_bmng_summer);*/

        //var wms_mtc = new OpenLayers.Layer.WMS("&#160;Metacarta (simple)", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'});
        //map.addLayer(wms_mtc);

        //var wms_nasa_bmng = new OpenLayers.Layer.WMS( "&#160;NASA BM (slow)", "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=BMNG&styles=&srs=EPSG:4326&format=image/jpeg");
        //map.addLayer(wms_nasa_bmng);
                
        //var wms_nasa_modis = new OpenLayers.Layer.WMS( "&#160;NASA Modis (slow)",   "http://onearth.jpl.nasa.gov/wms.cgi?request=GetMap&width=512&height=512&layers=modis&styles=&srs=EPSG:4326&format=image/jpeg");
        //map.addLayer(wms_nasa_modis);
		
        //var wms_nasagm = new OpenLayers.Layer.WMS( "&#160;NASA Global Mosaic", "http://t1.hypercube.telascience.org/cgi-bin/landsat7", {layers: "landsat7"},{attribution:"Provided by Telascience"});
        //map.addLayer(wms_nasagm);
        //var wms_modis = new OpenLayers.Layer.WMS( "&#160;Modis", "http://nsidc.org/cgi-bin/atlas_north?", {layers: 'blue_marble_01', projection: new OpenLayers.Projection("EPSG:4326")});
        //map.addLayer(wms_modis);

        // Draw layer
		
        vectors = new OpenLayers.Layer.Vector("Vector", {isBaseLayer: false, displayInLayerSwitcher: false});
        map.addLayer(vectors);
        
        polygonControl = new OpenLayers.Control.DrawFeature(vectors,
        OpenLayers.Handler.Polygon,
        {
            featureAdded: function(f) {
                document.getElementById('geom').value = f.geometry;
                document.getElementById('srid').value = vectors.projection.getCode().replace(/[a-zA-Z]*:/, '');
                polygonControl.deactivate();
            }
        });
        // map.addControl(polygonControl);

        	
        // Customizing the map
		
        // Custom controls
        var zb = new OpenLayers.Control.ZoomBox( {title:"Zoom box: Selecting it you can zoom on an area by clicking and dragging."} );
        var mouseDefaults = new OpenLayers.Control.Navigation( {title:'You can use the default mouse configuration'} );
        //var toMaxExtent = new OpenLayers.Control.ZoomToMaxExtent({title:"Zoom to the max extent"});
        var resetButton = new OpenLayers.Control.Button({
            displayClass: "resetButton", trigger: destroyDraw
        });
		
        var panel = new OpenLayers.Control.Panel({defaultControl: polygonControl});
        panel.addControls([polygonControl, resetButton, mouseDefaults, zb]);
        map.addControl(panel);

        
        map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':true}));
        //map.addControl(new OpenLayers.Control.MousePosition());
        //map.addControl(new OpenLayers.Control.OverviewMap());	//Doesn't work correctly with Yahoo & Google
        //map.addControl(new OpenLayers.Control.ScaleLine());
        //map.addControl(new OpenLayers.Control.PanZoomBar());
        map.setCenter(new OpenLayers.LonLat(0, 0), 1);
        //map.zoomToMaxExtent();
        //map.zoomToExtent(new OpenLayers.Bounds(-112.306698,36.017792,-112.03204,36.18087));
    }

    // Draw events
	
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
    }

    /*function sendData() {
        document.getElementById('msg').style.display = "none";
        OpenLayers.Request.POST({
            url: 'insert.php',
            data: OpenLayers.Util.getParameterString({
                nom: document.getElementById('nom').value,
                geom: document.getElementById('geom').value,
                srid: document.getElementById('srid').value,
            }),
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            success: function(request) {
                document.getElementById('msg').style.display = "block";
                document.getElementById('msg').innerHTML = request.responseText;
            },
            failure: function(request) {
                document.getElementById('msg').style.display = "block";
                document.getElementById('msg').innerHTML = "Impossible d'envoyer les données";
            }
        });
    }*/


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