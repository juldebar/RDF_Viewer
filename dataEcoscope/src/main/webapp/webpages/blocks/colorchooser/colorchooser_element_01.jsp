<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<%-- Choosing color according to the resource type --%>
<s:if test="matchType(properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource'], @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@abiotic_element.URI)" >
    <script defer="defer" type="text/javascript">
        <!--
        $(document).ready(function() {
            $("#div_central").css("background", "#d4e5dd url('webpages/pictures/11_backgrounds/bg_abiotic.png') no-repeat");
        });
        // -->
    </script>
</s:if>
<s:elseif test="matchType(properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource'], @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@biotic_element.URI)" >
    <script defer="defer" type="text/javascript">
        <!--
        $(document).ready(function() {
            $("#div_central").css("background", "#dceef1 url('webpages/pictures/11_backgrounds/bg_biotic.png') no-repeat");
        });
        // -->
    </script>
</s:elseif>
<s:elseif test="matchType(properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@indirectType]['resource'], @org.ird.crh.ecoscope.jena.vocabulary.ECOSYSTEMS_DEF@human_element.URI)" >
    <script defer="defer" type="text/javascript">
        <!--
        $(document).ready(function() {
            $("#div_central").css("background", "#f8f1d7 url('webpages/pictures/11_backgrounds/bg_anthrop.png') no-repeat");
        });
        // -->
    </script>
</s:elseif>

<%-- Defaulting to Ecoscope Blue --%>
<s:else>
    <script defer="defer" type="text/javascript">
        <!--
        $(document).ready(function() {
            $("#div_central").css("background-color", "#32758d");
        });
        // -->
    </script>
</s:else>