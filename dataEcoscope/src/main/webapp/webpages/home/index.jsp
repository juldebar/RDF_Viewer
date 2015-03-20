<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"  %>


<s:i18n name="ShowResource">
    <html xmlns="http://www.w3.org/1999/xhtml" class="no-js">
        <head>
            <sj:head locale="fr" jqueryui="true" defaultIndicator="myDefaultIndicator"/>

            <meta charset="utf-8" />
            <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
            <!-- Mobile viewport optimized: h5bp.com/viewport -->
            <meta name="viewport" content="width=device-width"/>
            <title>Ecoscope - Data</title>

            <meta name="robots" content="noindex, nofollow"/>

            <!-- remove or comment this line if you want to use the local fonts -->
            <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'/>

            <link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/bootmetro.css"/>"/>
            <link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/bootmetro-responsive.css"/>"/>
            <link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/bootmetro-icons.css"/>"/>
            <link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/bootmetro-ui-light.css"/>"/>
            <link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/datepicker.css"/>"/>
            <link rel="stylesheet" type="text/css" href="<s:url value="/webpages/tools/style.css"/>"/>





            <!--  these two css are to use only for documentation -->
            <%--<link rel="stylesheet" type="text/css" href="<s:url value="/css/bootstrapMetro/demo.css"/>"/>--%>

            <!-- Le fav and touch icons -->
            <!--   <link rel="shortcut icon" href="./assets/ico/favicon.ico">
               <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
               <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
               <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
               <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
            -->
            <!-- All JavaScript at the bottom, except for Modernizr and Respond.
               Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries
               For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
            <script src="<s:url value="/js/bootstrapMetro/modernizr-2.6.2.min.js"/>"></script>

            <script type="text/javascript">
