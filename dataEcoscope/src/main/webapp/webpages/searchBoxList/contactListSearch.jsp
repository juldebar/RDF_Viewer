<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="well" style="max-width: 340px; padding: 8px 0;">
    <ul class="nav metro-nav-list">
        <ul class="nav">
            <s:iterator value="results">                                
                <li class="active individualData" id="<s:property value="agent.uri" />" view="bdd">
                    <a href="#"><s:property value="name.literal"/></a>
                </li>
            </s:iterator>
        </ul>
    </ul>