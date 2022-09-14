using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace TimeSheet
{
    public partial class Test : System.Web.UI.Page
    {
        String connetionString = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";

        string clientid = "114081476260-sggv93gu2j3pl39uktjq7opgiamf1q4i.apps.googleusercontent.com";
        //your client secret  
        string clientsecret = "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";
        //your redirection url  
        string redirection_url = "https://localhost:44327/Test.aspx";
        string url = "https://accounts.google.com/o/oauth2/token";
        public void GetToken(string code)
        {
            string poststring = "grant_type=authorization_code&code=" + code + "&client_id=" + clientid + "&client_secret=" + clientsecret + "&redirect_uri=" + redirection_url + "";
            var request = (HttpWebRequest)WebRequest.Create(url);
            request.ContentType = "application/x-www-form-urlencoded";
            request.Method = "POST";
            UTF8Encoding utfenc = new UTF8Encoding();
            byte[] bytes = utfenc.GetBytes(poststring);
            Stream outputstream = null;
            try
            {
                request.ContentLength = bytes.Length;
                outputstream = request.GetRequestStream();
                outputstream.Write(bytes, 0, bytes.Length);
            }
            catch { }
            var response = (HttpWebResponse)request.GetResponse();
            var streamReader = new StreamReader(response.GetResponseStream());
            string responseFromServer = streamReader.ReadToEnd();
            JavaScriptSerializer js = new JavaScriptSerializer();
            Tokenclass obj = js.Deserialize<Tokenclass>(responseFromServer);
            GetuserProfile(obj.access_token);
        }
        public void GetuserProfile(string accesstoken)
        {
            string url = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token=" + accesstoken + "";
            WebRequest request = WebRequest.Create(url);
            request.Credentials = CredentialCache.DefaultCredentials;
            WebResponse response = request.GetResponse();
            Stream dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            reader.Close();
            response.Close();
            JavaScriptSerializer js = new JavaScriptSerializer();
            Userclass userinfo = js.Deserialize<Userclass>(responseFromServer);
            using (SqlConnection con = new SqlConnection(connetionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "insert into employee_profile(employee_id,employee_name, employee_email, employee_username, employee_password, employee_team, employee_role, employee_DOJ, employee_picture, employee_DOB, employee_gender, employee_contact, created_at, update_status, last_updated, user_type)values(@NA,@name,@email,@username,'12345678',@NA,@NA,getdate(),@emp_img,getdate(),@gender,@NA,getdate(),'pending',getdate(),'Goolge')";
                cmd.Parameters.AddWithValue("@name",Convert.ToString(userinfo.name));
                cmd.Parameters.AddWithValue("@email",Convert.ToString(userinfo.id));
                cmd.Parameters.AddWithValue("@username",Convert.ToString(userinfo.given_name));
                cmd.Parameters.AddWithValue("@emp_img",Convert.ToString(userinfo.picture));
                cmd.Parameters.AddWithValue("@gender", userinfo.locale);
                cmd.Parameters.AddWithValue("@contact", userinfo.id);
                cmd.Parameters.AddWithValue("@NA", "N/A");
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
            protected void Page_Load(object sender, EventArgs e)
            {
            if (!IsPostBack)
            {
                if (Request.QueryString["code"] != null)
                {
                    GetToken(Request.QueryString["code"].ToString());
                }
            }
        }
    }
}