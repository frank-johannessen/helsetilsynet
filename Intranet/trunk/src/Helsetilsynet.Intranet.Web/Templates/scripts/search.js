var losen = losen || {};
losen.searchResult = losen.searchResult || {};

(function(LSR){
	var q, keywordRegex, updateResultCount, labelUpdater;
	keywordRegex = /.*search-filter-([\w]*).*/;

	labelUpdater = function( labelElement ) {
		var $le, responseHandler;
		$le = $(labelElement);

		responseHandler = function(response) {

		    var $xml = $(response.responseXML);
		    var count = $xml.find('string,int').text();
		    
		    var countElement = $('<span class="count"> (' + count + ')</span>');
		    $le.find('.count').remove();
		    $le.append(countElement);
		};
		return responseHandler;
	};

	updateResultCount = function() {
		q = $('.text-filter input[type="text"]').val();
	    
        if( $.trim(q)=='') {
            return;
        }

        // TODO: NEIO: collections (docQuery "c"): enten sende med de/den som er valgt (med '|' mellom), eller dersom ingen er valgt sende ALLE med '|' mellom

	    $('.filters [class^="search-filter-"]').each(
			function(){
				var $listElement, keyword, match;
				$listElement = $(this);
			    match = keywordRegex.exec($listElement.attr("class"));
			    keyword = match ? match[1] : '';
			    $listElement.find('label').each(function() {
			        var $labelElement = $(this);
			        var labelText = $labelElement.contents().filter(function() { return this.nodeType == 3; })[0].textContent;
                    var queryString = 'q:' + q + ';' + keyword + ':' + labelText.toLocaleLowerCase();
			        $.ajax({
			            dataType: 'json',
			            contentType: 'application/json; charset=utf-8',
                        scriptCharset: 'utf-8',
			            type: 'GET',
			            url: losen.searchResult.resultCountUrl,
			            data: $.parseJSON('{"docQueryStr": "' + queryString +'"}'),
			            complete: labelUpdater($labelElement)
			        });
			    });

		});
	};

	LSR.updateResultCount = updateResultCount;
})(losen.searchResult);

$(document).ready(losen.searchResult.updateResultCount);
