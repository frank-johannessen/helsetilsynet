using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.MyPage;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class EditProfileContactInfo : RelateUserControlBase<Model.MyPage>
    {
        protected override void OnLoad(EventArgs e)
        {
            ucNewPassword.UserName = DisplayUser.UserName;
            ucNewPassword.DataBind();
        }

        public override void DataBind()
        {
            base.DataBind();
            SetFylkesmannsView(DisplayUser.IsFylkesmann());
            
            if (DisplayUser.GivenName != null)
            {
                txtFirstname.Text = DisplayUser.GivenName;
            }
            if (DisplayUser.SurName != null)
            {
                txtLastname.Text = DisplayUser.SurName;
            }
            if (DisplayUser.GetRoomNumber() != null)
            {
                txtRoomNumber.Text = DisplayUser.GetRoomNumber();
            }
            if (DisplayUser.EMail != null)
            {
                txtEmail.Text = DisplayUser.EMail;
            }
            if (DisplayUser.GetTitle() != null)
            {
                txtTitle.Text = DisplayUser.GetTitle();
            }
            if (DisplayUser.GetTelephone() != null)
            {
                txtTelephone.Text = DisplayUser.GetTelephone();
            }
            if (DisplayUser.GetMobile() != null)
            {
                txtMobile.Text = DisplayUser.GetMobile();
            }
            if(DisplayUser.GetFylkesmannDepartment() != null)
            {
                txtDepartment.Text = DisplayUser.GetFylkesmannDepartment();
            }
            if(DisplayUser.GetRoomNumber() != null)
            {
                txtRoomNumber.Text = DisplayUser.GetRoomNumber();
            }
            if(DisplayUser.GetInitials() != null)
            {
                txtInitials.Text = DisplayUser.GetInitials();
            }

            ddlDepartment.DataSource = GetDepartmentItems();
            ddlDepartment.DataTextField = "Text";
            ddlDepartment.DataValueField = "Value";
            ddlDepartment.DataBind();

            ddlFylkesmannsEmbete.DataSource = DepartmentHelper.GetAllFylkesmannsEmbete();
            ddlFylkesmannsEmbete.DataTextField = "Name";
            ddlFylkesmannsEmbete.DataValueField = "ID";
            ddlFylkesmannsEmbete.DataBind();
        }

        private static List<ListItem> GetDepartmentItems()
        {
            var retVal = new List<ListItem> { new ListItem("Velg avdeling", "0") };
            retVal.AddRange(from @group in GetDepartmentsForDropDown() select new ListItem(@group.Name, @group.ID.ToString()));
            return retVal;
        } 
        private static IEnumerable<IGroup> GetDepartmentsForDropDown()
        {
            var allDeps = DepartmentHelper.GetAllDepartments();
            var fylkesMannGroup = DepartmentHelper.GetFylkesmannenDepartmentgroup();
            if (fylkesMannGroup != null && allDeps.Contains(fylkesMannGroup))
                allDeps.Remove(fylkesMannGroup);
            return allDeps;
        }

        protected void SetFylkesmannsView(bool IsFylkesmann)
        {
            liFylkesmannsEmbete.Visible = IsFylkesmann;
            ddlDepartment.Visible = !IsFylkesmann;
            lblDepartmentDdl.Visible = !IsFylkesmann;
            valDepartment.Visible = !IsFylkesmann;
            valDepartment.Enabled = !IsFylkesmann;
            txtDepartment.Visible = IsFylkesmann;
            lblDepartmentTxt.Visible = IsFylkesmann;
            liRoomNumber.Visible = !IsFylkesmann;
            if (IsFylkesmann)
            {
                fmEmployee.CssClass = "selected";
                c1Employee.CssClass = null;
            } else
            {
                c1Employee.CssClass = "selected";
                fmEmployee.CssClass = null;
            }

        }
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && (CurrentUser == DisplayUser || CurrentUser.IsAdmin()))
            {
                // Create a writable clone of the user to enable edit
                var displayUserClone = DisplayUser.Clone() as IUser;
                // Create a writable clone of the user's My Page
                var currentMyPageClone = MyPageHandler.Instance.GetMyPage(DisplayUser).Clone() as MyPage;

                if (displayUserClone != null)
                {
                    displayUserClone.GivenName = txtFirstname.Text.FormatContentTextNoHtml();
                    displayUserClone.SurName = txtLastname.Text.FormatContentTextNoHtml();
                    displayUserClone.EMail = txtEmail.Text.FormatContentTextNoHtml();
                    displayUserClone.SetTitle(txtTitle.Text.Trim().FormatContentTextNoHtml());
                    displayUserClone.SetInitials(txtInitials.Text.Trim().FormatContentTextNoHtml());
                    displayUserClone.SetTelephone(txtTelephone.Text.Trim());
                    displayUserClone.SetMobile(txtMobile.Text.Trim());
                    displayUserClone.SetRoomNumber(txtRoomNumber.Text.Trim().FormatContentTextNoHtml());

                    displayUserClone.IsFylkesmann(liFylkesmannsEmbete.Visible);

                    if(displayUserClone.IsFylkesmann())
                    {
                        var departmentFreetext = txtDepartment.Text.FormatContentTextNoHtml();
                        if (departmentFreetext != string.Empty)
                            displayUserClone.SetFylkesmannDepartment(departmentFreetext);

                        var fylkesmannsEmbete = CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(int.Parse(ddlFylkesmannsEmbete.SelectedValue));
                        if (fylkesmannsEmbete != null)
                            displayUserClone.SetFylkesmannsEmbete(fylkesmannsEmbete);
                    }

                    var department = displayUserClone.IsFylkesmann()
                                            ? DepartmentHelper.GetFylkesmannenDepartmentgroup()
                                            : CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(int.Parse(ddlDepartment.SelectedValue));

                    if (department != null)
                        displayUserClone.SetDepartment(department);
                    
                    if(fuImage.HasFile)
                        SaveImage(currentMyPageClone);
                    
                    UpdateUser(displayUserClone);
                    OnInfoSaved(sender, e);
                }
            }
        }
        private void UpdateUser(IUser displayUserClone)
        {
            // Save everything to the user
            CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(displayUserClone);

            //DataBind();
            
            //Response.Redirect(Request.RawUrl);
        }
           
        protected void OnInfoSaved(object sender, EventArgs e)
        {
            if (InfoSaved != null)
            {
                InfoSaved(sender, e);
            }
        }

        public event EventHandler<EventArgs> InfoSaved;

        protected bool IsValidPhone(string strPhoneInput)
        {
            if (strPhoneInput.Length > 15)
            {
                return false;
            }
            var strPhone = Regex.Replace(strPhoneInput, @"[\+\- ()\*\!,]", String.Empty);
            var regDigits = new Regex(@"^\d*$");
            var matDigits = regDigits.Match(strPhone);

            return matDigits.Success;
        }
        protected void cvValidatePhoneNumber(object source, ServerValidateEventArgs args)
        {
            args.IsValid = IsValidPhone(args.Value);
        }
        protected void ddlDepartment_DataBound(object sender, EventArgs e)
        {
            var department = DisplayUser.GetDepartment();
            if (department != null)
            {
                foreach (ListItem li in ((DropDownList) sender).Items)
                {
                    if (int.Parse(li.Value) == department.ID)
                        li.Selected = true;
                }
            }
        }
        protected void ddlFylkesmannsEmbete_DataBound(object sender, EventArgs e)
        {
            var fylkesmannsEmbete = DisplayUser.GetFylkesmannsEmbete();
            if (fylkesmannsEmbete != null)
            {
                foreach (ListItem li in ((DropDownList)sender).Items)
                {
                    if (int.Parse(li.Value) == fylkesmannsEmbete.ID)
                        li.Selected = true;
                }
            }
        }

        protected void ChangeEmployeView_OnCommand(object sender, CommandEventArgs e)
        {
            SetFylkesmannsView(bool.Parse(e.CommandArgument.ToString()));
        }
        protected void valFileUpload_OnServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = fuImage.FileName.ValidImageFile();
        }

        private void SaveImage(MyPage currentMyPageClone)
        {
            // Create  image and set the presentation name of the user as name of image
            var title = currentMyPageClone.User.GetPresentationName(100, false);

            var imageName = String.IsNullOrEmpty(title) ? fuImage.FileName.Substring(0, fuImage.FileName.LastIndexOf(".")) : title;

            var portraitGallery = currentMyPageClone.ImageGallery;
            foreach (var gallery in currentMyPageClone.ImageGallery.Children.Where(gallery => gallery.Header.Equals("portrait", StringComparison.OrdinalIgnoreCase)))
            {
                portraitGallery = gallery;
                break;
            }

            var portraitImage = new EPiServer.Community.ImageGallery.Image(portraitGallery, imageName, String.Empty,
                                                                    AuthorHandler.Instance.ChangeAuthor(null, new UserAuthor(currentMyPageClone.User)),
                                                                    fuImage.PostedFile.InputStream)
            {
                Status = EntityStatus.Approved
            };
            
            currentMyPageClone.Portrait = portraitImage;
            // Update the user's my page with the new image
            currentMyPageClone.Portrait = portraitImage;
            MyPageHandler.Instance.UpdateMyPage(currentMyPageClone);
        }
    }
}