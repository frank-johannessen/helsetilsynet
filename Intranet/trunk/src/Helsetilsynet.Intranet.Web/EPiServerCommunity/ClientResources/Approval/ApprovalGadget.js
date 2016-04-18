///<reference path="../jquery-1.3.2-vsdoc.js" />
(function($, epi) {
    if (!epi.community) {
        epi.community = {};
    }

    epi.community.approvalGadget = function() {

        var temp = {};

        var callApprovalAction = function(gadgetInstance, clickedAnchor, action) {
            var data = gadgetInstance.routeParams;
            $.extend(data, {
                approvalAction: action,
                itemMetadata: clickedAnchor.parent().parent().find("input#Metadata").val(),
                itemId: clickedAnchor.parent().parent().find("input#ItemId").val(),
                status: clickedAnchor.parent().parent().find("input#Status").val()
            });

            var options = {
                url: gadgetInstance.getActionPath({ action: "UpdateItem" }),
                data: data,
                success: function(data) {
                    $.extend(gadgetInstance.routeParams, { feedbackMessage: data });
                    gadgetInstance.loadView(gadgetInstance.routeParams);
                }
            };

            gadgetInstance.ajax(options);
        };

        var onloaded = function(e, gadgetInstance) {

            if (gadgetInstance.routeParams && gadgetInstance.routeParams.action == "EditSettings") {
                $("input[type=checkbox][name^='ApprovalTypeItems']").dblclick(function() {
                    $("input[type=checkbox][name^='ApprovalTypeItems']").attr("checked", !$(this).attr('checked'));
                })
            }
            else {
                if (gadgetInstance.routeParams && gadgetInstance.routeParams.feedbackMessage) {
                    gadgetInstance.routeParams.feedbackMessage = "";
                }

                // approval action buttons handler
                $("input[name=actionButton]", this).click(function(e) {
                    $("input[name=actionButtonValue]", gadgetInstance.element).val(this.id);
                });

                // approval action links handler
                $("tr.epi-gadget-defaultRow a[name^=ApprovalAction]", this).click(function(e) {
                    var action = $(this).attr("name").replace("ApprovalAction", "");
                    callApprovalAction(gadgetInstance, $(this), action);
                });

                // enable/disable buttons
                var setButtonStates = function() {
                    var value = $('td input:checkbox:checked', gadgetInstance.element).length == 0;
                    $('input[name=actionButton]', gadgetInstance.element).attr('disabled', value);
                    var itemsCount = $('td input:checkbox:visible', gadgetInstance.element).length;
                    var itemsChkCount = $('td input:checkbox:checked', gadgetInstance.element).length;
                    if ((itemsCount == itemsChkCount) && (itemsCount != 0)) {
                        $('#ApprovalGadget-AllSelected', gadgetInstance.element).attr('checked', 'checked');
                    } else {
                        $('#ApprovalGadget-AllSelected', gadgetInstance.element).removeAttr('checked');
                    }
                };

                setButtonStates();

                // highlight selected rows
                $('tr.epi-gadget-defaultRow :checkbox', this).click(function() {
                    $(this).closest('tr').toggleClass('epi-selectedRow', $(this).is(':checked'));
                    setButtonStates();
                });

                // select row on doubleclick
                $('tr.epi-gadget-defaultRow', this).dblclick(function() {
                    var chk = $(this).find('input');
                    if (chk.is(":checked")) {
                        chk.removeAttr("checked");
                    }
                    else {
                        chk.attr("checked", "checked");
                    }
                    $(this).toggleClass('epi-selectedRow', chk.is(':checked'));

                    setButtonStates();
                });

                $("#ApprovalGadget-AllSelected", this).click(function(e) {
                    if ($(this).is(':checked')) {
                        $('tr.epi-gadget-defaultRow input', gadgetInstance.element).each(function() {
                            $(this).attr('checked', 'checked').closest('tr').addClass('epi-selectedRow');
                        });
                    } else {
                        $('tr.epi-gadget-defaultRow input', gadgetInstance.element).each(function() {
                            $(this).removeAttr('checked').closest('tr').removeClass('epi-selectedRow');
                        })
                    }
                    setButtonStates();
                });



                //popup image
                $(".epi-gadget-previewImage", this).load(function(e) {
                    var img = $(this);
                    var containerW = img.parent().width();
                    var containerH = img.parent().height();
                    img.css('top', (containerH - img.height()) / 2);
                    img.css('left', (containerW - img.width()) / 2);
                });

                $(".epi-gadget-previewImageWrapper", this).mouseenter(function(e) {
                    var thumbContainer = $(this);
                    var div = thumbContainer.children(".epi-gadget-imagePopup");

                    $('body').append(div);
                    div.attr("id", "gadgetPopup_" + gadgetInstance.id);

                    var image = $("img", div);

                    if (!image.length) {
                        return;
                    }
                    div.show();
                    var popupBottomOffset = $(".epi-dashboardTabPanelContainer").height() - (thumbContainer.position().top + div.height());
                    div.css("top", thumbContainer.offset().top + Math.min(0, popupBottomOffset - 5));
                    div.css("left", thumbContainer.offset().left + thumbContainer.width() + 5);
                    image.css("left", (div.width() - image.width()) / 2);
                    image.css("top", (div.height() - image.height()) / 2);
                });

                $(".epi-gadget-previewImageWrapper", this).mouseleave(function(e) {
                    var div = $("#gadgetPopup_" + gadgetInstance.id);
                    $(this).append(div);
                    div.removeAttr("id");
                    div.hide();
                });
            }
        };

        temp.init = function(e, gadgetInstance) {
            $(this).bind("epigadgetloaded", onloaded);
        };

        return temp;
    } ();
} (epiJQuery, epi));