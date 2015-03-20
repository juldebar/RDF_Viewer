<%-- 
    Document   : homeCategory
    Created on : 12 janv. 2015, 08:55:51
    Author     : arnaud
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="metro span12">
        <div class="metro-sections">
            <div class="metro-section" id="section1">
                


                <%-- base de donnée --%>
                <a class="tile wide imagetext bg-color-greenDark category" href="#bddCategory" id="BDDCategory">
                    <div class="image-wrapper">
                        <span class="icon  icon-database"></span>
                    </div>
                    <div class="column-text">
                        <div class="text4">Bases de données</div>
                    </div>
                    <div class="app-label">Bases de données</div>
                    <div class="app-count" id="bddHomeLabel"></div>
                </a>

                <%-- images --%>
                <a class="tile app bg-color-orange category" href="#imageCategory" id="picturesCategory">
                    <div class="image-wrapper">
                        <span class="icon  icon-images"></span>
                    </div>
                    <div class="app-label">Images</div>
                    <div class="app-count" id="picturesHomeLabel"></div>
                </a>
                
                
                <%-- contact --%>
                <a class="tile app bg-color-orange category" href="#contactCategory" id="contactCategory">
                    <div class="image-wrapper">
                        <span class="icon  icon-vcard"></span>
                    </div>
                    <div class="app-label">Contacts</div>
                    <div class="app-count" id="contactsHomeLabel"></div>
                </a>

                <%-- indicateurs --%>
                <a class="tile wide imagetext bg-color-greenDark category" href="#indicateurCategory" id="indicatorCategory">
                    <div class="image-wrapper">
                        <span class="icon icon-stats-3 "></span>
                    </div>
                    <div class="column-text">
                        <div class="text4">Indicateurs</div>
                    </div>
                    <div class="app-label">Indicateurs</div>
                    <div class="app-count" id="indicateursHomeLabel">no data</div>
                </a>

                
                <%-- publication --%>
                <a class="tile app bg-color-purple category" href="#publicationsCategory" id="publicationsCategory">
                    <div class="image-wrapper">
                        <span class="icon icon-book-3"></span>
                    </div>
                    <div class="app-label">Publications</div>
                    <div class="app-count" id="publicationsHomeLabel"></div>
                </a>
                
                <%-- process ou slide --%>
                <a class="tile app bg-color-purple category" href="#atlasCategory" id="atlasCategory">
                    <div class="image-wrapper">
                        <span class="icon icon-book-3"></span>
                    </div>
                    <div class="app-label">Atlas thonier</div>
                    <div class="app-count" id="publicationsHomeLabel"></div>
                </a>
                
                <%-- pending test --%> 
                <a class="tile app bg-color-purple category" href="#satCategory" id="satCategory">
                    <div class="image-wrapper">
                        <span class="icon icon-earth-3"></span>
                    </div>
                    <div class="app-label">images satellites</div>
                    <div class="app-count" id="satHomeLabel"></div>
                </a>
                
                
            </div>
        </div>
    </div>
</div>