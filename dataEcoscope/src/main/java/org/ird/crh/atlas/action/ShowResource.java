/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.action;

import org.ird.crh.atlas.ability.ResourceDisplayable;
import static com.opensymphony.xwork2.Action.INPUT;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;
import org.ird.crh.ecoscope.kb.util.StrutsUtils;
import org.ird.crh.ecoscope.libraries.ConstantsKeeper;

/**
 * Action S² qui s'exécute après réception d'une requête HTTP client et qui
 * détermine la vue à exécuter. Elle initialise au passage quelques getters qui
 * peuvent être requis par certaines vues.
 *
 * @author pcauquil
 */
public class ShowResource extends ActionSupport implements SessionAware, ResourceDisplayable {

    // Communicable properties
    private String uri = null;
    private String view = null;
    private Map<String, Object> session;

    // Private properties
    private final ConstantsKeeper ck = ConstantsKeeper.getInstance();

    @Override
    public String execute() throws Exception {
        // Seeking the appropriate view
        if (view == null || (view != null && view.isEmpty())) {
            return INPUT;
        }

        return view;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public void setView(String view) {
        this.view = view;
    }

    // Interfaces implementation
    // Prefusable
    @Override
    public String getUri() {
        return uri;
    }

    @Override
    public String getRdfLocales() {
        return StrutsUtils.getRdfLocalesAsString(session);
    }

    @Override
    public String getHttpLocale() {
        return ActionContext.getContext().getLocale().getLanguage();
    }

    // SessionAware
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    // Picturable
    @Override
    public String getPictureUrlForSize(String originalUrl, String size) {
        return StrutsUtils.getPictureUrlForSize(originalUrl, size);
    }

    // TextShortable
    @Override
    public String subText(String str, int end) {
        return StrutsUtils.subText(str, end);
    }

    // ConstantsKeeperAware
    @Override
    public ConstantsKeeper getCk() {
        return this.ck;
    }

    // Pageable
    @Override
    public Integer getPageNumber() {
        throw new UnsupportedOperationException("Not supported yet");
    }

    @Override
    public void setPageNumber(Integer pageNumber) {
        throw new UnsupportedOperationException("Not supported yet");
    }

    // CharRepleacable
    @Override
    public String replace(String source, String regex, String replacement) {
        return source.replaceAll(regex, replacement);
    }
}
