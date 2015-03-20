/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ird.crh.atlas.ability;

import java.util.List;
import org.ird.crh.ecoscope.libraries.ConstantsKeeper;

/**
 *
 * @author pcauquil
 */
public interface ResourceDisplayable extends TextShortable {
    	// ConstantsKeeperAware
	public ConstantsKeeper getCk();
	// Picturable
	public String getPictureUrlForSize(String originalUrl, String resolution);
	// Pageable
	public void setPageNumber(Integer pageNumber);
	public Integer getPageNumber();
	// Prefusable
	public String getRdfLocales();
	public String getHttpLocale();
	// SingleResourcePrefusable
	public String getUri();
	// CharReplaceable
	public String replace(String source, String regex, String replacement);
}
