package org.ird.crh.ecoscope.libraries;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.InvalidPropertiesFormatException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.ird.crh.ecoscope.kb.pojos.ResourcesLocation;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class ConstantsKeeper {

    // Private
    NodeList nodes1;

    // Singleton
    private static ConstantsKeeper instance;

    // Debug mode
    public boolean DEBUG = false;

    // General
    public String APP_CONTEXT = null;
    public String[] LANGAGES_PRIORITY = null;
    public String ADMINISTRATION_PASSWORD = null;
    public String LABELS_MANAGEMENT_MODE = null;
    public String SHIRO_CONFIG_FILE = null;

    public float JPG_QUALITY;
    public Integer AUTOCOMPLETER_MAX_RESULTS = null;

    // Semantic atlas
    public String ENDPOINT_LOCATION = null;

    // Resources files locations
    public ArrayList<ResourcesLocation> RESOURCES_FILES_LOCATIONS = new ArrayList<ResourcesLocation>();

    // Display filters
    public int PREFUSE_LABELS_LENGTH = 0;

    // Applet
    public String SPARQL_REQUEST_REPLACEMENT_STRING = null;

    // Thematic constants
    // Nothing at the moment

    // Internal Constants
    public static final String OPERAND_AND = "AND";
    public static final String OPERAND_OR = "OR";

    // Factory
    public static ConstantsKeeper getInstance() {
        if (instance == null) {
            instance = new ConstantsKeeper();
        }
        return instance;
    }

    // Constructor
    private ConstantsKeeper() {
        super();
        //ClassLoader classLoader = this.getClass().getClassLoader();

        // --------------------
        // Loading the XML file
        // --------------------

        String filepath = EcoscopeUtils.RELATIVE_CONFIG_PATH;
        String filename = "config.xml";
        File file = EcoscopeUtils.getConfigFile(filepath, filename);

        FileInputStream fis;

        try {
            fis = new FileInputStream(file);
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(fis);
            XPath xpath = XPathFactory.newInstance().newXPath();

            Node configurationNode = (Node) xpath.evaluate("/configuration", doc, XPathConstants.NODE);

            Node node1;
            Node node2;

            // System
            node1 = (Node) xpath.evaluate("debug", configurationNode, XPathConstants.NODE);
            if (node1.getTextContent().trim().equalsIgnoreCase("true")) {
                DEBUG = true;
            } else {
                DEBUG = false;
            }

            node1 = (Node) xpath.evaluate("app_context", configurationNode, XPathConstants.NODE);
            APP_CONTEXT = node1.getTextContent().trim();

            node1 = (Node) xpath.evaluate("langages_priority", configurationNode, XPathConstants.NODE);
            LANGAGES_PRIORITY = node1.getTextContent().trim().split(";");

            node1 = (Node) xpath.evaluate("administration_password", configurationNode, XPathConstants.NODE);
            ADMINISTRATION_PASSWORD = node1.getTextContent().trim();

            node1 = (Node) xpath.evaluate("labels_management_mode", configurationNode, XPathConstants.NODE);
            LABELS_MANAGEMENT_MODE = node1.getTextContent().trim();

            node1 = (Node) xpath.evaluate("jpg_quality", configurationNode, XPathConstants.NODE);
            JPG_QUALITY = Float.valueOf(node1.getTextContent().trim());

            node1 = (Node) xpath.evaluate("autocompleter_max_results", configurationNode, XPathConstants.NODE);
            if (Integer.valueOf(node1.getTextContent().trim()) > 0) {
                AUTOCOMPLETER_MAX_RESULTS = Integer.valueOf(node1.getTextContent().trim());
            }


            // Semantic atlas
            node1 = (Node) xpath.evaluate("endpoint_location", configurationNode, XPathConstants.NODE);
            ENDPOINT_LOCATION = node1.getTextContent().trim();

            // Resources files locations
            nodes1 = (NodeList) xpath.evaluate("files_locations/file_location", configurationNode, XPathConstants.NODESET);
            for (int j = 0; j < nodes1.getLength(); j++) {
                node2 = (Node) xpath.evaluate("regex", nodes1.item(j), XPathConstants.NODE);
                String regex = node2.getTextContent();

                node2 = (Node) xpath.evaluate("sizeSpecificString", nodes1.item(j), XPathConstants.NODE);
                String sizeSpecificString = node2.getTextContent();

                node2 = (Node) xpath.evaluate("base_path", nodes1.item(j), XPathConstants.NODE);
                String basePath = node2.getTextContent().trim();
                if (basePath.endsWith("/") || basePath.endsWith("\"")) {
                    basePath = basePath.substring(0, basePath.length() - 1);
                }
                if (basePath.equalsIgnoreCase("null") || basePath.equalsIgnoreCase("NULL")) {
                    basePath = "";
                }
                if (basePath.startsWith("~")) {
                    basePath = System.getProperty("user.dir") + basePath.substring(1, basePath.length());
                }

                node2 = (Node) xpath.evaluate("originalSizeRequestKeyword", nodes1.item(j), XPathConstants.NODE);
                String originalSizeRequestKeyword = node2.getTextContent();

                ResourcesLocation resLoc = new ResourcesLocation(regex, sizeSpecificString, basePath, originalSizeRequestKeyword);
                RESOURCES_FILES_LOCATIONS.add(resLoc);
            }

        } catch (FileNotFoundException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        } catch (InvalidPropertiesFormatException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        } catch (IOException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        } catch (ParserConfigurationException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        } catch (SAXException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        } catch (XPathExpressionException e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, e);
        }
    }
}

