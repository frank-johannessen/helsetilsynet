<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditorGuideSV.ascx.cs" Inherits="EPiServer.Edit.EditorGuideSV" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<h1>
	Anv�ndbarhetsguide
</h1>
<p>
	H�r kan du l�sa om hur du som redakt�r kan skapa anv�ndbart och tillg�ngligt inneh�ll anpassat f�r webben.
</p>
<p>
	<a href="javascript:displaySection('Section1')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Bilder och grafiska element</a>
	<br />
	<a href="javascript:displaySection('Section2')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />L�nkar</a>
	<br />
	<a href="javascript:displaySection('Section3')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Formul�r</a>
	<br />
	<a href="javascript:displaySection('Section4')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Tabeller</a>
	<br />
	<a href="javascript:displaySection('Section5')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />Text</a>
	<br />
	<a href="javascript:displaySection('Section6')" class="EPEdit-editorGuideNavigationHeader"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowright.gif" />F�rger och kontraster</a>
</p>
<hr />
<div id="DisplayText">
	<p>
		Klicka p� n�gon av rubrikerna ovan f�r att l�sa om respektive omr�de.
	</p>
</div>

<div id="Section1" class="hidden">
	<h1>
		Bilder och grafiska element
	</h1>
	<h2>
		Komplettera bilder och andra grafiska element med alternativ text
	</h2>
	<p>
		Grafiska element � fotografier, illustrationer, kartor, text som sparats som bild etc. ska kompletteras med en kort alternativ beskrivning. Detta kallas alternativ text. Om du vill kontrollera hur de alternativa texterna blir p� din webbplats s� syns de som gula rutor om du pekar p� bilderna (om du anv�nder Internet Explorer som webbl�sare).
	</p>
	<p>
		Den alternativa texten ska beskriva bilden och bildens funktion. Det betyder att olika typer av bilder kan beh�va mer eller mindre omfattande beskrivningar. Se nedan vad som g�ller f�r n�gra olika typer av grafiska element.
	</p>
	<p>
		Observera att samma bild kan beh�va beskrivas p� olika s�tt beroende p� i viket sammanhang den publiceras. Undvik d�rf�r att arbeta med fasta alternativa bildbeskrivningar.
	</p>
	<h3>	
		<a id="ShowHideLink11" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection11', 'ShowHideImage11', 'ShowHideLink11')">
			<img id="ShowHideImage11" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bilder av dekorkarakt�r
		</a>
	</h3>
	<div id="SubSection11" class="hidden">
		<p>
			Bilder som mest anv�nds f�r att l�tta upp sidan har ingen djupare funktion och ska d�rf�r beskrivas kortfattat. OBS! Du beh�ver inte skriva "Bild". D�remot kan det vara bra att skriva om bilden �r ett fotografi eller en illustration. Den alternativa texten: "Glada barn som leker i sandl�dan. Fotografi" �r en bra alternativ text f�r en bild som anv�nds p� en sida f�r att l�tta upp en text om f�rskoleverksamhet.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink12" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection12', 'ShowHideImage12', 'ShowHideLink12')">
			<img id="ShowHideImage12" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Inneh�llsrika bildelement
		</a>
	</h3>
	<div id="SubSection12" class="hidden">
		<p>
			Vissa bilder inneh�ller information som �r mycket viktig f�r anv�ndarens f�rst�else. Det kan till exempel vara diagram, ritningar, spr�ngskisser eller nyhetsbilder. F�r dessa kr�vs en mer noggrann och omfattande beskrivning. F�rs�k �nd� att begr�nsa beskrivningen till max 150 tecken.
		</p>
		<p>
			Beh�ver bilden f�rklaras mer �n s� kan du beh�va beskriva bilden i en separat text. Ibland finns en s�dan beskrivning i den text som omger bilden. D� kan den alternativa texten referera till denna text.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink13" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection13', 'ShowHideImage13', 'ShowHideLink13')">
			<img id="ShowHideImage13" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bildkartor (image maps)
		</a>
	</h3>
	<div id="SubSection13" class="hidden">
		<p>
			En bildkarta �r en bild d�r delar av bilden �r klickbara med l�nkar till andra sidor. Elementen,  de olika delarna av bildkartan, best�r d� b�de av bilder och l�nkar samtidigt. F�r att en bildkarta ska fungera ska bilden vara beskriven med en alternativ text. Varje l�nk ska dessutom vara beskriven med en kompletterande text, en s� kallad l�nktitel. Dessutom kan det vara bra om du har vanliga textl�nkar bredvid bildelementet. 
		</p>
		<p>
			Om du t�nker dig en l�nskarta d�r varje kommun ska vara klickbar s� beskriver du l�nskartan med hj�lp av alternativ text och l�nken till varje kommun med en l�nktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink14" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection14', 'ShowHideImage14', 'ShowHideLink14')">
			<img id="ShowHideImage14" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Ikoner
		</a>
	</h3>
	<div id="SubSection14" class="hidden">
		<p>
			Ikoner anv�nds f�r att markera vissa speciella funktioner och ska tydligg�ra den aktuella funktionen. Ikoner b�r anv�ndas sparsamt och anv�nd standardikoner s� l�ngt det �r m�jligt. Undvik ikoner i l�pande text.
		</p>
		<p>
			Ikoner ska beskrivas med alternativ text. Om ikonen �r klickbar ska den b�de beskrivas med alternativ text och med en l�nktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink15" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection15', 'ShowHideImage15', 'ShowHideLink15')">
			<img id="ShowHideImage15" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Textbilder
		</a>
	</h3>
	<div id="SubSection15" class="hidden">
		<p>
			Undvik att anv�nda bilder f�r att endast presentera text. I de flesta fall g�r det att ers�tta "textbilder" med riktig text. I vissa fall kan det kr�vas en utveckling av er webbplats s� kallade stilmall (CSS) f�r att det ska fungera.
		</p>
		<p>
			Om du �nd� anv�nder textbilder s� m�ste du skriva in samma text som en alternativ text.
		</p>
	</div>
	<h2>
		Icke meningsb�rande grafiska element
	</h2>
	<p>
		Om bildens funktion inte �r meningsb�rande ska du inte ange n�gon alternativ text. Exempel p� icke meningsb�rande element �r typografiska linjer, prickar och liknande, som anv�nds f�r att tydligg�ra den visuella presentationen p� sidan.
	</p>
	<h2>
		Varf�r �r det h�r viktigt?
	</h2>
	<p>
		Det �r inte s�kert att den utrustning som anv�ndarna av din webbplats anv�nder kan presentera bilder. Till exempel har personer med funktionshinder ibland hj�lpmedel som inte kan tolka vad en bild f�rest�ller. Ist�llet anv�nder dessa hj�lpmedel bildens alternativa text. 
	</p>
	<p>
		Ett s�dant exempel �r att anv�ndaren kan ha ett program som l�ser upp inneh�llet p� sidan. S�dana program kan inte tolka vad som finns i en bild men de �r bra p� att hitta och l�sa upp de alternativa texterna.
	</p>
