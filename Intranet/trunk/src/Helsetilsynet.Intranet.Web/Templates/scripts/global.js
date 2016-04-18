// BEGIN: mega menu functionality
var losen = losen || {};
losen.megaMenu = {
    setManuallyExpandedMenu: function (event) {
        var $this = $(this),
                        $parent = $this.parent(),
                        $target = $(event.target);

        if ($target.attr('href').indexOf('#') != -1) {
            event.preventDefault();

            if (!$parent.hasClass('expanded')) {
                $parent.closest('.mega-menu').addClass('active').find('.expanded').removeClass('expanded');
                $parent.addClass('expanded');
                return false;
            }
        }
    },
    close: function (event) {
        if (event) {
            event.stopPropagation();
        }
        $('.mega-menu').removeClass('active').find('.expanded').removeClass('expanded');
        $('.mega-menu').find('a:focus').blur();
        return false;
    },
    eventDelayTimers: [],
    hoverDelay: 300
};

$(document).ready(function (event) {
    var block = function (event) {
        event.stopPropagation();
    };

    var focus = function (element) {
        $(element).find('a').first().focus();
        if (!$(element).closest('.mega-menu').hasClass('active')) {
            $(element).addClass('expanded');
        }
    };
    
    var delayedFocus = function (event) {
        var focusBinder = function (element) {
            return function () {
                focus(element);
            };
        };
        losen.megaMenu.eventDelayTimers[this] = setTimeout(focusBinder(this), losen.megaMenu.hoverDelay);
    };

    var cancelDelayedFocus = function (event) {
        event.stopPropagation();
        if (losen.megaMenu.eventDelayTimers[this]) {
            clearTimeout(losen.megaMenu.eventDelayTimers[this]);
        }
    };
    
    var blurTab = function (element) {
        var $this = $(element);
        if (!$this.closest('.mega-menu').hasClass('active')) {
            $this.removeClass('expanded');
        }
        $this.find('a').first().blur();
    };

    var delayedBlur = function (event) {
        var blurTabBinder = function (element) {
            return function () {
                blurTab(element);
            };
        };
        setTimeout(blurTabBinder(this), losen.megaMenu.hoverDelay);
    };

    $('.modal-popup-wrapper').first().appendTo($('.page-main-content').first());

    $('.mega-menu')
        .delegate('.header, #my-tools-tab', 'click touchstart', losen.megaMenu.setManuallyExpandedMenu)
        .delegate('#my-tools-tab', 'click touchstart', block)
        .find('.first, .second, .third, .my-tools').hover(
            function (e) {
                delayedFocus.call(this, e);
            },
            function (e) {
                cancelDelayedFocus.call(this, e);
                delayedBlur.call(this, e);
            });
});
// END: mega menu functionality

// BEGIN: auto clear search text box default text Søk på Losen og Helsetilsynet.no
(function ($) {
    $.fn.losenSearchBox = function(options) {
        options = $.extend({ }, {
            swap_val: ''
        }, options);

        $(this)
            .val(options.swap_val)
            .focusin(function() {
                if ($(this).val() == options.swap_val) {
                    $(this).val('');
                }
            })
            .focusout(function() {
                if ($.trim($(this).val()) == '') {
                    $(this).val(options.swap_val);
                }
            });
    };
})(jQuery);
// END: auto clear search text box default text

// BEGIN: Define and initialize clickableItems plugin
(function ($) {
    $.fn.clickableItems = function(options) {
        return this.each(function() {
            var $target = $(this), thisPlugin;
            if (!$target.data('clickableItems')) {
                thisPlugin = new ClickableItems($target, options);
                $target.data('clickableItems', thisPlugin);
            }
        });
    };

    function ClickableItems($target, options) {
        options = $.extend({}, {
            itemSelector: '.item',
            hoverClass: 'hover'
        }, options);
        $target.find(options.itemSelector)
            .css('cursor', 'pointer')
            .hover(function() {
                $(this).addClass(options.hoverClass);
            }, function() {
                $(this).removeClass(options.hoverClass);
            })
            .each(function () {
                var $item = $(this);
                $item.click(function(e) {
                    var $targetLink = $(e.target);
                    if (!$targetLink.is('a')) {
                        // Search downwards for link
                        $targetLink = $item.find('a').first();
                        if (!$targetLink.length) {
                            // Search upwards for link
                            $targetLink = $targetLink.parents('a');
                        }
                    }
                    if ($targetLink.length) {
                        document.location = $targetLink.attr('href');
                        e.preventDefault();
                    }
                });
            });
    }
    
    // Initialize
    $(document).ready(function(e) {
        // Search results
        $('.search-results').clickableItems({ itemSelector: '.result' });
    });
})(jQuery);
// END: Define and initialize clickableItems plugin