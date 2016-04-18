$().ready(function () {

    //test if ie6
    isIE6 = false;
    $.each(jQuery.browser, function (i, val) {
        if (i == "msie" && (jQuery.browser.version.substr(0, 1) == "6")) {
            isIE6 = true;
        }
    });

     window.scrollTo(0, 1); 

    var accordion = {
        toggleClass: function(clickedEle, openEle) {

            if (clickedEle === undefined || clickedEle === null) return;
            if (openEle === undefined || openEle === null) openEle = clickedEle;
            
            var open = openEle.hasClass("is-open");

            if (!open || open === "false") {
               
                openEle.addClass("is-open");
                openEle.slideDown();

            } else {
                openEle.removeClass("is-open");
                openEle.slideUp();
            }

        },

        init: function() {
            var self = this;
            $(".accordion-header span").live("touchstart", function(e) {
                e.preventDefault();
                self.toggleClass($(this), $(this).parent().next(".accordion-tab-content"));
            });
        },
    };

    accordion.init();

    var setMenuWidth = function() {
        var mainMenuWidth = 0;
        $(".level0>li").each(function() { mainMenuWidth += $(this).width() + parseInt($(this).css("margin-right")); });
        mainMenuWidth += parseInt($(".level0").css("padding-left"));
        $(".mainMenu").width(mainMenuWidth + 60);

        $(".mainMenu li").each(function() {
            if ($(this).find("ul").length > 0) {
                $(this).addClass("hasSubmenu");
            }
        });
    };

    //Javascript media queries
    if (matchMedia) {
        var mediaQueryMin641 = window.matchMedia("(min-width: 641px)");
        if (!mediaQueryMin641) {
            var mediaQueryMin641 = {};
            mediaQueryMin641.matches = true;
            widthChange(mediaQueryMin641);
        } else {
             mediaQueryMin641.addListener(widthChange);
             widthChange(mediaQueryMin641);
        }
   }

    $(".mainMenu").width($(".level0").width() + 60);

    $(".mainMenu li").each(function () {
        if ($(this).find("ul").length > 0) {
            $(this).addClass("hasSubmenu");
        }
    });
    
    var closeDropdown = function() {
        $(this).addClass("icon-arrow-right").removeClass("icon-arrow-down");
        $(this).siblings("ul").hide();
        $(this).parent("li").removeClass("expanded");
    };

    var openDropdown = function() {
        $(this).addClass("icon-arrow-down").removeClass("icon-arrow-right");
        $(this).siblings("ul").show();
        $(this).parent("li").addClass("expanded");
    };

    $(".icon-arrow-down").live("touchstart", closeDropdown);
    //$(".icon-arrow-down").live("click", closeDropdown);
    $(".icon-arrow-right").live("touchstart", openDropdown);
    //$(".icon-arrow-right").live("click", openDropdown);


    function widthChange() {
        if (mediaQueryMin641.matches) { 
            $(".mainMenu").show();
            setMenuWidth(); 
            equalHeight($(".expanded>.level1>li"));
            equalHeight($(".expanded>.level2>li"));
            var wrapperPadding = $(".expanded>.level1").height() + $(".expanded>.level2").height() + $("#breadCrumbs").height() + "px";
            $("#innerWrapper").css("padding-top", wrapperPadding); 
            $(".expanded>.level2").css("top", $(".expanded>.level1").height());
            $(".expanded>.level1").height($(".expanded>.level1").height() + $(".expanded>.level2").height() + parseInt($(".expanded>.level2").css("border-bottom-width")));
            $(".go-to-top").hide();
            
        } else {
            $("#innerWrapper").css("padding-top", "30px");
            $(".mainMenu li").css("height", "auto");
            $(".mainMenu ul").css("height", "auto");
            $(".expanded>.icon-arrow-right").addClass("icon-arrow-down").removeClass("icon-arrow-right");
            
             if ($(".articleMenu").length > 0) {
                    $(".go-to-top").show();
            }
        }
    }

    //--add <br> to "rettigheter og klager"
    $(".mainMenu span").each(function () {
        if ($(this).text() == "Rettigheter og klager") {
            if ($(this).parent().is("a")) {
                $(this).html("Rettigheter <br />og klager");
            } else {
                var url = $(this).find("a").attr("href");
                $(this).html("<a href='" + url + "'>Rettigheter <br />og klager</a>");
            }
        }
    });

    (function() {
        var wrapperPadding = '0px';
        
        var beforePrint = function() {
            wrapperPadding = $("#innerWrapper").css("padding-top");
            $("#innerWrapper").css("padding-top", "30px");
        };

        var afterPrint = function() {
            $("#innerWrapper").css("padding-top", wrapperPadding); ;
        };

        if (window.matchMedia) {
            var mediaQueryList = window.matchMedia('print');
            mediaQueryList.addListener(function(mql) {
                if (mql.matches) {
                    beforePrint();
                } else {
                    afterPrint();
                }
            });
        }
        window.onbeforeprint = beforePrint;
        window.onafterprint = afterPrint;
    }());

    //---breadcrumb start----------
    //flag for breadcrumb slider functionality
    var breadCrumbClicked = false;
    //set equal height on lower level menus when no breadcrumb is present


    $("#breadCrumbs span:eq(0)").remove();
    $("#breadCrumbs").addClass("jQbreadCrumbs");
    $("#breadCrumbs").prepend("<span class='trigger'> </span>");

    //change bg-color if selected item is 6th item because last item doesn't go all the way to the right edge because of the elasticity
    $("#mainMenuSubLevels .level2 .noRightBorder.selected").parent().addClass("jQLastItemSelected");
    $("#mainMenuSubLevels .level3 .noRightBorder.selected").parent().addClass("jQLastItemSelected");
    $("#mainMenuSubLevels .level4 .noRightBorder.selected").parent().addClass("jQLastItemSelected");

    //open/close breadcrumb
    $("#breadCrumbs").click(function () {
        $("#mainMenuSubLevels").slideToggle(200);
        $(this).find(".trigger").toggleClass("isExpanded");
        if (mediaQueryMin641.matches) {
            if ($(".level1").is(":visible")) {
                $(".level1").hide();
                $("#innerWrapper").css("padding-top", "60px");
            } else {
                $(".level1").show();
                var wrapperPadding = $(".expanded>.level1").height() + $("#breadCrumbs").height() + "px";
                $("#innerWrapper").css("padding-top", wrapperPadding);
            }
           
        } else {

            if ($(".mainMenu").is(":visible")) {
                $(".mainMenu").slideUp();
            } else {
                $(".mainMenu").slideDown();
            }
            
        }
    });
    
    //don't open breadcrumb when hyperlinked
    $("#breadCrumbs a").click(function (event) {
        event.stopPropagation();
    });

    //remove underline on active item on breadcrumb on hover
    $("#breadCrumbs a").hover(function () {
        $(this).parents("#breadCrumbs").find(".lastItem").removeClass("hover");

    }, function () {
        $(this).parents("#breadCrumbs").find(".lastItem").addClass("hover");

    });

    $("#breadCrumbs").hover(function () {
        $(this).find(".lastItem").addClass("hover");

    }, function () {
        $(this).find(".lastItem").removeClass("hover");

    });
    //---breadcrumb end---

   
    //---leseweb start---
    $("body").addClass("leseweb");
    //---leseweb end---



    //---equal height on signature start---
    if ($(".signature_left").height() < $(".signature_right").height()) {
        $(".signature_left").height($(".signature_right").height());
    } else {
        $(".signature_right").height($(".signature_left").height());
    }
    //---equal height on signature end---



    //---article navigator start---
    var articleNavigationNamesArray = [];
    var articleNavigationUrlsArray = [];
    var articleNavigationHeadersArray = [];
    var arrayItemCounter = 0;
    //index wrapped in <ul>
    $("#main li > a[href^='#']").not(".go-to-top").each(function () {
        if ($(this).attr("href").length > 1) {
            //check if it's time to remove <ul>
            if ($(this).parent().next().text()) {
                nogo = true;
            } else {
                nogo = false;
            }
            articleNavigationNamesArray[arrayItemCounter] = $(this).text();
            articleNavigationUrlsArray[arrayItemCounter] = $(this).attr("href");
            articleNavigationHeadersArray[arrayItemCounter] = $(this).attr("href").substr(1);
            $([name=articleNavigationHeadersArray[arrayItemCounter]]).insertBefore("<a href=\"#top\">Go to top</a>");
            arrayItemCounter++;
            if (nogo == false) {
                $(this).parent().parent().addClass("jQhiddenIndex"); //hide <ul>to co 
            }
        }
    });
    //index wrapped in <p>
    $("#main p > a[href^='#']").not(".go-to-top").each(function () {
        if ($(this).attr("href").length > 1) {
            articleNavigationNamesArray[arrayItemCounter] = $(this).text();
            articleNavigationUrlsArray[arrayItemCounter] = $(this).attr("href");
            arrayItemCounter++;
            $(this).parent().addClass("jQhiddenIndex"); //remove anchor links in body and the <p> parent
        }
    });
    //index without wrapper (or <span>)
    $("#main a[href^='#']").not($("#main .jQhiddenIndex a[href^='#']")).not(".go-to-top").each(function () {
        if ($(this).attr("href").length > 1) {
            articleNavigationNamesArray[arrayItemCounter] = $(this).text();
            articleNavigationUrlsArray[arrayItemCounter] = $(this).attr("href");
            arrayItemCounter++;
            //remove <br>s
            if ($(this).next().is("br")) {
                $(this).next().remove();
            }
            $(this).addClass("jQhiddenIndex"); //remove anchor links in body
        }
    });
    //hide index heading
    $("#main").find("h2").not(".go-to-top").each(function () {
        if ($.trim($(this).text().toLowerCase()) == "innhold") {
            //remove next <br> if any
            if ($(this).next().is("br")) {
                $(this).next().remove();
            }
            $(this).addClass("jQhiddenIndex");
        }
    });
    //render index in left column
    if (arrayItemCounter > 0) {
        $("#jQarticleNavigator").prepend("<div class='box'><h2 class=\"mobile-hidden\">Innhold</h2><ul class='articleMenu'>");
        for (i = 0; i < articleNavigationNamesArray.length; i++) {
            $("#jQarticleNavigator .articleMenu").append("<li><a href='" + articleNavigationUrlsArray[i] + "'>" + articleNavigationNamesArray[i] + "</a></li>");
        }
        $("#jQarticleNavigator").append("</ul></div>");
        $("#jQarticleNavigator .box").clone().insertAfter("h2.go-to-top").addClass("mobile-article-menu");
      
    }
    //set vertical position on navigator ][ position navigator if page is reset
    if ($(this).scrollTop() > $("#innerWrapper").position().top - 20) {
        $("#jQarticleNavigator").addClass("fixed");
        if (isIE6) {
            $("#jQarticleNavigator .box").css("top", $(window).scrollTop() - $("#innerWrapper").offset().top + 15);
        }
    }
    
      if ($(".articleMenu").length > 0 && !mediaQueryMin641.matches) {
            $(".go-to-top").show();
        }

    $(window).scroll(function () {
        if (isIE6) {
            if ($("#jQarticleNavigator .box").length > 0) {
                currentTopPosition = getIntegerPixelValue($("#jQarticleNavigator .box"), "top");
            }
        }
        if ($(this).scrollTop() > $("#innerWrapper").position().top - 20) {//if scrolled below breadcrumb
            $("#jQarticleNavigator").addClass("fixed");
            if (isIE6) {
                $("#jQarticleNavigator .box").css("top", $(window).scrollTop() - $("#innerWrapper").offset().top + 15);
            }
        } else {
            $("#jQarticleNavigator").removeClass("fixed");
            $("#jQarticleNavigator .box").removeAttr("style"); //reset top in case it has been scrolled (long index on articles)
            $("#articleNavigatorScrollerUp").addClass("inactive");
            $("#articleNavigatorScrollerDown").removeClass("inactive");
            if (isIE6) {
                $("#jQarticleNavigator .box").removeAttr("style");
            }
        }
        if (isIE6) {
            $("#PAFTOOLBAR").css("top", $(window).scrollTop()); // <- leseweb
            $("#articleNavigatorScroller").css("top", $(window).scrollTop() + $(window).height() - $("#articleNavigatorScroller").parent().offset().top - 21);
        }
    });
    //---article navigator end---



    //---article navigator scroll start---
    //on startup
    if ($("#jQarticleNavigator .box").outerHeight() > $(window).height()) {
        activateArticleNavigatorScroller();
    }

    //on resize
    $(window).resize(function () {
        if ($("#jQarticleNavigator .box").outerHeight() > $(window).height()) {
            removeArticleNavigatorScroller()//reset
            activateArticleNavigatorScroller();
            $("#jQarticleNavigator .box").css("top", $("#jQarticleNavigator .box").css("top")); //for IE
        } else {
            removeArticleNavigatorScroller();
        }
    });
    //---article navigator scroll end---



    //---anchor---
    $("#main a[name]").css("color", "#000");
    //---anchors end---



    //---second search box enter key---
    $(".searchBox").keypress(function (event) {
        if (event.keyCode == "13") {
            event.preventDefault();
            $(".searchButton").click();
        }
    });
    //---second search box enter key end---



    //---page navigator hover effect---
    $(".pageNavigator input[disabled]").addClass("disabled");
    //---page navigator hover effect end---



    //---generate PDF status---
    $(".generatePdf a").click(function () {
        $(this).text("Vent litt...").css({ "text-decoration": "none", "color": "#666" }).parent().addClass("generatingPdfInProgress");
        $(window).blur(function () {
            $(".generatePdf a").text("Lag PDF").removeAttr("style");
            $(".generatingPdfInProgress").removeClass("generatingPdfInProgress");
        });
    });
    //---generate PDF status end---



    //---topic start--------
    $(".jQtopicList").each(function () {
        $(this).find("li:gt(3)").hide(); //show 4 items on each topic on pageload
        $(this).parent().find("p.readMore").show();
    });
    $(".jQtopicList").parent().find("p.readMore").click(function () {
        if ($(this).find("a").text() != "Tilbake til emnegrupper") {
            $(".jQtopicList").parent().not($(this).parent()).hide();
            $(this).parent().find(".jQtopicList li:gt(3)").show();
            tempTriggerValue = $(this).find("a").text();
            $(this).find("a").text("Tilbake til emnegrupper");
            $(this).addClass("noIconReadMore");
            return false;
        } else {
            $(".jQtopicList").parent().show();
            $(this).parent().find(".jQtopicList li:gt(3)").hide();
            $(this).find("a").text(tempTriggerValue);
            $(this).removeClass("noIconReadMore");
            return false;
        }
        return false;
    });
    //---topic end---



    //---tabs start--------
    $(".contentItemHead").hide();
    $(".tabBox .contentItem:gt(0)").hide();
    $(".liveTabs li").show();
    //make 1st heading in list larger
    $(".tabBox .contentItem").each(function () {
        $(this).find("h2:eq(0)").addClass("large");
    });
    //switch between tabs
    var previousTab = 0;
    $(".liveTabs li").click(function () {
        $(".liveTabs li").removeClass("selected");
        $(this).addClass("selected");
        var tabClicked = $(".liveTabs li").index(this);
        if (tabClicked != previousTab) {
            $(".tabBox .contentItem").hide();
            $(".tabBox .contentItem:eq(" + tabClicked + ")").fadeIn(300);
        }
        previousTab = tabClicked;
    });
    //---tabs end---



    //---extended info start-------
    $(".detailTrigger").parent().addClass("hideExtendedInfo");
    $(".detailTrigger").parent().wrap("<div style=''></div>"); //set style='position:relative' for browsers other than ie < 8

    $(".detailTrigger").click(function () {
        //find position on this trigger
        var thisPosition = $(this).offset();
        var wrapperPosition = $("#wrapper").offset();
        var positionX = thisPosition.left - wrapperPosition.left - 20;
        var positionY = thisPosition.top - ($(".mainMenuSubLevelsAndBreadcrumbs").height() + 242);

        $(this).parent().toggleClass("showExtendedInfo");
        $(".hideExtendedInfo").not($(this).parent()).removeClass("showExtendedInfo");
        $(".extendedInfoItems").remove();
        $(this).parent().find(".extendedInfoContent").prepend("<div class='extendedInfoItems' style='display:block;'></div>");
        $(this).parent().find(".extendedInfoContent div:gt(1)").hide();
        $(this).parent().find(".extendedInfoContent div:eq(1)").show();
        $(this).parent().find("h4").addClass("tempHidden");
        $(this).parent().find("h4").each(function () {
            $(this).parent().parent().find(".extendedInfoItems").append("<span>" + $(this).text() + "</span>");
        });
        $(this).parent().find(".extendedInfoContent span:eq(0)").addClass("selected");

        var previousExtendedInfoTab = 0;
        $(".extendedInfoItems span").click(function () {
            $(".extendedInfoItems span").removeClass("selected");
            $(this).addClass("selected");
            var extendedInfoTabClicked = ($(".extendedInfoItems span").index(this)) + 1;
            if (extendedInfoTabClicked != previousExtendedInfoTab) {
                $(this).parent().parent().find("div:gt(0)").hide();
                $(this).parent().parent().find("div:eq(" + extendedInfoTabClicked + ")").show();
            }
            previousExtendedInfoTab = extendedInfoTabClicked;
        });

        $(this).parent().css("top", positionY);
        $(this).parent().css("left", positionX);
    });
    //---extended info end---



    /**
    *
    * Em Change Plugin (http://jquery.lukelutman.com/plugins/emchange)
    * Trigger a custom event when the pixel size of 1em changes.
    * 
    * Version 1.0
    * December 8th, 2006
    *
    * Copyright (c) 2006 Luke Lutman (http://www.lukelutman.com)
    * Licensed under the MIT License:
    * http://www.opensource.org/licenses/mit-license.php
    * 
    * Examples: 
    * 
    * $('#example').bind('emchange', function() {
    *     // do stuff
    * });
    *
    * $('#example').unbind('emchange');
    *
    * This is a stripped-down implementation. 
    * For more features, see Dave Cardwell's JQEm plugin:
    * http://davecardwell.co.uk/geekery/javascript/jquery/jqem/
    *
    **/
    var bang, then;
    var $node = jQuery(document.createElement('div'))
		.html('.')
		.addClass('fontresizetester')
		.css({
		    position: 'absolute',
		    visibility: 'hidden',
		    width: '1em'
		});
    jQuery('body').append($node);
    then = $node.width();
    bang = setInterval(function () {
        var now = $node.width();
        if (then != now) {
            //set leftmargin on searchfield
            var sfWidth = $("ul.mainMenu").width();
            $(".mainSearchField").css("margin-left", sfWidth + 45 + "px");
        }
        then = now;
    }, 100);
    jQuery(window).bind('unload', function (e) {
        clearInterval(bang);
        bang = null;
    });
    //leftmargin on searchfield on pageload
    $(".mainSearchField").css("margin-left", $("ul.mainMenu").width() + 45 + "px");



    //---font resize start----------
    $("#tools").prepend('<div id="increaseSize"><a title="Endre fontst&oslash;rrelse" href="#"><img src="/templates/avenir/images/iconFontSize.png" alt="Endre fontst&oslash;rrelse" /></a></div>');
    //initial font-size
    var currentSize = readCookie('fontSize');
    if (currentSize) {
        if (currentSize == "jQnormal") {
            currentSize = "jQlarge";
        } else {
            currentSize = "jQnormal";
        }
    }

    changeFontSize(currentSize);
    //changing font-size
    $("#increaseSize a").click(function () {
        changeFontSize($(this).attr("class"));
        return false;
    });
    //changeFontSize

    function changeFontSize(size) {
        $("#increaseSize a").removeClass();
        if (size == "jQnormal") {
            var nextSize = "jQlarge";
            $("body").attr("style", "font-size:105%;");
            $("#increaseSize a").addClass("jQlarge");
            resizeMainMenuItems("large");
        } else {
            var nextSize = "jQnormal";
            $("body").removeAttr("style");
            $("#increaseSize a").addClass("jQnormal");
            resizeMainMenuItems("small");
        }
        createCookie('fontSize', nextSize, 30);
    }
    //---font resize end---


});


