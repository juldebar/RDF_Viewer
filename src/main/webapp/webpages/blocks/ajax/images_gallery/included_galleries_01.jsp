<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Initializing pagination --%>
<s:if test="pageNumber != null"><s:set name="pageNumber" value="%{pageNumber}" /></s:if>
<s:else><s:set name="pageNumber" value="1" /></s:else>
<s:set name="resultsPerPage" value="12" />
<s:set name="start" value="%{(#resultsPerPage*#pageNumber) - #resultsPerPage}" />
<s:set name="stop" value="%{(#resultsPerPage*#pageNumber) - 1}" />
<s:set name="previous" value="false"/>
<s:set name="next" value="false"/>

<%-- Display --%>
<s:div id="galleries">
	<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@madeOfImageGallery]['resource']" status="state">
		<s:set name="nbOfItems" value="#state.count" />
		<s:if test="#state.first">
			<h4><s:text name="individual.imagesGallery.subGalleries"/></h4>
		</s:if>
		
		<s:if test="(#state.index >= #start) && (#state.index <= #stop)">
			<s:url id="url" action="ShowResource">
			    <s:param name="resourceUri"><s:property /></s:param>
			    <s:param name="pageNumber">1</s:param>
			</s:url>
			<s:div cssClass="galleryCell1">
				<div class="galleryCell2">
					<%-- First method : the uri is direclty available in the "resource" structure --%>
					<%--
					<s:a href="%{url}">	
						<img src="<s:url value="%{getPictureUrlForSize(properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource'][0].properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0], 'xxs')}" />" />
					</s:a>
					<s:action name="ShowResource" executeResult="false" var="subGallery">
					    <s:param name="resourceUri"><s:property /></s:param>
					    <s:param name="forcedView">multi###graph</s:param>
					</s:action>
					<img src="<s:url value="%{getPictureUrlForSize(#subGallery.properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource'][0].properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0], 'xxs')}" />" />
					--%>
					
					<%-- Second method : using an ajax call and a mini view --%>
					<%--
					<s:url id="url2" value="ShowResource" escapeAmp="false">
						<s:param name="resourceUri"><s:property /></s:param>
						<s:param name="forcedView">individual###imageGallery-GallerieIcon</s:param>
					</s:url>
					
				    <sj:div href="%{url2}">
				        <img src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" />
				    </sj:div>
				    --%>
					
					<%-- Third method : using an embedded action --%>
					
					<div>
						<s:action name="ShowResource" executeResult="false" var="resource">
						    <s:param name="resourceUri"><s:property value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@depiction]['resource'][0]}"/></s:param>
						</s:action>
						<s:url id="picUrl" action="GetFile" escapeAmp="false">
							<s:param name="filePath"><s:property value="#resource.properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]"/></s:param>
							<s:param name="forcedView">imageGallery-GallerieIcon-embeddedAction</s:param>
							<s:param name="picSize">125x125</s:param>
						</s:url>
						<s:a href="%{url}">
							<img alt="<s:text name="individual.galleryIcon.noIcon"/>" src="<s:property value="picUrl"/>" />
						</s:a>
					</div>
					
					<%-- Fourth method : using a simple default icon --%>
					<%--<s:a href="%{url}">	
						<img src="<s:url value="/webpages/pictures/03_image_galleries/gallery_125_125.png" />" />
					</s:a>--%>
				    
				</div>
				<div>
					<s:a href="%{url}">
						<s:property value="subText(properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0], 50)"/>
					</s:a>
				</div>
			</s:div>
		</s:if>
		
		<s:if test="(#state.index < #start)">
			<s:set name="previous" value="true"/>
		</s:if>
		
		<s:if test="(#state.index > #stop)">
			<s:set name="next" value="true"/>
		</s:if>
		
		<!-- Edition -->
		<!-- <s:url id="urlEdit1" action="GetResourceEditor">
		    <s:param name="resourceUri"><s:property /></s:param>
		</s:url>
		<sx:a href="%{urlEdit1}" targets="formEditResource" indicator="wait1"><s:text name="'Editer la resource[+]:'+properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]" /></sx:a>-->	
	</s:iterator>
	<div style="clear:both;"></div>

	<%-- Pagination widgets classic --%>
	<%-- <s:if test="(#previous == true) || (#next == true)">
		<div style="margin: 10px;text-align: center;">
			<s:if test="(#previous == true)">
				<s:url id="firstUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber">1</s:param>
				</s:url>
				<sj:a href="%{firstUrl}" targets="galleries"><img src="<s:url value="/webpages/pictures/10_icons/bb_bback_25_25.png"/>" /></sj:a>
				
				<s:url id="prevUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber - 1"/></s:param> 
				</s:url>
				<sj:a href="%{prevUrl}" targets="galleries"><img src="<s:url value="/webpages/pictures/10_icons/bb_back_25_25.png"/>" /></sj:a>
			</s:if>
			
			<s:if test="(#next == true)">
				<s:url id="nextUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber + 1"/></s:param>
				</s:url>
				<sj:a id="nextLink" loadingText="Loading..." href="%{nextUrl}" targets="galleries"><img src="<s:url value="/webpages/pictures/10_icons/bb_forward_25_25.png"/>" /></sj:a>
				
				<s:set name="nbPages" value="#nbOfItems / #resultsPerPage"/>
				<s:set name="oneMorePage" value="#nbOfItems % #resultsPerPage"/>
				<s:if test="#oneMorePage > 0">
					<s:set name="nbPages" value="#nbPages + 1"/>
				</s:if>
				<s:url id="lastUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#nbPages"/></s:param>
				</s:url>
				<sj:a href="%{lastUrl}" targets="galleries"><img src="<s:url value="/webpages/pictures/10_icons/bb_fforward_25_25.png"/>" /></sj:a>
			</s:if>
		</div>
	</s:if> --%>
	
	<%-- Pagination widgets with jQuery theme --%>
	<s:if test="(#previous == true) || (#next == true)">
		<div style="position: relative; left:385px; margin-top: 10px;">
			<s:if test="(#previous == true)">
				<s:url id="firstUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber">1</s:param>
				</s:url>
				<sj:a href="%{firstUrl}" targets="galleries" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-fisrt"></span>
				</sj:a>
				
				<s:url id="prevUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber - 1"/></s:param> 
				</s:url>
				<sj:a href="%{prevUrl}" targets="galleries" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-prev"></span>
				</sj:a>
			</s:if>
			
			<s:if test="(#next == true)">
				<s:url id="nextUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber + 1"/></s:param>
				</s:url>
				<sj:a id="nextLink" loadingText="Loading..." href="%{nextUrl}" targets="galleries" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-next"></span>
				</sj:a>
				
				<s:set name="nbPages" value="#nbOfItems / #resultsPerPage"/>
				<s:set name="oneMorePage" value="#nbOfItems % #resultsPerPage"/>
				<s:if test="#oneMorePage > 0">
					<s:set name="nbPages" value="#nbPages + 1"/>
				</s:if>
				<s:url id="lastUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-GalleriesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#nbPages"/></s:param>
				</s:url>
				<sj:a href="%{lastUrl}" targets="galleries" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-end"></span>
				</sj:a>
			</s:if>
		</div>
	</s:if>
</s:div>