<%-- 
    Document   : subjectBddIndiv
    Created on : 19 janv. 2015, 09:43:36
    Author     : arnaud
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>

<div class="row-fluid">
    <s:iterator value="results">
        <div class="span4">
            <div class="thumbnail">
                
                    <img alt="300x200" data-src="holder.js/300x200" style="width: 300px; height: 200px;" src="data:image/png;base64,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">
               
            </div>
        </div>
        <div class="span8">
            <div class="thumbnail">
                <div class="caption">
                    <s:if test="Title.literal != null">
                        <h3><s:property value="Title.literal"/></h3>
                    </s:if>
                    <s:else>
                        Aucune donnée 
                    </s:else>   
                    <div class="comment">
                        <s:if test="description.literal != null">
                            <s:property value="description.literal"/>
                        </s:if>
                        <s:else>
                            Aucune donnée disponible
                        </s:else>
                    </div>
                    <p><s:property value="subject.uri"/></p>
                    <!--            <p><a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a></p>-->
                </div>
            </div>
        </div>
    </s:iterator>
</div>
