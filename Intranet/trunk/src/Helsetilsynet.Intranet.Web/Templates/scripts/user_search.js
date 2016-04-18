var losen = losen || {};
losen.userSearch = losen.userSearch || {};

(function(LUS){
	var buttonSelectorHandler, 
	    buttonSelectorAllHandler,  
	    hideDetailedViews, 
	    showDetailedView, 
	    search, 
	    getSearchParameters, 
	    updateResult,
	    addShowMoreListener,
	    initExtraFilterOptionsToggle,
	    appendSpecification, 
	    disableSpecificationIfUnselected,
	    getButtonSelectValues,
	    getCounty,
	    getSpecialities,
	    extraResultsCount = 0;

    disableSpecificationIfUnselected = function(index, cb) {
        var checkbox = $(cb);
    	if (checkbox.next().is('.label-wrapper')) {
	    // the button has a specification dropdown, disable when the button is 
	        
	        if (!checkbox.is(':checked')) {
	            checkbox.next().find('select').attr('disabled', true);
	        } else {
	            checkbox.next().find('select').attr('disabled', false);
	        }
	    }
    };
    
	buttonSelectorHandler = function(event) {
	    var $this, $selectedItems, $allSelector;
	    $this = $(this);
	    if ($this.is(':checked')) {
	        $this.parent().addClass('checked');
	    }
	    else {
	        $this.parent().removeClass('checked');
	    }
	    
        // Update allSelector
	    $selectedItems = $this.closest('.button-selector').find('input[type="checkbox"]:checked');
	    $allSelector = $this.closest('fieldset').find('.select-all input[type="checkbox"]');
	    if ($selectedItems.length === 0) {
	        $allSelector
    	        .attr('checked', true)
	            .parent().addClass('checked');
	    } else if ($allSelector.is(':checked')) {
	        $allSelector
    	        .attr('checked', false)
	            .parent().removeClass('checked');
	    }
	    disableSpecificationIfUnselected(null, $this);
	};

	buttonSelectorAllHandler = function(event) {
		var $this, $selectableItems, $selectedItems;
		$this = $(this);
	    
		$selectableItems = $this.closest('fieldset').find('.button-selector input[type="checkbox"]');

		if ($this.is(':checked')) {
   			$selectedItems = $selectableItems.filter(':checked');
			$selectedItems.attr('checked', false);
   			$selectedItems.each(disableSpecificationIfUnselected);
	        $selectedItems.parent().removeClass('checked');
		} else {
			$this.attr('checked', true);
		}
	    $this.parent().addClass('checked');
	};

	hideDetailedViews = function() {
		$('.detailed-result-wrapper .details').remove();
		$('.detailed-result-wrapper .vcard').unwrap();
	};

	showDetailedView = function(event) {
		hideDetailedViews();
		var $this = $(this), contentCopy;
		contentCopy = $this.clone().addClass('details').removeClass('vcard');
		$this.wrap('<div class="detailed-result-wrapper" />');
		contentCopy.prependTo($this.parent());
		return false;
	};
    
    var getButtonSelectedValuesArray = function(element) {
        var $element = $(element);
        var texts = [], labels;
        labels = $element.find('.button-selector input:checked + label, .button-selector input:checked + .label-wrapper label').each(function (index, e) {
            texts.push($(e).text());
        });
        return texts;
    };

    getButtonSelectValues = function(element) {
        return getButtonSelectedValuesArray(element).join(',');
    };
    
    getCounty = function() {
        var selector = $('.county-selector');
        if (selector.is(':enabled')) {
            return selector.val();
        }
        return '';
    };
    
    getSpecialities = function() {
        var values = [];
        $('.specialty-selector:enabled:not(.specialty-andre)').each(function (index, e) {
            var value = $(e).val();
            if (value) {
                values.push(value);
            }
        });
        return values.join(',');
    };

    var getProfessions = function() {
        var values = getButtonSelectedValuesArray($('.extra-filter-options .professions'));
        var otherProfessionSelector = $('.specialty-selector.specialty-andre');
        if (otherProfessionSelector.is(':enabled') && otherProfessionSelector.val()) {
            values.push(otherProfessionSelector.val());
        }
        return values.join(',');
    };

    getSearchParameters = function() {
        var p = { };
        var freetext = $('.filter-options input[type="text"]');
        p.maxResult = losen.userSearch.maxResultCount + extraResultsCount;  
        p.freetext = (freetext.val().length >= 3 && freetext.val() != losen.userSearch.placeholderText)  ? freetext.val() : '';
        p.services = getButtonSelectValues($('.filter-options .services'));
        p.departments = getButtonSelectValues($('.filter-options .departments'));
        p.county = getCounty();
        p.proffessions = getProfessions();
        p.tasks = getButtonSelectValues($('.extra-filter-options .tasks'));
        p.specialities = getSpecialities();
        return p;
        
    };

    updateResult = function(response) {
        var xml = $.parseXML(response.responseText),
            resultStr = $(xml).find('string').text(),
            $showMore;
        $('.result').html(resultStr);
        addShowMoreListener();
    };
    addShowMoreListener = function() {
        // button to show more results
        $('.show-more-results').first().bind('click', getMoreResults);
    };
    var searchParameterChanged = function() {
        extraResultsCount = 0;
        search();
    };
    search = function(event) {
        var params = getSearchParameters();
        
        $.ajax({
            url: '/WebServices/UserSearchService.asmx/Search',
            type: 'GET',
            dataType: 'json',
            mimeType: 'application/json',
            data: params,
            cache: false,
            contentType: 'application/json; charset=utf-8',
            scriptCharset: 'utf-8',
            complete: updateResult,
            headers: {'Accept': 'application/json'}
        });
        
    };
    
    initExtraFilterOptionsToggle = function() {
        var showExtraOptionsLink, hideExtraOptionsLink, extraFilterOptions, filterOptions, hideOptions, showOptions;
        
        showExtraOptionsLink = $('<a tabindex="0" class="toggle" href=".">' + losen.userSearch.showExtendedFiltersText + '</a>');
        hideExtraOptionsLink = $('<a tabindex="0" class="toggle" href=".">' + losen.userSearch.hideExtendedFiltersText + '</a>');
        
        extraFilterOptions = $('.extra-filter-options');
        extraFilterOptions.append(hideExtraOptionsLink);
        
        filterOptions = $('.filter-options');
        filterOptions.append(showExtraOptionsLink);
        
        hideOptions = function() {
            extraFilterOptions.hide();
            showExtraOptionsLink.show();
            return false;
        };
        showOptions = function() {
            extraFilterOptions.show();
            showExtraOptionsLink.hide();
            return false;
        };
        showExtraOptionsLink.bind('click active', showOptions);
        hideExtraOptionsLink.bind('click active', hideOptions);
        hideOptions();
    };

    appendSpecification = function(element, specification) {
        var label;
        label = $(element).children('label').first();
        label.wrap('<div class="label-wrapper" />');
        specification.attr('disabled', true);
        specification.insertAfter(label);
    };

    var autoSearch = function(event) {
        var freetext = $('.freetext-input');
        if ($( document.activeElement ).is(freetext)  && freetext.val().lenght != losen.userSearch.freetextLength) {
            losen.userSearch.freetextLength = freetext.val().length;
//            if (losen.userSearch.freetextLength >= 3) {
                search();
//            }
        }
    };

    var getMoreResults = function(event) {
        extraResultsCount += losen.userSearch.maxResultCount;
        search();
        return false;
    };

    LUS.appendSpecification = appendSpecification;
	LUS.buttonSelectorAllHandler = buttonSelectorAllHandler;
	LUS.buttonSelectorHandler = buttonSelectorHandler;
	LUS.hideDetailedViews = hideDetailedViews;
	LUS.showDetailedView = showDetailedView;
    LUS.search = search;
    LUS.searchParameterChanged = searchParameterChanged;
    LUS.initExtraFilterOptionsToggle = initExtraFilterOptionsToggle;
    LUS.autoSearch = autoSearch;
    LUS.getMoreResults = getMoreResults;
    LUS.addShowMoreListener = addShowMoreListener;
        
})(losen.userSearch);


