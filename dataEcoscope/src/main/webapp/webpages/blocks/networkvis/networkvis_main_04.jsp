<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<%-- Unescaped SPARQL query --%>
<%-- PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX owl: <http://www.w3.org/2002/07/owl#> CONSTRUCT { ?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type . ?type rdfs:subClassOf owl:Thing . ?type rdf:type owl:Class} WHERE {?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type} --%>

<div id="network_vis_04" style="background-color:white;min-height:300px;margin-bottom:10px;">
	<s:url id="ontologyUrl" action="GetOntologyAsGraphOrTreeML" escapeAmp="false"/>
	<s:url id="resourceUriPrefix" action="ShowResource" forceAddSchemeHostAndPort="true" escapeAmp="false" />
	
	<object codetype="application/java" classid="java:org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" archive="webpages/tools/prefuseSparql_20091210.jar" width="100%" height="500px">
		<param name="documentType" value="graph"/>
		<param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
		<param name="httpParameterName" value="resourceUri"/>
		<param name="mode" value="oneshot"/>
		<param name="recursiveRequest" value="false"/>
		<param name="queryString" value="PREFIX rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; PREFIX rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; PREFIX foaf: &lt;http://xmlns.com/foaf/0.1/&gt; PREFIX owl: &lt;http://www.w3.org/2002/07/owl#&gt; CONSTRUCT { ?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type . ?type rdfs:subClassOf owl:Thing . ?type rdf:type owl:Class} WHERE {?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type}"/>
		<param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
		<param name="visualizationName" value="radial"/>
		<param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
		<param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
		<param name="inferenceEngine" value="OWL_MEM"/>
		<param name="noResultLabel" value="<s:text name="networkvis.main.common.noResultLabel"/>"/>
		<param name="bgColor" value="50;117;141"/>
		<%--<param name="mayscript" value="yes"/>--%>
		<param name="scriptable" value="true"/>
		<!-- For Netscape -->
		<param name="name" value="jsapplet"/>
		
		<!-- For IE -->
		<applet <%--MAYSCRIPT--%> name="jsapplet" archive="<s:url forceAddSchemeHostAndPort="true" value="/webpages/tools/prefuseSparql_20091210.jar"/>" code="org.ird.crh.ecoscope.prefuse.applet.EcoPrefuseApplet" width="100%" height="500px">
			<param name="documentType" value="graph"/>
			<param name="documentUri" value="<s:property value="ontologyUrl"/>"/>
			<param name="httpParameterName" value="resourceUri"/>
			<param name="mode" value="oneshot"/>
			<param name="recursiveRequest" value="false"/>
			<param name="queryString" value="PREFIX rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; PREFIX rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; PREFIX foaf: &lt;http://xmlns.com/foaf/0.1/&gt; PREFIX owl: &lt;http://www.w3.org/2002/07/owl#&gt; CONSTRUCT { ?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type . ?type rdfs:subClassOf owl:Thing . ?type rdf:type owl:Class} WHERE {?sourceActor foaf:knows ?targetActor . ?sourceActor rdf:type ?type}"/>
			<param name="resourceUriPrefix" value="<s:property value="resourceUriPrefix"/>"/>
			<param name="visualizationName" value="radial"/>
			<param name="httpLocale" value="<s:property value="locale.getLanguage()"/>"/>
			<param name="rdfLocales" value="<s:property value="rdfLocales"/>"/>
			<param name="inferenceEngine" value="OWL_MEM"/>
			<param name="noResultLabel" value="<s:text name="networkvis.main.common.noResultLabel"/>"/>
			<param name="bgColor" value="255;255;255"/>
			Java isn't correctly configured on your computer.
		</applet>
	</object>
</div>