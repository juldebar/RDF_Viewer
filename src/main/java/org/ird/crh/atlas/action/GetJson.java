/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import static com.hp.hpl.jena.shared.uuid.Bits.test;
import static com.opensymphony.xwork2.Action.SUCCESS;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONObject;
import org.json.JSONException;

//import org.json.JSONObject;
/**
 *
 * @author arnaud
 */

// <dependency>
//            <groupId>com.fasterxml.jackson.core</groupId>
//            <artifactId>jackson-databind</artifactId>
//            <version>2.5.0</version>
//            <type>jar</type>
//        </dependency>
//        <dependency>
//            <groupId>com.fasterxml.jackson.core</groupId>
//            <artifactId>jackson-annotations</artifactId>
//            <version>2.5.0</version>
//            <type>jar</type>
//        </dependency>




public class GetJson {
    private String jsonPath = null;
    private Object json;
    
    

    public String execute() throws IOException, JSONException {
        
        if (jsonPath == null || jsonPath.isEmpty()) {
            Logger.getLogger(GetSparqlResult.class.getName()).log(Level.INFO, "Parameter jsonPath is null or empty. Continuing without         if (jsonPath == null || jsonPath.isEmpty()) {\n" +"...");
        }
        
        ObjectMapper mapper = new ObjectMapper();
        
        JSONObject jsonInput = readJsonFromUrl(jsonPath);
        String jsonTest = jsonInput.toString();
        
        mapper = new ObjectMapper();
        json = mapper.readValue(jsonTest, Object.class);	
        System.out.println(mapper.writerWithDefaultPrettyPrinter().writeValueAsString(json));
        
        return SUCCESS;
    }

    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString();
    }

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            JSONObject json = new JSONObject(jsonText);
            return json;
        } finally {
            is.close();
        }
    }

    public Object getJson() {
        return json;
    }

    public void setJson(Object json) {
        this.json = json;
    }

    public String getJsonPath() {
        return jsonPath;
    }

    public void setJsonPath(String jsonPath) {
        this.jsonPath = jsonPath;
    }
    
    

}
