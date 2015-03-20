<%-- 
    Document   : simple-terms-column
    Created on : 13 juin 2013, 12:32:11
    Author     : pcauquil
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">
    <s:if test="results.size < 1">
        n/a
    </s:if>
    <s:iterator value="results" status="state">
        <%-- Link url --%>
        <s:url var="linkUrl" action="ShowResource" escapeAmp="false" >
            <s:param name="uri"><s:property value="resource.uri"/></s:param>
            <s:param name="view">individual###element-01</s:param>
        </s:url>
        <a href="<s:url value="%{linkUrl}"/>"><s:property value="term.literal"/></a><s:if test="!(#state.last)">, </s:if>
    </s:iterator>
</s:i18n>