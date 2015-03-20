package org.ird.crh.atlas.action;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.apache.commons.lang.CharEncoding;
import org.ird.crh.ecoscope.kb.pojos.WebLink;
import org.ird.crh.ecoscope.libraries.ConstantsKeeper;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * Fournit aux autocompleters les données d'autocomplétion. Cette Action est
 * exécutée chaque fois qu'un autocompleter lui transmet une chaîne de caractère
 * pour recherche. La recherche est exécutée sur le SPARQL endpoint par défaut.
 * Les résultats sont retournés sous forme de liste JSON.
 *
 * @author pcauquil
 */
public class GetSelectAutocompleterContent extends ActionSupport {

    private static final long serialVersionUID = 7913701861743976832L;
    // Communicable properties
    private String endpointUrl = null;
    private String searchType = null;
    private String term = null;
    private String customQuery = null;
    private Object jsonModel;
    // Private properties
    private ConstantsKeeper ck = ConstantsKeeper.getInstance();
    private List<WebLink> weblinks;

    @Override
    public String execute() {
        String queryString;

        if (term == null || term.isEmpty()) {
            return Action.INPUT;
        }

        if (customQuery != null) {
            queryString = customQuery.replace("###1###", term);
        } else {
            queryString
                    = "PREFIX skos: <http://www.w3.org/2004/02/skos/core#> "
                    + "PREFIX foaf: <http://xmlns.com/foaf/0.1/> "
                    + "PREFIX dc: <http://purl.org/dc/elements/1.1/> "
                    + "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> "
                    + "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> "
                    + "SELECT ?subject ?label "
                    + "WHERE 	{";

            if (searchType != null && !searchType.isEmpty()) {
                queryString += " ?subject rdf:type <" + searchType + "> .";
            }

            queryString += "		?subject ?p ?label ."
                    + "		FILTER ( ?p = dc:title || ?p = skos:prefLabel || ?p = rdfs:label || ?p = foaf:name  || ?p = skos:altLabel ) ."
                    + "		FILTER regex(str(?label), \"" + term.trim() + "\", \"i\") "
                    + "		} ";

            if (ck.AUTOCOMPLETER_MAX_RESULTS != null) {
                queryString += " LIMIT " + ck.AUTOCOMPLETER_MAX_RESULTS;
            }
        }

        BufferedReader in = null;
        InputStreamReader isr = null;
        InputStream is = null;

        try {
            String urlStr;
            if (endpointUrl != null && !endpointUrl.isEmpty()) {
                urlStr = endpointUrl;
            } else {
                urlStr = ck.ENDPOINT_LOCATION;
            }

            urlStr += URLEncoder.encode(queryString, CharEncoding.UTF_8);

            URL url = new URL(urlStr);
            URLConnection con = url.openConnection();
            con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.0; H010818)");
            String xml_content = "application/sparql-results+xml";
            con.setRequestProperty("ACCEPT", xml_content);

            is = con.getInputStream();
            isr = new InputStreamReader(is, "utf8");
            in = new BufferedReader(isr);

            String xmlResult = "";
            String line;
            while ((line = in.readLine()) != null) {
                xmlResult = xmlResult + line + "\n";
            }

            in.close();
            isr.close();
            is.close();

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputStream is2 = new ByteArrayInputStream(xmlResult.getBytes());
            Document doc = builder.parse(is2);

            weblinks = buildResult(doc);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MalformedURLException ex) {
            Logger.getLogger(GetSelectAutocompleterContent.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(GetSelectAutocompleterContent.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(GetSelectAutocompleterContent.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(GetSelectAutocompleterContent.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
                if (isr != null) {
                    isr.close();
                }
                if (is != null) {
                    is.close();
                }
            } catch (IOException ex) {
                Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        jsonModel = weblinks;
        return SUCCESS;
    }

    private List<WebLink> buildResult(Document doc) {
        List<WebLink> weblinks = new ArrayList<WebLink>();

        try {
            XPath xpath = XPathFactory.newInstance().newXPath();

            NodeList nodes1 = (NodeList) xpath.evaluate("/sparql/results/result", doc, XPathConstants.NODESET);

            // In each result, several bindings (one for uri, one for label, etc)
            for (int i = 0; i < nodes1.getLength(); i++) {
                WebLink weblink = new WebLink();

                Node node1 = (Node) nodes1.item(i);
                NodeList nodes2 = (NodeList) xpath.evaluate("./binding", node1, XPathConstants.NODESET);

                // Each binding
                for (int j = 0; j < nodes2.getLength(); j++) {
                    Element element = ((Element) nodes2.item(j));

                    //String name = element.getAttribute("name");
                    Node node = (Node) xpath.evaluate("./uri", element, XPathConstants.NODE);
                    if (node != null) {
                        weblink.setUri(node.getTextContent());
                    }

                    node = (Node) xpath.evaluate("./literal", element, XPathConstants.NODE);
                    if (node != null) {
                        weblink.setLabel(node.getTextContent());
                    }

                    weblinks.add(weblink);
                }
            }
        } catch (NullPointerException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }

        return weblinks;
    }

    // Getters & Setters
    public void setTerm(String term) {
        this.term = term;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    // Common
    public Object getJsonModel() {
        return jsonModel;
    }

    public void setEndpointUrl(String endpointUrl) {
        this.endpointUrl = endpointUrl;
    }

    public void setCustomQuery(String customQuery) {
        this.customQuery = customQuery;
    }

}
