///<reference path="../jquery-1.3.2-vsdoc.js" />
(function($, epi) {
    if (!epi.community) {
        epi.community = {};
    }
    epi.community.activityGadget = function() {


        var initCheckboxHighlight = function() {
            $('.epi-checkboxTree input').each(function() {
                chk(this);
            })
            enableDisable();
            $('.epi-checkboxTree input').click(function() {
                chk(this);
                enableDisable();
            })
            function enableDisable() {
                if ($('.epi-checkboxTree input:checked').length >= 4) {
                    $('.epi-checkboxTree input').not('input:checked').attr('disabled', 'disabled');
                } else {
                    $('.epi-checkboxTree input').removeAttr('disabled');
                }
            }
            function chk(input) {
                $(input).closest('li').toggleClass('epi-checkboxTree-selected', input.checked);
            }
        }

        var SetChartResolution = function(gadgetInstance, chartID, resolution) {

            var actionPath = gadgetInstance.getActionPath({
                action: "GetData",
                Resolution: resolution
            });
            var chartCtl = $("#" + chartID, gadgetInstance.element)[0];
            chartCtl.Content.ActivityData.ShowActivity(actionPath);
            SetChartResolutionSelectors(resolution, gadgetInstance.element);
            $("#Resolution", gadgetInstance.element).val(resolution);
        }

        var SetChartResolutionSelectors = function(resolution, context) {
            var grapthByLinks = new Array($("#activityByDay", context), $("#activityByMonth", context), $("#activityByQuarter", context));
            switch (resolution) {
                case '4': //Day
                    SetupGraphByLinks(grapthByLinks, 0);
                    break;
                case '3': //Month
                    SetupGraphByLinks(grapthByLinks, 1);
                    break;
                case '2': // Quater
                    SetupGraphByLinks(grapthByLinks, 2);
                    break;
            }
        }

        var SetupGraphByLinks = function(links, selectedLinkNumber) {
            var i;
            for (i in links) {
                if (i == selectedLinkNumber) {
                    links[i].removeAttr("href");
                    links[i].parent().addClass("epi-gadgetShortlinks-active");
                }
                else {
                    links[i].attr("href", "#");
                    links[i].parent().removeClass("epi-gadgetShortlinks-active");
                }
            }
        }

        var temp = {};

        var onloaded = function(e, gadgetInstance) {

            var self = this;

            var resolutionValue = $("#Resolution", self).val();
            if (resolutionValue) {
                //Index view
                var dateFormat = $("#DateFormatContainer", self).val();
                var activityChartId = "activity_chart_" + gadgetInstance.id.replace(/-/g, '_');
                var datesContainerId = 'label_' + gadgetInstance.id;
                var CultureValue = $("#CurrentCultureContainer", self).val();

                CreateActivityChart($("#SilverlightActivityChartHost", self)[0], activityChartId, gadgetInstance.id, datesContainerId, CultureValue, dateFormat);
                SetChartResolutionSelectors(resolutionValue, self);

                $("#activityByDay", self).click(function() {
                    SetChartResolution(gadgetInstance, activityChartId, '4');
                });

                $("#activityByMonth", self).click(function() {
                    SetChartResolution(gadgetInstance, activityChartId, '3');
                });

                $("#activityByQuarter", self).click(function() {
                    SetChartResolution(gadgetInstance, activityChartId, '2');
                });
            }
            else {
                //Settings view
                var shortDateFormat = $("input[name=ShortDatePattern]", this).val()
                $("input[name=FromDate]", this).datepicker({ changeMonth: true, changeYear: true, dateFormat: shortDateFormat, showOn: 'button' });
                $("input[name=ToDate]", this).datepicker({ changeMonth: true, changeYear: true, dateFormat: shortDateFormat, showOn: 'button' });
                $("input[name=FromDate]", this).focus(function() {
                    $(this).datepicker("show");
                });
                $("input[name=ToDate]", this).focus(function() {
                    $(this).datepicker("show");
                });

                var onUseDateIntervalClick = function() {
                    if (this.checked) {
                        $("input[name=FromDate]", self).removeAttr("disabled");
                        $("input[name=FromDate] + button.ui-datepicker-trigger").removeAttr("disabled");
                        $("input[name=ToDate]", self).removeAttr("disabled");
                        $("input[name=ToDate] + button.ui-datepicker-trigger").removeAttr("disabled");
                    }
                    else {
                        $("input[name=FromDate]", self).attr("disabled", "disabled");
                        $("input[name=FromDate] + button.ui-datepicker-trigger").attr("disabled", "disabled");
                        $("input[name=ToDate]", self).attr("disabled", "disabled");
                        $("input[name=ToDate] + button.ui-datepicker-trigger").attr("disabled", "disabled");
                    }
                }

                $("input[name=UseDateInterval]", this).click(onUseDateIntervalClick);
                onUseDateIntervalClick.call($("input[name=UseDateInterval]", this)[0]);
                initCheckboxHighlight();
            }
        };

        temp.init = function(e, gadgetInstance) {
            $(this).bind("epigadgetloaded", onloaded);
        };

        return temp;
    } ();
} (epiJQuery, epi));


