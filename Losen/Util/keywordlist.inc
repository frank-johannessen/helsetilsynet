	
	
	<script language="JavaScript">	
	
	
	function initbox() {
		var objSelect = document.all[selectid];		
		for(var i=0; i < objSelect.length; i++)
		{
			if (valuestring.indexOf(objSelect[i].value)>-1 && objSelect[i].value.length>0) objSelect[i].selected = true; else objSelect[i].selected = false;
		}		
	}
	
	function GetValue()
	{
		var strSave = "";
		var objSelect = document.all[selectid];
		var objText = document.all[hiddenid];
		
		for(var i=0; i < objSelect.length; i++)
		{
			if(objSelect[i].selected)
			{
				if(strSave == "")
				{
					strSave += objSelect[i].value;
				}
				else
				{
					strSave += "," + objSelect[i].value;
				}
				
			}
		}
		
		objText.value = strSave;
	}
	
	initbox();
	
	</script>
	