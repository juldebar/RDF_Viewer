package org.ird.crh.ecoscope.kb.util;

import java.util.Locale;
import java.util.Map;

import org.ird.crh.ecoscope.libraries.ConstantsKeeper;

/**
 * Collection de méthodes statiques utilitaires pratiques pour le bon
 * fonctionnement des vues S². Il s'agit notamment de gérer le multilinguisme,
 * de pouvoir proposer des versions courtes de chaînes de caractères sans
 * coupure de mot, etc.
 *
 * @author pcauquil
 */
public class StrutsUtils {

    /**
     * Retourne la liste des langues RDF définies au niveau de la configuration de l'application
     * 
     * @param session La session HTTP
     * @return La liste des codes langues
     */
    public static String[] getRdfLocales(Map<String, Object> session) {
        StrutsUtils.initSessionRdfLocales(session);

        return (String[]) session.get("WW_TRANS_RDF_LOCALES");
    }

    /**
     * Used by MyI18nInterceptor to initialize session's rdf locales
     *
     * @param session
     */
    public static void initSessionRdfLocales(Map<String, Object> session) {
        ConstantsKeeper ck = ConstantsKeeper.getInstance();
        Locale sessionLocale = (Locale) session.get("WW_TRANS_I18N_LOCALE");
        String[] sessionRdfLocales = (String[]) session.get("WW_TRANS_RDF_LOCALES");

        if (sessionLocale == null) {
            if (sessionRdfLocales == null) {
                session.put("WW_TRANS_RDF_LOCALES", ck.LANGAGES_PRIORITY);
            }
        } else {
            String newLocale = sessionLocale.getLanguage();
            int found = 0;

            for (int i = 0; i < ck.LANGAGES_PRIORITY.length; i++) {
                if (ck.LANGAGES_PRIORITY[i].equals(newLocale)) {
                    found = i;
                    break;
                }
            }
            String[] tempLocales = new String[ck.LANGAGES_PRIORITY.length];
            tempLocales[0] = newLocale;
            if (found != 0) {
                System.arraycopy(ck.LANGAGES_PRIORITY, 0, tempLocales, 1, found);
                System.arraycopy(ck.LANGAGES_PRIORITY, found + 1, tempLocales, found + 1, ck.LANGAGES_PRIORITY.length - 1 - found);
            } else {
                System.arraycopy(ck.LANGAGES_PRIORITY, 1, tempLocales, 1, ck.LANGAGES_PRIORITY.length - 1);
            }
            session.put("WW_TRANS_RDF_LOCALES", tempLocales);
        }
    }

    /**
     * Teste si un code langue fait partie de la liste des langues disponibles
     * déclarées au niveau de la configuration de l'application
     *
     * @param i18nLang Le code langue à tester
     * @param langs une liste de codes de langues
     * @return true si le code a été trouvé, false sinon
     */
    public static Boolean isLangExists(String i18nLang, String[] langs) {
        for (String lang : langs) {
            if (lang.equalsIgnoreCase(i18nLang)) {
                return true;
            }
        }
        return false;
    }

    public static String extractRdfLocale(String acceptLangage, String[] langs) {
        for (String lang : langs) {
            if (acceptLangage.contains(lang)) {
                return lang;
            }
        }
        return null;
    }

    public static String getRdfLocalesAsString(Map<String, Object> session) {
        String[] langs = StrutsUtils.getRdfLocales(session);
        String langsAsString = "";

        for (int i = 0; i < langs.length; i++) {
            if (i != 0) {
                langsAsString += ";";
            }
            langsAsString += langs[i];
        }
        return langsAsString;
    }

    /**
     * Tronque une chaîne de caractères à un certain nombre de caractères, sans
     * couper le dernier mot, et y ajoute "..."
     *
     * @param str La chaîne à couper
     * @param end Le nombre maximal de caractères
     * @return La chaîne coupée
     */
    public static String subText(String str, int end) {
        if (end > str.length() || end <= 0) {
            return str;
        } else {
            int idx = str.lastIndexOf(' ', end);
            if (idx >= 0) {
                if (str.charAt(idx - 1) == ',') {
                    return str.substring(0, idx - 1) + "...";
                } else {
                    return str.substring(0, idx) + "...";
                }
            } else {
                return str.substring(0, end) + "...";
            }
        }
    }

    public static String getPictureUrlForSize(String originalUrl, String size) {
        String replacementString = null;

        if (originalUrl.startsWith("/")) {
            if (size.equalsIgnoreCase("xxxs")) {
                replacementString = "75x75";
            } else if (size.equalsIgnoreCase("xxs")) {
                replacementString = "125x125";
            } else if (size.equalsIgnoreCase("m")) {
                replacementString = "380x380";
            } else if (size.equalsIgnoreCase("l")) {
                replacementString = "800x800";
            }
            originalUrl = originalUrl.replace("/original_size/", "/" + replacementString + "/");
        }

        return originalUrl;
    }

}