</div>

<div id="Section2" class="hidden">
	<h1>
		L�nkar
	</h1>
	<h2>
		Formulera tydliga l�nkar
	</h2>
	<p>
		Grundregeln �r att en l�nk ska kunna f�rst�s �ven om l�nken l�ses utlyft ur det sammanhang d�r den presenteras. L�nktexten ska s� att s�ga kunna st� p� egna ben. Det betyder att en l�nktext ska tydligg�ra vad som kommer att h�nda om man v�ljer att klicka p� l�nken. T�nk dig in i en situation d�r du bara ser l�nktexten. Skulle du f�rst� vart l�nken d� leder? I s� fall har du en tillr�ckligt bra l�nktext. Om inte, d� m�ste du komplettera l�nken med ytterligare information. Eller skriva om l�nken.
	</p>
	<h2>
		Kompletterande beskrivningar av l�nkar
	</h2>
	<p>
		Ibland blir en l�nk inte tillr�ckligt tydlig i sig sj�lv. D� ska du komplettera l�nktexten med en s� kallad l�nktitel.
	</p>
	<p>
		"L�s mer" �r ett exempel p� en l�nk som inte �r tydlig i sig sj�lv. S�dana l�nkar ska kompletteras med en l�nktitel En "l�s mer"-l�nk som leder till en text om att importen av bananer sl�r nya rekord kan d� ha l�nktiteln "L�s mer om att importen av bananer sl�r rekord".
	</p>
	<h3>	
		<a id="ShowHideLink21" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection21', 'ShowHideImage21', 'ShowHideLink21')">
			<img id="ShowHideImage21" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Bildelement som �ven �r l�nkar
		</a>
	</h3>
	<div id="SubSection21" class="hidden">
		<p>
			Om en bild �r klickbar ska du beskriva b�de bilden och l�nken. Enligt det du l�rt dig ovan ska bilden beskrivas med en alternativ text och l�nken med en l�nktitel. F�r att vara helt s�ker p� att det ska fungera f�r en person med hj�lpmedel b�r du dock anv�nda samma beskrivning f�r b�de alternativ text och l�nktitel. 
		</p>
		<p>
			F�r att ta ett vanligt exempel. Oftast �r verksamhetens logotyp klickbar och leder tillbaka till startsidan. Den �r b�de en bild och en l�nk samtidigt. D� fungerar det b�st om du skriver till exempel: "Logotyp f�r Bolaget AB, till startsidan f�r Bolaget AB" b�de som alternativ text och som l�nktitel.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink22" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection22', 'ShowHideImage22', 'ShowHideLink22')">
			<img id="ShowHideImage22" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />L�nkar som leder till alternativa format
		</a>
	</h3>
	<div id="SubSection22" class="hidden">
		<p>
			Om den l�nk du skapar leder till dokument som inte �r webbsidor (till exempel PDF, Word, PowerPoint etc.) s� ska du ange filformatet i l�nken. �ven filens storlek kan beh�va anges, s�rskilt om det �r fr�ga om ett stort dokument. 
		</p>
		<p>
			OBS! Vissa webbplatser �r gjorda s� att filformat och filstorlek automatiskt tillfogas l�nken. Om din webbplats fungerar p� det s�ttet beh�ver du inte ange dessa uppgifter manuellt.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink23" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection23', 'ShowHideImage23', 'ShowHideLink23')">
			<img id="ShowHideImage23" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />L�nkar som �ppnar interna sidor i nytt f�nster
		</a>
	</h3>
	<div id="SubSection23" class="hidden">
		<p>
			Anv�ndaren ska f�rvarnas om att sidan �ppnas i nytt f�nster. Du kan g�ra det p� tre s�tt:
		</p>
		<ul>
			<li>
				Skriv det i klartext i l�nken			
			</li>
			<li>
				Skriv det i l�nktiteln
			</li>
			<li>
				Anv�nd en ikon som signalerar nytt f�nster
			</li>
		</ul>
		<p>
			Generellt g�ller att du b�r anv�nda nya f�nster sparsamt och n�r det �r v�l motiverat.		
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink24" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection24', 'ShowHideImage24', 'ShowHideLink24')">
			<img id="ShowHideImage24" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />L�nkar som �ppnar externa webbplatser i nytt f�nster
		</a>
	</h3>
	<div id="SubSection24" class="hidden">
		<p>
			Anv�ndaren ska f�rvarnas om
		</p>
		<ul>
			<li>
				att l�nken leder till en annan webbplats			
			</li>
			<li>
				att l�nken �ppnas i ett nytt f�nster
			</li>
		</ul>		
		<p>
			Du kan g�ra det p� tre s�tt:
		</p>
		<ul>
			<li>
				Skriv det i klartext i l�nken			
			</li>
			<li>
				Skriv det i l�nktiteln
			</li>
			<li>
				Anv�nd en ikon som signalerar extern webbplats och nytt f�nster
			</li>
		</ul>
	</div>
	<h2>
		Varf�r �r det h�r viktigt?
	</h2>
	<p>
		L�nkar �r bland det viktigaste som finns p� en webbplats. En anv�ndare som inte f�rst�r dina l�nkar kommer att hamna fel eller f�r leta on�digt l�nge. Genom att ha tydliga l�nkar och genom att hj�lpa anv�ndaren att f�rst� skillnader mellan olika typer av l�nkar s� blir det enklare att anv�nda din webbplats. Vissa anv�ndare har hj�lpmedel som l�ser alla l�nkar f�r sig, som i en l�ng lista. D�rf�r m�ste l�nken vara tydlig i sig sj�lv.
	</p>
