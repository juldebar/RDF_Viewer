/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.common.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import java.util.Map;
import org.ird.crh.ecoscope.kb.util.StrutsUtils;

/**
 *
 * @author pcauquil
 */
public class MyI18nInterceptor implements Interceptor {

    @Override
    public void init() {
        System.out.println("Initializing MyI18nInterceptor...");
    }

    @Override
    public String intercept(ActionInvocation ai) throws Exception {
        String className = ai.getAction().getClass().getName();
        
        Map<String, Object> session = ai.getInvocationContext().getSession();     
        
        /*Locale sessionStrutsLocale = (Locale) session.get("WW_TRANS_I18N_LOCALE");
        // bug cast ici
        String[] langs = StrutsUtils.getRdfLocales(session);
        
            
        if (sessionStrutsLocale != null && sessionStrutsLocale.getLanguage() != null) {
            // chercher équivalent dans liste des langues rdf et setter la langue session rdf si trouvé. Sinon prendre la langue prioritaire
            String i18nLang = sessionStrutsLocale.getLanguage();
            
            Boolean exists = StrutsUtils.isLangExists(i18nLang, langs);
            
            if (exists) {
                session.put("WW_TRANS_RDF_LOCALES", i18nLang);
            } else {
                session.put("WW_TRANS_RDF_LOCALES", langs[0]);
            }
        } else {
            // essayer de parser Accept-Language.
            final HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
            String acceptLangage = request.getHeader("Accept-Language");
            
            // Si trouvé
            if (acceptLangage != null && !acceptLangage.isEmpty()) {
                //setter la session i18n
                //voir si ça n'interfère pas de façon néfaste avec S2
                
                //et si trouvé dans rdf, setter rdf
                String extracted = StrutsUtils.extractRdfLocale(acceptLangage, langs);
                Locale locale = new Locale(extracted);
                Boolean exists = StrutsUtils.isLangExists(locale.getLanguage(), langs);
                
                if (exists) {
                    session.put("WW_TRANS_RDF_LOCALES", locale.getLanguage());
                } else {
                    session.put("WW_TRANS_RDF_LOCALES", langs[0]);
                }
            } else {
                session.put("WW_TRANS_RDF_LOCALES", langs[0]);
            }
        }

        // Invoking requested action
        String result = ai.invoke();

        System.out.println("MyI18nInterceptor after calling action: " + className);
        return result;*/
        
        StrutsUtils.initSessionRdfLocales(session);


        // Invoking requested action
        String result = ai.invoke();

        return result;
    }

    @Override
    public void destroy() {
        System.out.println("Destroying MyI18nInterceptor...");
    }
}
