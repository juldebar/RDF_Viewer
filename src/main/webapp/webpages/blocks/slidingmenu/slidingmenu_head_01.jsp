<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%-- [TODO] - To be converted to struts 2 jquery plugin --%>
<script type="text/javascript" src="<s:url value="/webpages/blocks/slidingmenu/ddaccordion.js" />"></script>

<script type="text/javascript">
    <!--
    ddaccordion.init({
        headerclass: "submenuheader", //Shared CSS class name of headers group
        contentclass: "submenu", //Shared CSS class name of contents group
        revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
        mouseoverdelay: 300, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
        collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
        defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
        onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
        animatedefault: false, //Should contents open by default be animated into view?
        persiststate: true, //persist state of opened contents within browser session?
        toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
        togglehtml: ["suffix", "<img src='<s:url value="/webpages/blocks/slidingmenu/plus.gif" forceAddSchemeHostAndPort="true" includeContext="true"/>' class='statusicon' alt='Status' />", "<img src='<s:url value="/webpages/blocks/slidingmenu/minus.gif" forceAddSchemeHostAndPort="true" includeContext="true"/>' class='statusicon' alt='Status' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
        animatespeed: "normal", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
        oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
            //do nothing
        },
        onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
            //do nothing
        }
    })
    // -->
</script>

<style type="text/css">
    .glossymenu{
        //margin: 5px 0;	/*englobing margins*/
        padding: 0;
        width: auto; /*width of menu*/
        background-repeat: no-repeat;
    }

    .glossymenu a.menuitem{
        background: black;
            <%--url(<s:url value="/webpages/pictures/00_commons/v_menu_tab_inactive_225_26.png" forceAddSchemeHostAndPort="true" includeContext="true"/>) repeat-x bottom left;--%>
        font: bold 14px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
        color: white; /*Headers text color*/
        display: block;
        position: relative; /*To help in the anchoring of the ".statusicon" icon image*/
        width: auto;
        padding: 4px 0; /*inter-headers padding*/
        padding-left: 10px;
        margin-bottom: 2px;	/*inter-headers margin*/
        text-decoration: none;
        cursor: pointer;
        background-repeat: inherit;
    }

    .glossymenu a.menuitem:visited, .glossymenu .menuitem:active{
        color: white;
    }

    .glossymenu a.menuitem .statusicon{ /*CSS for icon image that gets dynamically added to headers*/
        position: absolute;
        top: 5px;
        right: 5px;
        border: none;
    }

    .glossymenu a.menuitem:hover{
        background-image: url(<s:url value="/webpages/pictures/00_commons/v_menu_tab_active_225_26.png" forceAddSchemeHostAndPort="true" includeContext="true"/>);
    }

    .glossymenu div.submenu{ /*DIV that contains each sub menu*/
        background: white;
    }

    .glossymenu div.submenu ul{ /*UL of each sub menu*/
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    .glossymenu div.submenu ul li{
        /*border-bottom: 1px solid black;*/	/*border between the submenus*/
    }

    .glossymenu div.submenu ul li a{
        display: block;
        font: normal 13px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
        color: black;
        text-decoration: none;
        padding: 2px 0;
        padding-left: 10px;
    }

    .glossymenu div.submenu ul li a:hover{
        background: #DFDCCB;
        colorz: white;
    }
</style>