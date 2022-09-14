using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;


namespace TimeSheet
{
    public partial class Forgot_page : System.Web.UI.Page
    {
        public string cs = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";

        protected void Page_Load(object sender, EventArgs e)
        {
            collapse_email.Visible = false;
            collapse_mobile.Visible = false;
            email_success.Visible = false;
            mobile_success.Visible = false;
            wrong_email_code.Visible = false;
            wrong_mobile_code.Visible = false;
            reset_visible_div.Visible = false;
            error_text.Visible = false;
            psd_reset_success.Visible = false;
        }

        // Email Code Generation function
        public string GenerateEmailOTP()
        {
            string PasswordLength = "8";
            string NewPassword = "";

            string allowedChars = "";
            allowedChars = "1,2,3,4,5,6,7,8,9,0";
            allowedChars += "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,";
            allowedChars += "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,";


            char[] sep = {','};
            string[] arr = allowedChars.Split(sep);


            string IDString = "";
            string temp = "";

            Random rand = new Random();

            for (int i = 0; i < Convert.ToInt32(PasswordLength); i++)
            {
                temp = arr[rand.Next(0, arr.Length)];
                IDString += temp;
                NewPassword = IDString;

            }
            return NewPassword;
        }

        //Sending Mail Function
        public string SendMail()
        {
           
                var emailcode = GenerateEmailOTP().ToString();
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress("noreply.gabriels@gmail.com");
                    mail.To.Add(forgot_email.Text);
                    mail.Subject = "GTS-TimeSheet - Your Password Reset Code";
                    mail.Body = "<span>Hi There!</span><br><span>Your OTP is <H1>" + emailcode + "</h1></span><br><br><span>Your OTP will be active for only 60sec</span><br><br><span>Thanks & Regards,<span><br><span>GTS - Support Team</span>";
                    mail.IsBodyHtml = true;
                    System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.Credentials = new NetworkCredential("noreply.gabriels@gmail.com", "AB_CD@123");
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }
                return emailcode;
            
        }


        // Mobile OTP Generation function
        protected string GenerateMobileOTP()
        {
            char[] charArr = "0123456789".ToCharArray();
            string strrandom = string.Empty;
            Random objran = new Random();
            for (int i = 0; i < 4; i++)
            {
                //It will not allow Repetation of Characters
                int pos = objran.Next(1, charArr.Length);
                if (!strrandom.Contains(charArr.GetValue(pos).ToString())) strrandom += charArr.GetValue(pos);
                else i--;
            }
            return strrandom;
        }

        // SMS Sending function
        public static string SendSMS(string MblNo, string Msg)
        {

            using (var wb = new WebClient())
            {
                byte[] response = wb.UploadValues("https://api.textlocal.in/send/", new NameValueCollection()
                {
                {"apikey" , "NTU2ZTYxNzQ3YTczNzI2NzRlNTY3MTM5NDE2MjQ5NzA="},
                {"numbers" , MblNo},
                {"message" , Msg},
                {"sender" , "600010"}
                });
                string result = System.Text.Encoding.UTF8.GetString(response);
                return result;
            }
        }
        // End SMS Sending function
        // Get Response function
        public static string GetResponse(string smsURL)
        {
            try
            {
                WebClient objWebClient = new WebClient();
                System.IO.StreamReader reader = new System.IO.StreamReader(objWebClient.OpenRead(smsURL));
                string ResultHTML = reader.ReadToEnd();
                return ResultHTML;
            }
            catch (Exception)
            {
                return "Fail";
            }
        }
        // End Get Response function


        protected void email_switch_Click(object sender, EventArgs e)
        {
            collapse_email.Visible = true;
            
        }

        protected void mobile_switch_Click(object sender, EventArgs e)
        {
            collapse_mobile.Visible = true;
        }


        //check the authentication details

