<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">
    <s:div id="taxonomy" cssStyle="display:block;">
        <h4><s:text name="flod.title"/></h4>
        <s:text name="flod.kingdom"/>&nbsp;<s:property value="kingdom"/>
        <br/>
        <s:text name="flod.phylum"/>&nbsp;<s:property value="phylum"/>
        <br/>
        <s:text name="flod.class"/>&nbsp;<s:property value="clazz"/>
        <br/>
        <s:text name="flod.order"/>&nbsp;<s:property value="order"/>
        <br/>
        <s:text name="flod.family"/>&nbsp;<s:property value="family"/>
        <br/>
        <s:text name="flod.genus"/>&nbsp;<s:property value="genus"/>
        <br/>
        <s:text name="flod.subgenus"/>&nbsp;<s:property value="subgenus"/>
        <br/>
        <s:text name="flod.epithet"/>&nbsp;<s:property value="specificEpithet"/>
        <br/>
        <s:text name="flod.scientificName"/>&nbsp;<s:property value="scientificName"/>
        <br/>
    </s:div>
</s:i18n>