/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.action;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Action destinée à transmettre à une page web une chaîne de caractères reçue
 * par ailleurs. En pratique cette Action a été mise en place pour fournir à une
 * vue un fichier XML capable, dans un second temps, d'initialiser un affichage
 * provenant de l'application Ecoscope MDST. l'implantation MDST de ce mécanisme
 * n'était pas encore opérationnelle au moment de l'écriture de cette Action.
 *
 * @author pcauquil
 */
public class ShowWPS extends ActionSupport {

    private String url;

    @Override
    public String execute() throws Exception {

        return SUCCESS;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
