<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:include value="/webpages/tools/openlayers/include_openlayers.jsp"/>

<!-- Here add optional Google, Bing & Yahoo! declarations -->

<script defer="defer" type="text/javascript">
    <!--
    var map;

    function init() {
        var options = {minResolution: "auto",
            minExtent: new OpenLayers.Bounds(-5, -2.5, 5, 2.5),
            maxResolution: "auto",
            maxExtent: new OpenLayers.Bounds(-180, -90, 180, 90)
        };
		
        map = new OpenLayers.Map('map', options);
		
        /*var wms_lz_bmng_winter = new OpenLayers.Layer.WMS( "&#160;Lizardtech BM (january)", "http://demo.lizardtech.com/lizardtech/iserv/ows",
                                {layers: 'bmng.200401.topobathy', exceptions:'application/vnd.ogc.se_xml'},
                                {tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
                map.addLayer(wms_lz_bmng_winter);*/
		
        var wms_demis_topo = new OpenLayers.Layer.WMS( "&#160;Demis topo",
        "http://www2.demis.nl/wms/wms.asp",
        {wms: 'WorldMap', layers: 'Topography', exceptions: 'inimage', format: 'image/gif', srs: 'epsg:4326', transparent: 'true', service: 'wms', version: '1.1.1'},
        {tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
        map.addLayer(wms_demis_topo);
		
        var wms_demis_bathy = new OpenLayers.Layer.WMS( "&#160;Demis bathy",
        "http://www2.demis.nl/wms/wms.asp",
        {wms: 'WorldMap', layers: 'Bathymetry', exceptions: 'inimage', format: 'image/gif', srs: 'epsg:4326', transparent: 'false', service: 'wms', version: '1.1.1'},
        {tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
        map.addLayer(wms_demis_bathy);
		
        /*
        var wms_lz_bmng_summer = new OpenLayers.Layer.WMS( "&#160;Lizardtech BM (october)", "http://demo.lizardtech.com/lizardtech/iserv/ows",
                        {layers: 'bmng.200410.topobathy', exceptions:"application/vnd.ogc.se_xml"},
                        {tileSize: new OpenLayers.Size(256,256), buffer: 1 } );
        map.addLayer(wms_lz_bmng_summer);

        var wms_mtc = new OpenLayers.Layer.WMS("&#160;Metacarta (simple)", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'});
        map.addLayer(wms_mtc);*/
		
    		
            map.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':true}));
            //map.addControl(new OpenLayers.Control.MousePosition());
            //map.addControl(new OpenLayers.Control.OverviewMap());	//Doesn't work correctly with Yahoo & Google
            //map.addControl(new OpenLayers.Control.ScaleLine());
            //map.addControl(new OpenLayers.Control.PanZoomBar());
            map.setCenter(new OpenLayers.LonLat(0, 0), 1);
            //map.zoomToMaxExtent();

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
            feature.popup.destroy();
            feature.popup = null;
        }
        function onPopupClose(evt) {
            onFeatureUnselect(selectedFeature);
        }
        // -->
</script>