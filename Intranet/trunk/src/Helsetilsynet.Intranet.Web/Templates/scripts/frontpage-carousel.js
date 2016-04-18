$(document).ready(function() {
  var losen, itemsPerPage, sectionWidth, itemWidth, itemHeight, featuredArticles, next, previous, initPager, updatePager, pageNavigationHandler, pagerElement;

  losen = losen || {};
  losen.frontpage = losen.frontpage || {};

  itemsPerPage = 4;
  sectionWidth =  $('.featured').innerWidth();
  itemWidth = sectionWidth / itemsPerPage;
  itemHeight = $('.featured .article').first().height();

  featuredArticles = $('.featured ul');
  next = $('<span id="featured-articles-carousel-next" class="carousel-nav next" />');
  next.text(losen.frontpage.featuredArticlesCarouselNextText || 'next');
  previous = $('<span id="featured-articles-carousel-previous" class="carousel-nav prev" />');
  previous.text(losen.frontpage.featuredArticlesCarouselPreviousText || 'previous');

  featuredArticles.after(next);
  featuredArticles.after(previous);

  pageNavigationHandler = function(event) {
    var $this, pageNumber, pageRegex;
    $this = $(this);

    pageRegex = /#featured_articles_page_([0-9]*).*/
    pageNumber = pageRegex.exec($this.attr('href'))[1];
    featuredArticles.rcarousel("goToPage", pageNumber)
    event.preventDefault();
  };

  updatePager = function(event, data) {
    pagerElement.find('.current').removeClass('current');
    pagerElement.children().eq(data.page).addClass('current');
/*
    next.removeClass('inactive');
    previous.removeClass('inactive');
    if (data.page === 0) {
      previous.addClass('inactive');
    }
    if (data.page === featuredArticles.rcarousel("getTotalPages") - 1) {
      next.addClass('inactive');
    }
*/
  };
  initPager = function(event, data) {
    var pageCount, i, pageLink;

    pageCount = featuredArticles.rcarousel("getTotalPages");
    pagerElement = $('<div class="pager" />');
    for (i = 0; i < pageCount; i += 1) {
      pageLink = $('<a>' + (i + 1) + '</a>');
      pageLink.attr('href', '#featured_articles_page_' + i);
      pageLink.appendTo(pagerElement);
      pageLink.bind("click", {page: i}, function(event) {
        featuredArticles.rcarousel( "goToPage", event.data.page );
        event.preventDefault();
      });
    }

    featuredArticles.after(pagerElement);
    updatePager(null, {page: 0});
  };


  featuredArticles.rcarousel({
    visible: itemsPerPage,
    step: itemsPerPage, 
    navigation: {
      prev: "#featured-articles-carousel-previous",
      next: "#featured-articles-carousel-next"
    },
    width: itemWidth,
    height: itemHeight,
    start: initPager,
    pageLoaded: updatePager
  });
/*
  $('.summary, .ingress').wrapInner($('<span />'));
  $('.summary span, .ingress span').each(function(index, item) {
    var $item = $(item);
    if ($item.height() > $item.parent().height()) {
      $item.addClass('height-constrained');
    }
  });
*/
  var addFocusedClass = function(event) {
    var $this = $(this);
    $this.closest('.ui-carousel').addClass('focused');
    $this.addClass('focused');
  };
  var removeFocusedClass = function(event) {
    var $this = $(this);
    $this.closest('.ui-carousel').removeClass('focused');
    $this.removeClass('focused');
  };

  $('.ui-carousel').delegate('.article', 'mouseover', addFocusedClass);
  $('.ui-carousel').delegate('.article.focused', 'mouseout', removeFocusedClass);

});

var losen = window.losen || {};
losen.startPage = losen.startPage || {};
losen.startPage.alphabeticalIndexTimers = {};

$(document).ready(function () {
    var alphaExpand = function (element) {
        var $this = $(element);
        if (!$this.closest('.letter').hasClass('expanded')) {
            $this.closest('ul').find('.expanded').removeClass('expanded');
            $this.closest('.letter').addClass('expanded');
        }
        if (losen.startPage.alphabeticalIndexTimers[element]) {
            clearTimeout(losen.startPage.alphabeticalIndexTimers[element]);
        }
    };
    var expandAlphabeticalIndex = function (event) {
        event.stopPropagation();
        alphaExpand(this);
    };
    var closeAlphabeticalIndex = function (event) {
        if (event) {
            event.stopPropagation();
        }
        $('.alphabetical-index .expanded').removeClass('expanded');
    };

    var delayedExpansion = function (event) {
        event.stopPropagation();

        var alphaExpander = function (element) {
            return function () {
                alphaExpand(element);
            };
        };

        losen.startPage.alphabeticalIndexTimers[$(this).attr('id')] = setTimeout(alphaExpander(this), 300);
    };

    var cancelDelayedExpansion = function (event) {
        event.stopPropagation();
        if (losen.startPage.alphabeticalIndexTimers[$(this).attr('id')]) {
            clearTimeout(losen.startPage.alphabeticalIndexTimers[$(this).attr('id')]);
        }
    };

    var delayedClose = function () {
        setTimeout(closeAlphabeticalIndex, 300);
    };

    $('.alphabetical-index').delegate('.letter span', 'click touchstart', expandAlphabeticalIndex);
    $('.alphabetical-index').delegate('.letter.expanded span', 'click touchstart', closeAlphabeticalIndex);
    $('.alphabetical-index').delegate('.letter', 'mouseover', delayedExpansion);
    $('.alphabetical-index').delegate('.letter', 'mouseout mouseleave', cancelDelayedExpansion);
    $('.alphabetical-index').delegate('.letter.expanded', 'mouseout mouseleave', delayedClose);
    $(document).bind('click touchstart', closeAlphabeticalIndex);

});