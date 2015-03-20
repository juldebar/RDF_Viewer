<%-- 
    Document   : homeCount
    Created on : 12 janv. 2015, 14:16:00
    Author     : arnaud
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:iterator value="results">
    <s:property value="pictureCount.literal"/>
</s:iterator>