<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:include value="/webpages/tools/openlayers/include_openlayers.jsp"/>

<!-- Here add optional Google, Bing & Yahoo! declarations -->


<script defer="defer" type="text/javascript">
// increase reload attempts 
OpenLayers.IMAGE_RELOAD_ATTEMPTS = 2;

var format = new OpenLayers.Format.WMC({'layerOptions': {buffer: 0}});
var doc, context, map;

function init() {
    var options = {
        maxExtent: new OpenLayers.Bounds(-130, 14, -60, 55)
    };
    map = new OpenLayers.Map("map", options);

    var jpl = new OpenLayers.Layer.WMS(
        "NASA Global Mosaic",
        "http://t1.hypercube.telascience.org/cgi-bin/landsat7", 
        {layers: "landsat7"},
        {
            maxExtent: new OpenLayers.Bounds(-130, 14, -60, 55),
            maxResolution: 0.1,
            numZoomLevels: 4,
            minResolution: 0.02
        }
    );

    map.addLayers([jpl]);
    map.addControl(new OpenLayers.Control.LayerSwitcher());
    map.setCenter(new OpenLayers.LonLat(-95, 34.5), 1);

    getWMCData();
};

function getWMCData() {
	map.destroy();
    OpenLayers.Request.POST({
        url: 'http://localhost:8079/EcoscopeKB/webpages/tools/wmc_alepisaurus_ferox.cml',
        /*data: OpenLayers.Util.getParameterString({
            geom: document.getElementById('geom').value,
            srid: document.getElementById('srid').value
        }),*/
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        success: function(request) {
        	var text = request.responseText;
            
            try {
            	var jsonFormat = new OpenLayers.Format.JSON();
                var mapOptions = jsonFormat.read('{"div": "map", "allOverlays": true}');
                map = format.read(text, {map: mapOptions});
                map.addControl(new OpenLayers.Control.LayerSwitcher());
            } catch(err) {
                document.getElementById("error").value = err;
            }
        },
        failure: function(request) {
            document.getElementById('msg').style.display = "block";
            document.getElementById('msg').innerHTML = "The server is temporarily unavailable. Please try again later.";
        }
    });
}


function readWMC(merge) {
    var text = document.getElementById("wmc").value;
    
    if(merge) {
        try {
            map = format.read(text, {map: map});
        } catch(err) {
            document.getElementById("wmc").value = err;
        }
    } else {
        map.destroy();
        try {
            var jsonFormat = new OpenLayers.Format.JSON();
            var mapOptions = jsonFormat.read(OpenLayers.Util.getElement('mapOptions').value);
            map = format.read(text, {map: mapOptions});
            map.addControl(new OpenLayers.Control.LayerSwitcher());
        } catch(err) {
            document.getElementById("wmc").value = err;
        }
    }
}

function writeWMC(merge) {
    try {
        var text = format.write(map);
        document.getElementById("wmc").value = text;
    } catch(err) {
        document.getElementById("wmc").value = err;
    }
}

// -->
</script>
