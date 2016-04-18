	

	

	<script language="JavaScript">	

	

	

	function initVbox() {

		var objSelectDT = document.all[selectVid];	
		var avaluesDT = valueVstring.split(',');			
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

	

	function GetVValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectVid];

		var objTextDT = document.all[hiddenVid];

		

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

	

	initVbox();

	

	</script>

	