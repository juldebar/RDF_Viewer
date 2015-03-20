<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="org.ird.crh.ecoscope.kb.strutstranslations.blocks.resourcestext.resourcestext">
    
    <div id="resources-text">
        <h3 style="color:black;">
            <%--<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@title]['preferred'][0]"/>--%>
            <s:property value="properties[@com.hp.hpl.jena.vocabulary.RDF@subject]['resource'][0].preferredLabel"/>
            <img id="wait1" src="<s:url value="/webpages/pictures/00_commons/ajax_wait_05_25_25.gif"/>" alt="Please wait..."/>
            <%--<s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@firstName]['preferred'][0]"/>&nbsp;
            <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@family_name]['preferred'][0]"/>--%>
        </h3>


        <%-- Alternative labels --%>
        <s:merge id="mergedAltLabels">
            <s:param value="%{properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@altLabel]['preferred']}" />
            <%-- Harmful if SKOS-RDF is inferred, because RDFS@label will return all SKOS@prefLabel and SKOS@altLabel --%>
            <%-- Unusefull too now because there's no more RDFS@label in the Ecoscope ontology --%>
            <%--<s:param value="%{properties[@com.hp.hpl.jena.vocabulary.RDFS@label]}" />--%>
        </s:merge>
        <s:iterator value="mergedAltLabels" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.synonyms"/></h4></s:if>
            <s:else><br/></s:else>
            <s:property />
        </s:iterator>		
        <div style="clear:both;"></div>

        <%-- Gender --%>
        <%--<span class="propertyLabel"><s:text name="resourcestext.individual.person.gender"/>:&nbsp;</span>
        <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@gender]['preferred'][0]" default="n/a"/>
        <div style="clear:both;"></div>--%>

        <%-- Organisms --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@fundedBy]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.organism"/>
                </h4>
            </s:if>
            <s:else><br/></s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/></s:a>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Phones --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@phone]['preferred']" status="state">
            <s:if test="#state.first">
                <div style="margin-top:10px;">
                    <div class="propertyLabel" style="float:left;"><s:text name="resourcestext.individual.person.phone"/>:&nbsp;</div>
                    <div style="float:left;">
                    </s:if>
                    <s:else>, </s:else>
                    <s:property/>
                    <s:if test="#state.last">
                    </div>
                </div>
            </s:if>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Description --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@description]['preferred']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.common.description"/></h4></s:if>
            <s:else><br/></s:else>
            <p class="resources-text"><s:property /></p>
        </s:iterator>

        <%-- Member of groups --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF_EXT@isMemberOf]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.member"/>			
                </h4>
            </s:if>
            <s:else>
                <br/>
            </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/></s:a>
        </s:iterator>

        <%-- Member of groups --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@member]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.member"/>				
                </h4>
            </s:if>
            <s:else>
                <br/>
            </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/></s:a>
        </s:iterator>

        <%-- Present projects --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@currentProject]['resource']" status="state">
            <s:if test="#state.first">
                <h4><s:text name="resourcestext.individual.person.presentProjects"/></h4>
            </s:if>
            <s:else>, </s:else>
            <s:url id="url" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
        </s:iterator>

        <%-- Past projects --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@pastProject]['resource']" status="state">
            <s:if test="#state.first">
                <h4><s:text name="resourcestext.individual.person.pastProjects"/></h4>
            </s:if>
            <s:else>, </s:else>
            <s:url id="url" value="%{properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred'][0]}"/>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="preferredLabel"/></s:a>
        </s:iterator>

        <%-- Workplace homepage --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@workplaceHomepage]['resource']" status="state">
            <s:if test="#state.first">
                <div style="margin-top:10px;">
                    <div class="propertyLabel" style="float:left;"><s:text name="resourcestext.individual.person.workplaceHomepage"/>:&nbsp;</div>
                    <div style="float:left;">
                    </s:if>
                    <s:else><br/></s:else>
                    <s:url id="url" action="ShowResource">
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]"/></s:a>
                    <s:if test="#state.last">
                    </div>
                </div>
            </s:if>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Work info homepage --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@workInfoHomepage]['resource']" status="state">
            <s:if test="#state.first">
                <div style="margin-top:10px;">
                    <div class="propertyLabel" style="float:left;"><s:text name="resourcestext.individual.person.workInfoHomepage"/>:&nbsp;</div>
                    <div style="float:left;">
                    </s:if>
                    <s:else><br/></s:else>
                    <s:url id="url" action="ShowResource">
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]"/></s:a>
                    <s:if test="#state.last">
                    </div>
                </div>
            </s:if>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Personal homepage --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@homepage]['resource']" status="state">
            <s:if test="#state.first">
                <div style="margin-top:10px;">
                    <div class="propertyLabel" style="float:left;"><s:text name="resourcestext.individual.person.personalHomepage"/>:&nbsp;</div>
                    <div style="float:left;">
                    </s:if>
                    <s:else><br/></s:else>
                    <s:url id="url" action="ShowResource">
                        <s:param name="resourceUri"><s:property/></s:param>
                    </s:url>
                    <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@com.hp.hpl.jena.vocabulary.DC@title]['preferred'][0]"/></s:a>
                    <s:if test="#state.last">
                    </div>
                </div>
            </s:if>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Topic interests --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@topic_interest]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.topicInterests"/>
                </h4>
            </s:if>
            <s:else>, </s:else>

            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel" />
            </s:a>
        </s:iterator>

        <%-- Colleagues --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@knows]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.colleagues"/>
                </h4>
            </s:if>
            <s:else>, </s:else>
            
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@name]['preferred'][0]"/>
            </s:a>
        </s:iterator>
        <div style="clear:both;"></div>

        <%-- Publications --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF@publications]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.publications"/>
                </h4>
            </s:if>
            <s:else>
                <br/>
            </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel"/>
            </s:a>
        </s:iterator>


        <%-- Funds --%>
        <s:iterator value="properties[@org.ird.crh.ecoscope.jena.vocabulary.FOAF_EXT@funds]['resource']" status="state">
            <s:if test="#state.first">
                <h4>
                    <s:text name="resourcestext.individual.person.funds"/>
                </h4>
            </s:if>
            <s:else>, </s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                <s:property value="preferredLabel"/>
            </s:a>
        </s:iterator>


        <%-- Coverage --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@coverage]['resource']" status="state">
            <s:if test="#state.first"><h4><s:text name="resourcestext.individual.informationalResource.coverage"/></h4></s:if>
            <s:else><br/></s:else>
            <s:url id="url" action="ShowResource">
                <s:param name="resourceUri"><s:property/></s:param>
            </s:url>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';"><s:property value="properties[@org.ird.crh.ecoscope.jena.vocabulary.SKOS@prefLabel]['preferred'][0]"/></s:a>
        </s:iterator>

        <%--Links --%>
        <s:iterator value="properties[@com.hp.hpl.jena.vocabulary.DC@identifier]['preferred']" status="state">
            <s:if test="#state.first"><h4>Links</h4></s:if>
            <s:else><br/></s:else>
            <s:url id="url" value="%{object}"/>
            <s:a href="%{url}" onclick="javascript:document.getElementById('wait1').style.visibility='visible';">
                Get this resource
            </s:a>
        </s:iterator>

        <%-- Access to RDF fragment --%>
        <s:include value="/webpages/blocks/rdfviewer/rdfviewer_01.jsp"/>
    </div>
    
</s:i18n>