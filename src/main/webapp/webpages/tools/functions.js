


$(document).ready(function () {
    //initialisation de la langue


    
    var lang = $("body").attr("lang");


    //initialisation de la home dans l'historique
    history.pushState({
        key: "category",
        category: "homeCategory"
    }, null, "homeCategory");

    //initialisation de la home
    init();

    //initHome("bddHomeLabel"), appel la fonction init home pour récupérer le nombre de donnée par tuile;
    function init() {
        initHome("picturesHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/picture");
        initHome("bddHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/dataBase");
        initHome("contactsHomeLabel", "http://xmlns.com/foaf/0.1/Person");
        initHome("indicateursHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/indicator");
        initHome("publicationsHomeLabel", "http://www.ecoscope.org/ontologies/resources_def/publication");
    }
    var queryHome = {
        countType: "",
        queryCount: "",
        view: "",
        endpointlocation: ""
    };
    //permet de charger le nombre de donnée par catégories
    function initHome(divToAppend, countType) {

        queryHome = {
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
                console.log("divToAppend : " + divToAppend + "countType : " + queryHome.queryCount);
                //$("#pageContent").html("<div id='loadingProgressG'><div id='loadingProgressG_1' class='loadingProgressG'></div></div>");
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
    }

    /****************************************************************************/
    /** fonction permettant de montrer les informations individuels (animation)**/
    /****************************************************************************/
    function showIndividualData() {
        $("#individualContentBloc").show();
        $("#pageContent").hide();
        $('.closeIndividualData').show();
        $('#permalink').show();
    }

    function hideIndividualData() {
        $("#individualContentBloc").hide();
        $("#pageContent").show();
        $('.closeIndividualData').hide();
        $('#permalink').hide();

        $("body").animate({
            marginTop: "0"
        }, 500, function () {
            // Animation complete.

        });

    }

    /*************************************************/
    /***** chargement des données par catégories *****/
    /*************************************************/
    var loadData = function (query, divToAppend) {

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
                    init();
                }
            },
            error: function (error)
            {

            }
        });
    };

    /********************************************************/
    /***** chargement d'une fiche au clic sur une tuile *****/
    /********************************************************/
    var loadIndividualData = function (viewIndividual, queryIndividual, endpointlocation) {


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
                showIndividualData();
                $("#individualData").html("");
//                $("#individualData").html("<div class='progress progress-indeterminate' style='margin: 20% auto 4px 46%;'><div class='bar'></div></div>");
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
                loadList(data);

            },
            error: function (error)
            {

            }
        });
    };


    /*******************************************************************************************/
    /***** chargement des listes une fois le chargement de individualData effectué ************/
    /*****************************************************************************************/
    var loadList = function (data) {
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
                        ajaxLoadList(queryList);
                        break;
                    case "publicationList":
                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?publications WHERE {<" + uri + "> foaf:name ?name .OPTIONAL { <" + uri + "> foaf:publications ?publications } }";
                        queryList.endpointlocation = "ecoscope";

                        queryList.view = "publicationList";
                        queryList.idList = idList;
                        ajaxLoadList(queryList);
                        break;
                    case "topicInterestList":
                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?topic_interest WHERE {<" + uri + "> foaf:name ?name .OPTIONAL { <" + uri + "> foaf:topic_interest ?topic_interest }}LIMIT 5";

                        queryList.endpointlocation = "ecoscope";
                        queryList.view = "topicInterestList";
                        queryList.idList = idList;
                        ajaxLoadList(queryList);
                        break;
                    case "publicationSpeciesList":
                        queryList.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def>  SELECT ?name ?publications WHERE {<" + uri + ">  skos:prefLabel ?name .OPTIONAL { <" + uri + ">  foaf:isPrimaryTopicOf ?publications } }";
                        queryList.endpointlocation = "ecoscope";

                        queryList.view = "publicationList";
                        queryList.idList = idList;
                        ajaxLoadList(queryList);
                        break;
                }
            }
        });
    };

    function ajaxLoadList(queryList) {
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

    /***********************************************************/
    /***** initialisation du click sur chaque fiche ************/
    /***********************************************************/
    var queryIndiv = {
        uri: "",
        request: "",
        endpointlocation: ""
    };

    var initIndividualData = function (viewIndividualData, endpointlocation) {
        var viewIndividualData = viewIndividualData;
        var endpointlocation = endpointlocation;

        $(document).off('click', '.individualData');
        $(document).on("click", ".individualData", function (e) {


            e.preventDefault();
            var uriIndividual = $(this).attr('id');

            if ($(this).attr('view') !== undefined) {
                viewIndividualData = $(this).attr('view');
            } else {

            }
            var url = viewIndividualData + "-" + uriIndividual.substr(uriIndividual.lastIndexOf('/') + 1);
            history.pushState({
                key: "individualData",
                category: "",
                view: viewIndividualData,
                uri: uriIndividual
            }, null, url);

            IndividualDataSwitch(viewIndividualData, uriIndividual);
        });
    };

    var queryIndividual = {
        request: "",
        uri: "",
        endpointlocation: "",
        view: ""
    };

    var IndividualDataSwitch = function (viewIndividualData, uriIndividual) {
        queryIndividual.uri = uriIndividual;
        queryIndividual.endpointlocation = "ecoscope";
        queryIndividual.view = viewIndividualData;


        switch (viewIndividualData) {
            case "bddIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?subject ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?startDate ?endDate ?spatialExtent ?depiction WHERE { <" + uriIndividual + "> skos:prefLabel ?Title . OPTIONAL {<" + uriIndividual + "> dc:description ?description }. OPTIONAL {<" + uriIndividual + "> dc:date ?date }. OPTIONAL {<" + uriIndividual + "> dc:creator ?creator }. OPTIONAL {<" + uriIndividual + "> dc:contributor ?contributor }. OPTIONAL {<" + uriIndividual + "> dc:rights ?rights }. OPTIONAL {<" + uriIndividual + "> dc:format ?format }. OPTIONAL {<" + uriIndividual + "> dc:type ?type }. OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }. OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?spatialExtent} .OPTIONAL {<" + uriIndividual + "> ical:dtstart ?startDate }.OPTIONAL {<" + uriIndividual + "> ical:dtend ?endDate }. OPTIONAL {<" + uriIndividual + "> foaf:depiction ?depiction }. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
            case "pictureIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?partOfImageGallery (group_concat(distinct ?subject ; separator='#') as ?subjects ) WHERE {<" + uriIndividual + "> dc:title ?Title .OPTIONAL { <" + uriIndividual + "> dc:subject ?subject } .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> dc:date ?date } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> dc:contributor ?contributor } .OPTIONAL { <" + uriIndividual + "> dc:rights ?rights } .OPTIONAL { <" + uriIndividual + "> dc:format ?format } .OPTIONAL { <" + uriIndividual + "> dc:type ?type } .OPTIONAL { <" + uriIndividual + "> ical:dtstart ?startDate } .OPTIONAL { <" + uriIndividual + "> ical:dtend ?endDate } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/partOfImageGallery> ?partOfImageGallery } . FILTER(langMatches(lang(?Title), \"" + lang + "\")). FILTER(langMatches(lang(?description), \"" + lang + "\"))} GROUP BY ?Title ?description ?creator ?depiction ?contributor ?rights ?type ?format ?date ?partOfImageGallery ";
                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
            case "contactIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('" + uriIndividual + "' as ?uri) ?name ?firstName ?family_name ?gender ?niceDepiction ?description ?isMemberOf ?phone ?homepage ?workplaceHomepage ?workInfoHomepage ?birthday  (group_concat(distinct ?knows ; separator='#') as ?knowss )  (group_concat(distinct ?prefGeoGraphicObject ; separator='#') as ?prefGeoGraphicObjects ) (group_concat(distinct ?fundedBy ; separator='#') as ?fundedBys ) (group_concat(distinct ?img ; separator='#') as ?imgs ) (group_concat(distinct ?logo ; separator='#') as ?logos ) (group_concat(distinct ?currentProject ; separator='#') as ?currentProjects ) WHERE {<" + uriIndividual + "> foaf:name ?name .OPTIONAL { <" + uriIndividual + "> foaf:firstName ?firstName } .OPTIONAL { <" + uriIndividual + "> foaf:family_name ?family_name } .OPTIONAL { <" + uriIndividual + "> foaf:gender ?gender } .OPTIONAL { <" + uriIndividual + "> foaf:img ?img } .OPTIONAL { <" + uriIndividual + "> foaf:logo ?logo } .OPTIONAL { <" + uriIndividual + "> foaf:fundedBy ?fundedBy } .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> foaf:isMemberOf ?isMemberOf } .OPTIONAL { <" + uriIndividual + "> foaf:phone ?phone } .OPTIONAL { <" + uriIndividual + "> foaf:homepage ?homepage } .OPTIONAL { <" + uriIndividual + "> foaf:currentProject ?currentProject } .OPTIONAL { <" + uriIndividual + "> foaf:workplaceHomepage ?workplaceHomepage } .OPTIONAL { <" + uriIndividual + "> foaf:workInfoHomepage ?workInfoHomepage } .OPTIONAL { <" + uriIndividual + "> foaf:knows ?knows } .OPTIONAL { <" + uriIndividual + "> foaf:birthday ?birthday } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction } .OPTIONAL { <" + uriIndividual + "> <http://www.ecoscope.org/ontologies/geographic_objects_def/prefGeoGraphicObject> ?prefGeoGraphicObject }. FILTER(langMatches(lang(?gender), \"" + lang + "\"))} GROUP BY ?name ?firstName ?family_name ?gender ?niceDepiction ?description?isMemberOf ?phone ?homepage ?workplaceHomepage ?workInfoHomepage ?birthday";
                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
            case "publicationIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title  ?description ?depiction ?contributor ?rights ?type ?format ?date  (group_concat(distinct ?subject ; separator='#') as ?subjects ) (group_concat(distinct ?creator ; separator='#') as ?creators ) (group_concat(distinct ?identifier ; separator='#') as ?identifiers ) WHERE {<" + uriIndividual + "> dc:title ?Title .OPTIONAL { <" + uriIndividual + "> dc:description ?description } .OPTIONAL { <" + uriIndividual + "> dc:date ?date } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> dc:contributor ?contributor } .OPTIONAL { <" + uriIndividual + "> dc:rights ?rights } .OPTIONAL { <" + uriIndividual + "> dc:format ?format } .OPTIONAL { <" + uriIndividual + "> dc:type ?type } .OPTIONAL { <" + uriIndividual + "> dc:identifier ?identifier } .OPTIONAL { <" + uriIndividual + "> ical:dtstart ?startDate } .OPTIONAL { <" + uriIndividual + "> ical:dtend ?endDate }.OPTIONAL { ?subject foaf:isPrimaryTopicOf <" + uriIndividual + ">}} GROUP BY ?Title  ?description ?depiction ?contributor ?rights ?type ?format ?date ";

                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
            case "indicateurIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX dct: <http://purl.org/dc/terms/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def/> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ('" + uriIndividual + "' as ?uri) ?Title ?TitlenoLang ?process (group_concat(distinct ?subject; separator='#') as ?subjects) (group_concat(distinct ?identifier; separator='#') as ?identifiers) (group_concat(distinct ?tableIdentifier; separator='#') as ?tableIdentifiers) (group_concat(distinct ?creator; separator='#') as ?creators) WHERE {<" + uriIndividual + "> dc:title ?TitlenoLang  .OPTIONAL { <" + uriIndividual + "> dc:title ?Title . FILTER(langMatches(lang(?Title), \"" + lang + "\")). FILTER(langMatches(lang(?TitlenoLang), \"" + lang + "\"))} .OPTIONAL { <" + uriIndividual + "> dc:identifier ?identifier }.OPTIONAL { <" + uriIndividual + "> dc:identifier ?tableIdentifier } .OPTIONAL { <" + uriIndividual + "> dc:subject ?subject } .OPTIONAL { <" + uriIndividual + "> dc:creator ?creator } .OPTIONAL { <" + uriIndividual + "> resources_def:usesProcess ?process }.FILTER regex(?identifier, \".html\", \"i\").FILTER (!regex(?identifier, \"_table.html\", \"i\")).FILTER(regex(?tableIdentifier, \"_table.html\", \"i\")) } GROUP BY ?Title ?TitlenoLang ?process";
                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
            case "speciesIndividualData":
                queryIndividual.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def/> PREFIX ecosystems_def: <http://www.ecoscope.org/ontologies/ecosystems_def/> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> SELECT ('" + uriIndividual + "' as ?uri) ?prefLabel ?description (group_concat(distinct ?altLabel; separator='#') as ?altLabels) (group_concat(distinct ?person; separator='#') as ?persons) (group_concat(distinct ?relatedDatabase; separator='#') as ?relatedDatabases) (group_concat(distinct ?depiction; separator='#') as ?depictions) (group_concat(distinct ?indicator; separator='#') as ?indicators) WHERE {<" + uriIndividual + "> skos:prefLabel ?prefLabel .OPTIONAL { <" + uriIndividual + "> skos:note ?description } .OPTIONAL { <" + uriIndividual + "> skos:altLabel ?altLabel } .OPTIONAL { ?person  foaf:topic_interest <" + uriIndividual + ">} .OPTIONAL { <" + uriIndividual + "> ecosystems_def:used_data_source ?relatedDatabase }.OPTIONAL { <" + uriIndividual + "> foaf:depiction ?depiction } .OPTIONAL { <" + uriIndividual + "> resources_def:has_related_indicator ?indicator } .} GROUP BY ?prefLabel ?description";
                loadIndividualData(viewIndividualData, queryIndividual.request, queryIndividual.endpointlocation);
                break;
        }
    };

    /***********************************************************/
    /***** initialisation de la navigation par catégories *****/
    /*********************************************************/
    //variable contenant la catégories cliqué
    var category = "";
    var offset = 0;




    $(document).on("click", ".category", function (e) {
        e.preventDefault();
        offset = 0;
        category = $(this).attr('id');
        loadCategory(category);
        setPageTitle(category.replace('Category', ''));
        history.pushState({
            key: "category",
            category: category
        }, null, category);

        hideIndividualData();
    });

    /*****************************************************************/
    /***** switch permettant de charger les catégories  **************/
    /***** en fonction du type (apellé par onclick sur .Categoy *****/
    /*****************************************************************/
    var query = {
        endpointlocation: "",
        request: "",
        view: "",
        divToAppend: ""
    };

    var loadCategory = function (category) {
        query.endpointlocation = "ecoscope";

        switch (category) {
            case "BDDCategory":
                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?database ?Title WHERE { ?database rdf:type <http://www.ecoscope.org/ontologies/resources_def/dataBase> . ?database skos:prefLabel ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\")) }";
                query.view = "bddCategory-result";
                loadData(query, "pageContent");
                query.view = "bddListSearch";
                loadData(query, "mozaicHolder");
                initIndividualData("bddIndividualData", query.endpointlocation);
                break;
            case "picturesCategory":
                if (offset !== 0) {
                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?picture ?Title WHERE { ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def/picture> . ?picture dc:title ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\"))} LIMIT 20 offset" + offset;
                } else {
                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?picture ?Title WHERE { ?picture rdf:type <http://www.ecoscope.org/ontologies/resources_def/picture> . ?picture dc:title ?Title. FILTER(langMatches(lang(?Title), \"" + lang + "\"))} LIMIT 20";
                }

                query.view = "picturesCategory-result";
                loadData(query, "pageContent");

                query.view = "pictureListSearch";
                loadData(query, "mozaicHolder");

                initIndividualData("pictureIndividualData", query.endpointlocation);
                break;
            case "indicatorCategory":
                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT ?indicator ?Title ?identifier WHERE { ?indicator rdf:type <http://www.ecoscope.org/ontologies/resources_def/indicator> . ?indicator dc:title ?Title. ?indicator dc:identifier ?identifier}LIMIT 30";
                query.view = "indicatorsCategory-result";
                loadData(query, "pageContent");

                query.view = "indicatorListSearch";
                loadData(query, "mozaicHolder");

                initIndividualData("indicateurIndividualData", query.endpointlocation);
                break;
            case "contactCategory":
                if (offset !== 0) {
                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?agent ?name ?depiction WHERE {?agent rdf:type <http://xmlns.com/foaf/0.1/Person> .?agent foaf:name ?name.OPTIONAL { ?agent foaf:depiction ?depiction  }}LIMIT 20 OFFSET " + offset;
                } else {
                    query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?agent ?name ?depiction WHERE {?agent rdf:type <http://xmlns.com/foaf/0.1/Person> .?agent foaf:name ?name.OPTIONAL { ?agent foaf:depiction ?depiction  }}LIMIT 20";
                }

                query.view = "contactCategory-result";
                loadData(query, "pageContent");

                query.view = "contactListSearch";
                loadData(query, "mozaicHolder");

                initIndividualData("contactIndividualData", query.endpointlocation);
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
                loadData(query, "pageContent");

                //on remplit le menu associé
                query.view = "publicationListSearch";
                loadData(query, "mozaicHolder");
                initIndividualData("publicationIndividualData", query.endpointlocation);
                break;
            case "homeCategory":
                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> SELECT ?indicator ?identifier WHERE {<http://www.ecoscope.org/ontologies/ecosystems/thunnus_obesus> <http://www.ecoscope.org/ontologies/resources_def/has_related_indicator> ?indicator .?indicator dc:identifier ?identifier.FILTER regex(?identifier, '.xml', 'i')}";
                query.view = "home-result";
                query.endpointlocation = "ecoscope";
                loadData(query, "pageContent");
                init();
                break;
            case "atlasCategory":
                query.request = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT DISTINCT  ?species ?label WHERE {?species  skos:prefLabel ?label .?species rdf:type <http://www.ecoscope.org/ontologies/ecosystems_def/tuna>}";
                query.view = "atlas-result";
                query.endpointlocation = "ecoscope";
                loadData(query, "pageContent");
                initIndividualData("speciesIndividualData", query.endpointlocation);

                break;
        }
    };

    /*****************************************************************/
    /********** gestion du offset dans les catégories  **************/
    /***************************************************************/
    var totalItem = "";

    $(document).on("click", ".loadMoreCategory", function () {
        totalItem = $(this).attr('totalItem');
        if (offset <= totalItem) {
            offset += 20;
            offsetCategory = $(this).attr('id');
            loadCategory(offsetCategory);
        }

    });

    $(document).on("click", ".loadLessCategory", function () {
        offsetCategory = $(this).attr('id');
        if (offset !== 0) {
            offset -= 20;
            loadCategory(offsetCategory);
        } else {
            offset = 0;
            $(".loadLessCategory").hide();
        }
    });


    /*****************************************************************/
    /********** gestion des permaliens ******************************/
    /***************************************************************/

    $(document).on('click', "#permalink", function (e) {
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

    //gestion des permaliens 
    if ($("#permalinkData").exists()) {
        var permalinkRequest = $("#permalinkData").attr("request");
        permalinkRequest = decodeURIComponent(permalinkRequest);
        var permalinkEndpointlocation = $("#permalinkData").attr("endpointlocation");
        var permalinkView = $("#permalinkData").attr("permalinkView");

        loadIndividualData(permalinkView, permalinkRequest, permalinkEndpointlocation);
    }


    function utf8_encode(string) {
        return unescape(encodeURIComponent(string));
    }

    function utf8_decode(string) {
        return decodeURIComponent(escape(string));
    }
//    <protocol>//<hostname>:<port>/<pathname><search><hash>
//    hash -Sets or returns the anchor portion of a URL.
//    host -Sets or returns the hostname and port of a URL.
//    hostname -Sets or returns the hostname of a URL.
//    href -Sets or returns the entire URL.
//    pathname -Sets or returns the path name of a URL.
//    port -Sets or returns the port number the server uses for a URL.
//    protocol -Sets or returns the protocol of a URL.
//    search -Sets or returns the query portion of a URL



    /***********************************************************/
    /******************** pending navigation *******************/
    /***********************************************************/
    $(document).on('click', ".closeIndividualData", function (e) {
        e.preventDefault();
        hideIndividualData();
    });
    $(document).on('click', "#openSearchBar", function (e) {
        e.preventDefault();
        $('#charms').css('right', '0');
    });
    $(document).on('click', "#closeSearchBar", function (e) {
        e.preventDefault();
        $('#charms').css('right', '-320px');
    });
    $(document).on('click', ".closeModal", function (e) {
        $('#myModal').modal('hide');
    });

    $(".brand").on('click', ".closeModal", function (e) {
        loadCategory("homeCategory");
    });


    $(document).on('click', ".closeDataTable", function (e) {
        $("#dataTable").modal("hide");
    });
    $(document).on('click', "#showDataTable", function (e) {
        $("#dataTable").modal("show");
    });

    function setPageTitle(categoryTitle) {
        $("#categoryTitle").html(categoryTitle);
    }

    /***********************************************************/
    /***** gestion de la navigation retour arrière en ajax *****/
    /***********************************************************/
    window.onpopstate = function (event) {
        hideIndividualData();
        if (event.state === null) {
            //si il n'existe pas d'historique
        } else {
            if (event.state.key === "category") {

                loadCategory(event.state.category);
            }
            if (event.state.key === "individualData") {
                IndividualDataSwitch(event.state.view, event.state.uri);

            }
            console.log(event.state.category);

        }
    };

    /**************************************************/
    /*******navigation dans le menu de droite**********/
    /**************************************************/
    $(document).on("mouseenter", ".titleSearchList", function () {

        $(this).next().css('max-height', '600px');
    }).on("mouseleave", ".titleSearchList", function () {
        $(this).next().css('max-height', '200px');

    });

    /************************************************/
    /*****************auto completion ***************/
    /************************************************/
    $(document).on('click', "#validateCompletion", function (e) {
        loadAutocompletion();
        e.preventDefault();
    });

    function loadAutocompletion() {
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
                $("#mozaicHolder").html("<div class='progress progress-indeterminate' style='margin-top:30%;margin-left:20%;'><div class='bar'></div></div>");
            },
            success: function (data)
            {
                $("#mozaicHolder").html(data);
            },
            error: function (error)
            {
                $("#mozaicHolder").html("error");
            }
        });
        return false;
    }


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


});
 