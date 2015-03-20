<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<s:i18n name="ShowResource">

    <%-- Content --%>

    <sj:div id="picture_viewer_main_01" cssStyle="background-color:white;height: auto;"  cssClass="kb-corner-radius-c1">

        <%-- ---------------------------------------- --%>
        <%-- Full-size pictures, in display:none DIVs --%>
        <%-- ---------------------------------------- --%>

        <s:set var="fullSizeCount" value="1"/>

        <div style="height:auto;margin: auto;width:100%;">

            <%-- Depictions --%>
            <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
                <s:param name="query" value="'DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT DISTINCT ?url WHERE { { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } '"/>
                <s:param name="view" value="'pictures_main_full'"/>
                <s:param name="endpointlocation" value="'fao'"/>
            </s:url>

            <sj:div id="pictures_main_full" href="%{ajaxUrl}">
                <div style="text-align: center; ">
                    <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
                </div>
            </sj:div>

        </div>

        <%-- ------------------- --%>
        <%-- Pictures thumbnails --%>
        <%-- ------------------- --%>
        <s:div style="width:100%;height:auto;overflow-x:scroll;float:left;overflow-y:hidden;">
            <%-- Using a table instead of divs because ie7 doesn't understand css property "display : table-cell;" --%>
            <s:url id="ajaxUrl" escapeAmp="false" value="GetSparqlResult">
                <s:param name="query" value="' DEFINE input:inference <http://www.ics.forth.gr/isl/TLObasedDataWarehouseV2> DEFINE input:same-as \"yes\" PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT DISTINCT ?url WHERE { { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?url } UNION { <' + uri + '> <http://ics.forth.gr/Ontology/MarineTLO/core#LX3isAboutConcept> ?z . ?z dc:identifier ?url } FILTER (regex(?url, \"jpg\")  || regex(?url, \"jpeg\")  || regex(?url, \"png\")  || regex(?url, \"gif\")) . FILTER ( !regex(?url, \"http\")) } '"/>
                <s:param name="view" value="'pictures_main_thumb'"/>
                <s:param name="endpointlocation" value="'fao'"/>
            </s:url>

            <sj:div id="pictures_main_thumb" href="%{ajaxUrl}">
                <div style="text-align: center; ">
                    <img src="<s:url value="/webpages/pictures/00_commons/ajax-loader-fan-32-32.gif"/>" alt="Please wait..."/>
                </div>
            </sj:div>

            <%-- Closing the table --%>

        </s:div>
    </sj:div>
</s:i18n>