//                var _gaq = _gaq || [];
//                _gaq.push(['_setAccount', 'UA-3182578-6']);
//                _gaq.push(['_trackPageview']);
//                (function () {
//                    var ga = document.createElement('script');
//                    ga.type = 'text/javascript';
//                    ga.async = true;
//                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
//                    var s = document.getElementsByTagName('script')[0];
//                    s.parentNode.insertBefore(ga, s);
//                })();
            </script>
        </head>
        <%--<body  <%--onload="init();"--%>
        <s:if test="#request.locale.language=='fr'">
            <body  lang="FR">
                <s:set var="lang" value="FR"/>
            </s:if>
            <s:if test="#request.locale.language=='en'">
                <body  lang="EN">
                    <s:set var="lang" value="EN"/>
                </s:if>

                <div id="mozaicContent" style="width:100%;height:100%;">


                    <!--                    <div class="col-md-3" style="width: auto;position: absolute;right: 0;margin-top: 25%;background-color: white;">
                                            <ul class="nav nav-pills nav-stacked">
                                                <li class="" style="text-align:center;">
                                                        <img src="<s:url value="/webpages/pictures/banner_left.png"/>"/>
                                                </li>
                                                <li><a href="#">Menu 1</a></li>
                                                <li><a href="#">Menu 2</a></li>
                                                <li><a href="#">Menu 3</a></li>
                                            </ul>
                                        </div>-->



                    <%-- popup individual data --%>
                    <div class="navbar">     
                        <div class="navbar-inner">



                            <ul class="nav pull-left">
                                <li>
                                    <a class="brand category" id="homeCategory" href="#homeCategory">
                                        <span class="pull-left">
                                            <i class="icon-home"></i>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="http://ecoscopebc.mpl.ird.fr:8080/joseki/ecoscope.html" target="_blank">sparql Endpoint</a>
                                </li>         
                                <li>
                                    <a href="http://www.ecoscopebc.ird.fr/EcoscopeKB/ShowWelcomePage" target="_blank">Ecoscope</a>
                                </li> 
                            </ul>       

                            <ul class="nav pull-right">       
                                <%-- gestion de la langue --%>
                                <li>
                                    <s:url action="ShowResource" var="requestLocaleFrVar" includeParams="all" escapeAmp="false">
                                        <s:param name="request_locale">fr</s:param>
                                    </s:url>
                                    <s:a href="%{requestLocaleFrVar}" style="margin-right: 5px;">
                                        <img style="height:20px;" src="<s:url value="/webpages/pictures/french_button.png"/>"/>
                                    </s:a>
                                </li>
                                <li>
                                    <s:url action="ShowResource" var="requestLocaleEnVar" includeParams="all" escapeAmp="false">
                                        <s:param name="request_locale">en</s:param>
                                    </s:url>
                                    <s:a href="%{requestLocaleEnVar}" style="margin-right: 5px;">
                                        <img style="height:20px;" src="<s:url value="/webpages/pictures/english_button.png"/>"/>
                                    </s:a>
                                </li>

                                <li class="dropdown">       
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        sites associées<b class="caret"></b>
                                    </a>
                                    <ul class="dropdown-menu" id="globalMenu"> 

                                    </ul>     
                                </li>   
                            </ul>
                        </div>   
                    </div>

                    <%-- popup contenant les informations de liste au click --%>
                    <div id="myModal" class="modal fade">
                        modal to append data
                    </div>

                    <header id="nav-bar" class="container">
                        <div class="row">
                            <div class="span12">
                                <div id="header-container">
                                    <a id="backbutton" class="win-backbutton" onclick="history.back(1);"></a>
                                    <h5 id="categoryTitle">Home</h5>
                                    <!--                            <a data-toggle="modal" href="#myModal" class="btn btn-primary">Show Flyout (classic modal)</a>-->
                                    <div class="dropdown">
                                        <a class="header-dropdown dropdown-toggle accent-color" data-toggle="dropdown" href="#" >
                                            Ecoscope Data
                                            <b class="caret"></b>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="category" id="BDDCategory" href="#bddCategory">Base de données</a></li>
                                            <li><a class="category" id="picturesCategory" href="#picturesCategory">images</a></li>
                                            <li><a class="category" id="contactCategory" href="#contactsCategory">Contacts</a></li>
                                            <li><a class="category" id="indicatorCategory" href="#indicateursCategory">Indicateurs</a></li>
                                            <li><a class="category" id="publicationsCategory" href="#publicationsCategory" >Référence bibliographique</a></li>
                                            <li><a class="category" id="atlasCategory" href="#atlasCategory">Atlas Thonier</a></li>
                                            <li><a class="category" id="satCategory" href="#satCategory">satellites data</a></li>
                                            <li class="divider"></li>
                                            <li><a class="category" id="homeCategory" href="#homeCategory">Home</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div id="top-info" class="pull-right">

                                    <button  style="display:none;" class="win-command closeIndividualData " rel="tootlip" title="Command with image with border ring">      
                                        <span class="win-commandimage win-commandring">         
                                            <img src="<s:url value="/css/img/sample-tiles.png"/>" width="42" height="42" alt=""/>      
                                        </span>   
                                    </button>
                                    <!--                                    <a href="#" class="win-command pull-right" >
                                                                            <span class="win-commandicon win-commandring  icon-link" id="permalink" style="display:none;"></span>
                                                                        </a> -->

                                    <a id="settings" href="#" class="win-command pull-right">
                                        <span class="win-commandicon win-commandring  icon-search" id="openSearchBar"></span>
                                    </a>     
                                </div>
                            </div>
                        </div>
                    </header>


                    <div class="container" id="individualContentBloc" >
                        <div id="individualData" style="width:100%;height:auto;"></div>
                    </div>
                    <div class="container" id="pageContent">
                        <s:if test="%{#parameters['permalinkView'] != null}">  
                            <div id="permalinkData" permalinkView="<%= request.getParameter("permalinkView")%>" request="<%= request.getParameter("request")%>"  endpointlocation="<%= request.getParameter("endpointlocation")%>"></div>
                        </s:if>
                        <s:else>
                            <s:include value="/webpages/category/homeCategory.jsp"/>
                        </s:else>


                    </div>


                    <div id="charms" class="win-ui-dark slide">
                        <div id="theme-charms-section" class="charms-section" style="height:100%;">
                            <div class="charms-header">
                                <a href="#" class="close-charms win-backbutton" id="closeSearchBar"></a>
                                <h2>Recherche</h2>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">

                                    <div class="span8">
                                        <input style="width:100%;" id="searchAutoCompletion" type="text" class="search-query input" placeholder="Search" onkeypress="return handleEnter(this, event)"/>
                                    </div>
                                    <div class="span4">
                                        <button id="validateCompletion"  style="width:100%;" class="btn">OK</button>
                                    </div>


                                </div>
                            </div>


                            <script type="text/javascript">

                                //autocompletion
                                //supprimer l'action de la touche entré sur l'input de la barre de recherche
                                function handleEnter(field, event) {
                                    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
                                    if (keyCode === 13) {
                                        var i;
                                        for (i = 0; i < field.form.elements.length; i++)
                                            if (field === field.form.elements[i])
                                                break;
                                        i = (i + 1) % field.form.elements.length;
                                        field.form.elements[i].focus();
                                        return false;
                                    }
                                    else
                                        return true;
                                }

                            </script>
                            <style>
                                .metro-nav-list .nav > li > a{
                                    margin-left:0 !important;
                                }
                                .well{
                                    border:0 !important;
                                    background-color:transparent !important;
                                }
                            </style>

                            <div class="" id="mozaicHolder" style="height: 83%;overflow-y: auto;">

                            </div> <!-- /well -->
                        </div>
                    </div>
                </div>
                </div>


                <!-- Grab Google CDN's jQuery. fall back to local if necessary -->
                <script src="//code.jquery.com/jquery-1.10.0.min.js"></script>
                <script>window.jQuery || document.write("<s:url value="/js/bootstrapMetro/jquery-1.10.0.min.js"/>")</script>

                <!--[if IE 7]>
                <script type="text/javascript" src="scripts/bootmetro-icons-ie7.js">
                <![endif]-->

                <script type="text/javascript" src="<s:url value="/js/bootstrapMetro/min/bootstrap.min.js"/>"></script>
                <script type="text/javascript" src="<s:url value="/js/jquery.shorten.1.0.js"/>"></script>
                <%--<script type="text/javascript" src="<s:url value="/js/bootstrapMetro/bootmetro-panorama.js"/>"></script>--%>
                <%--<script type="text/javascript" src="<s:url value="/js/bootstrapMetro/bootmetro-pivot.js"/>"></script>
                <script type="text/javascript" src="<s:url value="/js/bootstrapMetro/bootmetro-charms.js"/>"></script>
                <script type="text/javascript" src="<s:url value="/js/bootstrapMetro/bootstrap-datepicker.js"/>"></script>

            <script type="text/javascript" src="<s:url value="/js/bootstrapMetro/jquery.mousewheel.min.js"/>"></script>
            <script type="text/javascript" src="<s:url value="/js/bootstrapMetro/jquery.touchSwipe.min.js"/>"></script>--%>


                <%--read more --%>
                <%--<script src="<s:url value="/js/readmore.js"/>"></script>--%>



                <script type="text/javascript" src="<s:url value="/webpages/tools/refactorFunction.js"/>"></script>
                <%--<script type="text/javascript" src="<s:url value="/js/bootstrapMetro/holder.js"/>"></script>--%>
                <!--<script type="text/javascript" src="./assets/js/perfect-scrollbar.with-mousewheel.min.js"></script>-->
                <%--<script type="text/javascript" src="<s:url value="/js/bootstrapMetro/demo.js"/>"></script>--%>


                <%-- show more less --%>
                <%--<script type="text/javascript" src="http://viralpatel.net/blogs/demo/jquery/jquery.shorten.1.0.js"></script>--%>
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/openlayers/2.13.1/OpenLayers.js"/>
                <script type="text/javascript">
                                //                $('.panorama').panorama({
                                //                    //nicescroll: false,
                                //                    showscrollbuttons: true,
                                //                    keyboard: true,
                                //                    parallax: true
                                //                });

                                //      $(".panorama").perfectScrollbar();
                                //$('#pivot').pivot();

                                //*** historique de navigation ***/


                </script>
            </body>
    </html>
</s:i18n>