        public bool checkdataemail()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select employee_email, employee_id from employee_profile where employee_id=@emp_id and employee_email=@emp_email;";
                cmd.Parameters.AddWithValue("emp_id", forgot_empId.Text);
                cmd.Parameters.AddWithValue("emp_email", forgot_email.Text);
                SqlDataReader rdp = cmd.ExecuteReader();
                while (rdp.Read())
                {
                    if (rdp.HasRows)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                rdp.Close();
                return false;
               
            }
        }
        protected void email_btn_Click(object sender, EventArgs e)
        {
            
            if(Convert.ToBoolean(checkdataemail()) == true)
            {
                if (IsPostBack)
                {
                    Session["mailOTP"] = SendMail();
                    email_success.Visible = true;
                    iblemail.Text = forgot_email.Text;
                }
            }
            else
            {
                error_text.Visible = true;
                collapse_email.Visible = true;
            }
        }

        public bool checkdataOTP()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select employee_contact, employee_id from employee_profile where employee_id=@emp_id and employee_contact=@emp_mobile;";
                cmd.Parameters.AddWithValue("emp_id", forgot_empId_mobile.Text);
                cmd.Parameters.AddWithValue("emp_mobile", forgot_mobile.Text);
                SqlDataReader rdp = cmd.ExecuteReader();
                while (rdp.Read())
                {
                    if (rdp.HasRows)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                rdp.Close();
                return false;

            }
        }

        protected void mobile_btn_Click(object sender, EventArgs e)
        {
            if (Convert.ToBoolean(checkdataOTP()) == true)
            {
                if (IsPostBack)
                {
                    string otp = GenerateMobileOTP();
                    string mobileNo = forgot_mobile.Text.Trim();
                    string SMSContents = "", smsResult = "";
                    SMSContents = HttpUtility.UrlEncode("Hi from GTS, thank you for sending your first test message from Textlocal. See how you can send effective SMS campaigns here: https://tx.gl/r/2nGVj/");
                    smsResult = SendSMS(mobileNo, SMSContents);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "countdown()", true);
                    //Session["mobileOTP"] = smsResult;
                    Session["mobileOTP"] = "0000";
                    mobile_success.Visible = true;
                    iblmobile.Text = forgot_mobile.Text;
                }
            }
            else
            {
                error_text.Visible = true;
                collapse_mobile.Visible = true;
            }
        }

        
        protected void eOTP_sucess_btn_Click(object sender, EventArgs e)
        {
            var tt = Session["mailOTP"];
            if (Convert.ToString(Session["mailOTP"]) == email_OTP.Text)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "mailcodesuccess()", true);
                reset_visible_div.Visible = true;
            }

            else
            {
                email_success.Visible = true;
                wrong_email_code.Visible = true;
            }
           
        }

        protected void mOTP_sucess_btn_Click(object sender, EventArgs e)
        {
            if (mobile_OTP.Text == "0000")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "mailcodesuccess()", true);
                reset_visible_div.Visible = true;
            }
            else
            {
                mobile_success.Visible = true;
                wrong_mobile_code.Visible = true;
            }
        }

        protected void reset_pwd_btn_Click(object sender, EventArgs e)
        {
            if(reset_NPWD_txt.Text== reset_RNPWD_txt.Text)
            {
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    con.Open();
                    cmd.CommandText = "update employee_profile set employee_password=@emp_psd where employee_contact=@emp_mobile and employee_id=@emp_id";
                    cmd.Parameters.AddWithValue("emp_psd", reset_NPWD_txt.Text);
                    cmd.Parameters.AddWithValue("emp_mobile", forgot_mobile.Text);
                    cmd.Parameters.AddWithValue("emp_id", forgot_empId_mobile.Text);

                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                remember_login.Visible = false;
                reset_div.Visible = false;
                psd_reset_success.Visible = true;
            }
            else
            {
                reset_visible_div.Visible = true;   
            }
        }

        protected void nav_login_btn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
    }
