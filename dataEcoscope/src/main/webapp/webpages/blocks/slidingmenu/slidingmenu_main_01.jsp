<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="ShowResource">
    <div class="glossymenu">	<%-- Overlaps glossymenu default margins --%>
        <s:url id="url" action="ShowWelcomePage"/>
        <s:a cssClass="menuitem" href="%{url}"><s:text name="slidingmenu.common.welcomePage"/></s:a>

        <s:a cssClass="menuitem submenuheader"><s:text name="slidingmenu.common.categories"/></s:a>
            <div class="submenu">
                <ul>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <%-- uri param not used for that view --%>
                        <s:param name="view">class###species-list-01</s:param>
                    </s:url>
                    <s:url id="url" action="ShowWelcomePage" />
                       
                    <s:a href="%{url}"><s:text name="atlas.entryPage.species.title"/></s:a>
                    </li>
                </ul>
            </div>

        <s:a cssClass="menuitem submenuheader"><s:text name="slidingmenu.common.species"/></s:a>
            <div class="submenu">
                <ul>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_obesus</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesBET"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_albacares</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesYFT"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/katsuwonus_pelamis</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesSKJ"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_alalunga</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesALB"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/auxis_thazard</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesFRI"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/euthynnus_affinis</s:param>
                        <s:param name="view">individual###element-01</s:param>
                    </s:url>
                    <s:a href="%{url}"><s:text name="slidingmenu.common.speciesKAW"/></s:a>
                    </li>
                    <li>
                    <s:url id="url" action="ShowResource">
                        <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/euthynnus_affinis</s:param>
                        <s:param name="view">showIndividualElement</s:param>
                    </s:url>
                    <s:a href="%{url}">Albacared thunus test</s:a>
                    </li>
                </ul>
            </div>

        <s:url id="url" action="ShowWebLinks"/>
        <s:a cssClass="menuitem" href="%{url}" cssStyle="border-bottom-width: 0"><s:text name="slidingmenu.common.links"/></s:a>

        </div>
</s:i18n>