
var oclientTab;
function clickedTab( oTab, oBody, tabBaseName, initialTab, cssPrefix )
{
	if(oclientTab==null)
	{
		oclientTab = new TabControl(document.all[tabBaseName+initialTab],'view' + initialTab,cssPrefix);
	}
	if (oclientTab)
		oclientTab.Close();
	oclientTab.oTab = oTab;
	oclientTab.oBody = oBody;
	oclientTab.Open();
}

function TabControl(oTab,oBody,cssPrefix)
{
	this.oTab	= oTab;
	this.oBody	= oBody;
	this.Close = function()
	{
		if(typeof(this.oBody)=='string')
		{
			document.all[this.oBody].className=cssPrefix + 'ObjectInactive';
		}
		else
		{
			this.oBody.className=cssPrefix + 'ObjectInactive';
		}
		SwitchTabClass(this.oTab,false,cssPrefix);
	}
	this.Open = function()
	{
		if(typeof(this.oBody)=='string')
		{
			document.all[this.oBody].className=cssPrefix + 'ObjectActive';
		}
		else
		{
			this.oBody.className=cssPrefix + 'ObjectActive';
		}
		SwitchTabClass(this.oTab,true,cssPrefix);
	}
}

function SwitchTabClass(oTab,active,cssPrefix)
{
	for(var i=0;i<oTab.children.length;i++)
	{
		if(active)
		{
			switch(oTab.children[i].className.substr(cssPrefix.length))
			{
				case 'InactiveLeft':
					oTab.children[i].className = cssPrefix + 'ActiveLeft';
					break;
				case 'InactiveRight':
					oTab.children[i].className = cssPrefix + 'ActiveRight';
					break;					
				case 'Inactive':
					oTab.children[i].className = cssPrefix + 'Active';
					break;
			}
		}
		else
		{
			switch(oTab.children[i].className.substr(cssPrefix.length))
			{
				case 'ActiveLeft':
					oTab.children[i].className = cssPrefix + 'InactiveLeft';
					break;
				case 'ActiveRight':
					oTab.children[i].className = cssPrefix + 'InactiveRight';
					break;					
				case 'Active':
					oTab.children[i].className = cssPrefix + 'Inactive';
					break;
			}
		
		}
	
	}
}