</div>

<div id="Section3" class="hidden">
	<h1>
		Formul�r
	</h1>
	<p>
		Till skillnad fr�n sidor som enbart inneh�ller information s� �r formul�r sidor (eller delar av sidor) d�r anv�ndaren inte bara ska l�sa p� sidan utan ocks� sj�lv fylla i vissa uppgifter. Man brukar s�ga att s�dana delar av webbplatsen �r interaktiva. Det betyder att anv�ndaren ska vara aktiv och d� �r det viktigt att vara tydlig och logisk s� att anv�ndaren f�rst�r hur formul�ret ska fyllas i . 
	</p>
	<p>
		F�r att anv�ndarna l�ttare ska f�rst� hur de ska anv�nda ett formul�r kr�vs att formul�ret har en konsekvent och tydlig utformning. Grundl�ggande �r att ledtexter och inmatningsf�lt i formul�r ska vara placerade p� ett logiskt och konsekvent s�tt. Ledtexter b�r s� l�ngt som m�jligt vara placerade f�re inmatningsf�ltet. Omfattande och komplexa formul�r kan beh�va delas upp i tydliga avdelningar.
	</p>
	<h2>
		Tekniska riktlinjer
	</h2>
	<p>
		Om du �r ovan vid att skapa formul�r s� kan du beh�va ta hj�lp av n�gon som satt sig in i hur den tekniska konstruktionen ska g� till. F�r komplexa formul�r finns det ett tekniskt regelverk som �r relativt omfattande.
	</p>
	<p>
		F�r enkla formul�r och som ett minimum f�r att g�ra formul�r tillg�ngliga g�ller att:
	</p>
	<ol>
		<li>
			Koppla ihop ledtexter och inmatningsf�lt ist�llet f�r att anv�nda en separat ledtext f�r f�ltet.
		</li>
		<li>
			F�rklara formul�rf�lt med hj�lp av sk�rmtips om inte f�ltets ledtext ger en tillr�cklig f�rklaring.
		</li>
	</ol>
	<h2>
		Varf�r �r det h�r viktigt?
	</h2>
	<p>
		Formul�r inneb�r ett interaktivt moment f�r anv�ndaren. Det st�ller stora krav p� tydlighet och begriplighet. Om anv�ndaren har olika hj�lpmedel f�r att fylla i formul�ret m�ste det vara gjort enligt vissa tekniska riktlinjer. Annars kan det bli om�jligt att f�rst� hur formul�ret ska fyllas i.
	</p>
