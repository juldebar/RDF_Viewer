<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.views.address_book">
	<s:set var="found" value="false" />
	<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF_EXT@funds]['resource']" >
		<s:set var="found" value="true" />
		
		<s:url id="url" action="ShowResource">
			<s:param name="resourceUri"><s:property/></s:param>
		</s:url>
		<s:a href="%{url}" >
			<s:property value="preferredLabel"/>
		</s:a>
		
		<br/>
	</s:iterator>
	
	<s:if test="#found == false">
		<span><s:text name="addressBook.organizations.noAgent"/></span>
	</s:if>
</s:i18n>