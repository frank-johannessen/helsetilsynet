﻿/*
stickyfloat - jQuery plugin for verticaly floating anything in a constrained area
   
Example: jQuery('#menu').stickyfloat({duration: 400});
parameters:
duration        (number, 200) - the duration of the animation
startOffset     (number) - the amount of scroll offset after the animations kicks in
offsetY         (number) - the offset from the top when the object is animated
offsetYbottom   (number) - the maximum space between the object and the window bottom while scrolling down
lockBottom      (boolean, true)  - set to false if you don't want your floating box to stop at parent's bottom
delay           (number, 0) - delay in milliseconds  until the animnations starts
easing          (string, linear) - easing function (jQuery has by default only 'swing' & 'linear')
stickToBottom   (boolean, false) - to make the element stick to the bottom instead to the top
        
$Version: 08.04.2012 r5 (bug fixes)
$Version: 12.02.2012 r4 (bus fixes, added 'stickToBottom')
$Version: 11.28.2011 r3
$Version: 08.10.2011 r2
$Version: 05.16.2009 r1
   
Copyright (c) 2012 Yair Even-Or
vsync.design@gmail.com
*/
(function ($) {
    $.fn.stickyfloat = function (options) {
        var $obj = this,
            doc = $(document),
            parentPaddingTop = parseInt($obj.parent().css('padding-top')),
            startOffset = $obj.parent().offset().top,
            opts, bottomPos, pastStartOffset, objFartherThanTopPos, objSmallerThanWindow, newpos, checkTimer, oldScrollTop;

        opts = $.fn.stickyfloat.opts;
        $.extend(opts, { startOffset: startOffset, offsetY: parentPaddingTop }, options);

        $obj.css('position', 'relative');

        function initFloat() {
            $obj.stop(); // stop all calculations on scroll event
            var objHeight = $obj.outerHeight(),
                winHeight = $(window).height(),
                scrollTop = doc.scrollTop(),
                winBottomPos;

            bottomPos = $obj.parent().height() - objHeight + parentPaddingTop; // get the maximum bottom position
            bottomPos = bottomPos < 0 ? 0 : bottomPos;

            winBottomPos = scrollTop + winHeight - objHeight + parentPaddingTop - opts.offsetYBottom;
            winBottomPos = winBottomPos < 0 ? 0 : winBottomPos;

            pastStartOffset = doc.scrollTop() > opts.startOffset; // check if the window was scrolled down more than the start offset declared.
            objFartherThanTopPos = $obj.offset().top > startOffset; // check if the object is at it's top position (starting point)
            objSmallerThanWindow = objHeight < winHeight; // if the window size is smaller than the Obj size, do not animate.

            // if window scrolled down more than startOffset OR obj position is greater than
            // the top position possible (+ offsetY) AND window size must be bigger than Obj size
            if (pastStartOffset || objFartherThanTopPos) {

                newpos = opts.stickToBottom ? scrollTop + $(window.top).height() - objHeight - startOffset - opts.offsetY : (scrollTop - startOffset + opts.offsetY);

                if (oldScrollTop < scrollTop && !objSmallerThanWindow && newpos > winBottomPos) {
                    newpos = winBottomPos;
                }
                if (newpos > bottomPos) {
                    newpos = bottomPos;
                    // if window scrolled < starting offset, then reset Obj position (opts.offsetY);
                } else if (scrollTop < opts.startOffset && !opts.stickToBottom) {
                    newpos = parentPaddingTop;
                }
                if (opts.duration > 5) {
                    $obj.stop().delay(opts.delay).animate({ top: newpos }, opts.duration, opts.easing);
                } else {
                    $obj.stop().css('top', newpos);
                }
            }
            oldScrollTop = scrollTop;
        }

        $(window).bind('scroll.sticky', initFloat);
    };

    $.fn.stickyfloat.opts = { duration: 200, lockBottom: true, delay: 0, easing: 'linear', stickToBottom: false, offsetYBottom: 150 };
})(jQuery);
