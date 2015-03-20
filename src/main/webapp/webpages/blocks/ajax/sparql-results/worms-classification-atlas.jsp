<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:i18n name="ShowResource">
    <s:div id="taxonomy" cssStyle="display:block;">
        <s:if test="results.size < 1">
            n/a
        </s:if>
        <s:iterator value="results">
            nom  : <s:property value="commonName.literal" default="n/a"/> | 
            nom commun : <s:property value="commonNameLanguage.literal" default="n/a"/> | 
            pays : <s:property value="country.uri" default="n/a"/>
            <br/>
        </s:iterator>
    </s:div>
</s:i18n>