<%@page import="java.net.URLDecoder"%>
<%@page import="org.ird.crh.ecoscope.libraries.ConstantsKeeper,org.ird.crh.ecoscope.kb.pojos.ResourcesLocation"%>
<%@page import="java.io.File,java.io.FilenameFilter,java.util.Arrays"%>
<%
/**
  * jQuery File Tree JSP Connector
  * Version 1.0
  * Copyright 2008 Joshua Gould
  * 21 April 2008
*/	

	ConstantsKeeper ck = ConstantsKeeper.getInstance();

	String dir = request.getParameter("dir");
	if (dir == null) {
		return;
	}
	
	if (dir.charAt(dir.length()-1) == '\\') {
		dir = dir.substring(0, dir.length()-1) + "/";
	} else if (dir.charAt(dir.length()-1) != '/') {
	    dir += "/";
	}
	
	dir = URLDecoder.decode(dir, "UTF-8");

	for (int i=0; i<ck.RESOURCES_FILES_LOCATIONS.size(); i++) {
		ResourcesLocation resLoc = ck.RESOURCES_FILES_LOCATIONS.get(i);
		
		if (dir.matches(resLoc.getRegex())) {
			
			String fullDir = resLoc.getBasePath() + dir;
			
		    if (new File(fullDir).exists()) {
				String[] files = new File(fullDir).list(new FilenameFilter() {
				    public boolean accept(File fullDir, String name) {
						return name.charAt(0) != '.';
				    }
				});
				Arrays.sort(files, String.CASE_INSENSITIVE_ORDER);
				out.print("<ul class=\"jqueryFileTree\" style=\"display: none;\">");
				// All dirs
				for (String file : files) {
				    if (new File(fullDir, file).isDirectory()) {
						out.print("<li class=\"directory collapsed\"><a href=\"#\" rel=\"" + dir + file + "/\">"
							+ file + "</a></li>");
				    }
				}
				// All files
				for (String file : files) {
				    if (!new File(fullDir, file).isDirectory()) {
						int dotIndex = file.lastIndexOf('.');
						String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
						out.print("<li class=\"file ext_" + ext + "\"><a href=\"#\" rel=\"" + dir + file + "\">"
							+ file + "</a></li>");
				    	}
				}
				out.print("</ul>");
		    }
		}
	}
%>