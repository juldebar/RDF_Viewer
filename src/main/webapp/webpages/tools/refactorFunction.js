$(window).load(function () {
    //pour tester si un div existe
    jQuery.fn.exists = function () {
        return this.length > 0;
    };

    //initialisation de variable commune
    var category = "";
    var offset = 0;
    var totalItem = "";
    var lang = $("body").attr("lang");
    var letterToPaginate = "";

    //permet de garder en mémoire la requête pour générer le permalink
    var queryIndividual = {
        request: "",
        uri: "",
        endpointlocation: "",
        view: ""
    };
    var eventObject = {
        category: '.category',
        loadMore: '.loadMoreCategory',
        loadLess: '.loadLessCategory',
        pagination: '.abcPagination',
        permalink: '#permalink',
        permalinkHolder: "#permalinkData",
        closeIndividualData: '.closeIndividualData',
        openSearchBar: '#openSearchBar',
        closeSearchBar: '#closeSearchBar',
        closeModal: '.closeModal',
        closeDataTable: '.closeDataTable',
        showDataTable: '#showDataTable',
        brand: '.brand',
        titleSearchList: ".titleSearchList",
        validateCompletion: '#validateCompletion'

    };
    var contentHolder = {
        pageContent: "pageContent",
        menuHolder: "mozaicHolder"
    };

    //fonctions principales
    var dataEcoscope =
            {
                home: {
                    init: function () {
                        //test si on est sur une page permalink
                        if ($(eventObject.permalinkHolder).exists()) {
                            dataEcoscope.permalink();
                        }

                        //on charge le menu marbec
                        dataEcoscope.home.loadMenu();

                        //on ajoute les listeners nécessaire à la navigation
                        dataEcoscope.eventListener();

                        //initialisation de la navigation ajax
                        dataEcoscope.ajaxNavigation();

                        history.pushState({
                            key: "category",
                            category: "homeCategory"
                        }, null, "ShowResource.action?view=index&type=homeCategory");

                        //on initialise les compteurs de la home
                        dataEcoscope.home.CategoryCount("picturesHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/picture");
                        dataEcoscope.home.CategoryCount("bddHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/dataBase");
                        dataEcoscope.home.CategoryCount("contactsHomeLabel", "http://xmlns.com/foaf/0.1/Person");
                        dataEcoscope.home.CategoryCount("indicateursHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/indicator");
                        dataEcoscope.home.CategoryCount("publicationsHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/publication");

                        dataEcoscope.home.CategoryCount("satHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/multidimensionnalData");


                    },
                    //compteur des ressources par catégories
                    CategoryCount: function (divToAppend, countType) {
                        //variable contenant la requête
                        var queryHome = {
                            countType: countType,
                            queryCount: "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT (COUNT(?picture) AS ?pictureCount)  WHERE { ?picture rdf:type  <" + countType + ">}",
                            view: "countView",
                            endpointlocation: "ecoscope"
                        };

                        $.ajax({
                            url: "GetSparqlResult.action",
                            type: "post",
                            dataType: "html",
                            data: {
                                query: queryHome.queryCount,
                                view: queryHome.view,
                                endpointlocation: queryHome.endpointlocation
                            },
                            beforeSend: function (xhr) {
                                $("#" + divToAppend).html("loading");
                            },
                            success: function (data)
                            {
                                $("#" + divToAppend).html(data);
                            },
                            error: function (error)
                            {
                                $("#" + divToAppend).html("no data");
                            }
                        });
                    },
                    // chargement du menu json Marbec
                    loadMenu: function () {
                        $.ajax({
                            url: "GetJson.action",
                            type: "post",
                            dataType: "json",
                            data: {
                                jsonPath: "http://mdst-macroes.ird.fr/cdn/MenuEcoscope.json"
                            },
                            beforeSend: function (xhr) {

                            },
                            success: function (data)
                            {
                                var dataset = data;
                                var jObjMenu = $("#globalMenu"),
                                        jObjModel = $("<li/>", {
                                            "html": '<a target="_blank" class="maClasse" href="#">Menu</a>'
                                        }),
                                        jObjLi = null,
                                        jObjA = null,
                                        jObjSLi = null,
                                        jObjSA = null;

                                $.each(dataset[ "menu" ], function (i, item) {
                                    jObjLi = jObjModel.clone();
                                    jObjA = jObjLi.find("a");

                                    jObjA.text(item[ "name" ]);
                                    jObjA.attr("class", item[ "classe" ]);
                                    jObjA.attr("href", item[ "url" ]);
                                    jObjA.attr("title", item[ "info" ]);

                                    if (item[ "sousMenu" ]) {
                                        jObjA.addClass("dropdown-toggle");
                                        jObjA.attr("data-toggle", "dropdown-submenu");
                                        jObjLi.addClass("dropdown");
                                        jObjLi.addClass("dropdown-submenu");
                                        jObjLi.append('<ul class="dropdown-menu"></ul>');

                                        $.each(item[ "sousMenu" ], function (j, jtem) {
                                            jObjSLi = jObjModel.clone(),
                                                    jObjSA = jObjSLi.find("a");

                                            jObjSA.text(jtem[ "name" ]);
                                            jObjSA.attr("class", jtem[ "classe" ]);
                                            jObjSA.attr("href", jtem[ "url" ]);

                                            jObjLi.find("ul").append(jObjSLi);
                                            jObjLi.find("ul").css("margin-left", "25%");
                                        });
                                    }

                                    jObjMenu.append(jObjLi);
                                });
                            },
                            error: function (error)
                            {
                            }
                        });
                    }
                },
                /***** gestion des catégories de données ******/
                category: {
                    //initialisation de la requête de la catégorie cliqué
                    loadCategory: function (category) {
                        var query = {
                            endpointlocation: "",
                            request: "",
                            view: "",
                            divToAppend: ""
                        };
                        query.endpointlocation = "ecoscope";
                        switch (category) {
                            case "BDDCategory":
                                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?database ?Title WHERE { ?database rdf:type <http://www.ecoscope.org/ontologies/resources_def/dataBase> . ?database skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                                query.view = "bddCategory-result";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                query.view = "bddListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("bddIndividualData", query.endpointlocation);
                                break;
                            case "picturesCategory":
                                if (offset !== 0) {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?picture ?Title WHERE { ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def/picture> . ?picture dc:title ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\"))} LIMIT 20 offset" + offset;
                                } else {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?picture ?Title WHERE { ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def/picture> . ?picture dc:title ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\"))} LIMIT 20";
                                }
                                query.view = "picturesCategory-result";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                query.view = "pictureListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("pictureIndividualData", query.endpointlocation);
                                break;
                            case "indicatorCategory":
                                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?indicator ?Title ?identifier WHERE { ?indicator rdf:type <http://www.ecoscope.org/ontologies/resources_def/indicator> . ?indicator dc:title ?Title. ?indicator dc:identifier ?identifier}LIMIT 30";
                                query.view = "indicatorsCategory-result";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                query.view = "indicatorListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("indicateurIndividualData", query.endpointlocation);
                                break;
                            case "contactCategory":

                                var filterAlphabet = '.FILTER regex(?name, \"^' + letterToPaginate + '\","i")';
                                if (offset !== 0) {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?agent ?name ?depiction WHERE {?agent rdf:type <http://xmlns.com/foaf/0.1/Person> .?agent foaf:name ?name.OPTIONAL { ?agent foaf:depiction ?depiction  } " + filterAlphabet + " }ORDER BY ASC(?name) LIMIT 20 OFFSET " + offset;
                                } else {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?agent ?name ?depiction WHERE {?agent rdf:type <http://xmlns.com/foaf/0.1/Person> .?agent foaf:name ?name.OPTIONAL { ?agent foaf:depiction ?depiction  }" + filterAlphabet + " }ORDER BY ASC(?name) LIMIT 20";
                                }
                                query.view = "contactCategory-result";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                query.view = "contactListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("contactIndividualData", query.endpointlocation);
                                break;
                            case "publicationsCategory":
                                //gestion de la pagination dans les pages
                                if (offset !== 0) {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?publication ?Title WHERE { ?publication rdf:type <http://www.ecoscope.org/ontologies/resources_def/publication> . ?publication dc:title ?Title } LIMIT 20 OFFSET " + offset;
                                } else {
                                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?publication ?Title WHERE { ?publication rdf:type <http://www.ecoscope.org/ontologies/resources_def/publication> . ?publication dc:title ?Title } LIMIT 20";
                                }
                                //chartement du résultat par catégorie
                                query.view = "publicationCategory-result";
                                query.endpointlocation = "ecoscope";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                //on remplit le menu associé
                                query.view = "publicationListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("publicationIndividualData", query.endpointlocation);
                                break;
                            case "homeCategory":
                                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?indicator ?identifier WHERE {<http://www.ecoscope.org/ontologies/ecosystems/thunnus_obesus> <http://www.ecoscope.org/ontologies/resources_def/has_related_indicator> ?indicator .?indicator dc:identifier ?identifier.FILTER regex(?identifier, '.xml', 'i')}";
                                query.view = "home-result";
                                query.endpointlocation = "ecoscope";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                dataEcoscope.home.init();
                                break;
                            case "atlasCategory":
                                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT  ?species ?label WHERE {?species  skos:prefLabel ?label .?species rdf:type <http://www.ecoscope.org/ontologies/ecosystems_def/tuna>}";
                                query.view = "atlas-result";
                                query.endpointlocation = "ecoscope";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                dataEcoscope.individualData.initIndividualData("speciesIndividualData", query.endpointlocation);
                                break;
                            case "satCategory":
                                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?satellite ?Title WHERE { ?satellite rdf:type <http://www.ecoscope.org/ontologies/resources_def/multidimensionnalData> . ?satellite skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                                alert(query.request);
                                query.view = "satCategory-result";
                                dataEcoscope.category.loadData(query, contentHolder.pageContent);
                                query.view = "bddListSearch";
                                dataEcoscope.category.loadData(query, contentHolder.menuHolder);
                                dataEcoscope.individualData.initIndividualData("bddIndividualData", query.endpointlocation);
                                break;
                        }
                    },
                    //requête ajax pour récupérer la catégorie en fonction de la requête définir dans loadData
                    loadData: function (query, divToAppend) {
                        $.ajax({
                            url: "GetSparqlResult.action",
                            type: "post",
                            dataType: "html",
                            data: {
                                query: query.request,
                                view: query.view,
                                endpointlocation: query.endpointlocation
                            },
                            beforeSend: function (xhr) {
                                $("#" + divToAppend).html("<div id='loadingProgressG'><div id='loadingProgressG_1' class='loadingProgressG'></div></div>");
                            },
                            success: function (data)
                            {
                                var dataToLoad = data;
                                $("#" + divToAppend).html(dataToLoad);

                                if ($(".categoryTitle").exists()) {
                                    $(".categoryTitle").shorten({
                                        "showChars": 45,
                                        "moreText": "",
                                        "lessText": ""
                                    });
                                }


                                if ($(".pagination").exists()) {
                                    if (offset !== 0) {
                                        $('#offsetStart').html(offset);
                                        $('#offsetEnd').html(offset + 20);
                                    } else {
                                        $('#offsetStart').html("0");
                                        $('#offsetEnd').html("20");
                                    }
                                }

                                if (divToAppend === "homeCategory") {
                                    dataEcoscope.home.init();
                                }
                            },
                            error: function (error)
                            {

                            }
                        });

                    }
                },
                /***** gestion des donnée individuel par URI ******/
                individualData: {
                    //initialisation du click sur individualData et pushState ajax
                    initIndividualData: function (viewIndividualData, endpointlocation) {
                        var viewIndividualData = viewIndividualData;

                        $(document).off('click', '.individualData');
                        $(document).on("click", ".individualData", function (e) {


                            e.preventDefault();
                            var uriIndividual = $(this).attr('id');

                            if ($(this).attr('view') !== undefined) {
                                viewIndividualData = $(this).attr('view');
                            } else {

                            }

                            //génération de l'url pour la navigation ajax
                            var url = "ShowResource.action?view=index&type=" + viewIndividualData + "-" + uriIndividual.substr(uriIndividual.lastIndexOf('/') + 1);

                            history.pushState({
                                key: "individualData",
                                category: "",
                                view: viewIndividualData,
                                uri: uriIndividual
                            }, null, url);

                            dataEcoscope.individualData.IndividualDataSwitch(viewIndividualData, uriIndividual);
                        });
                    },
                    //chargement ajax de la donnée en fonction de la requête définie dans IndividualDataSwitch
                    loadIndividualData: function (viewIndividual, queryIndividual, endpointlocation) {
                        $.ajax({
                            url: "GetSparqlResult.action",
                            type: "post",
                            dataType: "html",
                            data: {
                                query: queryIndividual,
                                view: viewIndividual,
                                endpointlocation: endpointlocation
                            },
                            beforeSend: function (xhr) {
                                dataEcoscope.animation.showIndividualData();
                                $("#individualData").html("");
                                $("#individualData").html("<div id='loadingProgressG'><div id='loadingProgressG_1' class='loadingProgressG'></div></div>");
                            },
                            success: function (data)
                            {
                                var dataToLoadIndiv = data;
                                $("#individualData").html(dataToLoadIndiv);
                                $(".comment").shorten({
                                    "showChars": 200,
                                    "moreText": "See More",
                                    "lessText": "Less"
                                });

                                if ($("#startDate").exists()) {
                                    var startDate = $("#startDate").html();
                                    var endDate = $("#endDate").html();
                                    startDate = startDate.split("T");
                                    endDate = endDate.split("T");
                                    $("#startDate").html(startDate[0]);
                                    $("#endDate").html(endDate[0]);
                                }
                                dataEcoscope.list.getList(data);

                            },
                            error: function (error)
                            {

                            }
                        });
                    },
                    IndividualDataSwitch: function (viewIndividualData, uriIndividual) {
                        queryIndividual = {
                            request: "",
                            uri: "",
                            endpointlocation: "",
                            view: ""
                        };

                        queryIndividual.uri = uriIndividual;
                        queryIndividual.endpointlocation = "ecoscope";
                        queryIndividual.view = viewIndividualData;


                        switch (viewIndividualData) {
                            case "bddIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?subject ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?startDate ?endDate ?spatialExtent ?depiction WHERE { <" + uriIndividual + "> skos:prefLabel ?Title . OPTIONAL {<" + uriIndividual + "> dc:description ?description }. OPTIONAL {<" + uriIndividual + "> dc:date ?date }. OPTIONAL {<" + uriIndividual + "> dc:creator ?creator }. OPTIONAL {<" + uriIndividual + "> dc:contributor ?contributor }. OPTIONAL {<" + uriIndividual + "> dc:rights ?rights }. OPTIONAL {<" + uriIndividual + "> dc:format ?format }. OPTIONAL {<" + uriIndividual + "> dc:type ?type }. OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }. OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?spatialExtent} .OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }.OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> foaf:depiction ?depiction }. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "pictureIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?partOfImageGallery (group_concat(distinct ?subject ; separator='#') as ?subjects ) WHERE {<" + uriIndividual + "> dc:title ?Title .OPTIONAL { <" + uriIndividual + "> dc:subject ?subject } .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> dc:date ?date } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> dc:contributor ?contributor } .OPTIONAL { <" + uriIndividual + "> dc:rights ?rights } .OPTIONAL { <" + uriIndividual + "> dc:format ?format } .OPTIONAL { <" + uriIndividual + "> dc:type ?type } .OPTIONAL { <" + uriIndividual + "> ical:dtstart ?startDate } .OPTIONAL { <" + uriIndividual + "> ical:dtend ?endDate } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/partOfImageGallery> ?partOfImageGallery } . FILTER(langMatches(lang(?Title), \"" + lang + "\")). FILTER(langMatches(lang(?description), \"" + lang + "\"))} GROUP BY ?Title ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?partOfImageGallery ";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "contactIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('" + uriIndividual + "' as ?uri) ?name ?firstName ?family_name ?gender ?niceDepiction ?description ?isMemberOf ?phone ?homepage ?workplaceHomepage ?workInfoHomepage ?birthday  (group_concat(distinct ?knows ; separator='#') as ?knowss )  (group_concat(distinct ?prefGeoGraphicObject ; separator='#') as ?prefGeoGraphicObjects ) (group_concat(distinct ?fundedBy ; separator='#') as ?fundedBys ) (group_concat(distinct ?img ; separator='#') as ?imgs ) (group_concat(distinct ?logo ; separator='#') as ?logos ) (group_concat(distinct ?currentProject ; separator='#') as ?currentProjects ) WHERE {<" + uriIndividual + "> foaf:name ?name .OPTIONAL { <" + uriIndividual + "> foaf:firstName ?firstName } .OPTIONAL { <" + uriIndividual + "> foaf:family_name ?family_name } .OPTIONAL { <" + uriIndividual + "> foaf:gender ?gender } .OPTIONAL { <" + uriIndividual + "> foaf:img ?img } .OPTIONAL { <" + uriIndividual + "> foaf:logo ?logo } .OPTIONAL { <" + uriIndividual + "> foaf:fundedBy ?fundedBy } .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> foaf:isMemberOf ?isMemberOf } .OPTIONAL { <" + uriIndividual + "> foaf:phone ?phone } .OPTIONAL { <" + uriIndividual + "> foaf:homepage ?homepage } .OPTIONAL { <" + uriIndividual + "> foaf:currentProject ?currentProject } .OPTIONAL { <" + uriIndividual + "> foaf:workplaceHomepage ?workplaceHomepage } .OPTIONAL { <" + uriIndividual + "> foaf:workInfoHomepage ?workInfoHomepage } .OPTIONAL { <" + uriIndividual + "> foaf:knows ?knows } .OPTIONAL { <" + uriIndividual + "> foaf:birthday ?birthday } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?prefGeoGraphicObject }. FILTER(langMatches(lang(?gender), \"" + lang + "\"))} GROUP BY ?name ?firstName ?family_name ?gender ?niceDepiction ?description?isMemberOf ?phone ?homepage ?workplaceHomepage ?workInfoHomepage ?birthday";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "publicationIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title  ?description ?depiction ?contributor ?rights ?type ?format ?date  (group_concat(distinct ?subject ; separator='#') as ?subjects ) (group_concat(distinct ?creator ; separator='#') as ?creators ) (group_concat(distinct ?identifier ; separator='#') as ?identifiers ) WHERE {<" + uriIndividual + "> dc:title ?Title .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> dc:date ?date } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> dc:contributor ?contributor } .OPTIONAL { <" + uriIndividual + "> dc:rights ?rights } .OPTIONAL { <" + uriIndividual + "> dc:format ?format } .OPTIONAL { <" + uriIndividual + "> dc:type ?type } .OPTIONAL { <" + uriIndividual + "> dc:identifier ?identifier } .OPTIONAL { <" + uriIndividual + "> ical:dtstart ?startDate } .OPTIONAL { <" + uriIndividual + "> ical:dtend ?endDate }.OPTIONAL { ?subject foaf:isPrimaryTopicOf <" + uriIndividual + ">}} GROUP BY ?Title  ?description ?depiction ?contributor ?rights ?type ?format ?date ";

                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "indicateurIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX dct: <http://purl.org/dc/terms/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def/> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?TitlenoLang ?process (group_concat(distinct ?subject; separator='#') as ?subjects) (group_concat(distinct ?identifier; separator='#') as ?identifiers) (group_concat(distinct ?tableIdentifier; separator='#') as ?tableIdentifiers) (group_concat(distinct ?creator; separator='#') as ?creators) WHERE {<" + uriIndividual + "> dc:title ?TitlenoLang  .OPTIONAL { <" + uriIndividual + "> dc:title ?Title . FILTER(langMatches(lang(?Title), \"" + lang + "\")). FILTER(langMatches(lang(?TitlenoLang), \"" + lang + "\"))} .OPTIONAL { <" + uriIndividual + "> dc:identifier ?identifier }.OPTIONAL { <" + uriIndividual + "> dc:identifier ?tableIdentifier } .OPTIONAL { <" + uriIndividual + "> dc:subject ?subject } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> resources_def:usesProcess ?process }.FILTER regex(?identifier, \".html\", \"i\").FILTER (!regex(?identifier, \"_table.html\", \"i\")).FILTER(regex(?tableIdentifier, \"_table.html\", \"i\")) } GROUP BY ?Title ?TitlenoLang ?process";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "speciesIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('" + uriIndividual + "' as ?uri) ?prefLabel ?description (group_concat(distinct ?altLabel; separator='#') as ?altLabels) (group_concat(distinct ?person; separator='#') as ?persons) (group_concat(distinct ?relatedDatabase; separator='#') as ?relatedDatabases) (group_concat(distinct ?depiction; separator='#') as ?depictions) (group_concat(distinct ?indicator; separator='#') as ?indicators) WHERE {<" + uriIndividual + "> skos:prefLabel ?prefLabel .OPTIONAL { <" + uriIndividual + "> skos:note ?description } .OPTIONAL { <" + uriIndividual + "> skos:altLabel ?altLabel } .OPTIONAL { ?person  foaf:topic_interest <" + uriIndividual + ">} .OPTIONAL { <" + uriIndividual + "> ecosystems_def:used_data_source ?relatedDatabase }.OPTIONAL { <" + uriIndividual + "> foaf:depiction ?depiction } .OPTIONAL { <" + uriIndividual + "> resources_def:has_related_indicator ?indicator } .} GROUP BY ?prefLabel ?description";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                            case "satIndividualData":
                                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?subject ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?startDate ?endDate ?spatialExtent ?depiction WHERE { <" + uriIndividual + "> skos:prefLabel ?Title . OPTIONAL {<" + uriIndividual + "> dc:description ?description }. OPTIONAL {<" + uriIndividual + "> dc:date ?date }. OPTIONAL {<" + uriIndividual + "> dc:creator ?creator }. OPTIONAL {<" + uriIndividual + "> dc:contributor ?contributor }. OPTIONAL {<" + uriIndividual + "> dc:rights ?rights }. OPTIONAL {<" + uriIndividual + "> dc:format ?format }. OPTIONAL {<" + uriIndividual + "> dc:type ?type }. OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }. OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?spatialExtent} .OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }.OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> foaf:depiction ?depiction }. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                                dataEcoscope.individualData.loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                                break;
                        }
                    }
                },
                list: {
                    getList: function (data) {
                        //console.log(data);
                        var dataList = $(data).find('.niceList');
                        var idList;
                        var uri;
                        var seen = {};

                        //console.log(dataList);
                        $(dataList).each(function (i) {
                            var queryList = {
                                idList: "",
                                request: "",
                                endpointlocation: "",
                                view: ""
                            };
                            idList = $(this).attr('id');

                            var txt = idList;
                            if (seen[txt]) {

                                $(this).remove();
                                return true;
                            }
                            else {
                                seen[txt] = true;
                                idList = $(this).attr('id');
                                uri = $(this).attr('uri');



                                //$("#" + idList).html("hello wolrd this is it");
                                switch (idList) {
                                    case "subjectList":
                                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def:  <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ?Title ?subject WHERE { <" + uri + "> skos:prefLabel  ?Title . <" + uri + "> dc:subject  ?subject. FILTER(langMatches(lang(?Title), \"FR\"))}";

                                        queryList.endpointlocation = "ecoscope";
                                        queryList.view = "subjectList";
                                        queryList.idList = idList;
                                        dataEcoscope.list.loadList(queryList);
                                        break;
                                    case "publicationList":
                                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?publications WHERE {<" + uri + "> foaf:name ?name .OPTIONAL { <" + uri + "> foaf:publications ?publications } }";
                                        queryList.endpointlocation = "ecoscope";

                                        queryList.view = "publicationList";
                                        queryList.idList = idList;
                                        dataEcoscope.list.loadList(queryList);
                                        break;
                                    case "topicInterestList":
                                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?topic_interest WHERE {<" + uri + "> foaf:name ?name .OPTIONAL { <" + uri + "> foaf:topic_interest ?topic_interest }}LIMIT 5";

                                        queryList.endpointlocation = "ecoscope";
                                        queryList.view = "topicInterestList";
                                        queryList.idList = idList;
                                        dataEcoscope.list.loadList(queryList);
                                        break;
                                    case "publicationSpeciesList":
                                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?publications WHERE {<" + uri + ">  skos:prefLabel ?name .OPTIONAL { <" + uri + ">  foaf:isPrimaryTopicOf ?publications } }";
                                        queryList.endpointlocation = "ecoscope";

                                        queryList.view = "publicationList";
                                        queryList.idList = idList;
                                        dataEcoscope.list.loadList(queryList);
                                        break;
                                }
                            }
                        });
                    },
                    loadList: function (queryList) {
                        $.ajax({
                            url: "GetSparqlResult.action",
                            type: "post",
                            dataType: "html",
                            data: {
                                query: queryList.request,
                                view: queryList.view,
                                endpointlocation: queryList.endpointlocation
                            },
                            beforeSend: function (xhr) {
                                $("#" + queryList.idList).html("<div class='progress progress-indeterminate' style='margin-top:30%;margin-left:20%;'><div class='bar'></div></div>");
                            },
                            success: function (data)
                            {


                                var dataToLoad = data;
                                $("#" + queryList.idList).html(dataToLoad);
                            },
                            error: function (error)
                            {
                                //console.log(JSON.stringify(error));
                            }
                        });
                    }
                },
                animation: {
                    showIndividualData: function () {
                        $("#individualContentBloc").show();
                        $("#" + contentHolder.pageContent).hide();
                        $('.closeIndividualData').show();
                        $('#permalink').show();
                    },
                    hideIndividualData: function () {
                        $("#individualContentBloc").hide();
                        $("#" + contentHolder.pageContent).show();
                        $('.closeIndividualData').hide();
                        $('#permalink').hide();

                        $("body").animate({
                            marginTop: "0"
                        }, 500, function () {
                            // Animation complete.
                        });

                    },
                    setPageTitle: function (categoryTitle) {
                        $("#categoryTitle").html(categoryTitle);
                    }
                },
                eventListener: function () {
                    $(document).on("click", eventObject.category, function (e) {
                        e.preventDefault();
                        offset = 0;
                        category = $(this).attr('id');

                        dataEcoscope.category.loadCategory(category);
                        dataEcoscope.animation.setPageTitle(category.replace('Category', ''));
                        dataEcoscope.animation.hideIndividualData();

                        var url = "ShowResource.action?view=index&type=" + category;
                        history.pushState({
                            key: "category",
                            category: category
                        }, null, url);


                    });
                    $(document).on('click', eventObject.permalink, function (e) {
                        e.preventDefault();
                        console.log("query : " + queryIndividual.request);
                        console.log("query : " + queryIndividual.uri);
                        console.log("query : " + queryIndividual.endpointlocation);
                        console.log("query : " + queryIndividual.endpointlocation);
                        console.log("query :" + queryIndividual.view);

                        var request = encodeURIComponent(queryIndividual.request);
                        var uri = queryIndividual.uri;
                        var endpointlocation = queryIndividual.endpointlocation;
                        var viewType = queryIndividual.view;

                        var url = window.location.protocol + "//" + window.location.hostname + ":" + window.location.port + "/dataEcoscope/permalink.action";
                        var requestPermalink = "?request=" + request + "&permalinkView=" + viewType + "&endpointlocation=" + endpointlocation;
                        var finalUrl = encodeURI(url + requestPermalink);
                        $('#myModal').html("<div class='row-fluid'><p><h3>URL vers la page : </h3>" + finalUrl + "</p></div>");
                        $('#myModal').modal('show');

                    });
                    $(document).on('click', eventObject.closeIndividualData, function (e) {
                        e.preventDefault();
                        dataEcoscope.animation.hideIndividualData();
                    });
                    $(document).on('click', eventObject.openSearchBar, function (e) {
                        e.preventDefault();
                        $('#charms').css('right', '0');
                    });
                    $(document).on('click', eventObject.closeSearchBar, function (e) {
                        e.preventDefault();
                        $('#charms').css('right', '-320px');
                    });
                    $(document).on('click', eventObject.closeModal, function (e) {
                        $('#myModal').modal('hide');
                    });
                    $(document).on('click', eventObject.brand, function (e) {
                        dataEcoscope.category.loadCategory("homeCategory");
                    });
                    $(document).on('click', eventObject.closeDataTable, function (e) {
                        $("#dataTable").modal("hide");
                    });
                    $(document).on('click', eventObject.showDataTable, function (e) {
                        $("#dataTable").modal("show");
                    });
                    $(document).on("click", eventObject.loadMore, function () {
                        totalItem = $(this).attr('totalItem');
                        if (offset <= totalItem) {
                            offset += 20;
                            offsetCategory = $(this).attr('id');
                            dataEcoscope.category.loadCategory(offsetCategory);
                        }

                    });
                    $(document).on("click", eventObject.loadLess, function () {
                        offsetCategory = $(this).attr('id');
                        if (offset !== 0) {
                            offset -= 20;
                            dataEcoscope.category.loadCategory(offsetCategory);
                        } else {
                            offset = 0;
                            $(".loadLessCategory").hide();
                        }
                    });
                    $(document).on('click', eventObject.pagination, function (e) {
                        e.preventDefault();
                        offset = 0;
                        letterToPaginate = $(this).children().html();
                        dataEcoscope.category.loadCategory($(this).parent().attr('class'));
                    });

                    /**************************************************/
                    /*******navigation dans le menu de droite**********/
                    /**************************************************/
                    $(document).on("mouseenter", eventObject.titleSearchList, function () {

                        $(this).next().css('max-height', '600px');
                    }).on("mouseleave", ".titleSearchList", function () {
                        $(this).next().css('max-height', '200px');

                    });
                    /************************************************/
                    /*****************auto completion ***************/
                    /************************************************/
                    $(document).on('click', eventObject.validateCompletion, function (e) {
                        dataEcoscope.searchForm.loadResult();
                        e.preventDefault();
                    });
                },
                searchForm: {
                    loadResult: function () {
                        var id = $('#searchAutoCompletion').val();
                        var query = "PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT DISTINCT ?uri ?label WHERE {?uri rdf:type ?type. ?type rdfs:subClassOf* owl:Thing. ?uri skos:prefLabel|skos:altLabel|skos:hiddenLabel ?label. FILTER regex (str(?label), \"" + id + "\", 'i') .}LIMIT 10";

                        $.ajax({
                            url: "GetSparqlResult.action",
                            type: "post",
                            dataType: "html",
                            data: {
                                query: query,
                                view: "defaultLeftList",
                                endpointlocation: "ecoscope"
                            },
                            beforeSend: function (xhr) {
                                $("#" + contentHolder.menuHolder).html("<div class='progress progress-indeterminate' style='margin-top:30%;margin-left:20%;'><div class='bar'></div></div>");
                            },
                            success: function (data)
                            {
                                $("#" + contentHolder.menuHolder).html(data);
                            },
                            error: function (error)
                            {
                                $("#" + contentHolder.menuHolder).html("error");
                            }
                        });
                        return false;
                    }
                },
                ajaxNavigation: function () {
                    window.onpopstate = function (event) {
                        dataEcoscope.animation.hideIndividualData();
                        if (event.state === null) {
                            //si il n'existe pas d'historique
                        } else {
                            if (event.state.key === "category") {

                                dataEcoscope.category.loadCategory(event.state.category);
                            }
                            if (event.state.key === "individualData") {
                                dataEcoscope.individualData.IndividualDataSwitch(event.state.view, event.state.uri);

                            }
                            console.log(event.state.category);

                        }
                    };
                },
                permalink: function () {
                    var permalinkRequest = $("#permalinkData").attr("request");
                    permalinkRequest = decodeURIComponent(permalinkRequest);
                    var permalinkEndpointlocation = $("#permalinkData").attr("endpointlocation");
                    var permalinkView = $("#permalinkData").attr("permalinkView");
                    dataEcoscope.individualData.loadIndividualData(permalinkView, permalinkRequest, permalinkEndpointlocation);
                }

            };

    dataEcoscope.home.init();
});