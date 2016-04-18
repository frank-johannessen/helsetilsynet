function EPiServerCommonOpenEditGlobalizationKey(key, searchControlId)
{
	window.open('../ControlWrapper.aspx?control=~/EPiServerCommunity/Globalization/GlobalizationKeyControl.ascx&key=' + key + '&searchControlId=' + searchControlId, '_blank', 'width=550, height=300, scrollbars=yes');
}

function EPiServerCommonAddLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    }
  }
}

function EPiServerCommonAddResizeEvent(func) {
  var oldonresize = window.onresize;
  if (typeof window.onresize != 'function') {
    window.onresize = func;
  } else {
    window.onresize = function() {
      oldonresize();
      func();
    }
  }
}