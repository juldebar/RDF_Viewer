package org.ird.crh.ecoscope.kb.pojos;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("serial")
public class WebLink implements Serializable, Comparable<WebLink>{
	private String label = null;
	private String lang = null;
	private String uri = null;
	private String summary = null;
	private ArrayList<WebLink> weblinks = null;
	
	// Constructors
	public WebLink() {
		super();
	}
	
	public WebLink(String label, String uri) {
		this();
		this.label = label;
		this.uri = uri;
	}
	
	public WebLink(String label, String uri, String lang, String summary) {
		this.label = label;
		this.uri = uri;
		this.lang = lang;
		this.summary = summary;
	}
	
	public WebLink(String label, String uri, String lang, String summary, ArrayList<WebLink> weblinks) {
		this.label = label;
		this.uri = uri;
		this.lang = lang;
		this.summary = summary;
		this.weblinks = weblinks;
	}
	
	public WebLink(WebLink w){
		this(w.getLabel(), w.getUri(), w.getLang(), w.getSummary(), w.getWeblinks());
	}
	
	// Comparator
	public int compareTo(WebLink o) {
		return this.getLabel().compareToIgnoreCase(o.getLabel());
	}
	
	// To string
	public String toString(){
		return label + "("+uri+")";
	}
	
	
	// Getters & Setters
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public ArrayList<WebLink> getWeblinks() {
		return weblinks;
	}
	public void setWeblinks(ArrayList<WebLink> weblinks) {
		this.weblinks = weblinks;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
}
