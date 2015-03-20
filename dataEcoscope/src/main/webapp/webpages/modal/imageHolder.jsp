<%-- 
    Document   : subjectBddIndiv
    Created on : 19 janv. 2015, 09:43:36
    Author     : arnaud
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>


    <s:iterator value="results">
        <s:url id="picUrl" action="GetFile" escapeAmp="false">
            <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
        </s:url>
        <img alt="300x200" onclick="loadPopupData('<s:property value="uri.literal"/>', 'image');" data-src="holder.js/300x200" src="<s:property value="picUrl"/>">
    </s:iterator>
