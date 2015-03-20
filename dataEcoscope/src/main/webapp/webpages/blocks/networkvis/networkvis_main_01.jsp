<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Unescaped SPARQL query --%>
<%-- PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> CONSTRUCT {<<s:property value="resourceUri"/>> ?p ?o . ?o rdf:type ?type . ?type rdf:type <http://www.w3.org/2002/07/owl#Class>} WHERE{<<s:property value="resourceUri"/>> ?p ?o . ?o rdf:type ?type} --%>

<sj:div id="network_vis_01" cssStyle="background-color:white; padding:10px;" cssClass="kb-corner-radius-c1">
    <s:url id="ontologyUrl" action="GetOntologyAsGraphOrTreeML" escapeAmp="false"/>
    <s:url id="resourceUriPrefix" action="ShowResource" forceAddSchemeHostAndPort="true" escapeAmp="false" />

    <object codetype="application/java" classid="java:org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" archive="webpages/tools/prefuseSparql_20091210.jar" width="360" height="280">
        <param name="documentType" value="graph"/>
        <param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
        <param name="httpParameterName" value="resourceUri"/>
        <param name="mode" value="oneshot"/>
        <param name="recursiveRequest" value="false"/>
        <param name="queryString" value="PREFIX rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; PREFIX rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; CONSTRUCT {&lt;<s:property value="resourceUri"/>&gt; ?p ?o . ?o rdf:type ?type . ?type rdf:type &lt;http://www.w3.org/2002/07/owl#Class&gt;} WHERE{&lt;<s:property value="resourceUri"/>&gt; ?p ?o . ?o rdf:type ?type}"/>
        <param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
        <param name="visualizationName" value="radial"/>
        <param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
        <param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
        <param name="inferenceEngine" value="OWL_MEM"/>
        <param name="noResultLabel" value="<s:text name="networkvis.main.common.noResultLabel"/>"/>
        <param name="bgColor" value="255;255;255"/>
        <%--<param name="mayscript" value="yes"/>--%>
        <param name="scriptable" value="true"/>
        <%-- For Netscape --%>
        <param name="name" value="jsapplet"/>

        <%-- For IE --%>
        <applet <%--MAYSCRIPT--%> name="jsapplet" archive="<s:url forceAddSchemeHostAndPort="true" value="/webpages/tools/prefuseSparql_20091210.jar"/>" code="org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" width="380" height="300px">
            <param name="documentType" value="graph"/>
            <param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
            <param name="httpParameterName" value="resourceUri"/>
            <param name="mode" value="oneshot"/>
            <param name="recursiveRequest" value="false"/>
            <param name="queryString" value="PREFIX rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; PREFIX rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; CONSTRUCT {&lt;<s:property value="resourceUri"/>&gt; ?p ?o . ?o rdf:type ?type . ?type rdf:type &lt;http://www.w3.org/2002/07/owl#Class&gt;} WHERE{&lt;<s:property value="resourceUri"/>&gt; ?p ?o . ?o rdf:type ?type}"/>
            <param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
            <param name="visualizationName" value="radial"/>
            <param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
            <param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
            <param name="inferenceEngine" value="OWL_MEM"/>
            <param name="noResultLabel" value="<s:text name="networkvis.main.common.noResultLabel"/>"/>
            <param name="bgColor" value="255;255;255"/>
            Java isn't correctly configured on your computer
        </applet>
    </object>

    <script defer="defer" type="text/javascript">
        var networkvis = true;
    </script>
</sj:div>