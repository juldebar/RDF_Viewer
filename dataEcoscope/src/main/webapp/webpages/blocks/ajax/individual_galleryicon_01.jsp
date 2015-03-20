<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:url id="url" action="ShowResource">
    <s:param name="resourceUri"><s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].object" /></s:param>
</s:url>

<s:a href="%{url}">
	<%--<img alt="<s:text name="individual.galleryIcon.noIcon"/>" src="<s:url value="%{getPictureUrlForSize(properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource'][0].properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0], 'xxs')}" />" />--%>
	<s:url id="picUrl" action="GetFile" escapeAmp="false">
		<s:param name="filePath"><s:property value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource'][0].properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
		<s:param name="picSize">125x125</s:param>
	</s:url>
	<img alt="<s:text name="individual.galleryIcon.noIcon"/>" src="<s:property value="picUrl"/>" />
</s:a>