</div>

<div id="Section4" class="hidden">
	<h1>
		Tabeller
	</h1>
	<p>
		N�r information presenteras i tabellform �r det viktigt att f�rs�ka f�rtydliga tabellen genom den visuella presentationen. Rad- och kolumnrubriker b�r d�rf�r grafiskt avvika fr�n sj�lva inneh�llet i tabellen. Om det �r m�nga rader eller kolumner kan dessa beh�va separeras med hj�lp av f�rger eller tonplattor etc.
	</p>
	<p>
		Om tabellen inneh�ller komplex information kan det vara bra att komplettera med samma information i diagramform. 
	</p>
	<h2>
		Anv�nd inte layouttabeller
	</h2>
	<p>
		Skapa inte layout med hj�lp av tabeller. Det ger otillg�ngliga sidor. F�r en anv�ndare med ett hj�lpmedel som l�ser upp sidorna kan det vara om�jligt eller mycket sv�rt att f� uppl�sningen att fungera. Hj�lpmedlet f�rs�ker tolka informationen som tabelldata (data uppst�lld i spalter och kolumner) medan du har styrt utformningen av sidan med hj�lp av tabeller. Hj�lpmedlet kan d�rf�r missa information helt eller l�sa upp information i helt fel ordning. Tabeller ska d�rf�r bara anv�ndas f�r data uppst�lld i spalter och kolumner.
	</p>
	<h2>
		Tekniska riktlinjer
	</h2>
	<p>
		Om du �r ovan vid att skapa tabeller s� kan du beh�va ta hj�lp av n�gon som satt sig in i hur den tekniska konstruktionen ska g� till. F�r komplexa tabeller finns det ett tekniskt regelverk som �r relativt omfattande.
	</p>
	<p>
		F�r enkla tabeller och som ett minimum f�r att g�ra tabeller tillg�ngliga g�ller att:
	</p>
	<ol>
		<li>
			Ange vilka tabellceller som �r rubrikceller.
		</li>
		<li>
			I datatabeller med mer �n en logisk niv� ska tabellrubriker associeras med tabellceller.
		</li>
	</ol>
	<p>
		Hur du g�r detta i EPiServer finns beskrivet i Redakt�rshandboken.
	</p>
	<h2>
		Varf�r �r det h�r viktigt?
	</h2>
	<p>
		M�nga tycker att tabeller �r sv�ra att f�rst�. Det g�ller att vara s� tydlig i presentationen som m�jligt. F�r de anv�ndare som har olika hj�lpmedel g�ller att de �r beroende av att tabellen �r konstruerad p� ett tekniskt korrekt s�tt. Annars kan de inte f� ut n�gon vettig information ur tabellen.
	</p>
