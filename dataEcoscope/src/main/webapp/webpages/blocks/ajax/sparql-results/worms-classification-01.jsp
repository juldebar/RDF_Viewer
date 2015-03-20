<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">
    <s:div id="taxonomy" cssStyle="display:block;">
        <s:if test="results.size < 1">
            n/a
        </s:if>
        <s:iterator value="results">
            <s:text name="flod.kingdom"/>&nbsp;<s:property value="kingdom.uri" default="n/a"/>
            <br/>
            <s:text name="flod.phylum"/>&nbsp;<s:property value="phylum.uri" default="n/a"/>
            <br/>
            <s:text name="flod.class"/>&nbsp;<s:property value="class.uri" default="n/a"/>
            <br/>
            <s:text name="flod.order"/>&nbsp;<s:property value="order.uri" default="n/a"/>
            <br/>
            <s:text name="flod.family"/>&nbsp;<s:property value="family.uri" default="n/a"/>
            <br/>
            <s:text name="flod.genus"/>&nbsp;<s:property value="genus.uri" default="n/a"/>
            <br/>
            <s:text name="flod.subgenus"/>&nbsp;<s:property value="subgenus.uri" default="n/a"/>
            <br/>
            <s:text name="flod.epithet"/>&nbsp;<s:property value="specificEpithet.uri" default="n/a"/>
            <br/>
            <s:text name="flod.scientificName"/>&nbsp;<s:property value="scientificName.uri" default="n/a"/>
            <br/>
        </s:iterator>
    </s:div>
</s:i18n>