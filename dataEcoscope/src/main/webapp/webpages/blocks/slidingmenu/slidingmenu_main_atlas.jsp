<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>

<s:i18n name="ShowResource">
    <ul class="glossymenu">	<%-- Overlaps glossymenu default margins --%>

        <s:url id="url" action="ShowWelcomePage"/>
        <li class="menuitem" href="%{url}"><s:text name="slidingmenu.common.welcomePage"/></li>

        <li class="menuitem submenuheader"><s:text name="slidingmenu.common.categories"/></li>
        <ul class="submenu">

            <li>
                <s:url id="url" action="ShowResource">
                    <%-- uri param not used for that view --%>
                    <s:param name="view">class###species-list-01</s:param>
                </s:url>
                <s:url id="url" action="ShowWelcomePage" />

                <s:a href="%{url}"><s:text name="atlas.entryPage.species.title"/></s:a>
                </li>

            </ul>

            <li class="menuitem submenuheader"><s:text name="slidingmenu.common.species"/></li>
        <ul class="submenu" >

            <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_obesus</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesBET"/></s:a>
                </li>
                <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_albacares</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesYFT"/></s:a>
                </li>
                <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/katsuwonus_pelamis</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesSKJ"/></s:a>
                </li>
                <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/thunnus_alalunga</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesALB"/></s:a>
                </li>
                <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/auxis_thazard</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesFRI"/></s:a>
                </li>
                <li>
                <s:url id="url" action="ShowResource">
                    <s:param name="uri">http://www.ecoscope.org/ontologies/ecosystems/euthynnus_affinis</s:param>
                    <s:param name="view">showIndividualElement</s:param>
                </s:url>
                <s:a href="%{url}"><s:text name="slidingmenu.common.speciesKAW"/></s:a>
                </li>
            </ul>

        <s:url id="url" action="ShowWebLinks"/>
        <li class="menuitem" href="%{url}" cssStyle="border-bottom-width: 0"><s:text name="slidingmenu.common.links"/></li>

    </ul>
    <style type="text/css">
        .submenu{
            position:absolute;   
        }
        .glossymenu{
            //margin: 5px 0;	/*englobing margins*/
            padding: 0;
            width: auto; /*width of menu*/
            background-repeat: no-repeat;
        }

        .glossymenu li.menuitem{
/*            background: black;*/
            <%--url(<s:url value="/webpages/pictures/00_commons/v_menu_tab_inactive_225_26.png" forceAddSchemeHostAndPort="true" includeContext="true"/>) repeat-x bottom left;--%>
            font: bold 14px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
            color: white; /*Headers text color*/
            display: inline-block;
            position: relative; /*To help in the anchoring of the ".statusicon" icon image*/
            width: auto;
            padding: 4px 0; /*inter-headers padding*/
            padding-left: 10px;
            margin-bottom: 2px;	/*inter-headers margin*/
            text-decoration: none;
            cursor: pointer;
            background-repeat: inherit;
            list-style: none; /* pour enlever les puces sur IE7 */
            margin: 10px;  
        }

        .glossymenu li.menuitem:visited, .glossymenu .menuitem:active{
            color: white;
        }

        .glossymenu li.menuitem .statusicon{ /*CSS for icon image that gets dynamically added to headers*/
            position: absolute;
            top: 5px;
            right: 5px;
            border: none;
        }

        .glossymenu li.menuitem:hover{
            background-image: url(<s:url value="/webpages/pictures/00_commons/v_menu_tab_active_225_26.png" forceAddSchemeHostAndPort="true" includeContext="true"/>);
        }

        .glossymenu ul.submenu{ /*DIV that contains each sub menu*/
            background: white;
        }

        .glossymenu ul.submenu { /*UL of each sub menu*/
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 100%;
            top: 60px;
            left: 0;
            background-color:lightgrey;
            border:1px solid black;
        }

        .glossymenu ul.submenu  li{
            /*border-bottom: 1px solid black;*/	/*border between the submenus*/
            padding: 20px;
            margin-left: 100px;
            display: inline-block;
            
        }

        .glossymenu ul.submenu  li a{
            display: block;
            font: normal 13px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
            color: black;
            text-decoration: none;
            padding: 2px 0;
            padding-left: 10px;
        }

        .glossymenu ul.submenu  li a:hover{
            background: #DFDCCB;
            colorz: white;
        }
    </style>
</s:i18n>