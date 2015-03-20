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
        <s:property value="term.literal"/>
        <s:if test="!(#state.last)">, </s:if>
    </s:iterator>
</s:i18n>