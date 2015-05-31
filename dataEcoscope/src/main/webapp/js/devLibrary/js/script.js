var atlasLib = function () {

    var params;
    var urlRequest;
    var finalRequest;
    var dataLoaded;
    var params;
    var FinalData = {};


    /**********************************************************************/
    /*** fonction permettant de construire la page après l'appell ajax ****/
    /**********************************************************************/
//    function constructPage(data) {
//        //permet de compter le nombre d'occurence de l'object
//        var count = Object.keys(data.results.bindings).length;
//        console.log(count);
//
//        var $wrapperLeft = $('<div>', {
//            'class': 'wrapper'
//        }).appendTo("#" + params.contentWrapper);
//        
//        var $wrappeMiddle = $('<div>', {
//            'class': 'wrapper'
//        }).appendTo("#" + params.contentWrapper);
//
//        var $wrapperRight = $('<div>', {
//            'class': 'wrapper'
//        }).appendTo("#" + params.contentWrapper);
//
//        var title = "";
//        var description = "";
//        var creator = "";
//        var startDate = "";
//        var endDate = "";
//        var uri = "";
//        var depiction = "";
//        //on itère pour récupérer les valeurs
//        for (var i = 0; i < count; i++) {
//            uri =  data.results.bindings[i].uri.value;
//            title = data.results.bindings[i].Title.value;
//            description = data.results.bindings[i].description.value;
//            creator = data.results.bindings[i].creator.value;
//            startDate = data.results.bindings[i].startDate.value;
//            endDate = data.results.bindings[i].endDate.value;
//            depiction = data.results.bindings[i].depiction.value;
//            console.log(depiction);
//            $('<div>', {
//                'class': 'title',
//                'html': $('<h3>').html(title+"<a href='"+uri+"' target='_blank'>en savoir plus </a>")
//            }).appendTo($wrapperLeft);
//            $('<div>', {
//                'class': 'title',
//                'html': $('<p>').text(description)
//            }).appendTo($wrapperLeft);
//            
//            $('<div>', {
//                'class': 'title',
//                'html': $('<p>').text("creator : "+creator)
//            }).appendTo($wrapperLeft);
//            
//            $('<div>', {
//                'class': 'title',
//                'html': $('<p>').text("startDate : "+startDate)
//            }).appendTo($wrapperLeft);
//            
//            $('<div>', {
//                'class': 'title',
//                'html': $('<p>').text("endDate : "+endDate)
//            }).appendTo($wrapperLeft);
//        }
//        $("#" + params.contentWrapper).append();
//    }

    function init(initObject) {
        params = initObject;
        console.log("uri : " + params.uri);
        console.log("contentWrapper : " + params.contentWrapper);
        console.log("lang : " + params.lang);
        console.log("endpointLocation : " + params.endPointLocation);
        console.log("view : " + params.view);
        console.log("format : " + params.format);
        console.log("dataType : " + params.dataType);
        console.log("viewSize : " + params.viewSize);
        setCss();
        setRequestData();
        sheetConstructor();

    }

    function setRequestData() {
        requests = {
            prefix: "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#>",
            fixedData: "('\"" + params.uri + "\"' as ?uri)",
            lang: ". FILTER(langMatches(lang(?Title), '" + params.lang + "'))",
            pictureRequest: {
                select: "?depiction",
                where: "<" + params.uri + "> foaf:depiction ?depiction "
            },
            titleRequest: {
                select: "?Title",
                where: "<" + params.uri + "> skos:prefLabel ?Title"
            },
            aboutRequest: {
                select: "?about",
                where: "<" + params.uri + "> dc:description ?about "
            },
            publicationRequest: {
                select: "?publication",
                where: ""
            },
            contactRequest: {
                select: "?contact",
                where: ""
            },
            speciesRequest: {
                select: "?species",
                where: ""
            }
        };
    }
    function sheetConstructor() {
        switch (params.view) {
            case "BDD":
                console.log("enter BDD.....................");
                finalRequest = bddRequestConstructor();
                urlRequest = urlContructor(finalRequest, params);
                loadSparqlJsonData(urlRequest, function (data) {
                    var FinalData = formatJsonData(data);
                    pageConstructor(FinalData);
                });

                break;
            case "agent":
                console.log("enter agent.....................");

                break;
            case "espece":
                console.log("enter espece.....................");

                break;
        }
    }

    /**************************************/
    /**** request constructor**************/
    /**************************************/
    //base de donnée
    function bddRequestConstructor() {
        finalRequest = requests.prefix + "SELECT " + requests.titleRequest.select + " " + requests.aboutRequest.select + " " + requests.pictureRequest.select + "  WHERE{" + requests.titleRequest.where + " .OPTIONAL{" + requests.aboutRequest.where + "} .OPTIONAL{" + requests.pictureRequest.where + "}" + requests.lang + "}";
        console.log(finalRequest);
        return finalRequest;
    }

    //agent
    function agentRequestConstructor() {

        return finalRequest;
    }

    //publication
    function publicationRequestConstructor() {

        return finalRequest;
    }

    function urlContructor(finalRequest) {
        finalRequest = encodeURIComponent(finalRequest);
        urlRequest = params.endPointLocation + finalRequest + "&output=" + params.format;
        console.log(urlRequest);
        return urlRequest;
    }

    /**************************************/
    /**** appel ajax pour passer l'url*****/
    /**************************************/
    function loadSparqlJsonData(urlRequest, callback) {
        $.ajax({
            url: urlRequest,
            dataType: "jsonp"
        }).done(function (data) {
            console.log(data);
            console.log('params.contentWrapper xxxxx:  ' + params.contentWrapper);
            callback.call(this, data);
        }).fail(function () {
            console.log("error");
        });
    }

    //on récupère les valeurs dans des variables
    function formatJsonData(data) {
        var count = Object.keys(data.results.bindings).length;
        //on itère pour récupérer les valeurs
        for (var i = 0; i < count; i++) {
            FinalData.title = data.results.bindings[i].Title.value || '';
            
            FinalData.about = data.results.bindings[i].about.value || '';
            FinalData.depiction = data.results.bindings[i].depiction.value || '';
            //data.results.bindings[i].depiction.value ? FinalData.depiction = data.results.bindings[i].depiction.value : console.log('no depiction data');
            console.log(FinalData.title);
            console.log(FinalData.depiction);
            console.log(FinalData.about);
        }
        return(FinalData);

    }

    //construction de la page html
    function pageConstructor(FinalData) {
        smallPageConstructor();
    }

    function smallPageConstructor() {
        var contentWrapper = params.contentWrapper;
        var $wrapper = $('<div>', {
            'class': 'wrapper'
        }).appendTo(contentWrapper);
        $('<div>', {
            'class': 'titleTopGlobal',
            'html': $('<h3>').html(FinalData.title)
        }).appendTo($wrapper);
        $('<div>', {
            'class': 'imageWrapper',
            'html': $('<div>').html()
        }).appendTo($wrapper);

        var textWrapper = $('<div>', {
            'class': 'textWrapper',
            'html': $('<div>').html()
        }).appendTo($wrapper);

        $('<div>', {
            'class': 'descriptionText',
            'html': $('<p>').html(FinalData.about)
        }).appendTo(textWrapper);
    }



    //ajout de la feuille de style
    function setCss() {
        // you could encode the css path itself to generate id..
        var cssMore = params.viewSize;
        if (!document.getElementById(cssId))
        {
            var head = document.getElementsByTagName('head')[0];
            var link = document.createElement('link');
            link.id = cssMore;
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.media = 'all';
            console.log("viewSize" + params.viewSize);
            switch (params.viewSize) {
                case "small":
                    link.href = 'http://localhost:8085/semantic-atlas/js/devLibrary/css/small.css';
                    break;
                case "middle":
                    link.href = 'http://localhost:8085/semantic-atlas/js/devLibrary/css/middle.css';
                    break;
                case "wide":
                    link.href = 'http://localhost:8085/semantic-atlas/js/devLibrary/css/wide.css';
                    break;
            }
            head.appendChild(link);
        }
        var cssId = 'style';
        if (!document.getElementById(cssId))
        {
            var link2 = document.createElement('link');
            link2.id = cssId;
            link2.rel = 'stylesheet';
            link2.type = 'text/css';
            link2.media = 'all';
            link2.href = 'http://localhost:8085/semantic-atlas/js/devLibrary/css/style.css';
            head.appendChild(link2);
        }
    }

    /**********************************************************************/
    /*** test des valeurs en initialisation des paramètres par défaut ****/
    /*********************************************************************/
    function isEmpty(value, paramType) {
        if (typeof value === 'undefined' || value === '') {
            switch (paramType) {
                case "uri":
                    return "http://www.ecoscope.org/ontologies/resources/dbStomac";
                    break;
                case "contentWrapper":
                    return "#wide";
                    break;
                case "lang":
                    return "EN";
                    break;
                case "endPointLocation":
                    return "http://ecoscopebc.mpl.ird.fr:8080/joseki/ecoscope?query=";
                    break;
                case "view":
                    return "BDD";
                    break;
                case "format":
                    return "json";
                    break;
                case "viewSize":
                    return "wide";
                    break;
            }
        } else {
            return value;
        }
    }
    /*************************/
    /*** méthode publique ****/
    /*************************/
    return {
        "init": function (initObject) {

            var initObject = {
                uri: isEmpty(initObject.uri, "uri"),
                contentWrapper: isEmpty(initObject.contentWrapper, "contentWrapper"),
                lang: isEmpty(initObject.lang, "lang"),
                endPointLocation: isEmpty(initObject.endPointLocation, "endPointLocation"),
                view: isEmpty(initObject.view, "view"),
                format: isEmpty(initObject.format, "format"),
                viewSize: isEmpty(initObject.viewSize, "viewSize"),
            };
            console.log(initObject.dataType);
            var test = new init(initObject);
        }
    };
};
