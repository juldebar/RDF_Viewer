package org.ird.crh.ecoscope.kb.pojos;

public class ResourcesLocation {
	// Communicable properties
	private String regex = null;
	private String sizeSpecificString = null;
	private String basePath = null;
	private String originalSizeRequestKeyword = null;
	
	// Constants
	public static final String PIC_SIZE_XXXSMALL = "xxxs";
	public static final String PIC_SIZE_XXSMALL = "xxs";
	public static final String PIC_SIZE_XSMALL = "xs";
	public static final String PIC_SIZE_MEDIUM = "m";
	public static final String PIC_SIZE_LARGE = "l";
	
	// Constructors
	public ResourcesLocation(String regex, String sizeSpecificString, String basePath, String originalSizeRequestKeyword) {
		super();
		this.regex = regex;
		this.sizeSpecificString = sizeSpecificString;
		this.basePath = basePath;
		this.originalSizeRequestKeyword = originalSizeRequestKeyword;
	}
	
	// Equality tester
	public boolean equals(Object o) {
		
		return false;
	}

	// Getters & setters
	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}
	
	public String getSizeSpecificString() {
		return sizeSpecificString;
	}

	public void setSizeSpecificString(String sizeSpecificString) {
		this.sizeSpecificString = sizeSpecificString;
	}

	public void setKeyword(String regex) {
		this.regex = regex;
	}

	public String getBasePath() {
		return basePath;
	}

	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}

	public String getOriginalSizeRequestKeyword() {
		return originalSizeRequestKeyword;
	}

	public void setOriginalSizeRequestKeyword(String originalSizeRequestKeyword) {
		this.originalSizeRequestKeyword = originalSizeRequestKeyword;
	}
}