$(document).ready(function () {

    $('fieldset .button-selector').delegate('input[type="checkbox"]', 'change', losen.userSearch.buttonSelectorHandler);
    $('fieldset .select-all').delegate('input[type="checkbox"]', 'change', losen.userSearch.buttonSelectorAllHandler);
    $('.result').delegate('.vcard', 'click touchstart', losen.userSearch.showDetailedView);
    $('.result').delegate('.details', 'click touchstart', function (event) { event.stopPropagation(); });
    $('.page-main-content').bind('click touchstart', losen.userSearch.hideDetailedViews);
    $('.filter-options,.extra-filter-options').delegate('input, select', 'change', losen.userSearch.searchParameterChanged);
    $(document).bind('keyup', losen.userSearch.autoSearch);
    
    losen.userSearch.addShowMoreListener();

    $('.filter-options input[type="checkbox"],.extra-filter-options input[type="checkbox"]').each(function () {
        if ($(this).is(':checked')) {
            $(this).parent().addClass('checked');
        }
        else {
            $(this).parent().removeClass('checked');
        }
    });
    
    losen.userSearch.maxResultCount = parseInt($('input[name="max-results"]').val());
    losen.userSearch.freetextLength = 0;
    losen.userSearch.placeholderText = $('.freetext-input').val();
    losen.userSearch.initExtraFilterOptionsToggle();
    losen.userSearch.appendSpecification($('.department-selector.department-fylkesmennene').first(), $('.county-selector.county').first());
    losen.userSearch.appendSpecification($('.profession-selector.profession-lege').first(), $('.specialty-selector.specialty-lege').first());
    losen.userSearch.appendSpecification($('.profession-selector.profession-sykepleier').first(), $('.specialty-selector.specialty-sykepleier').first());
    losen.userSearch.appendSpecification($('.profession-selector.profession-andre').first(), $('.specialty-selector.specialty-andre').first());

});