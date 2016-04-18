	

	

	<script language="JavaScript">	

	

	

	function initbox() {

		var objSelect = document.all[selectid];	
		var avalues = valuestring.split(',');			
		for (var t=0; t<avalues.length; t++) {

			for(var i=0; i < objSelect.length; i++)

			{

				if (avalues[t] == objSelect[i].value && objSelect[i].value.length>0) 
				{
					objSelect[i].selected = true; 
				}

			}	
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

	