	

	

	<script language="JavaScript">	

	

	

	function initTbox() {

		var objSelectDT = document.all[selectTid];	
		var avaluesDT = valueTstring.split(',');			
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

	

	function GetTValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectTid];

		var objTextDT = document.all[hiddenTid];

		

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

	

	initTbox();

	

	</script>

	