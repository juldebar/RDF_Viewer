package org.ird.crh.atlas.result;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.ird.crh.atlas.action.GetFile;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.Result;

/**
 * Classe de type S² Result. Ce type de classe permet de spécifier des types de
 * réponses HTTP qu'une action S² sera capable de retourner aux clients. Celle
 * ici présente spécifie un format permettant de retourner des fichiers
 * binaires, comme par exemple des images (que le navigateur peut intégrer aux
 * pages web) ou tout autre type de fichier destiné à l'enregistrement sur le
 * système de fichiers des clients. En d'autres termes, gérer le téléchargement
 * HTTP.
 *
 * @author pcauquil
 */
@SuppressWarnings("serial")
public class BytesResult implements Result{
	
	public void execute(ActionInvocation invocation) throws Exception {
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		if ( invocation.getAction().getClass().equals(GetFile.class) ){
			GetFile action = (GetFile) invocation.getAction();
			
			// Encoding file name
			String encodedFileName = URLEncoder.encode(action.getFileName(), "UTF-8");
			
			// Download
			if (action.isDownload()) response.setHeader("Content-Disposition", "attachment; filename="+encodedFileName);
			// Display in the browser if possible, try to avoid downloading
			else response.setHeader("Content-Disposition", "filename=" + encodedFileName);
			
			byte[] bytes = action.getDocumentInBytes();
			
			if (bytes != null) {
				response.getOutputStream().write(bytes);
			}
		}

		response.getOutputStream().flush();
	}
}