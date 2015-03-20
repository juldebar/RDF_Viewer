/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.ecoscope.libraries;

import com.opensymphony.xwork2.ActionSupport;

/**
 *
 * @author pascal
 */
public class MyActionSupport extends ActionSupport {
    // Actions results
    public static final String NOTLOGGED = "notlogged";
    public static final String ALREADYLOGGED = "alreadylogged";
    
    // Session keys
    public static final String SHIRO_SUBJECT = "shiro_principal";
    public static final String SHIRO_FIRSTNAME = "shiro_firstname";
    public static final String SHIRO_LASTNAME = "shiro_lastname";
    
    // Localization
    public static final String DEFAULT_I18N_PACKAGE = "ShowResource";
    
    // Interfaces implemantation
    public ConstantsKeeper getCk() {
        return ConstantsKeeper.getInstance();
    }
}
