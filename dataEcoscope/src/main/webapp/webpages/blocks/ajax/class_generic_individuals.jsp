<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>


<s:div id="individuals" cssStyle="display:block;">
	<div style="margin-bottom:10px;">
		<%-- Instances --%>
		<s:div>
			<s:set var="found" value="false"/>
			<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.ARTEFACTS@typeOf]['resource']" status="state">
				<s:set var="found" value="true"/>
				<s:if test="#state.first == false">, </s:if>
				<s:url id="url" action="ShowResource">
				    <s:param name="resourceUri"><s:property /></s:param>
				</s:url>
				<s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
			</s:iterator>
			<s:if test="#found == false">-</s:if>
		</s:div>
	</div>
</s:div>