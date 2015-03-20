<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>

<!-- Content -->
<!-- Results as list -->

<p>
<sx:autocompleter label="Predicate" name="%{'predicate_'+ResourceEditorSize}" list="#session.WW_PREDICATE_LIST" listKey="uri" listValue="label"  autoComplete="true" />
</p>	

<!-- Object as resource -->	
<p>
<sx:autocompleter label="Resouce Object" name="%{'object_'+ResourceEditorSize}" list="#session.WW_OBJECT_LIST" listKey="uri" listValue="label" autoComplete="true"/>
</p>

<!-- Object as literal -->	
<s:textarea cols="50" label="Literal Object" rows="6" name="preferredLabel"/>
<sx:autocompleter label="Language" />
<br></br>
<br></br>

<s:url id="url" action="GetNewStatementEditor" >
</s:url>

<sx:a id="addNewStatement" onclick="this.style.display='none';" href="%{#url}" targets="%{'div_NewStatement_'+ResourceEditorSize}"><s:text name="Add New Statement"/></sx:a>


<div id="div_NewStatement_<s:property value="ResourceEditorSize"/>">
</div>


