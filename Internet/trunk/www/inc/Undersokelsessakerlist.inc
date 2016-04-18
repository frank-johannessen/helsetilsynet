	

	

	<script language="JavaScript">	

	

	

	function initUbox() {

		var objSelectDT = document.all[selectUid];	
		var avaluesDT = valueUstring.split(',');			
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

	

	function GetUValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectUid];

		var objTextDT = document.all[hiddenUid];

		

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

	

	initUbox();

	

	</script>

	