<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="/struts-tags" prefix="s"  %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>


<div id="pagination" style="text-align:center;width: 100%;height: 20px;right: 0px;position: absolute;margin-top: -40px;"></div>
<div id="highchartContainer" style="width:100%;overflow: hidden;">

    <ul id="listHighchart" style="margin:0 auto;">
        <s:set var="counter" value="0"/>
        <s:iterator value="results">
            <s:url id="pathtojson" action="GetFile" escapeAmp="false">
                <s:param name="filePath"><s:property value="identifier.literal"/></s:param>
            </s:url>
            <%--<p>path :<s:property value="pathtojson"/></p>--%>
            <li class="individualHighchart" style="width:400px;float:left;display: inline-block;">

                <div id="container<s:property value="#counter"/>" path="<s:property value="pathtojson"/>" style="margin-left:5%;width: 90%; height: auto; float:left;display:inline;"></div>
            </li>
            <s:set var="counter" value="%{#counter+1}"/>
        </s:iterator>
    </ul>
    <s:if test="#counter == 1">

    </s:if>
    <s:else>
        <div id="previousHighchart" class="highchartNavigate" style="font-size: 2em;width:30px;height:20px;position:absolute;cursor:pointer;background-color:black;opacity:0.5;">
            
        </div>
        <div id="nextHighchart" class="highchartNavigate" style="font-size: 2em;width:30px;height:20px;right:20px;position:absolute;cursor:pointer;background-color:black;opacity:0.5;">
            
        </div>
    </s:else>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var nbr_highchart = 0;
        var current_highchart = 1;
        //permet de remplir les graphiques highchart avec les json (récupération de l'URL dans l'attribut path définit plus haut)
        $('ul#listHighchart li.individualHighchart div').each(function(i) {
            var json = $(this).attr('path');
            console.log('test' + json);
            nbr_highchart++;

            $.getJSON(json, function(data) {
                $('#container' + i).highcharts(data);
            });

        }).promise().done(function() {
            setTimeout(function() {
                var containerHeight = $('#container0').height();
                $('.highchartNavigate').css("margin-top", "-20px");
                $('#previousHighchart').css('height', containerHeight);
                $('#nextHighchart').css('height', containerHeight);
                $("#pagination").html(current_highchart + " / " + nbr_highchart);

            }, 1000);


//            alert(containerHeight);
//            if (current_highchart === 1) {
//                $('#previousHighchart').hide();
//            }

        });


        $(function() {
            if (current_highchart === 1) {
                $('#previousHighchart').hide();
            }
            document.getElementById('nextHighchart').addEventListener('click', function() {
                current_highchart++;
                gotoNext(true);
                $("#pagination").html(current_highchart + " / " + nbr_highchart);
            });
            document.getElementById('previousHighchart').addEventListener('click', function() {
                current_highchart--;
                gotoNext(false);
                $("#pagination").html(current_highchart + " / " + nbr_highchart);
            });
        });

        //permet de calculer la largueur du highchart
        var rightColumnWidth = $('#rightColumn').width();
        $('.individualHighchart').css('width', rightColumnWidth);
        $('.individualHighchart').css('float', "left");
        $('.individualHighchart').css('display', "inline-block");
        $("#listHighchart").css("width", 2 * rightColumnWidth);



        function gotoNext(dir) {
            if (current_highchart === 1) {
                $('#previousHighchart').hide();
            }
            if (current_highchart === nbr_highchart) {
                $('#nextHighchart').hide();
            }
//            alert('current highchart :' + current_highchart);
//            alert('nbr highchart :' + nbr_highchart);

            var marginLeft = $("#listHighchart").css('margin-left');
            var abs = Math.abs(parseInt(marginLeft, 10));
            //        var index = $('#listHighchart').attr('index');
            var index = 2;

            var step = dir ? '-=' + rightColumnWidth : '+=' + rightColumnWidth;
            if (dir === true) {
                if (abs < ((index) * rightColumnWidth)) {
                    $('#previousHighchart').show();
                    $('#listHighchart').animate({
                        marginLeft: step
                    }, 100, "linear");
                } else {
                    $('#nextHighchart').hide();
                }
            }
            if (dir === false) {
                if (marginLeft < 0 + 'px') {
                    $('#nextHighchart').show();
                    $('#listHighchart').animate({
                        marginLeft: step
                    }, 150, "linear");
                } else {
                    $('#previousHighchart').hide();
                }
            }


        }
    });
</script>