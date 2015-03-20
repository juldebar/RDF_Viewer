package org.ird.crh.common.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * This interceptor enables to know if the user of the current session is authenticated or not.
 * According to that, the access to the requested page can be allowed or refused.
 * 
 * Note that this interceptor helps managing the access to actions/functionnalities of the website, but doesn't helps
 * for filtering access on data. As data querying is necessary to achieve that,
 * that functionnality must be implemented in each concerned action.
 * 
 * @author Pascal Cauquil
 */
public class MyAuthenticationInterceptor implements Interceptor {

    @Override
    public void init() {
        System.out.println("Initializing AuthenticationInterceptor...");
    }

    @Override
    public String intercept(ActionInvocation ai) throws Exception {
        String className = ai.getAction().getClass().getName();
        //System.out.println("Before calling action: " + className);

        // TODO - Chosir ici l'action à effectuer, en fonction du résultat
        // Invoking requested action
        String result = ai.invoke();
        
        //System.out.println("After calling action: " + className);
        
        return result;
    }
    
    @Override
    public void destroy() {
        System.out.println("Destroying AuthenticationInterceptor...");
    }
    
}