//-----resize main menu item boxes-----
function resizeMainMenuItems(currentSize) {
	if (currentSize == "large") {
		$(".mainMenu a span").each(function() {
			spanWith = $(this).width();
			if (spanWith > 104) {
				$(this).parent().css("width", spanWith);
			} else {
				$(this).parent().removeAttr("style");
			}
		});
	} else {
		$(".mainMenu a").removeAttr("style");
	}
}
//-----resize main menu item boxes end---


//---cookie functions http://www.quirksmode.org/js/cookies.html----------
function createCookie(name,value,days)
{
	if (days)
	{
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}
function readCookie(name)
{
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++)
	{
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
function eraseCookie(name)
{
	createCookie(name,"",-1);
}
//---cookie functions end---

function equalHeight(group) {
	tallest = 0;
	group.each(function() {
		thisHeight = $(this).height();
		if(thisHeight > tallest) {
			tallest = thisHeight;
		}
	});
	group.height(tallest);
}
//--------

function activateArticleNavigatorScroller() {
	if ($("#articleNavigatorScroller").length < 1) {//if not already set
		$("#jQarticleNavigator").append("<div id='articleNavigatorScroller'><span id='articleNavigatorScrollerUp' rel='up'></span><span id='articleNavigatorScrollerDown' rel='down'></span></div>");
	}
	$("#articleNavigatorScroller").css("top", $(window).height() - 22 + "px");//place at bottom
	currentTopPosition = getIntegerPixelValue($("#jQarticleNavigator .box"), "top");
	if (currentTopPosition >= 0) {
		$("#articleNavigatorScrollerUp").addClass("inactive");
	}
	if (currentTopPosition + $("#jQarticleNavigator .box").height() + 30 <= $(window).height()) {
		$("#articleNavigatorScrollerDown").addClass("inactive");
	}
	
	//pressing the scroller buttons
	$("#articleNavigatorScroller span").mousedown(function() {
		articleNavigatorElevate($(this).attr("rel"));
	}).mouseup(function() {
		articleNavigatorElevate("abort");
	}).mouseout(function() {
		articleNavigatorElevate("abort");
	});
}
function removeArticleNavigatorScroller() {
	$("#articleNavigatorScroller").remove();
	$("#jQarticleNavigator .box").removeAttr("style");
}
articleNavigatorScrollerClicked = false;//flag for clearTimeout
function articleNavigatorElevate(dir) {
	if (dir != "abort") {
		articleNavigatorScrollerClicked = true;
		var scrollSpeed = 10;
		var bottomScrollMargin = 30;
		if ($("#jQarticleNavigator").is(".fixed")) {
			currentTopPosition = getIntegerPixelValue($("#jQarticleNavigator .box"), "top");
			if (dir == "up") {//moving down
				$("#articleNavigatorScrollerDown").removeClass("inactive");
				if (!isIE6 && currentTopPosition < 15) {
					$("#jQarticleNavigator .box").css("top", (currentTopPosition + scrollSpeed) + "px");
				} else if (isIE6 && currentTopPosition < $(window).scrollTop() - ($("#jQarticleNavigator .box").offset().top - currentTopPosition - 15)) {
					$("#jQarticleNavigator .box").css("top", (currentTopPosition + scrollSpeed) + "px");
				} else {
					if (!isIE6) {
						$("#jQarticleNavigator .box").css("top", "15px");
					}
					$("#articleNavigatorScrollerUp").addClass("inactive");
				}
			} else {//moving up
				$("#articleNavigatorScrollerUp").removeClass("inactive");
				if (!isIE6 && (currentTopPosition + $("#jQarticleNavigator .box").height() + bottomScrollMargin > $(window).height())) {
					$("#jQarticleNavigator .box").css("top", (currentTopPosition - scrollSpeed) + "px");
				} else if (isIE6 & (currentTopPosition + $("#jQarticleNavigator .box").height() + ($("#jQarticleNavigator .box").offset().top - currentTopPosition + bottomScrollMargin) > $(window).scrollTop() + $(window).height())) {
					$("#jQarticleNavigator .box").css("top", (currentTopPosition - scrollSpeed) + "px");
				} else {
					$("#articleNavigatorScrollerDown").addClass("inactive");
				}
			}
		} else {
			if (dir == "down") {
				var currentScrollTop = $(window).scrollTop();
				$("html, body").scrollTop(currentScrollTop + scrollSpeed * 2);
			}
		}
		aneTimeout = setTimeout(function() {
			articleNavigatorElevate(dir)
		}, 10);
	} else {//abort scroll
		if (articleNavigatorScrollerClicked == true) {
			clearTimeout(aneTimeout);
		}
	}
}

function getIntegerPixelValue(tag, selector) {
	var pixelTxtValue = $(tag).css(selector).length;
	var pixelValue = parseInt($(tag).css(selector).substring(0, pixelTxtValue - 2));
	return pixelValue;
}