	

	

	<script language="JavaScript">	

	

	

	function initObox() {

		var objSelectDT = document.all[selectOid];	
		var avaluesDT = valueOstring.split(',');			
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

	

	function GetOValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectOid];

		var objTextDT = document.all[hiddenOid];

		

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

	

	initObox();

	

	</script>

	