</div>

<div id="Section5" class="hidden">
	<h1>
		Text
	</h1>
	<h2>
		Typografiska r�d
	</h2>
	<p>
		F�r en anv�ndare �r det viktigt att snabbt kunna orientera sig p� en sida och i ett textmaterial. F�r att hj�lpa anv�ndaren �r det viktigt att anv�nda en tydlig och konsekvent typografi. Det ska vara l�tt att skilja menyer och l�nkar fr�n rubriker och l�pande text. Det ska ocks� vara l�tt att skilja olika typer av l�nkar fr�n varandra.
	</p>
	<p>
		Den l�pande texten ska vara tillr�ckligt stor f�r att de flesta inte ska f� problem med att l�sa p� sk�rmen. Raderna ska inte vara f�r l�nga eller ligga f�r t�tt. Det mesta av detta sk�ts redan av de sidmallar och stilmallar som anv�nds p� er webbplats, s� det �r normalt ingenting som du som redakt�r beh�ver t�nka p�. 
	</p>
	<h2>
		Rubriker
	</h2>
	<p>
		Anv�nd rubriker f�r att strukturera sidorna p� ett tydligt s�tt. F�r kortare texter kan det r�cka med att texten har en huvudrubrik. Mer omfattande texter kan beh�va b�de huvudrubriker och underrubriker. T�nk p� att rubriker och underrubriker skapar en hierarki i texten. 
	</p>
	<p>
		F�r att kunna anv�nda en underrubrik m�ste det finnas en huvudrubrik. F�r att det ska bli snyggt kan du ibland beh�va olika typer av huvudrubriker, till exempel huvudrubriker med olika storlek. Det �r viktigt att de rubriker du beh�ver finns som rubrikklasser. Undvik att skapa egna rubriker � de blir inte tillg�ngliga som rubriker f�r anv�ndare med hj�lpmedel.
	</p>
	<p>
		Tydliga och bra formulerade rubriker g�r dina sidor l�ttare att l�sa. Det �r s�rskilt viktigt f�r personer med l�ssv�righeter. Det blir ocks� l�ttare f�r l�saren att snabbt bilda sig en uppfattning om texten. Dessutom kan din s�kmotor ha l�ttare att indexera sidor p� ett bra s�tt om det finns rubriker.
	</p>
	<p>
		F�r att rubriker ska kunna tolkas som rubriker av ett uppl�sande hj�lpmedel s� r�cker det inte med att de ser ut som rubriker. Det �gat ser �r en rubrik genom att storleken �r st�rre, stilen �r fet etc. r�cker inte f�r ett hj�lpmedel. F�r hj�lpmedlet m�ste det skapas en liten rubrikkod. Den kallas H, vilket betyder Heading. En huvudrubrik blir d� H1 och en underrubrik H2. Om det inte blir s�dana "H-taggar" i koden p� din webbplats, s� kan vissa anv�ndare inte skilja rubriker fr�n l�pande text. Och d� tappar dessa anv�ndare den struktur som skapas av dina rubriker.
	</p>
	<h2>
		L�pande text
	</h2>
	<p>
		L�ngre texter b�r indelas i korta och tydliga stycken. Styckemellanrum �r att f�redra framf�r indrag. Anv�nd rubriker och g�rna ocks� ingresser f�r att underl�tta l�sning av l�nga texter
	</p>
	<p>
		Om l�saren har l�ssv�righeter (vilket 20-30% av den vuxna befolkningen har) s� kan en v�lstrukturerad text underl�tta l�sningen. Webbplatsens mallar och stilmallar kan avg�ra hur presentationen blir och de kan ibland beh�va justeras s� att l�sbarheten blir b�ttre. Som redakt�r kan du undvika att skriva l�nga stycken och du kan arbeta med rubriker och underrubriker f�r hj�lpa l�saren igenom texten.
	</p>
	<p>
		Sidor blir ofta mer l�ttl�sta om det finns bilder som hj�lper texterna att f�rmedla informationen. Detta hj�lper de flesta anv�ndare och speciellt anv�ndare med l�ssv�righeter. Sj�lvklart ska alla bilder beskrivas med hj�lp av en alternativ text.
	</p>
	<h3>	
		<a id="ShowHideLink51" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection51', 'ShowHideImage51', 'ShowHideLink51')">
			<img id="ShowHideImage51" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Punktlistor och numrerade listor
		</a>
	</h3>
	<div id="SubSection51" class="hidden">
		<p>
			Listor �r bra n�r du radar upp information. Anv�nd listfunktionen i editorn. D� skapas korrekta listor. 
		</p>
		<p>
			Anv�nd inte listor f�r att skapa layout. G�r inte egna utseenden p� listor genom att l�gga bildelement och texter i en tabellstruktur. 
		</p>
		<p>
			Om du tycker att de listor du skapar via editorn inte ser bra ut s� kan det �ndras via de stilmallar som anger hur olika typer av text ska presenteras.
		</p>
		<p>
			Rent tekniskt blir det inga listor om du g�r listor av vanliga streck eller punkter och radbrytningar. D� kan en anv�ndare med ett hj�lpmedel inte f�rst� att det �r en lista, vilket ofta g�r informationen sv�rbegriplig. 
		</p>
	</div>
	<h2>
		Skrivtips
	</h2>
	<p>
		Det finns en omfattande litteratur p� detta omr�de f�r dig som vill f�rdjupa dig i hur man skriver bra webbtexter. Din organisation kan dessutom ha tagit fram egna skrivregler. H�r presenteras n�gra grundl�ggande r�d, som g�r din text l�ttare att ta till sig.
	</p>
	<h3>	
		<a id="ShowHideLink52" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection52', 'ShowHideImage52', 'ShowHideLink52')">
			<img id="ShowHideImage52" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv s� enkelt som m�jligt
		</a>
	</h3>
	<div id="SubSection52" class="hidden">
		<p>
			F�rs�k att formulera inneh�llet s� enkelt och tydligt som m�jligt och t�nk p� att m�nga olika grupper av anv�ndare kanske ska l�sa och f�rst� samma texter. Ibland kan samma information beh�vas i flera olika versioner. Det h�r r�det betyder inte att du ska l�ta bli att skriva om s�dant som �r sv�rt eller komplext. Det betyder d�remot att du hela tiden b�r fundera p� hur du ska formulera dig s� att dina l�sare f�rst�r det du skriver om.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink53" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection53', 'ShowHideImage53', 'ShowHideLink53')">
			<img id="ShowHideImage53" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv det viktigaste f�rst
		</a>
	</h3>
	<div id="SubSection53" class="hidden">
		<p>
			Av flera sk�l �r det d�rf�r viktigt att strukturera materialet s� att det viktigaste finns f�rst i dokumentet. Det hj�lper anv�ndaren att snabbare kunna avg�ra om han eller hon ska forts�tta l�sa det aktuella dokumentet eller leta vidare i andra dokument. 
		</p>
		<p>
			M�nga anv�ndare l�ser inte hela texten i ett dokument. Det �r t.ex. vanligt att anv�ndaren inte scrollar i ett dokument utan bara l�ser den text som ryms p� sk�rmen. Andra anv�ndare kanske snabbt blir tr�tta eller anstr�ngda av l�sningen eller de kanske inte har f�rm�ga att beh�lla koncentrationen. Ovana l�sare tycker ofta att l�nga texter k�nns problematiska.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink54" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection54', 'ShowHideImage54', 'ShowHideLink54')">
			<img id="ShowHideImage54" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />F�rklara sv�ra och ovanliga begrepp
		</a>
	</h3>
	<div id="SubSection54" class="hidden">
		<p>
			Ord och begrepp som �r sj�lvklara f�r dig och din verksamhet kan vara sv�ra att f�rst� f�r den som inte �r insatt. F�rs�k d�rf�r att hitta ett bra s�tt att f�rklara sv�ra ord och ovanliga begrepp.
		</p>
		<p>
			Om det finns enklare ord som betyder samma sak som ett sv�rare ord s� b�r du anv�nda det enklare ordet.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink55" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection55', 'ShowHideImage55', 'ShowHideLink55')">
			<img id="ShowHideImage55" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Skriv helst ut f�rkortningar och akronymer
		</a>
	</h3>
	<div id="SubSection55" class="hidden">
		<p>
			F�rkortningar och akronymer kan skapa problem. En akronym �r en f�rkortning som man kan l�sa som ett eget ord. Det �r inte s�kert att anv�ndaren f�rst�r en f�rkortning. Generellt g�ller d�rf�r att undvika f�rkortningar. 
		</p>
		<p>
			De f�rkortningar som du anv�nder kan beh�va f�rklaras. Det finns flera s�tt att g�ra det: Antingen skriver du ut f�rkortningen i klartext. Det b�r ske �tminstone den f�rsta g�ngen f�rkortningen f�rekommer i en text. Ett annat t�nkbart alternativ �r att f�rklara f�rkortningar (och andra viktiga eller sv�ra begrepp) i en ordlista.
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink56" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection56', 'ShowHideImage56', 'ShowHideLink56')">
			<img id="ShowHideImage56" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Datumformat
		</a>
	</h3>
	<div id="SubSection56" class="hidden">
		<p>
			Uppl�sande programvaror kan ha sv�rt att hantera datum. Vilken anv�ndare som helst kan ha problem med att f�rst� datum om datum presenteras p� olika s�tt p� olika delar av webbplatsen. D�rf�r b�r alla datum, b�de de som skapas automatiskt av olika listningar eller skrivs ut direkt i mallarna och de som skapas manuellt av redakt�rer skrivas p� samma s�tt. Det ger anv�ndaren en b�ttre m�jlighet att f�rst� och hantera datum. Rekommenderat s�tt att skriva datum �r: �r-m�nad-dag. 
		</p>
		<p>
			Den h�r meningen skrevs till exempel 2005-07-08, vilket �r enligt det rekommenderade s�ttet att skriva datum.
		</p>
	</div>
	<h2>
		L�ttl�sta versioner och teckenspr�k
	</h2>
	<p>
		F�r vissa anv�ndare r�cker det inte med att den ordinarie webbplatsen g�rs s� bra som m�jligt. Dessa anv�ndare har behov av kompletterande information anpassad till deras speciella f�ruts�ttningar. 
	</p>
	<h3>	
		<a id="ShowHideLink57" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection57', 'ShowHideImage57', 'ShowHideLink57')">
			<img id="ShowHideImage57" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />L�ttl�st
		</a>
	</h3>
	<div id="SubSection57" class="hidden">
		<p>
			F�r personer med beg�vningshandikapp och f�r personer som har sv�rt att beh�rska det svenska spr�ket finns ett s�tt att skriva som kallas "L�ttl�st". Med hj�lp av detta s�tt att skriva s� kan texten f�renklas s� att den blir l�ttare att f�rst�. Det finns s�rskilda utbildningar f�r att l�ra sig att skriva l�ttl�st.
		</p>
		<p>
			H�r kommer ett exempel (K�lla: Centrum f�r l�ttl�st, <a href="http://www.lattlast.se" target="_blank">www.lattlast.se</a>):
		</p>
		<p>
			S� h�r kan en text se ut f�re:
			<br />
			"N�r man l�mnar sitt land f�r man en helt ny livssituation. Man l�mnar ett k�nt sammanhang och ett gemensamt spr�k. Man f�rlorar den tillvaro d�r man hade sin identitet och trygghet. Man f�rst�r inte spr�ket, samspelet och koderna i det nya landet."
		</p>
		<p>
			S� h�r kan texten se ut efter:
			<br />
			"Det �r sv�rt att flytta till ett annat land. Du kan inte prata med m�nniskorna d�r. Du vet inte hur de h�lsar p� varandra eller tackar."
		</p>
	</div>
	<h3>	
		<a id="ShowHideLink58" title="<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>"
		href="javascript:showOrHideSubSection('SubSection58', 'ShowHideImage58', 'ShowHideLink58')">
			<img id="ShowHideImage58" src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/EditorGuide/arrowdown.gif" />Teckenspr�k
		</a>
	</h3>
	<div id="SubSection58" class="hidden">
		<p>
			F�r d�va kan det vara viktigt att f� viss information p� det egna spr�ket � teckenspr�ket. S�dant material l�ggs upp som filmer p� webbplatsen. M�nga d�va har mycket l�ttare f�r att f�rst� information som ges p� teckenspr�k j�mf�rt med skriftlig information p� svenska. Som ett komplement till en text kan det d�rf�r beh�vas en teckenspr�kig information.
		</p>
	</div>
