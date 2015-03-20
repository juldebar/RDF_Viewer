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
            <h2>Base de donnée</h2>
            <s:iterator value="results" status="stat">
                <s:if test="#stat.even == true">
                    <a class="tile app bg-color-blue individualData" view="bddIndividualData" href="#" id="<s:property value="database.uri" />">
                        <div class="image-wrapper">
                            <span class="icon icon-database"></span>
                        </div>
                        <div class="app-label categoryTitle">
                            <s:property value="Title.literal" />
                        </div>
                        <!--                        <div class="app-count">12</div>-->
                    </a>
                </s:if>
                <s:else>
                    <a class="tile app bg-color-orange individualData" view="bddIndividualData" href="#" id="<s:property value="database.uri" />">
                        <div class="image-wrapper">
                            <span class="icon icon-database"></span>
                        </div>
                        <div class="app-label categoryTitle">
                            <s:property value="Title.literal"/>
                        </div>
                        <!--                        <div class="app-count">12</div>-->
                    </a>
                </s:else>
            </s:iterator>   
        </div>
    </div>
</div>



