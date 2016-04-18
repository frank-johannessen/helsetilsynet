<%@ Page language="c#" MasterPageFile="~/Templates/Avenir/MasterPages/HTMaster.master" 
Codebehind="Lover.aspx.cs" AutoEventWireup="false" Inherits="Avenir.Templates.Pages.Lover"  %>

<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="ht" TagName="KeywordList"	Src="~/Templates/Avenir/Units/Placeable/KeywordList.ascx" %>
<%@ Register TagPrefix="ht" TagName="ChangedPages" Src="~/Templates/Avenir/Units/Placeable/ChangedPages.ascx" %>

<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
			<div class="box">
				<h2>Siste publiserte</h2>
				<ht:ChangedPages ID="ChangedPages" runat="server" />
				<p class="readMore"><a href="<%= ResolveUrl("~/no/nyheter/sistpub/") %>">Se alle</a></p>
			</div>
</asp:Content>


<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server">
			<div class="tabBox">
				<ul class="tabs">
					<li class="selected"><a href="#">Helsetjenesten</a></li>
					<li><a href="#">Sosialtjenesten</a></li>
					<li><a href="#">Barneverntjenesten</a></li>
					<li><a href="#">Andre lover</a></li>
				</ul>
				<div class="contentWrapper">
					<div class="content">
					
						<div class="contentItem">
							<table>
								<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven med lang tittel som nok brekker over to linjer</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							<tr>
									<td>
										<div class="leftCol">
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
									<td>
										<div>
											<h3 class="detailTrigger">Helseforskningsloven</h3>
											<p>Les hele loven på <a href="#">Lovdata</a></p>
											
											<div class="extendedInfoContent">
												<div class="extendedInfoItemContent">
													<h4>Forskrifter</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Rundskriv</h4>
													<p><a href="#">1997.06.19 nr. 0680:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Veiledninger</h4>
													<p><a href="#">1997.06.19 nr. 0619:</a> (AID) Forskrift om overgangsregler til lov 13.juni</p>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
												</div>
												
												<div class="extendedInfoItemContent">
													<h4>Brev</h4>
													<p><a href="#">1997 nr. 59</a> om endringer i lov 16.desember 1966 nr. 9 om anke til Trygderetten og i lov 28.februar 1997 nr. 19 om folketrygd</p>
													<p><a href="#">2001.09.11 nr. 1078:</a> (AID) Forskrift om overgangsregler i forbindelse med nye bestemmelser i lov 28.februar 1997 nr. 19 om folketrygd, kapittel 11</p>
													<p><a href="#">2002.12.20 nr. 1796:</a> (AID) Forskrift om overgangsregler i forbindelse med endringer i folketrygdloven kapittel 4 fra 1.januar 2003</p>
													<p><a href="#">2006.06.30 nr. 0731:</a> (AID) Forskrift om inkorparasjon av trygdeordningene i  ØS-avtalen</p>
													<p><a href="#">2008.08.18 nr. 0942:</a> (AID) Forskrift om arbeidsgiver- og arbeidstakerregisteret</p>
												</div>
												
											</div>
											
										</div>
									</td>
								</tr>
							</table>
						</div>
						
						<div class="contentItem">
							
						</div>
						
						<div class="contentItem">
							
						</div>
						
						<div class="contentItem">
							
						</div>
						
					<!-- end .content -->
					</div>
				<!-- end .contentWrapper -->
				</div>
				
			<!-- end .tabBox -->
			</div>

</asp:Content>

<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
	<ht:KeywordList ID="KeywordList" runat="server" />
</asp:Content>

