using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Net;
using System.Web.Script.Serialization;
using System.IO;
using System.Text;


namespace TimeSheet.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        String connetionString = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";

        protected void Page_Load(object sender, EventArgs e)
        {
            wrong_passord.Visible = false;
        }

        protected void Login_btn_Click1(object sender, EventArgs e)
        {
            

           SqlConnection cnn = new SqlConnection(connetionString);

            cnn.Open();


            String query = "Select employee_username from employee_profile where employee_email='"+ user_name.Text + "' or employee_username='" + user_name.Text +"'and employee_password='" + user_psw.Text + "';";
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader rd = cmd.ExecuteReader();

            if (rd.Read())
            {
                Session["username"] = user_name.Text;
                Response.Redirect("Index.aspx");
            }
            else
            {
                wrong_passord.Visible = true;   
            }

          
        }

        protected void GoogleAPI_btn_Click(object sender, EventArgs e)
        {
            //Google client id  
            string clientid = "114081476260-sggv93gu2j3pl39uktjq7opgiamf1q4i.apps.googleusercontent.com";
            //Google client secret  
            //string clientsecret = "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";
            //Google redirection url  
            string redirection_url_login = "https://localhost:44327/Index.aspx";
            string url = "https://accounts.google.com/o/oauth2/v2/auth?scope=profile&include_granted_scopes=true&redirect_uri=" + redirection_url_login + "&response_type=code&client_id=" + clientid + "";
            Response.Redirect(url);

        }

        protected void MicrosoftAPI_btn_Click(object sender, EventArgs e)
        {
            ////Microsoft client id  
            //string clientid = "114081476260-sggv93gu2j3pl39uktjq7opgiamf1q4i.apps.googleusercontent.com";
            ////Microsoft client secret  
            //string clientsecret = "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";
            ////Microsoft redirection url  
            //string redirection_url_login = "https://localhost:44327/Index.aspx";
            //string url = "https://accounts.google.com/o/oauth2/v2/auth?scope=profile&include_granted_scopes=true&redirect_uri=" + redirection_url_login + "&response_type=code&client_id=" + clientid + "";
            //Response.Redirect(url);


        }

        protected void GitAPI_btn_Click(object sender, EventArgs e)
        {

        }
    }
}

