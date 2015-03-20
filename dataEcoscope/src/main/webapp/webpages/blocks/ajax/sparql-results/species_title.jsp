<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">
    <s:iterator value="results">
        <h3 style="text-align:center">
            <s:property value="term.literal" />
        </h3>
    </s:iterator>
</s:i18n>