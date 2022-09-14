using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Drawing;
using System.Text;
using System.Net;
using System.Web.Script.Serialization;
using System.IO;

namespace TimeSheet
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        public string cs = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";

        string clientid = "114081476260-sggv93gu2j3pl39uktjq7opgiamf1q4i.apps.googleusercontent.com";
        //your client secret  
        string clientsecret = "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";
        //your redirection url  
        string redirection_url = "https://localhost:44327/Index.aspx";
        string url = "https://accounts.google.com/o/oauth2/token";
        public void GetToken(string code)
        {
            Session["code"] = code;
            string poststring = "grant_type=authorization_code&code=" + Session["code"] + "&client_id=" + clientid + "&client_secret=" + clientsecret + "&redirect_uri=" + redirection_url + "";
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
            try
            {
                var response = (HttpWebResponse)request.GetResponse();
                var streamReader = new StreamReader(response.GetResponseStream());
                string responseFromServer = streamReader.ReadToEnd();
                JavaScriptSerializer js = new JavaScriptSerializer();
                Tokenclass obj = js.Deserialize<Tokenclass>(responseFromServer);
                GetuserProfile(obj.access_token);
                var epx = obj.expires_in;

            }
            catch
            {
                page_load_datafill();
            }


        }
    
        public void GetuserProfile(string accesstoken)
        {
            Session["at"]= accesstoken;
            string url = "https://www.googleapis.com/oauth2/v2/userinfo?alt=json&access_token=" + accesstoken + "";
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
            

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select employee_username,user_type from employee_profile where employee_email=@email and user_type=@type and employee_id=@emp_name";
                cmd.Parameters.AddWithValue("email", userinfo.email);
                cmd.Parameters.AddWithValue("emp_name", userinfo.id);
                cmd.Parameters.AddWithValue("type", "Google");
                SqlDataReader rdp = cmd.ExecuteReader();
                if (rdp.HasRows)
                {
                    rdp.Close();
                    Session["username"] = userinfo.given_name;
                }
                else
                {
                    rdp.Close();
                    using (SqlConnection conn = new SqlConnection(cs))
                    {
                        SqlCommand cmd1 = new SqlCommand();
                        cmd1.CommandText = "insert into employee_profile(employee_id,employee_name, employee_email, employee_username, employee_password, employee_team, employee_role, employee_DOJ, employee_picture, employee_DOB, employee_gender, employee_contact, created_at, update_status, last_updated, user_type)values(@id,@name,@email,@username,'12345678',@NA,@NA,getdate(),@emp_img,getdate(),@gender,@NA,getdate(),'pending',getdate(),'Google')";
                        cmd1.Parameters.AddWithValue("@name", Convert.ToString(userinfo.name));
                        cmd1.Parameters.AddWithValue("@email", Convert.ToString(userinfo.email));
                        cmd1.Parameters.AddWithValue("@id", Convert.ToString(userinfo.id));
                        cmd1.Parameters.AddWithValue("@username", Convert.ToString(userinfo.given_name));
                        cmd1.Parameters.AddWithValue("@emp_img", Convert.ToString(userinfo.picture));
                        cmd1.Parameters.AddWithValue("@gender", userinfo.locale);
                        cmd1.Parameters.AddWithValue("@contact", userinfo.id);
                        cmd1.Parameters.AddWithValue("@NA", "N/A");
                        cmd1.Connection = con;
                        conn.Open();
                        cmd1.ExecuteNonQuery();
                        conn.Close();
                    }
                    Session["username"] = userinfo.given_name;

                    var profile = userinfo.profile;
                }
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

            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            

            //Function Calls

            //Employee Profile Data Fill Function
            page_load_datafill();

            ////Employee Profile Update
            profile_update_check();

            //Project Curd Functions
            FillDataProject();

            //Team Project Curd Fuctions
            TeamFillDataProject();
                
            //Task Curd Functions
            FillDataTask();

            //Team Task Curd Functions
            TeamFillDataTask();



        }
        public void page_load_datafill()
        {
            string connetionString = "Server= localhost; Database= Timesheet_DB;Integrated Security = SSPI;";
            SqlConnection cnn = new SqlConnection(connetionString);
            cnn.Open();

            //Profile Name
            String query = "Select  employee_name,employee_id,employee_role,employee_username,employee_picture, employee_team from employee_profile where employee_username='" + Session["username"] + "' or employee_email='" + Session["username"] + "' ;";
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader rd = cmd.ExecuteReader();
            while(rd.Read())
            {
                //Basic Details Fill
                employee_name.Text = rd.GetString(0);
                welcome_txt_lbl.Text = rd.GetString(0);
                employee_id.Text = rd.GetString(1);
                employee_role.Text = rd.GetString(2);
                profile_name.Text = rd.GetString(3);
                try { profile_img.Src = rd.GetString(4); } catch { profile_img.Src = "IMG/avatar.jpg"; }
                nav_time.Text = DateTime.Now.ToString("hh:mm tt");
                calender_date.Text = DateTime.Now.ToString("D");

                //Session Variables
                Session["Emp_ID"] = employee_id.Text;

            }
            cnn.Close();
        }

        public void profile_update_check()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select update_status from employee_profile where employee_id=@emp_id or employee_username=@emp_uname ";
                cmd.Parameters.AddWithValue("emp_id", Session["Emp_ID"]);
                cmd.Parameters.AddWithValue("emp_uname", Session["username"]);
                SqlDataReader rdp = cmd.ExecuteReader();
                while (rdp.Read())
                {
                    if ((rdp.GetValue(0)).ToString() == "updated")
                    {
                        ModalPopupExtender10.Hide();
                    }

                    else
                    {
                        ModalPopupExtender10.Show();
                    }
                }
                rdp.Close();

            }
        }

        //Main Grid
        protected void project_overview_gridview_RowCreated(object sender, GridViewRowEventArgs e)
        {
            defualt_content.Visible = false;
            navigation_btn.Visible = false;
            if (project_overview_gridview.Rows is null)
            {
                defualt_content.Visible = true;
                navigation_btn.Visible = true;
            }
        }

        //Project Function
        protected static int a = 0;
        protected void Create_project_Click1(object sender, EventArgs e)
        {
                a = a + 1;
                string pid = "PJ" + employee_id.Text + a.ToString();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "insert into project_details(employee_id,project_id,product_name,client_name,project_team,project_name,start_date,project_team_email_id,project_type,project_status) values('" + employee_id.Text + "','" + pid + "','" + project_product.Text + "','" + project_client.Text + "','" + project_team.Text + "','" + project_name.Text + "','" + project_startdate.Text + "','NA','Individual','Pending')";
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            main_update_panel.Update();
            Response.Redirect("Index.aspx");
        }

        //Project Databind Function
        public void FillDataProject()
        {

            using (SqlConnection con = new SqlConnection(cs))
            {
                string emp_id = "";
                if (Session["Emp_ID"] != null)
                {
                    emp_id = Session["Emp_ID"].ToString();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select * from project_details where employee_id='" + emp_id + "' and project_type='individual' ";
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                project_edit_gridview.DataSource = ds;
                project_edit_gridview.DataBind();
                con.Close();
            }

        }

        //Project Edit Cancel Function 
        protected void project_edit_gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Cancel_project_btn")
            {
                project_edit_gridview.EditIndex = -1;
                FillDataProject();
            }

        }

        //Project Edit Function
        protected void project_edit_gridview_RowEditing(object sender, GridViewEditEventArgs e)
        {
            project_edit_gridview.EditIndex = e.NewEditIndex;
            FillDataProject();
        }

        public void project_edit_gridview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                Label id = project_edit_gridview.Rows[e.RowIndex].FindControl("lbl_project_id") as Label;
                TextBox employee_id = project_edit_gridview.Rows[e.RowIndex].FindControl("txt_project_eid") as TextBox;
                TextBox project_id = project_edit_gridview.Rows[e.RowIndex].FindControl("txt_project_pid") as TextBox;
                TextBox project_name = project_edit_gridview.Rows[e.RowIndex].FindControl("txt_project_pname") as TextBox;
                DropDownList project_team = project_edit_gridview.Rows[e.RowIndex].FindControl("DD_project_team") as DropDownList;
                DropDownList product_name = project_edit_gridview.Rows[e.RowIndex].FindControl("DD_product_name") as DropDownList;
                DropDownList client_name = project_edit_gridview.Rows[e.RowIndex].FindControl("DD_client_name") as DropDownList;
                TextBox project_sdate = project_edit_gridview.Rows[e.RowIndex].FindControl("txt_project_sdate") as TextBox;
                TextBox project_Temail = project_edit_gridview.Rows[e.RowIndex].FindControl("txt_project_Temail") as TextBox;
                DropDownList project_status = project_edit_gridview.Rows[e.RowIndex].FindControl("DD_project_status") as DropDownList;

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "update project_details set  project_name=@project_name, project_team=@project_team, client_name=@client_name , start_date=@start_date ,project_team_email_id=@Pteam_email,project_status=@Pstatus where id=@id";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.Parameters.AddWithValue("project_name", project_name.Text);
                cmd.Parameters.AddWithValue("project_team", project_team.Text);
                cmd.Parameters.AddWithValue("product_name", product_name.Text);
                cmd.Parameters.AddWithValue("client_name", client_name.Text);
                cmd.Parameters.AddWithValue("start_date", project_sdate.Text);
                cmd.Parameters.AddWithValue("Pteam_email", project_Temail.Text);
                cmd.Parameters.AddWithValue("Pstatus", project_status.Text);

                cmd.ExecuteNonQuery();
                con.Close();
            }
            project_edit_gridview.EditIndex = -1;
            FillDataProject();
            main_update_panel.Update();

        }

        //Project Delete Function
        protected void project_edit_gridview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = project_edit_gridview.Rows[e.RowIndex].FindControl("lbl_project_id") as Label;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "delete from project_details where id=@id";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.ExecuteNonQuery();
                con.Close();
            }
            FillDataProject();
            main_update_panel.Update();

        }

        //External Delete Button Project
        protected void Delete_all_project_btn_Click(object sender, EventArgs e)
        {
            
            foreach (GridViewRow gvrow in project_edit_gridview.Rows)
            {

                CheckBox chck = gvrow.FindControl("checkbox_project") as CheckBox;
                if (chck.Checked)
                {
                    var Label = gvrow.FindControl("lbl_project_id") as Label;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        con.Open();
                        cmd.CommandText = "delete from project_details where id=@id";
                        cmd.Parameters.AddWithValue("id", int.Parse(Label.Text));
                        int id = cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    FillDataProject();
                    main_update_panel.Update();
                }
            }
        }

        //External Edit Button Project
        protected void Edit_all_project_btn_Click(object sender, EventArgs e)
        {
            int value = 0;
            foreach (GridViewRow gvrow in project_edit_gridview.Rows)
            {
                CheckBox chck = gvrow.FindControl("checkbox_project") as CheckBox;
                if (chck.Checked)
                {
                    project_edit_gridview.EditIndex = value;
                    FillDataProject();
                }
                value = value + 1;
            }

        }

        //External Cancel Button Project
        protected void cancel_project_selected_Click(object sender, EventArgs e)
        {
            project_edit_gridview.EditIndex = -1;
            FillDataProject();
            team_project_edit_gridview.EditIndex = -1;
            TeamFillDataProject();
            task_edit_gridview.EditIndex = -1;
            FillDataTask();
            team_task_edit_gridview.EditIndex = -1;
            TeamFillDataTask();
        }

        //Status Color Change 
        protected void project_edit_gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            Label project_status = (Label)e.Row.FindControl("lbl_project_status");

            if (project_status != null)
            {
                string statusP = project_status.Text;
                if (statusP == "Completed")
                {
                    e.Row.Cells[9].ForeColor = Color.Green;
                }
                else if (statusP == "Terminated")
                {
                    e.Row.Cells[9].ForeColor = Color.DarkRed;
                }
                else
                {
                    e.Row.Cells[9].ForeColor = Color.Chocolate;
                }
            }
        }


        //Task Functions
        protected void task_create_btn_Click(object sender, EventArgs e)
        {
            var data_value = hidden_field_val.Value;
            var data_text = hidden_field_txt.Value;
            {
                var dataValue = Existing_Project.Text;
                a = a + 1;
                string tid = "Tk" + employee_id.Text + a.ToString();
                //task submit
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "insert into task_details(empid_task,project_id,task_id,ticket_id,project_name,task_name,created_at,team_task_email,task_type,task_status) values('" + employee_id.Text + "','" + data_value + "','" + tid + "','" + task_ticket_id.Text + "','" + data_text + "','" + task_name.Text + "',getdate(),'N/A','Individual','Pending')";
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                Response.Redirect("Index.aspx");
                main_update_panel.Update();

            }

        }

        //Task DropDown DataFill
        //void Task_Assign()
        //{
        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.Connection = con;
        //        cmd.CommandText = "select project_id,project_name from project_details where project_type='Individual' and employee_id='" + employee_id.Text + "'";
        //        con.Open();
        //        SqlDataAdapter ad = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        ad.Fill(dt);
        //        if (dt.Rows.Count > 0)
        //        {
        //            Existing_Project.DataSource = dt;
        //            Existing_Project.DataBind();
        //        }
        //        con.Close();
        //    }
        //}

        void FillDataTask()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string emp_id = "";
                if (Session["Emp_ID"] != null)
                {
                    emp_id = Session["Emp_ID"].ToString();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select * from task_details where empid_task='" + emp_id + "' and task_type='individual' ";
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                task_edit_gridview.DataSource = ds;
                task_edit_gridview.DataBind();
                con.Close();
            }

        }
        //task Edit operations
        //External Task buttons 

        //edit
        protected void Edit_all_task_btn_Click(object sender, EventArgs e)
        {
            int value = 0;
            foreach (GridViewRow gvrow in task_edit_gridview.Rows)
            {
                CheckBox chck = gvrow.FindControl("checkbox_task") as CheckBox;
                if (chck.Checked)
                {
                    task_edit_gridview.EditIndex = value;
                    FillDataTask();
                }
                value = value + 1;
            }
        }

        //delete
        protected void Delete_all_task_btn_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gvrow in task_edit_gridview.Rows)
            {

                CheckBox chck = gvrow.FindControl("checkbox_task") as CheckBox;
                if (chck.Checked)
                {
                    var Label = gvrow.FindControl("lbl_task_id") as Label;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        con.Open();
                        cmd.CommandText = "delete from task_details where id=@id";
                        cmd.Parameters.AddWithValue("id", int.Parse(Label.Text));
                        int id = cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    FillDataTask();
                    main_update_panel.Update();

                }

            }
        }

        //cancel
        protected void cancel_all_task_btn_Click(object sender, EventArgs e)
        {
            task_edit_gridview.EditIndex = -1;
            FillDataTask();
        }
        
        //Task Update Function
        protected void task_edit_gridview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                Label id = task_edit_gridview.Rows[e.RowIndex].FindControl("lbl_task_id") as Label;
                TextBox task_name = task_edit_gridview.Rows[e.RowIndex].FindControl("txt_task_tname") as TextBox;
                TextBox ticket_id = task_edit_gridview.Rows[e.RowIndex].FindControl("txt_task_ticket_id") as TextBox;
                DropDownList project_name = task_edit_gridview.Rows[e.RowIndex].FindControl("DD_task_pname") as DropDownList;
                TextBox task_sdate = task_edit_gridview.Rows[e.RowIndex].FindControl("txt_task_sdate") as TextBox;
                TextBox task_email = task_edit_gridview.Rows[e.RowIndex].FindControl("txt_task_Temail") as TextBox;
                DropDownList task_status = task_edit_gridview.Rows[e.RowIndex].FindControl("DD_task_status") as DropDownList;

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "update task_details set  task_name=@task_name, ticket_id=@ticket_id, project_name=@project_name , created_at=@task_sdate ,team_task_email=@task_email, task_status=@task_status where id=@id";
                cmd.Parameters.AddWithValue("id", id.Text);

                cmd.Parameters.AddWithValue("task_name", task_name.Text);
                cmd.Parameters.AddWithValue("ticket_id", ticket_id.Text);
                cmd.Parameters.AddWithValue("project_name", project_name.Text);
                cmd.Parameters.AddWithValue("task_sdate", task_sdate.Text);
                cmd.Parameters.AddWithValue("task_email", task_email.Text);
                cmd.Parameters.AddWithValue("task_status", task_status.Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            task_edit_gridview.EditIndex = -1;
            FillDataTask();
            main_update_panel.Update();

        }

        //Task Edit Function
        protected void task_edit_gridview_RowEditing(object sender, GridViewEditEventArgs e)
        {
            task_edit_gridview.EditIndex = e.NewEditIndex;
            FillDataTask();
        }

        //Task Cancel Function
        protected void task_edit_gridview_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            task_edit_gridview.EditIndex = -1;
            FillDataTask();
        }

        //Task Delete Function
        protected void task_edit_gridview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = task_edit_gridview.Rows[e.RowIndex].FindControl("lbl_task_id") as Label;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "delete from task_details where id=@id";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.ExecuteNonQuery();
                con.Close();
            }
            FillDataTask();
            main_update_panel.Update();

        }

        //Status Color
        protected void task_edit_gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Label task_status = (Label)e.Row.FindControl("lbl_task_status");

            if (task_status != null)
            {
                string statusP = task_status.Text;
                if (statusP == "Completed")
                {
                    e.Row.Cells[8].ForeColor = Color.Green;
                }
                else if (statusP == "Terminated")
                {
                    e.Row.Cells[8].ForeColor = Color.DarkRed;
                }
                else
                {
                    e.Row.Cells[8].ForeColor = Color.Chocolate;
                }
            }
        }
    
        //Team Project 
        protected void team_project_create_btn_Click(object sender, EventArgs e)
        {
            a = a + 1;
            string pid = "TPJ" + employee_id.Text + a.ToString();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "insert into project_details(employee_id,project_id,product_name,client_name,project_team,project_name,start_date,project_team_email_id,project_type,project_status) values('" + employee_id.Text + "','" + pid + "','" + team_project_product.Text + "','" + team_project_client.Text + "','" + team_project_team.Text + "','" + team_project_name.Text + "','" + team_project_startdate.Text + "','" + team_project_email.Text + "','team','Pending')";
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("Index.aspx");
            main_update_panel.Update();

        }

        //Team project functions
        public void TeamFillDataProject()
        {

            using (SqlConnection con = new SqlConnection(cs))
            {
                string emp_id = "";
                if (Session["Emp_ID"] != null)
                {
                    emp_id = Session["Emp_ID"].ToString();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select * from project_details where employee_id='" + emp_id + "' and project_type='team' ";
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                team_project_edit_gridview.DataSource = ds;
                team_project_edit_gridview.DataBind();
                con.Close();
            }

        }

        //Team Edit Project Functions 
        protected void team_project_edit_gridview_RowEditing(object sender, GridViewEditEventArgs e)
        {
            team_project_edit_gridview.EditIndex = e.NewEditIndex;
            TeamFillDataProject();
        }

        //Team Cancel Project Functions
        protected void team_project_edit_gridview_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            team_project_edit_gridview.EditIndex = -1;
            TeamFillDataProject();
        }

        //Team Update Project Functions
        protected void team_project_edit_gridview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                Label id = team_project_edit_gridview.Rows[e.RowIndex].FindControl("lbl_team_project_id") as Label;
                TextBox employee_id = team_project_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_project_eid") as TextBox;
                TextBox project_id = team_project_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_project_pid") as TextBox;
                TextBox project_name = team_project_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_project_pname") as TextBox;
                DropDownList project_team = team_project_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_project_team") as DropDownList;
                DropDownList product_name = team_project_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_product_name") as DropDownList;
                DropDownList client_name = team_project_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_client_name") as DropDownList;
                TextBox project_sdate = team_project_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_project_sdate") as TextBox;
                TextBox project_Temail = team_project_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_project_Temail") as TextBox;
                DropDownList project_status = team_project_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_project_status") as DropDownList;

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "update project_details set  project_name=@project_name, project_team=@project_team, client_name=@client_name , start_date=@start_date ,project_team_email_id=@Pteam_email,project_status=@Pstatus where id=@id";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.Parameters.AddWithValue("project_name", project_name.Text);
                cmd.Parameters.AddWithValue("project_team", project_team.Text);
                cmd.Parameters.AddWithValue("product_name", product_name.Text);
                cmd.Parameters.AddWithValue("client_name", client_name.Text);
                cmd.Parameters.AddWithValue("start_date", project_sdate.Text);
                cmd.Parameters.AddWithValue("Pteam_email", project_Temail.Text);
                cmd.Parameters.AddWithValue("Pstatus", project_status.Text);

                cmd.ExecuteNonQuery();
                con.Close();
            }
            team_project_edit_gridview.EditIndex = -1;
            TeamFillDataProject();
            main_update_panel.Update();
        }
        
        //Team Delete Project Functions
        protected void team_project_edit_gridview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = team_project_edit_gridview.Rows[e.RowIndex].FindControl("lbl_team_project_id") as Label;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "delete from project_details where id=@id";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.ExecuteNonQuery();
                con.Close();
            }
            TeamFillDataProject();
            main_update_panel.Update();
        }

        //External btn funtions for Team project
        //delete
        protected void team_delete_project_btn_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gvrow in team_project_edit_gridview.Rows)
            {

                CheckBox chck = gvrow.FindControl("checkbox_team_project") as CheckBox;
                if (chck.Checked)
                {
                    var Label = gvrow.FindControl("lbl_team_project_id") as Label;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        con.Open();
                        cmd.CommandText = "delete from project_details where id=@id and project_type='team'";
                        cmd.Parameters.AddWithValue("id", int.Parse(Label.Text));
                        int id = cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    TeamFillDataProject();
                    main_update_panel.Update();
                }

            }
        }
        //edit
        protected void team_edit_project_btn_Click(object sender, EventArgs e)
        {
            int value = 0;
            foreach (GridViewRow gvrow in team_project_edit_gridview.Rows)
            {
                CheckBox chck = gvrow.FindControl("checkbox_team_project") as CheckBox;
                if (chck.Checked)
                {
                    team_project_edit_gridview.EditIndex = value;
                    TeamFillDataProject();
                }
                value = value + 1;
            }
        }
        //cancel
        protected void team_cancel_project_btn_Click(object sender, EventArgs e)
        {
            team_project_edit_gridview.EditIndex = -1;
            TeamFillDataProject();
        }

        //Team Task Functions
        protected void team_task_create_btn_Click(object sender, EventArgs e)
        {
            var Tdata_value = Thidden_field_val.Value;
            var Tdata_text = Thidden_field_txt.Value;

            a = a + 1;
            string tid = "TTk" + employee_id.Text + a.ToString();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "insert into task_details(empid_task, project_id, task_id, project_name, ticket_id, task_name, created_at, team_task_email, task_type , task_status) values('" + employee_id.Text + "', '" + Tdata_value + "', '" + tid + "','" + Tdata_text + "','" + team_task_ticket_id.Text + "','" + team_task_name.Text + "', getdate(), '" + team_task_email.Text + "','team','Pending')";
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("Index.aspx");
        }

        //Team task Data Fill
        void TeamFillDataTask()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string emp_id = "";
                if (Session["Emp_ID"] != null)
                {
                    emp_id = Session["Emp_ID"].ToString();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "select * from task_details where empid_task='" + emp_id + "' and task_type='team' ";
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                team_task_edit_gridview.DataSource = ds;
                team_task_edit_gridview.DataBind();
                con.Close();
            }

        }

        //External Button functions
        //Edit
        protected void Edit_all_team_task_btn_Click(object sender, EventArgs e)
        {
            int value = 0;
            foreach (GridViewRow gvrow in team_task_edit_gridview.Rows)
            {
                CheckBox chck = gvrow.FindControl("checkbox_team_task") as CheckBox;
                if (chck.Checked)
                {
                    team_task_edit_gridview.EditIndex = value;
                    TeamFillDataTask();
                }
                value = value + 1;
            }
        }

        //Delete
        protected void Delete_all_team_task_btn_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gvrow in team_task_edit_gridview.Rows)
            {

                CheckBox chck = gvrow.FindControl("checkbox_team_task") as CheckBox;
                if (chck.Checked)
                {
                    var Label = gvrow.FindControl("lbl_team_task_id") as Label;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        con.Open();
                        cmd.CommandText = "delete from task_details where id=@id" ;
                        cmd.Parameters.AddWithValue("id", int.Parse(Label.Text));
                        int id = cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    TeamFillDataTask();
                    main_update_panel.Update();
                }

            }
        }

        //Cancel
        protected void cancel_all_team_task_btn_Click(object sender, EventArgs e)
        {
            team_task_edit_gridview.EditIndex = -1;
            TeamFillDataTask();

        }

        //Team Task Edit function
        protected void team_task_edit_gridview_RowEditing(object sender, GridViewEditEventArgs e)
        {
            team_task_edit_gridview.EditIndex = e.NewEditIndex;
            TeamFillDataTask();
        }

        //Team Task Delete function
        protected void team_task_edit_gridview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = team_task_edit_gridview.Rows[e.RowIndex].FindControl("lbl_team_task_id") as Label;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "delete from task_details where id=@id and task_type='team'";
                cmd.Parameters.AddWithValue("id", int.Parse(id.Text));
                cmd.ExecuteNonQuery();
                con.Close();
            }
            TeamFillDataTask();
            main_update_panel.Update();
        }

        //Team Task Update Funtion
        protected void team_task_edit_gridview_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                Label id = team_task_edit_gridview.Rows[e.RowIndex].FindControl("lbl_team_task_id") as Label;
                TextBox task_name = team_task_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_task_tname") as TextBox;
                TextBox ticket_id = team_task_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_task_ticket_id") as TextBox;
                DropDownList project_name = team_task_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_task_pname") as DropDownList;
                TextBox task_sdate = team_task_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_task_sdate") as TextBox;
                TextBox task_email = team_task_edit_gridview.Rows[e.RowIndex].FindControl("txt_team_task_Temail") as TextBox;
                DropDownList task_status = team_task_edit_gridview.Rows[e.RowIndex].FindControl("DD_team_task_status") as DropDownList;

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "update task_details set  task_name=@task_name, ticket_id=@ticket_id, project_name=@project_name, created_at=@task_sdate ,team_task_email=@task_email, task_status=@task_status where id=@id";
                cmd.Parameters.AddWithValue("id", id.Text);

                cmd.Parameters.AddWithValue("task_name", task_name.Text);
                cmd.Parameters.AddWithValue("ticket_id", ticket_id.Text);
                cmd.Parameters.AddWithValue("project_name", project_name.Text);
                cmd.Parameters.AddWithValue("task_sdate", task_sdate.Text);
                cmd.Parameters.AddWithValue("task_email", task_email.Text);
                cmd.Parameters.AddWithValue("task_status", task_status.Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            team_task_edit_gridview.EditIndex = -1;
            TeamFillDataTask();
            main_update_panel.Update();
        }

        //Team Task cancel Function
        protected void team_task_edit_gridview_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            team_task_edit_gridview.EditIndex = -1;
            TeamFillDataTask();
        }

        //Team Task Status 
        protected void team_task_edit_gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Label team_task_status = (Label)e.Row.FindControl("lbl_team_task_status");

            if (team_task_status != null)
            {
                string statusP = team_task_status.Text;
                if (statusP == "Completed")
                {
                    e.Row.Cells[8].ForeColor = Color.Green;
                }
                else if (statusP == "Terminated")
                {
                    e.Row.Cells[8].ForeColor = Color.DarkRed;
                }
                else
                {
                    e.Row.Cells[8].ForeColor = Color.Chocolate;
                }
            }
        }


        //Common Grid Functions
        protected void project_overview_gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label id = (Label)e.Row.FindControl("pid");
                GridView gr = (GridView)e.Row.FindControl("task_overview_gridview");
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string emp_id = "";
                    if (Session["Emp_ID"] != null)
                    {
                        emp_id = Session["Emp_ID"].ToString();
                    }
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    con.Open();
                    cmd.CommandText = "select * from task_details where empid_task='" + emp_id + "' and project_id=@id ";
                    cmd.Parameters.AddWithValue("id", id.Text);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    sda.Fill(ds);
                    gr.DataSource = ds;
                    gr.DataBind();
                    con.Close();
                }
            }

            Label project_status = (Label)e.Row.FindControl("status_main_grid");
            if (project_status != null)
            {
                string statusP = project_status.Text;
                if (statusP == "Completed")
                {
                    e.Row.Cells[1].ForeColor = Color.ForestGreen;
                }
                else if (statusP == "Terminated")
                {
                    e.Row.Cells[1].ForeColor = Color.Firebrick;
                }
                else
                {
                    e.Row.Cells[1].ForeColor = Color.OrangeRed;
                }
            }
        }

        //Download Btn Home
        protected void download_report_Click(object sender, EventArgs e)
        {

            PdfPTable pdftable = new PdfPTable(project_overview_gridview.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in project_overview_gridview.HeaderRow.Cells)
            {
                
                PdfPCell pdfcell = new PdfPCell(new Phrase(headerCell.Text));
                pdfcell.Colspan = 2;
                pdfcell.BackgroundColor = BaseColor.GRAY;
                pdftable.AddCell(pdfcell);
            }
            foreach (GridViewRow gridViewrow in project_overview_gridview.Rows)
            {
                foreach (TableCell tableCell in gridViewrow.Cells)
                {
                    PdfPCell pdfcell = new PdfPCell(new Phrase(tableCell.Text));
                    pdfcell.Colspan = 1;
                    pdftable.AddCell(pdfcell);
                }
            }
            Document pdfdocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfdocument, Response.OutputStream);
            pdfdocument.Open();
            pdfdocument.Add(pdftable);
            pdfdocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-disposition", "attachment;filename=Project Summary("+Session["Emp_ID"]+").pdf");
            Response.Write(pdfdocument);
            Response.Flush();
            Response.End();
        }

        protected void task_overview_gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Label task_status = (Label)e.Row.FindControl("Tstatus_main_grid");

            if (task_status != null)
            {
                string statusOT = task_status.Text;
                if (statusOT == "Completed")
                {
                    e.Row.Cells[0].ForeColor = Color.ForestGreen;
                }
                else if (statusOT == "Terminated")
                {
                    e.Row.Cells[0].ForeColor = Color.Firebrick;
                }
                else
                {
                    e.Row.Cells[0].ForeColor = Color.OrangeRed;
                }
            }

        }

        //Profile Update
        protected void profile_update_btn_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "update employee_profile set employee_role=@emp_role,employee_team=@emp_team, employee_DOJ=@emp_doj, employee_DOB=@emp_dob, employee_contact=@emp_contact,employee_gender=@emp_gender, last_updated=getdate(), update_status='updated' where employee_id=@emp_id";
                cmd.Parameters.AddWithValue("emp_id", Session["Emp_ID"]);
                cmd.Parameters.AddWithValue("emp_role", emp_role.Text);
                cmd.Parameters.AddWithValue("emp_team", emp_team.Text);
                cmd.Parameters.AddWithValue("emp_doj", emp_doj.Text);
                cmd.Parameters.AddWithValue("emp_dob", emp_dob.Text);
                cmd.Parameters.AddWithValue("emp_gender", emp_gender.Text);
                cmd.Parameters.AddWithValue("emp_contact", (emp_contact.Text).ToString());
                cmd.ExecuteNonQuery();
                con.Close();
            }
            page_load_datafill();
            ModalPopupExtender10.Hide();

            
        }

        //Logout
        protected void profile_name_Click(object sender, EventArgs e)
        {
            var logouturl = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=https://localhost:44327/Login.aspx";          
            Response.Redirect(logouturl);
        }

    }
}







