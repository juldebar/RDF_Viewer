<%-- 
    Document   : bddCategory
    Created on : 9 janv. 2015, 15:46:35
    Author     : arnaud
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<div style="height: 883px;" class="metro panorama">      
    <div style="width: 2390px; height: 981px; margin-left: 0px;" class="panorama-sections">
        <div class="panorama-section tile-span-8">
            <h2>Images satellites</h2>
            <s:iterator value="results">
                <a class="tile app bg-color-orange individualData" view="satIndividualData" href="#" id="<s:property value="satellite.uri" />">
                    <div class="image-wrapper">
                        <span class="icon icon-earth-3"></span>
                    </div>
                    <div class="app-label categoryTitle">
                        <s:property value="Title.literal"/>
                    </div>
                </a>
            </s:iterator>   
        </div>
    </div>
</div>



