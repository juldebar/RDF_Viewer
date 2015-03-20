<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<s:div id="edition" cssStyle="display:yes;overflow:auto;width:800px;height:300px;border:solid"> 
	<!-- La servlet AddResource reste à developper -->  
	<s:form id="formEdit" name="formulaire"  action="UpdateResource" method="post">	 	
	    <s:div id="methode" > 
	      	<s:iterator value="spo" status="state">	
		 		<!-- Predicate -->
		 		<p>
		 			<!--<sx:autocompleter  name="%{'predicate_'+#state.index}" forceValidOption="true" value="%{predicate}" label="Predicate" list="listPredicate" listKey="uri" listValue="label" autoComplete="true" />-->
		 			<s:select name="%{'predicate_'+#state.index}" value="%{predicate}" list="listPredicate" listKey="uri" listValue="label" ></s:select>
				</p>
			
				<!-- Object as resource -->
				<p>
					<sx:autocompleter label="Resource Object" name="%{'object_'+#state.index}" value="%{object}" list="listObject" listKey="uri" listValue="label" autoComplete="true"/>
				</p>
					
				<!-- Object as literal -->	
				<p>
					<s:textarea cols="50" label="Literal Object" rows="6" name="%{'preferredLabel_'+#state.index}" value="%{preferredLabel}"/> <sx:autocompleter name="%{lang_+#state.index}" value="%{lang}" label="Language" />	
				</p>
				<p>
					<s:checkbox name="%{'deleteStatement_'+#state.index}" fieldValue="true" label="DeleteStatement" ></s:checkbox>
				</p>
						 	
				<s:if test="(#state.last)"><br/>
					<s:url id="url" action="GetNewStatementEditor"/>
					<sx:a id="GetNewStatementEditor" onclick="this.style.display='none';" href="%{#url}" targets="newStatement"><s:text name="Add New Statement"/></sx:a>
				</s:if>
				
				<br/><br/>
			</s:iterator>
			
			<s:div id="newStatement" >
			</s:div>
		
			<s:submit /> 
		</s:div>
	</s:form>
</s:div>

