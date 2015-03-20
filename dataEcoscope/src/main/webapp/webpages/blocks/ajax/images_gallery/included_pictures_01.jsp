<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<%-- Initializing pagination --%>
<s:if test="pageNumber != null"><s:set name="pageNumber" value="%{pageNumber}" /></s:if>
<s:else><s:set name="pageNumber" value="1" /></s:else>
<s:set name="resultsPerPage" value="20" />
<s:set name="start" value="%{(#resultsPerPage*#pageNumber) - #resultsPerPage}" />
<s:set name="stop" value="%{(#resultsPerPage*#pageNumber) - 1}" />
<s:set name="previous" value="false"/>
<s:set name="next" value="false"/>

<%-- Display --%>
<s:div id="thumbnails" cssStyle="margin-right:10px;">
	<s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.RESOURCES_DEF@madeOfPicture]['resource']" status="state">
		<s:set name="nbOfItems" value="#state.count" />
		<s:if test="#state.first">
			<h4><s:text name="individual.imagesGallery.pictures"/></h4>
		</s:if>
		
		<s:if test="(#state.index >= #start) && (#state.index <= #stop)">
			<s:url id="url" action="ShowResource">
				<s:param name="resourceUri"><s:property /></s:param>
			</s:url>
			<s:div cssClass="pictureCell1">
				<div class="pictureCell2">
					<s:a href="%{url}">
						<%--<img src="<s:url value="%{getPictureUrlForSize(properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0], 'xxs')}" />" /> --%>
						<s:url id="picUrl" action="GetFile" escapeAmp="false">
							<s:param name="filePath"><s:property value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/></s:param>
							<s:param name="picSize">125x125</s:param>
						</s:url>
						<img src="<s:property value="picUrl"/>" alt="[Picture not found]"/>
					</s:a>
				</div>
			</s:div>
			<s:if test="(#state.count % 5) == 0"><br/></s:if>
		</s:if>
		
		<%-- Managing pagination --%>
		<s:if test="(#state.index < #start)">
			<s:set name="previous" value="true"/>
		</s:if>
		
		<s:if test="(#state.index > #stop)">
			<s:set name="next" value="true"/>
		</s:if>
	</s:iterator>
	<div style="clear:both;"></div>

	<%-- Pagination widgets --%>
	<%-- <s:if test="(#previous == true) || (#next == true)">
		<div style="margin-top: 10px;">
			<s:if test="(#previous == true)">
				<s:url id="firstUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber">1</s:param>
				</s:url>
				<sj:a href="%{firstUrl}" targets="thumbnails" cssStyle="float: left;">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_bback_25_25.png"/>" />
				</sj:a>
				
				<s:url id="prevUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber - 1"/></s:param>
				</s:url>
				<sj:a href="%{prevUrl}" targets="thumbnails">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_back_25_25.png"/>" />
				</sj:a>
			</s:if>
			
			<s:if test="(#next == true)">
				<s:url id="nextUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber + 1"/></s:param>
				</s:url>
				<sj:a id="nextLink" loadingText="Loading..." href="%{nextUrl}" targets="thumbnails">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_forward_25_25.png"/>" />
				</sj:a>
				
				<s:set name="nbPages" value="#nbOfItems / #resultsPerPage"/>
				<s:set name="oneMorePage" value="#nbOfItems % #resultsPerPage"/>
				<s:if test="#oneMorePage > 0">
					<s:set name="nbPages" value="#nbPages + 1"/>
				</s:if>
				<s:url id="lastUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#nbPages"/></s:param>
				</s:url>
				<sj:a href="%{lastUrl}" targets="thumbnails">
					<img src="<s:url value="/webpages/pictures/10_icons/bb_fforward_25_25.png"/>" />
				</sj:a>
			</s:if>
		</div>
	</s:if> --%>
	
	<%-- Pagination widgets with jQuery theme --%>
	<s:if test="(#previous == true) || (#next == true)">
		<div style="position: relative; left: 385px; margin-top: 10px;">
			<s:if test="(#previous == true)">
				<s:url id="firstUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber">1</s:param>
				</s:url>
				<sj:a href="%{firstUrl}" targets="thumbnails" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-fisrt"></span>
				</sj:a>
				
				<s:url id="prevUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber - 1"/></s:param>
				</s:url>
				<sj:a href="%{prevUrl}" targets="thumbnails" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-prev"></span>
				</sj:a>
			</s:if>
			
			<s:if test="(#next == true)">
				<s:url id="nextUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#pageNumber + 1"/></s:param>
				</s:url>
				<sj:a id="nextLink" loadingText="Loading..." href="%{nextUrl}" targets="thumbnails" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-next"></span>
				</sj:a>
				
				<s:set name="nbPages" value="#nbOfItems / #resultsPerPage"/>
				<s:set name="oneMorePage" value="#nbOfItems % #resultsPerPage"/>
				<s:if test="#oneMorePage > 0">
					<s:set name="nbPages" value="#nbPages + 1"/>
				</s:if>
				<s:url id="lastUrl" action="ShowResource" escapeAmp="false">
					<s:param name="resourceUri"><s:property value="resourceUri"/></s:param>
					<s:param name="forcedView">individual###imageGallery-PicturesOverview</s:param>
					<s:param name="pageNumber"><s:property value="#nbPages"/></s:param>
				</s:url>
				<sj:a href="%{lastUrl}" targets="thumbnails" cssStyle="float: left;">
					<span class="ui-icon ui-icon-seek-end"></span>
				</sj:a>
			</s:if>
		</div>
	</s:if>
</s:div>