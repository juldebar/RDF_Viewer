/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//début de la requête--> . OPTIONAL {?niceDepiction dc:identifier ?identifier}

/*****************************************/
/** chargement des informations de fiche**/
function loadPopupData(uri, type, description) {
    //alert("uri : " + uri + '<br/>type : ' + type);
    var lang = $("body").attr("lang");
    switch (type) {
        case "tags":
            var uri = uri;
            var query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> SELECT (<" + uri + "> as ?uri) ?Title  ?description ?identifier WHERE { <" + uri + "> skos:prefLabel ?Title. OPTIONAL {<" + uri + "> skos:note ?description} .OPTIONAL{<"+uri+"> <http://www.ecoscope.org/ontologies/resources_def/niceDepiction> ?niceDepiction .?niceDepiction dc:identifier ?identifier} }";
            //alert(query);
            var view = "subjectBddData";
            var endPointLocation = "ecoscope";
            ajaxCallIndividualData(query, view, endPointLocation);
            break;
        case "publication":
            var uri = uri;
            var query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT ?Title ?subject ?description WHERE {<" + uri + "> dc:title ?Title. OPTIONAL { <" + uri + "> dc:description ?description }}";
            var view = "publiContactData";
            var endPointLocation = "ecoscope";
            ajaxCallIndividualData(query, view, endPointLocation);
            break;
        case "image":
            var uri = uri;
            var query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc:<http://purl.org/dc/elements/1.1/> PREFIX foaf:<http://xmlns.com/foaf/0.1/> SELECT ?identifier WHERE{ <"+uri+"> dc:identifier ?identifier.}";
            var view = "imageHolder";
            var endPointLocation = "ecoscope";
            ajaxCallIndividualData(query, view, endPointLocation);
            break;
        case "topicInterest":
            var uri = uri;
            var query = "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX dc: <http://purl.org/dc/elements/1.1/> PREFIX skos: <http://www.w3.org/2004/02/skos/core#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> PREFIX resources_def: <http://www.ecoscope.org/ontologies/resources_def> PREFIX geographic_objects_def: <http://www.ecoscope.org/ontologies/geographic_objects_def> PREFIX ical: <http://www.w3.org/2002/12/cal/ical#> SELECT (<" + uri + "> as ?uri) ?Title ?description WHERE {<" + uri + "> skos:prefLabel ?Title.OPTIONAL { <" + uri + "> skos:note ?description }}";
            var view = "topicInterestData";
            var endPointLocation = "ecoscope";
            ajaxCallIndividualData(query, view, endPointLocation);
            break;
        }
}

function ajaxCallIndividualData(query, view, endPointLocation) {
    $.ajax({
        url: "GetSparqlResult.action",
        type: "post",
        dataType: "html",
        async: true,
        data: {
            query: query,
            view: view,
            endpointlocation: endPointLocation
        },
        beforeSend: function (xhr) {
            //alert(query);
            $('#myModal').modal('show');
            $('#myModal').html("<div class='progress progress-indeterminate' style='margin: 20% auto 4px 46%;'><div class='bar'></div></div>")
        },
        success: function (data)
        {
            var dataLoadOnClick = data;
            $('#myModal').html("<button class='close closeModal'></button>"+dataLoadOnClick);
            $('#myModal').modal('show');
            
            $(".comment").shorten({
                    "showChars": 200,
                    "moreText": "See More",
                    "lessText": "Less"
                });
        },
        error: function (error)
        {
            //alert("error");
            //alert(JSON.stringify(error));
        }
    });
}


function loadImageData(src) {
    
    $('#myModal').html("<img style='width:100%;height:100%;' src=" + src + ">");
    $('#myModal').modal('show');
}
