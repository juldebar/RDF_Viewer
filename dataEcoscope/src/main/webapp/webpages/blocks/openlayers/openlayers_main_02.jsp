<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:div id="openlayers_main_02">
    
	<div id="map" style="width:380px;height:300px;"></div>
	
	<s:hidden name="geom" id="geom" />
	<s:hidden name="srid" id="srid" />
	
	<%--<s:checkbox name="draw" id="draw" label="Add a spatial criterium" onchange="javascript:manageCheckboxAction();" />--%>
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