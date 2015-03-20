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
                <div class="listview-item bg-color-blue individualData" view="indicateurIndividualData" href="#" id="<s:property value="indicator.uri"/>" style="height:100px !important;margin-top:0px !important;">      
                    <div class="pull-left" href="#">         
                        <div class="listview-item-object icon-graph" data-src="holder.js/60x60"></div>      
                    </div>      
                    <div class="listview-item-body">         
                        <h4 class="listview-item-heading"><s:property value="Title.literal" /></h4>         
                        <!--                            <p class="two-lines">Body text that wraps over two lines. Vivamus elementum semper nisi.</p>     -->
                    </div>   
                </div>
            </s:iterator>   
        </div>
    </div>
</div>
