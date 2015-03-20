/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.action;

import org.ird.crh.ecoscope.libraries.MyActionSupport;

/**
 * Action S² neutre utilisée pour afficher des vues qui ne nécessitent aucune
 * autre logique que la leur. Son utilisation dans la déclaration d'une action
 * dans struts.xml est équivalent à la déclaration d'une action sans paramètre
 * class.
 *
 * @author pascal
 */
public class ShowSimplePage extends MyActionSupport {

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }
}