</div>

<div id="Section6" class="hidden">
	<h1>
		F�rger och kontraster
	</h1>
	<h2>
		Anv�ndarens f�rguppfattningsf�rm�ga
	</h2>
	<p>
		Om du bara anv�nder f�rg f�r att f�rmedla information kan anv�ndare med f�rs�mrad f�rguppfattningsf�rm�ga inte ta del av information p� det s�tt det �r t�nkt. Ett exempel �r om du g�r viss text r�d f�r att markera n�got viktigt. Anv�nds f�rger f�r att f�rmedla information �r det extra viktigt att informationen ocks� f�rmedlas p� annat s�tt. R�d f�rg tillsammans med fet stil �r d�rf�r b�ttre �n enbart r�d f�rg i exemplet ovan.
	</p>
	<p>
		F�r att vara s�ker p� att sidor fungerar �ven om anv�ndaren inte kan uppfatta f�rgen kan du testa sidan genom att titta p� den p� en svartvit bildsk�rm eller genom att skriva ut den p� en svartvit skrivare. 
	</p>
	<h2>
		Kontraster
	</h2>
	<p>
		N�r f�rgrunds- och bakgrundf�rger ligger f�r n�ra varandra i f�rgskalor och ljushet f�r vissa anv�ndare problem med l�sbarheten. V�lj f�rger som ger god kontrast och d�rmed b�ttre l�sbarhet f�r alla m�nniskor. L�shastighet och m�jlighet till avst�ndsl�sning h�nger starkt samman med kontraster. Bra kontrast ger till exempel: svart text p� vit bakgrund, gr�nt p� vitt, bl�tt p� vitt och svart p� gult.
	</p>
	<p>
		Anv�nd endast f�rgrunds- och bakgrundsf�rger som tillsammans ger tillr�cklig kontrastverkan. 
	</p>
	<p>
		Ett s�tt att testa om skillnaderna mellan f�rger �r tillr�cklig �r att m�ta skillnaden i ljushet mellan de tv� f�rgerna. Skillnaden mellan f�rgerna ska ligga p� minst 50 enheter p� en 100 gradig skala. Om du har tillg�ng till Adobe Photoshop s� kan du m�ta skillnaden i f�rgv�rden enligt ovan.
	</p>
	<h2>
		Varf�r �r det h�r viktigt?
	</h2>
	<p>
		Alla uppfattar inte f�rg likadant. Viss utrustning �terger f�rg p� ett felaktigt s�tt och m�nga har sv�rt att l�sa text d�r kontrasten �r f�r liten. 
	</p>
</div>
