using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace TimeSheet
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signup_btn_Click(object sender, EventArgs e)
        {
            string connetionString;
            SqlConnection cnn;

            connetionString = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";

            cnn = new SqlConnection(connetionString);
            string empid = ((emp_id.Text).ToUpper());

            cnn.Open();
            String query = "insert into employee_profile(employee_id,employee_name,employee_username,employee_email,employee_password,employee_role,update_status) values('" + empid + "','" + emp_name.Text + "','" + emp_name.Text + "','" + login_email.Text + "','" + user_psw.Text + "','N/A','pending')";
            SqlCommand cmd = new SqlCommand(query, cnn);
            cmd.ExecuteNonQuery();
            Response.Redirect("Login.aspx");


        }
    }
}