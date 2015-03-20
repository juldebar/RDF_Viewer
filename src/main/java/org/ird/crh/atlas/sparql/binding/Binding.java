/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.sparql.binding;

/**
 * Un résultat atomique de la liste des résultats donnée par le SPARQL endpoint
 * requêté. L'objet peut être une uri ou un litéral
 *
 * @author pcauquil
 */
public class Binding {

    private String uri;
    private String literal;

    @Override
    public String toString() {
        if (uri != null) {
            return uri;
        } else if (literal != null) {
            return literal;
        } else {
            return "empty binding";
        }
    }

    public String getUri() {
        return uri;
    }

    public String getLiteral() {
        return literal;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public void setLiteral(String literal) {
        this.literal = literal;
    }

}
