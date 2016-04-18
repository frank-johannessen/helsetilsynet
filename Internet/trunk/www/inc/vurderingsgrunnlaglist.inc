	

	

	<script language="JavaScript">	

	

	

	function initGbox() {

		var objSelectDT = document.all[selectGid];	
		var avaluesDT = valueGstring.split(',');			
		for (var t=0; t<avaluesDT.length; t++) {

			for(var i=0; i < objSelectDT.length; i++)

			{

				if (avaluesDT[t] == objSelectDT[i].value && objSelectDT[i].value.length>0) 
				{
					objSelectDT[i].selected = true; 
				}

			}	
		}

	}

	

	function GetGValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectGid];

		var objTextDT = document.all[hiddenGid];

		

		for(var i=0; i < objSelectDT.length; i++)

		{

			if(objSelectDT[i].selected)

			{

				if(strSaveDT == "")

				{

					strSaveDT += objSelectDT[i].value;

				}

				else

				{

					strSaveDT += "," + objSelectDT[i].value;

				}

				

			}

		}

		

		objTextDT.value = strSaveDT;

	}

	

	initGbox();

	

	</script>

	