function CreateActivityChart(parent, ChartId, gadgetId, datesRangeContainerID, CultureValue, dateFormat) {
    var getSilverlightMethodCall =
            "javascript:Silverlight.getSilverlight(\"3.0.40624.0\");"
    var installImageUrl =
            "http://go.microsoft.com/fwlink/?LinkId=161376";
    var imageAltText = "Get Microsoft Silverlight";
    var altHtml =
            "<a href='{1}' style='text-decoration: none;'>" +
            "<img src='{2}' alt='{3}' " +
            "style='border-style: none'/></a>";
    altHtml = altHtml.replace('{1}', getSilverlightMethodCall);
    altHtml = altHtml.replace('{2}', installImageUrl);
    altHtml = altHtml.replace('{3}', imageAltText);

    Silverlight.createObjectEx({
        source: "../ClientBin/EPiServer.Community.Silverlight.ActivityGadgetChart.xap",
        parentElement: parent,
        id: ChartId,
        properties: {
            width: "100%",
            height: "100%",
            background: "white",
            alt: altHtml,            
            version: "3.0.40624.0",
            Culture: CultureValue,
            UICulture: CultureValue,
            Windowless: "True"
        },
        events: {            
            onError: onSilverlightError
        },
        initParams: "htmlDateRangeContainserId=" + datesRangeContainerID + ", gadgetId=" + gadgetId + ",dateFormat=" + dateFormat
    });
}

function SetActivityChartDateRanges(DateContainerId, value) {
    $("#" + DateContainerId).html(value);
}

function GetActionUrl(gadgetId) {
    var gadgetInstance = epi.gadget.getById(gadgetId);
    var resolution = $("#Resolution", gadgetInstance.element).val();
    var actionPath = gadgetInstance.getActionPath({
        action: "GetData",
        Resolution: resolution
    });
    return actionPath;
}

function onSilverlightError(sender, args) {
    var appSource = "";
    if (sender != null && sender != 0) {
        appSource = sender.getHost().Source;
    }

    var errorType = args.ErrorType;
    var iErrorCode = args.ErrorCode;

    if (errorType == "ImageError" || errorType == "MediaError") {
        return;
    }

    var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

    errMsg += "Code: " + iErrorCode + "    \n";
    errMsg += "Category: " + errorType + "       \n";
    errMsg += "Message: " + args.ErrorMessage + "     \n";

    if (errorType == "ParserError") {
        errMsg += "File: " + args.xamlFile + "     \n";
        errMsg += "Line: " + args.lineNumber + "     \n";
        errMsg += "Position: " + args.charPosition + "     \n";
    }
    else if (errorType == "RuntimeError") {
        if (args.lineNumber != 0) {
            errMsg += "Line: " + args.lineNumber + "     \n";
            errMsg += "Position: " + args.charPosition + "     \n";
        }
        errMsg += "MethodName: " + args.methodName + "     \n";
    }

    throw new Error(errMsg);
}


