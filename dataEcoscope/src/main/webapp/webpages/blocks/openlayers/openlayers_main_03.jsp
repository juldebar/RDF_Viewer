<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:div id="openlayers_main_02">

	<s:div id="map" cssStyle="width:224px;height:150px;"></s:div>
	
	<s:hidden name="geom" id="geom" />
	<s:hidden name="srid" id="srid" />
	
	<script defer="defer" type="text/javascript">
	<!--
		function manageCheckboxAction(){
			checkbox = document.getElementById('draw');

			if (checkbox.checked) beginDrawing();
			else destroyDraw();
		}
	// -->
	</script>
</s:div>