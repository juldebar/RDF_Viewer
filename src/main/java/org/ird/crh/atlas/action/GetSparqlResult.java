/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.action;

import static com.opensymphony.xwork2.Action.INPUT;
import com.opensymphony.xwork2.ActionSupport;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.Authenticator;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.ird.crh.atlas.sparql.binding.Binding;
import org.ird.crh.ecoscope.libraries.ConstantsKeeper;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * L'une des deux Actions S² essentielles de l'application (l'autré étant
 * ShowResource) : elle reçoit d'une vue une requête SPARQL, qu'elle se charge
 * d'encapsuler dans une requête HTTP complète à destination d'un SPARQL
 * endpoint. Le SPARQL endpoint lui retourne ses résultats, impérativement sous
 * format XML. L'action ici présente se charge alors de parser ce résultat XML
 * et de mettre son contenu à disposition de la vue pour affichage.
 *
 * @author pcauquil
 */
public class GetSparqlResult extends ActionSupport {

    private List<Map<String, Binding>> results;
    private String view = null;
    private String query;
    private String endpointlocation;
    private String endpointUrl = "http://62.217.127.213:8890/sparql?query=";
    private ConstantsKeeper ck = ConstantsKeeper.getInstance();

    @Override
    public String execute() {

        if (query == null || query.isEmpty()) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, "Parameter query is null or empty");
            return INPUT;
        }

        if (view == null || view.isEmpty()) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.INFO, "Parameter view is null or empty. Continuing without view...");
        }

        BufferedReader in = null;
        InputStreamReader isr = null;
        InputStream is = null;

        // Si la vue fournit une adresse de endpoint (via le paramètre 'endpointUrl') on utilise celle-ci.
        //Sinon on utilise celle par défaut (ck.ENDPOINT_LOCATION)
        try {
            String urlStr;

            if (endpointUrl != null && !endpointUrl.isEmpty()) {

                urlStr = endpointUrl;
            } else {
                urlStr = ck.ENDPOINT_LOCATION;
            }
//
            if ("ecoscope".equals(endpointlocation)) {

                endpointUrl = "http://ecoscopebc.mpl.ird.fr:8080/joseki/ecoscope?query=";
                urlStr = endpointUrl;
                System.out.println("end point url : " + endpointlocation);
//                http://ecoscopebc.mpl.ird.fr:8080/joseki/ecoscope
            }
//             if ("getotherit".equals(endpointlocation)) {
//                 System.out.println("query  of death shit ::!!!!!!!!!!!!!!!!!!!!" + query);
//             }

            if ("fao".equals(endpointlocation)) {

                endpointUrl = "http://62.217.127.213:8890/sparql?query=";
                urlStr = endpointUrl;
                System.out.println("end point url : " + endpointlocation);
            }

            // Concaténation de l'url du endpoint et de la requête SPARQL (fournie par la vue dans 'query')
            urlStr += URLEncoder.encode(query, CharEncoding.UTF_8);
            System.out.print(urlStr);

            // Création d'une url à partir de la chaîne 'urlStr'
            Authenticator.setDefault(new CustomAuthenticator());
            URL url = new URL(urlStr);

            // Création d'une connexion HTTP à partir de cette url
            URLConnection con = url.openConnection();
            con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.0; H010818)");
            String xml_content = "application/sparql-results+xml";
            con.setRequestProperty("ACCEPT", xml_content);

            // Obtention de la réponse HTTP dans un InputStream
            is = con.getInputStream();
            isr = new InputStreamReader(is, "utf8");
            in = new BufferedReader(isr);

            // Transformation du flux binaire en String
            String xmlResult = "";
            String line;
            while ((line = in.readLine()) != null) {
                xmlResult = xmlResult + line + "\n";
            }

            in.close();
            isr.close();
            is.close();

            // Transformation String -> Document XML validé (variable 'doc')
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputStream is2 = new ByteArrayInputStream(xmlResult.getBytes());
            Document doc = builder.parse(is2);

            results = buildResult(doc);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MalformedURLException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
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

        // Returning the view name to the controller if it was provided
        if (view == null || (view != null && view.isEmpty())) {
            return SUCCESS;
        } else {
            return view;
        }
    }

    /**
     * Analyse le document XML et place les résultats dans une structure de
     * données exploitable par les vues.
     *
     * @param doc La réponse du SPARQL endpoint sous forme de Document XML
     * @return Une liste de résultats
     */
    private List<Map<String, Binding>> buildResult(Document doc) {
        List<Map<String, Binding>> maps = null;

        try {
            XPath xpath = XPathFactory.newInstance().newXPath();

            NodeList nodes1 = (NodeList) xpath.evaluate("/sparql/results/result", doc, XPathConstants.NODESET);
            maps = new ArrayList<Map<String, Binding>>();

            // In each result, several bindings
            for (int i = 0; i < nodes1.getLength(); i++) {
                Map<String, Binding> bindings = new HashMap<String, Binding>();

                Node node1 = (Node) nodes1.item(i);

                NodeList nodes2 = (NodeList) xpath.evaluate("./binding", node1, XPathConstants.NODESET);

                // Each binding
                for (int j = 0; j < nodes2.getLength(); j++) {
                    Binding binding = new Binding();

                    Element element = ((Element) nodes2.item(j));

                    String name = element.getAttribute("name");
                    //binding.setName(name);

                    Node node = (Node) xpath.evaluate("./uri", element, XPathConstants.NODE);
                    if (node != null) {
                        binding.setUri(node.getTextContent());
                    }

                    node = (Node) xpath.evaluate("./literal", element, XPathConstants.NODE);
                    if (node != null) {
                        binding.setLiteral(node.getTextContent());
                    }

                    bindings.put(name, binding);
                }

                maps.add(bindings);
            }

        } catch (NullPointerException e) {
            //kingdom = LocalizedTextUtil.findDefaultText("common.text.notAvailable", ActionContext.getContext().getLocale());
        } catch (XPathExpressionException ex) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.SEVERE, null, ex);
        }

        return maps;
    }

    public void setEndpointlocation(String endpointlocation) {
        this.endpointlocation = endpointlocation;
    }

    public String getEndpointlocation() {
        return endpointlocation;
    }

    public List<Map<String, Binding>> getResults() {
        return results;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public void setEndpointUrl(String endpointUrl) {
        this.endpointUrl = endpointUrl;
    }

    public void setView(String view) {
        this.view = view;
    }

    //overide de la fonction d'identification afin de passer l'identifiant et le mot de passe en paramètre (appelé en début de fichier)
    public static class CustomAuthenticator extends Authenticator {

        // Called when password authorization is needed
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {

            // Get information about the request
            String prompt = getRequestingPrompt();
            String hostname = getRequestingHost();
            InetAddress ipaddr = getRequestingSite();
            int port = getRequestingPort();

            String username = "imarine";
            String password = "imarine";

            // Return the information (a data holder that is used by Authenticator)
            return new PasswordAuthentication(username, password.toCharArray());

        }

    }
}
