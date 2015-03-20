<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">
    <s:iterator value="results">
        <s:url id="pathtoopenlayer" action="GetFile" escapeAmp="false">
            <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
        </s:url>
        <div style="width:40px;height:40px;position: absolute;margin-top: -50px;right: 20px;">
            <a href="<s:property value="pathtoopenlayer"/>">
                <img style="display:block;" src="<s:url value="/webpages/pictures/00_commons/download.png"/>" alt="download file"/>
            </a>
        </div>
        <div id="mapa" class="span12" style='height: 300px;' path="<s:property value="pathtoopenlayer"/>">

        </div>
    </s:iterator>
    <script type="text/javascript">
        $(document).ready(function() {
//            var openlayerfile = $('#mapa').attr('path');
            //var map = new OpenLayers.Map("mapa");
//            var wms_osgeo = new OpenLayers.Layer.WMS("OSGeo WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?", {layers: 'basic'});
//            map.addLayer(wms_osgeo);

            var map = new OpenLayers.Map('mapa');
//            var layer = new OpenLayers.Layer.WMS("OpenLayers WMS",
//                    "http://vmap0.tiles.osgeo.org/wms/vmap0",
//                    {layers: 'basic'});
//            map.addLayer(layer);
//            map.zoomToMaxExtent();

            var openlayerfile = $('#mapa').attr('path');
            getWMCData(openlayerfile);



            function getWMCData(wmcUrl) {
                var format = new OpenLayers.Format.WMC({'layerOptions': {buffer: 0}});
                OpenLayers.Request.POST({
                    url: wmcUrl,
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    success: function(request) {
                        var text = request.responseText;
//                        alert(text);

                        try {
                            map.destroy();
                            var jsonFormat = new OpenLayers.Format.JSON();
                            var mapOptions = jsonFormat.read('{"div": "mapa", "allOverlays": true}');
                            map = format.read(text, {map: mapOptions});
                            map.addControl(new OpenLayers.Control.LayerSwitcher());
                        } catch (err) {
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
        });


    </script>
</s:i18n>




