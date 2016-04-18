	

	

	<script language="JavaScript">





    function initVIbox() {

    var objSelectDT = document.all[selectVIid];
    var avaluesDT = valueVIstring.split(',');
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

	

	function GetVIValue()

	{

		var strSaveDT = "";

		var objSelectDT = document.all[selectVIid];

		var objTextDT = document.all[hiddenVIid];

		

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

	

	initVIbox();

	

	</script>

	