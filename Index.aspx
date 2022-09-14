<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TimeSheet.WebForm1" ViewStateMode="Disabled" Explicit="True" EnableTheming="True" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible">

    <title>Timesheet - Home </title>

    <!--Favicon-->
    <link rel="icon" href="favicon.ico" />

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- CSS -->
    <link href="Stylesheet.css" rel="stylesheet" />

    <!-- jQuery 3 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>


    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous" />

    <!-- Javascript-->
    <script type="text/javascript" src="JavaScript.js"></script>
    <script type="text/javascript" src="NodeScript.js"></script>

</head>
<body>
    <form runat="server">
        <div class="dashboard homepage">
            <%--top Container--%>
            <div class="top-container">
                <header>
                    <%--Navigation bar--%>
                    <div class="nav-bar">
                        <div class="menu-collapse">
                            <span><i class='bx bx-menu'></i></span>
                            <a href="Index.aspx"><span><i class='bx bxs-home'></i></span></a>
                        </div>

                        <%--menu--%>
                        <div class="nav-content">
                            <div class="nav-time">
                                <i class='bx bx-timer'></i><span>Time: </span>
                                <asp:Label runat="server" ID="nav_time"></asp:Label>
                            </div>
                            <div class="nav-search ">

                                <asp:TextBox ID="nav_search" runat="server" placeholder="Search" TextMode="Search"></asp:TextBox>
                                <i class='bx bx-search-alt-2' runat="server" onclick="nav_search_Click"></i>
                            </div>
                            <div class="nav-menu">
                                <ul>
                                    <li><i class='bx bxs-alarm-add'></i></li>
                                    <li><i class='bx bxs-bell-ring bx-tada'></i></li>
                                </ul>
                            </div>
                            <div class="nav-uname" runat="server">
                                <i class='bx bxs-face'></i>
                                <asp:LinkButton runat="server" ID="profile_name" Text="Profile" ToolTip="Logout" OnClick="profile_name_Click" OnClientClick=""></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </header>
            </div>

            <%--Main Content--%>
            <div class="main-container">
                <%--Left Side nav--%>
                <div class="left-container">
                    <%--side bar--%>
                    <div class="side-nav">
                        <%--Logo-section--%>
                        <div class="nav-logo">
                            <a href="https://www.gabriels.net/">
                                <img src="IMG/logo.png" /></a>
                        </div>
                        <div class="side-nav-content">
                            <div class="side-nav-title"><span>TimeSheet</span></div>
                            <hr />
                            <%--profile--%>
                            <div class="side-nav-profile">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="employee_name" runat="server" Style="font-weight: 500; font-size: 14px;" Text="Employee Name"></asp:Label>
                                            <asp:Label ID="employee_id" runat="server" Text="Employee ID"></asp:Label>
                                            <asp:Label ID="employee_role" runat="server" Text="Employee Role"></asp:Label>
                                        </td>
                                        <td>
                                            <img id="profile_img" runat="server" src="IMG/avatar.jpg" /></td>
                                    </tr>
                                </table>
                            </div>
                            <hr />
                        </div>
                        <%--menu--%>
                        <div class="side-nav-menu">
                            <ul style="list-style: none;">
                                <li onclick="tabswtich('Index.aspx')"><i class='bx bxs-time'></i><span>Time</span></li>
                                <li onclick="tabswtich('Dashboard_Sheets.aspx')"><i class='bx bxs-spreadsheet'></i><span>Sheets</span><i class='bx bxs-circle ' style="padding-left: 62px; color: lawngreen;"></i></li>
                                <li onclick="tabswtich('Dashboard_Calender.aspx')"><i class='bx bx-calendar'></i><span>Calender</span></li>
                                <li onclick="tabswtich('Dashboard_Reports.aspx')"><i class='bx bx-stats'></i><span>Reports</span></li>
                                <li onclick="tabswtich('Dashboard_Reports.aspx')"><i class='bx bxs-cog'></i><span>Settings</span></li>
                            </ul>
                        </div>
                        <%--help section--%>
                        <div class="side-nav-help side-nav-content ">
                            <i class='bx bxs-help-circle'></i>
                            <i class='bx bx-info-square'></i>
                        </div>
                        <%--copyrigths--%>
                        <div class="side-nav-copyright">
                            <span><i class='bx bx-copyright'></i>Copyrights<br />
                                XYZ</span>
                        </div>
                    </div>
                </div>
                <%--main content right--%>
                <div class="main-content-right">
                    <div class="main-content-header">
                        <div class="clock-in">
                            <i class='bx bxs-time'></i>
                            <span>Clocked in: </span>
                            <asp:Label ID="clock_in" runat="server">09:20 PM</asp:Label>
                        </div>
                        <div class="calendar-collapse">
                            <i id="calender_left" runtat="server" class='bx bx-chevron-left'></i>
                            <i class='bx bx-calendar-check'></i>
                            <asp:Label runat="server" ID="calender_date" Text="DD:MM:YYY"></asp:Label>
                            <i id="calender_right" runat="server" class='bx bx-chevron-right'></i>
                        </div>
                        <div class="download-report">
                            <asp:Button runat="server" ID="download_report" Text="Download Report" BorderStyle="None" OnClick="download_report_Click" />
                            <i class='bx bx-cloud-download'></i>
                        </div>
                        <div class="menu-icons">
                            <button runat="server" style="outline: none; border: none;"><i class='bx bxs-report'></i></button>
                            <button runat="server" style="outline: none; border: none;"><i class='bx bx-refresh'></i></button>
                            <button runat="server" style="outline: none; border: none;"><i class='bx bx-dots-horizontal'></i></button>
                        </div>
                    </div>
                    <div class="main-content-header-meta">
                        <div class="main-lable">
                            <i class='bx bx-fingerprint'></i>
                            <span>Project portal</span>
                        </div>
                        <div class="main-content-search">
                            <i class='bx bxs-filter-alt'></i>
                            <input class="inline-search" type="search" placeholder="search records" />
                            <i class='bx bxs-file-find' style="font-size: large;"></i>
                        </div>
                    </div>
                    <div class="curd-btn">
                        <div class="curd-left">
                            <i class='bx bxs-comment-add'></i>
                            <div class="dropdown">
                                <button class="dropbtn" type="reset">Projects</button>
                                <div id="Project_Dropdown" class="dropdown-content">
                                    <asp:Button ID="project_create_popup" runat="server" Text="Create Project" type="submit" />
                                    <asp:Button ID="project_edit_popup" runat="server" Text="Edit Project" type="reset" />
                                </div>
                                <i class='bx bxs-chevron-down'></i>
                            </div>
                            <i class='bx bxs-comment-add'></i>
                            <div class="dropdown">
                                <button class="dropbtn" type="reset">Tasks</button>
                                <div id="Task_Dropdown" class="dropdown-content">
                                    <asp:Button ID="task_create_popup" runat="server" Text="Create Task" type="reset" />
                                    <asp:Button ID="task_edit_popup" runat="server" Text="Edit Task" type="reset" />
                                </div>
                                <i class='bx bxs-chevron-down'></i>
                            </div>
                        </div>
                        <div class="curd-right">
                            <i class='bx bxs-add-to-queue'></i>
                            <div class="dropdown">
                                <button class="dropbtn" type="reset">Team Projects</button>
                                <div id="Team_project_Dropdown" class="dropdown-content" style="min-width: 175px;">
                                    <asp:Button ID="project_create_team_popup" runat="server" Text="Create Team Project" type="reset" />
                                    <asp:Button ID="project_edit_team_popup" runat="server" Text="Edit Team Project" type="reset" />
                                </div>
                                <i class='bx bxs-chevron-down'></i>
                            </div>
                            <i class='bx bxs-add-to-queue'></i>
                            <div class="dropdown">
                                <button class="dropbtn" type="reset">Team Tasks</button>
                                <div id="Team_Task_Dropdown" class="dropdown-content" style="min-width: 175px;">
                                    <asp:Button ID="task_create_team_popup" runat="server" Text="Create Team Task" type="reset" />
                                    <asp:Button ID="task_edit_team_popup" runat="server" Text="Edit Team Task" type="reset" />
                                </div>
                                <i class='bx bxs-chevron-down'></i>
                            </div>
                        </div>
                    </div>


                    <%-- empty popup--%>
                    <div>
                        <asp:Panel runat="server" ID="navigation_btn" class="popup popup-nav">
                            <span class="close" id="btn_close_nav"><i class='bx bx-x-circle'></i></span>
                            <table class="popup-table">
                                <tr>
                                    <td>
                                        <div class="buttons-popup">
                                            <asp:Button OnClientClick="javascript:$find('create_project_icon').show();$find('update_create_icon').hide();$find('team_create_project_icon').hide();return false;" runat="server" Text="Create Project" CausesValidation="False" UseSubmitBehavior="False" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="buttons-popup">
                                            <asp:Button OnClientClick="javascript:$find('team_create_project_icon').show();$find('update_create_icon').hide();$find('create_project_icon').hide();return false;" type="button" runat="server" Text="Create Team Project" CausesValidation="False" UseSubmitBehavior="False" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>

                    <asp:ScriptManager ID="ScriptManager2" runat="server">
                    </asp:ScriptManager>
                    <%--Main Content Dashboard Homepage--%>
                    <%--panel view--%>
                    <div class="panel">
                        <label class="main-content-lbl"><i class='bx bx-grid-alt'></i><span style="padding-left: 5px">Project Overview</span> </label>
                        <asp:Panel ID="Panel1" CssClass="homepage-panel" runat="server" ScrollBars="Auto" Wrap="False">
                            <%--default panel--%>
                            <div class="default-content" id="defualt_content" runat="server">
                                <asp:LinkButton runat="server" Style="color: gray; font-size: medium;" ID="nav_click_icon" Text="<i class='bx bxs-layer-plus' ></i>"></asp:LinkButton>
                                <br />
                                <span>Create Project</span>
                            </div>
                            <%--main panel--%>
                            <div id="main_content" class="main-content" runat="server">
                                <asp:UpdatePanel runat="server" ID="main_update_panel" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView ID="project_overview_gridview" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="main_grid_DS" CssClass="main-grid-table" HeaderStyle-CssClass="main-grid-header" OnRowDataBound="project_overview_gridview_RowDataBound" RowStyle-CssClass="main-grid-row" OnRowCreated="project_overview_gridview_RowCreated" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="id">
                                            <AlternatingRowStyle BackColor="White" ForeColor="#1c88d9"></AlternatingRowStyle>
                                            <Columns>
                                                <asp:TemplateField HeaderText="<i class='bx bxs-layer-plus' style='color:#3d3b3b'></i>">
                                                    <ItemTemplate>
                                                        <span id="img<%# Eval("project_id")%>" onclick="collapse(img<%# Eval("project_id") %>)" class="task-grid-expand" name="plus"><i class="fas fa-plus-square" tooltip="Task Overview"></i></span>

                                                        <div id="task_overview_div" style="display: none; border: 1px solid">
                                                            <div class="task-overview-div">
                                                                <span style="padding-left: 5px"><i class='bx bx-bookmarks'></i>Task Overview (<%# Eval("project_id") %>)</span> </label>
                                                            <asp:Panel ID="task_overview_panel" runat="server" ScrollBars="Auto" CssClass="task-overview-panel">
                                                                <asp:GridView ID="task_overview_gridview" runat="server" HorizontalAlign="Center" AutoGenerateColumns="false" CssClass="main-grid-table" DataKeyNames="id" OnRowDataBound="task_overview_gridview_RowDataBound">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="<i class='bx bxs-doughnut-chart'></i>" ItemStyle-HorizontalAlign="Center">
                                                                            <ItemTemplate>
                                                                                <i class='bx bxs-pie-chart-alt-2' style="display: contents; font-size: smaller"></i></span><asp:Label ID="Tstatus_main_grid" Style="margin-left: 3px;" runat="server" Text='<%#Bind("task_status")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="id"></asp:BoundField>
                                                                        <asp:BoundField DataField="task_id" HeaderText="Task ID" SortExpression="task_id"></asp:BoundField>
                                                                        <asp:BoundField DataField="ticket_id" HeaderText="Ticket ID" SortExpression="ticket_id"></asp:BoundField>
                                                                        <asp:BoundField DataField="project_id" HeaderText="Project ID" SortExpression="empid_task"></asp:BoundField>
                                                                        <asp:BoundField DataField="project_name" HeaderText="Project Name" SortExpression="project_name"></asp:BoundField>
                                                                        <asp:BoundField DataField="task_name" HeaderText="Task Name" SortExpression="task_name"></asp:BoundField>
                                                                        <asp:BoundField DataField="team_task_email" HeaderText="Team Task Email" SortExpression="team_task_email"></asp:BoundField>
                                                                        <asp:BoundField DataField="created_at" HeaderText="Created at" SortExpression="created_at"></asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <asp:LinkButton ID="Ttype_icon" runat="server" name='<%# Eval("task_type") %>' Text="<i class='bx bxs-message-square-edit'></i>" type="reset" Style="color: inherit" OnClientClick="Edittaskpopup(this)"></asp:LinkButton>
                                                                                </span>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <RowStyle BackColor="#F7F6F3" CssClass="main-grid-row" ForeColor="#333333"></RowStyle>
                                                                    <SelectedRowStyle BackColor="White" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>
                                                                    <HeaderStyle BackColor="#ebebeb" CssClass="main-grid-header" Font-Bold="True" ForeColor="#272a2c"></HeaderStyle>
                                                                    <EmptyDataTemplate>
                                                                        <span><i class='bx bx-collection'></i>No Tasks Created</span>
                                                                    </EmptyDataTemplate>
                                                                </asp:GridView>
                                                                <asp:SqlDataSource runat="server" ID="task_overview_DS" ConnectionString='<%$ ConnectionStrings:Timesheet_DBConnectionString %>' SelectCommand="SELECT [id], [project_id], [empid_task], [task_id], [ticket_id], [project_name], [task_name], [team_task_email], [created_at], [task_status] FROM [task_details]"></asp:SqlDataSource>
                                                            </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="<i class='bx bxs-cylinder'></i>">
                                                    <ItemTemplate>
                                                        <i class='bx bxs-bolt-circle' style="display: contents; font-size: xx-small;"></i></span><asp:Label ID="status_main_grid" Style="margin-left: 3px; color: inherit;" runat="server" Text='<%#Bind("project_status")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id" InsertVisible="False" ReadOnly="True"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Project ID" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="pid" runat="server" Text='<%#Bind("project_id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="project_name" HeaderText="Project Name" SortExpression="project_name" />
                                                <asp:BoundField DataField="product_name" HeaderText="Product " ItemStyle-HorizontalAlign="Center" SortExpression="product_name" />
                                                <asp:BoundField DataField="client_name" HeaderText="Client " ItemStyle-HorizontalAlign="Center" SortExpression="client_name" />
                                                <asp:BoundField DataField="project_team" HeaderText="Team" ItemStyle-HorizontalAlign="Center" SortExpression="project_team" />
                                                <asp:BoundField DataField="start_date" HeaderText="Started From" SortExpression="start_date" />
                                                <asp:BoundField DataField="project_team_email_id" HeaderText="Members" ItemStyle-HorizontalAlign="Center" SortExpression="project_team_email_id"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <span>
                                                            <asp:LinkButton ID="ptype_icon" runat="server" name='<%# Eval("project_type") %>' Text='<i class="fas fa-user-edit"></i>' type="reset" Style="color: inherit" OnClientClick="Editpopup(this)"></asp:LinkButton>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                            <EditRowStyle BackColor="#999999"></EditRowStyle>

                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                                            <HeaderStyle BackColor="#d3d1d1" CssClass="main-grid-header" Font-Bold="True" ForeColor="#272a2c"></HeaderStyle>

                                            <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

                                            <RowStyle BackColor="#F7F6F3" CssClass="main-grid-row" ForeColor="#333333"></RowStyle>

                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                                            <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                                            <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                                            <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>

                                        </asp:GridView>
                                        <asp:SqlDataSource ID="main_grid_DS" runat="server" ConnectionString="<%$ ConnectionStrings:Timesheet_DBConnectionString %>" SelectCommand="SELECT [id], [employee_id], [project_id], [project_name], [product_name], [client_name], [project_team], [start_date], [project_team_email_id], [project_status], [project_type] FROM [project_details] WHERE ([employee_id] = @employee_id)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="employee_id" Name="employee_id" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </asp:Panel>
                    </div>
                </div>



                <%--create project popup--%>
                <div>
                    <asp:Panel runat="server" ID="project_create_panel" class="popup">
                        <span class="close" id="close_popup_project"><i class='bx bx-x-circle'></i></span>
                        <label><i class='bx bxs-layer-plus'></i>Create Project</label>
                        <table class="popup-table">
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="project_product" value="-1">
                                        <asp:ListItem>--Select Product--</asp:ListItem>
                                        <asp:ListItem>Product 1</asp:ListItem>
                                        <asp:ListItem>Product 2</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="project_client" placeholder="Select client">
                                        <asp:ListItem>--Select Client--</asp:ListItem>
                                        <asp:ListItem>Client 1</asp:ListItem>
                                        <asp:ListItem>Client 2</asp:ListItem>
                                        <asp:ListItem>Client 3</asp:ListItem>
                                        <asp:ListItem>Client 4</asp:ListItem>
                                        <asp:ListItem>Client 5</asp:ListItem>
                                        <asp:ListItem>Client 6</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="project_team" placeholder="Select Team">
                                        <asp:ListItem>--Select Team--</asp:ListItem>
                                        <asp:ListItem>Data Management</asp:ListItem>
                                        <asp:ListItem>Systems</asp:ListItem>
                                        <asp:ListItem>Client Services</asp:ListItem>
                                        <asp:ListItem>FrontEnd</asp:ListItem>
                                        <asp:ListItem>BackEnd</asp:ListItem>
                                        <asp:ListItem>Database</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Project Name*</label><br />
                                    <asp:TextBox runat="server" ID="project_name" TextMode="SingleLine" placeholder="Enter Project Name"></asp:TextBox>
                                </td>
                                <td>
                                    <label>Project Start Date</label><br />
                                    <asp:TextBox runat="server" ID="project_startdate" placeholder="Pick the Start Date" TextMode="SingleLine"></asp:TextBox><br />
                                </td>
                            </tr>
                        </table>

                        <div class="buttons-popup">
                            <asp:Button ID="Create_project" runat="server" Text="Create Project" OnClick="Create_project_Click1" UseSubmitBehavior="true" CausesValidation="false" />
                        </div>
                    </asp:Panel>
                </div>



                <%--create task popup--%>
                <div>
                    <asp:Panel runat="server" ID="task_create_panel" class="popup">
                        <span class="close" id="close_popup_task"><i class='bx bx-x-circle'></i></span>
                        <label><i class='bx bxs-network-chart'></i>Create Task</label>
                        <table class="popup-table">
                            <tr>
                                <td>
                                    <asp:SqlDataSource ID="Existing_project_DS" runat="server" ConnectionString="<%$ ConnectionStrings:Timesheet_DBConnectionString %>" SelectCommand="SELECT [project_id], [employee_id], [project_name] FROM [project_details] WHERE (([employee_id] = @employee_id) AND ([project_type] = @project_type))">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="employee_id" Name="employee_id" PropertyName="Text" Type="String" />
                                            <asp:Parameter DefaultValue="individual" Name="project_type" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:DropDownList runat="server" ID="Existing_Project" DataTextField="project_name" DataSourceID="Existing_project_DS" DataValueField="project_id" AutoPostBack="false" AppendDataBoundItems="true">
                                        <asp:ListItem Selected="False">--Select Task--</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label>Task Ticket ID</label><br />
                                    <asp:TextBox runat="server" ID="task_ticket_id" TextMode="SingleLine" placeholder="Enter Ticket ID"></asp:TextBox>
                                </td>
                                <td>
                                    <label>Task Ticket Name</label><br />
                                    <asp:TextBox runat="server" ID="task_name" placeholder="Enter Task Name" TextMode="SingleLine"></asp:TextBox><br />
                                </td>
                            </tr>
                        </table>

                        <div class="buttons-popup">
                            <asp:Button ID="task_create_btn" runat="server" Text="Create Task" OnClick="task_create_btn_Click" UseSubmitBehavior="false" />
                        </div>
                    </asp:Panel>
                </div>

                <%--create team project popup--%>
                <div>
                    <asp:Panel runat="server" ID="team_project_create_panel" class="popup">
                        <span class="close" id="close_popup_team_project"><i class='bx bx-x-circle'></i></span>
                        <label><i class='bx bxl-microsoft-teams'></i>Create Team Project</label>
                        <table class="popup-table">
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="team_project_product" placeholder="Select Project">
                                        <asp:ListItem>--Select Product--</asp:ListItem>
                                        <asp:ListItem>Product 1</asp:ListItem>
                                        <asp:ListItem>Product 2</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="team_project_client" placeholder="Select client">
                                        <asp:ListItem>--Select Client--</asp:ListItem>
                                        <asp:ListItem>Client 1</asp:ListItem>
                                        <asp:ListItem>Client 2</asp:ListItem>
                                        <asp:ListItem>Client 3</asp:ListItem>
                                        <asp:ListItem>Client 4</asp:ListItem>
                                        <asp:ListItem>Client 5</asp:ListItem>
                                        <asp:ListItem>Client 6</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="team_project_team" placeholder="Select Team">
                                        <asp:ListItem>--Select Team--</asp:ListItem>
                                        <asp:ListItem>Data Management</asp:ListItem>
                                        <asp:ListItem>Systems</asp:ListItem>
                                        <asp:ListItem>Client Services</asp:ListItem>
                                        <asp:ListItem>FrontEnd</asp:ListItem>
                                        <asp:ListItem>BackEnd</asp:ListItem>
                                        <asp:ListItem>Database</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Project Name*</label><br />
                                    <asp:TextBox runat="server" ID="team_project_name" TextMode="SingleLine" placeholder="Enter Project Name" CausesValidation="false" ValidationGroup=""></asp:TextBox>
                                </td>
                                <td>
                                    <label>Project Start Date</label><br />
                                    <asp:TextBox runat="server" ID="team_project_startdate" placeholder="Pick the Start Date" TextMode="SingleLine"></asp:TextBox><br />
                                </td>
                            </tr>
                        </table>
                        <div class="popup-table">
                            <label style="padding-right: 183px;">Team Mail IDs</label><br />
                            <asp:TextBox runat="server" ID="team_project_email" CssClass="team-email-box" Style="margin-left: 0px;" data-role="tagsinput" placeholder="Enter team mails"></asp:TextBox>

                        </div>
                        <div class="buttons-popup">
                            <asp:Button ID="team_project_create_btn" runat="server" Text="Create Team Project" OnClick="team_project_create_btn_Click" />
                        </div>
                    </asp:Panel>
                </div>

                <%--create team task popup--%>
                <div>
                    <asp:Panel runat="server" ID="team_task_create_panel" class="popup">
                        <span class="close" id="close_popup_team_task"><i class='bx bx-x-circle'></i></span>
                        <label><i class='bx bx-sitemap'></i>Create Team Task</label>
                        <table class="popup-table">
                            <tr>
                                <td>
                                    <asp:SqlDataSource ID="Team_Existing_project_DS" runat="server" ConnectionString="<%$ ConnectionStrings:Timesheet_DBConnectionString %>" SelectCommand="SELECT [project_id], [employee_id], [project_name] FROM [project_details] WHERE (([employee_id] = @employee_id) AND ([project_type] = @project_type))">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="employee_id" Name="employee_id" PropertyName="Text" Type="String" />
                                            <asp:Parameter DefaultValue="team" Name="project_type" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:DropDownList runat="server" ID="team_Existing_Project" AppendDataBoundItems="true" DataSourceID="Team_Existing_project_DS" DataTextField="project_name" DataValueField="project_id">
                                        <asp:ListItem>--Select Team Task--</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                            </tr>

                            <tr>
                                <td>
                                    <label>Task Ticket ID</label><br />
                                    <asp:TextBox runat="server" ID="team_task_ticket_id" TextMode="SingleLine" placeholder="Enter Ticket ID"></asp:TextBox>
                                </td>
                                <td>
                                    <label>Team Task Name</label><br />
                                    <asp:TextBox runat="server" ID="team_task_name" placeholder="Enter Task Name" TextMode="SingleLine"></asp:TextBox><br />
                                </td>
                            </tr>
                        </table>
                        <div class="popup-table">
                            <label style="padding-right: 183px;">Team Mail IDs</label><br />
                            <asp:TextBox runat="server" ID="team_task_email" TextMode="SingleLine" CssClass="team-email-box"></asp:TextBox>

                        </div>
                        <div class="buttons-popup">
                            <asp:Button ID="team_task_create_btn" runat="server" Text="Create Team Task" OnClick="team_task_create_btn_Click" />
                        </div>
                    </asp:Panel>
                </div>


                <%--Edit popup panels--%>

                <%--project Edit panel--%>
                <div id="project_edit_panel" class="popup" style="margin-left: 40px">
                    <label runat="server" id="project_overview"><i class='bx bx-sort-up'></i>Edit Project<i id="close_popup_projectUP" class='bx bx-x-circle update-project-popup'></i></label>
                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="project_edit_operations">
                                <div class="curd-btns">
                                    <div id="curd_btns_project" style="display: none">
                                        <asp:LinkButton runat="server" ID="Edit_all_project_btn" OnClick="Edit_all_project_btn_Click" Text='<i class="fas fa-pen-square"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="Delete_all_project_btn" OnClick="Delete_all_project_btn_Click" Text='<i class="fas fa-trash-alt"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="cancel_project_selected" OnClick="cancel_project_selected_Click" Text='<i class="fas fa-window-close"></i>'></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="project_edit_operations_right">
                                    <a href="#" style="text-decoration: none; color: inherit;"><i class="fas fa-sort"></i></a>
                                    <asp:TextBox runat="server" ID="project_edit_search" CssClass="project_edit_search" TextMode="Search" placeholder="Search Team Projects"></asp:TextBox>
                                </div>

                            </div>
                            <asp:Panel ID="project_edit_popup_panel" runat="server" ScrollBars="Auto" CssClass="update-project-panel">
                                <%--Edit project main content--%>
                                <asp:GridView runat="server" ID="project_edit_gridview" CssClass="main-grid-table" HeaderStyle-CssClass="main-grid-header" RowStyle-CssClass="main-grid-row" AutoGenerateColumns="false" OnRowUpdating="project_edit_gridview_RowUpdating" OnRowCommand="project_edit_gridview_RowCommand" OnRowEditing="project_edit_gridview_RowEditing" OnRowDeleting="project_edit_gridview_RowDeleting" OnRowDataBound="project_edit_gridview_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" ID="Cancel_edit" Text='<i class="fas fa-times-circle"></i>' Style="color: inherit" OnClick="cancel_project_selected_Click"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="checkbox_project" runat="server" OnClick="checkUncheck(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_id" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Project ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_pid" runat="server" Text='<%# Bind("project_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_pname" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_project_pname" Text='<%# Bind("project_name") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_emp_team" runat="server" Text='<%# Bind("project_team") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_project_team" Text='<%# Bind("project_team") %>'>
                                                    <asp:ListItem>Data Management</asp:ListItem>
                                                    <asp:ListItem>Systems</asp:ListItem>
                                                    <asp:ListItem>Client Services</asp:ListItem>
                                                    <asp:ListItem>FrontEnd</asp:ListItem>
                                                    <asp:ListItem>BackEnd</asp:ListItem>
                                                    <asp:ListItem>Database</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_product_name" runat="server" Text='<%# Bind("product_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_product_name" Text='<%#Bind("product_name") %>'>
                                                    <asp:ListItem>Product 1</asp:ListItem>
                                                    <asp:ListItem>Product 2</asp:ListItem>
                                                    <asp:ListItem>Others</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Client Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_client" runat="server" Text='<%# Bind("client_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_client_name" Text='<%#Bind("client_name") %>'>
                                                    <asp:ListItem>Client 1</asp:ListItem>
                                                    <asp:ListItem>Client 2</asp:ListItem>
                                                    <asp:ListItem>Client 3</asp:ListItem>
                                                    <asp:ListItem>Client 4</asp:ListItem>
                                                    <asp:ListItem>Client 5</asp:ListItem>
                                                    <asp:ListItem>Client 6</asp:ListItem>
                                                    <asp:ListItem>Others</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Started From">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_sdate" runat="server" Text='<%# Bind("start_date") %>' DataFormatString="{dd/MM/yyyy}"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="date" ID="txt_project_sdate" DataFormatString="{dd/MM/yyyy}" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team Member">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_project_Temail" runat="server" Text='<%# Bind("project_team_email_id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="SingleLine" ID="txt_project_Temail" Text='<%# Bind("project_team_email_id") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <div id="status-project">
                                                    <i class="fas fa-chart-pie" style="font-size: smaller;"></i>
                                                    <asp:Label ID="lbl_project_status" runat="server" Text='<%# Bind("project_status") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_project_status" Text='<%# Bind("project_status")%>'>
                                                    <asp:ListItem>Pending</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                    <asp:ListItem>Terminated</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ControlStyle-CssClass="action-btns">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Edit" ID="edit_project_btn"><i class="fas fa-pen-square"></i></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="delete" ID="delete_project_btn" CssClass="delete_checked"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Update" ID="update_project_btn" Text='<i class="fas fa-upload"></i>'></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="Cancel_project_btn" ID="cancel_project_btn" Text='<i class="fas fa-times"></i>'></asp:LinkButton>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:LinkButton runat="server" Style="color: gray" Text='<i class="fas fa-plus-square"></i>' OnClientClick="projectempty()"></asp:LinkButton>
                                        <%--                                        <button type="reset" OnClick="projectempty()"><i class="fas fa-plus-square"></i></button>--%>
                                        <br />
                                        <span>Create Project</span>
                                    </EmptyDataTemplate>
                                    <EmptyDataRowStyle CssClass="empty-gridview" />
                                </asp:GridView>
                            </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <%--task Edit panel--%>
                <div id="task_edit_panel" class="popup" style="margin-left: 40px">
                    <label runat="server" id="task_overview"><i class='bx bx-sort-up'></i>Edit Task<i id="close_popup_taskUP" class='bx bx-x-circle update-project-popup'></i></label>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="project_edit_operations">
                                <div class="curd-btns">
                                    <div id="curd_btns_task" style="display: none">
                                        <asp:LinkButton runat="server" ID="Edit_all_task_btn" OnClick="Edit_all_task_btn_Click" Text='<i class="fas fa-pen-square"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="Delete_all_task_btn" OnClick="Delete_all_task_btn_Click" Text='<i class="fas fa-trash-alt"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="cancel_all_task_btn" OnClick="cancel_all_task_btn_Click" Text='<i class="fas fa-window-close"></i>'></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="project_edit_operations_right">
                                    <a href="#" style="text-decoration: none; color: inherit;"><i class="fas fa-sort"></i></a>
                                    <asp:TextBox runat="server" ID="task_edit_search" CssClass="project_edit_search" TextMode="Search" placeholder="Search Tasks"></asp:TextBox>
                                </div>

                            </div>
                            <asp:Panel ID="task_edit_popup_panel" runat="server" ScrollBars="Auto" CssClass="update-project-panel">
                                <%--Edit task main content--%>
                                <asp:GridView runat="server" ID="task_edit_gridview" CssClass="main-grid-table" HeaderStyle-CssClass="main-grid-header" RowStyle-CssClass="main-grid-row" AutoGenerateColumns="false" OnRowUpdating="task_edit_gridview_RowUpdating" OnRowEditing="task_edit_gridview_RowEditing" OnRowDeleting="task_edit_gridview_RowDeleting" OnRowCancelingEdit="task_edit_gridview_RowCancelingEdit" OnRowDataBound="task_edit_gridview_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" ID="Cancel_edit" Text='<i class="fas fa-times-circle"></i>' Style="color: inherit" OnClick="cancel_project_selected_Click"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="checkbox_task" runat="server" OnClick="checkboxtask(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_id" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Task ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_tid" runat="server" Text='<%# Bind("task_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Task Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_tname" runat="server" Text='<%# Bind("task_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_task_tname" Text='<%# Bind("task_name") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Ticket ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_ticket_id" runat="server" Text='<%# Bind("ticket_id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_task_ticket_id" Text='<%# Bind("ticket_id") %>' ViewStateMode="Enabled" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_pname" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_task_pname" DataSourceID="Existing_Project_DS" DataTextField="project_name" DataValueField="project_id">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_sdate" runat="server" Text='<%# Bind("created_at") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="date" ID="txt_task_sdate" Text='<%# Bind("created_at") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team ">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_Temail" runat="server" Text='<%# Bind("team_task_email") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="SingleLine" ID="txt_task_Temail" Text='<%# Bind("team_task_email") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <div id="status-project">
                                                    <i class="fas fa-chart-pie" style="font-size: smaller;"></i>
                                                    <asp:Label ID="lbl_task_status" runat="server" Text='<%# Bind("task_status") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_task_status" Text='<%# Bind("task_status")%>'>
                                                    <asp:ListItem>Pending</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                    <asp:ListItem>Terminated</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ControlStyle-CssClass="action-btns">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Edit" ID="edit_task_btn"><i class="fas fa-pen-square"></i></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="delete" ID="delete_task_btn" CssClass="delete_checked"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Update" ID="update_task_btn" Text='<i class="fas fa-upload"></i>'></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="Cancel" ID="cancel_task_btn" Text='<i class="fas fa-times"></i>'></asp:LinkButton>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:LinkButton runat="server" Style="color: gray" Text='<i class="fas fa-plus-square"></i>' OnClientClick="taskempty()"></asp:LinkButton>
                                        <br />
                                        <span>Create Task</span>
                                    </EmptyDataTemplate>
                                    <EmptyDataRowStyle CssClass="empty-gridview" />
                                </asp:GridView>
                            </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


                <%--Team project Edit panel--%>

                <div id="team_project_edit_panel" class="popup" style="margin-left: 40px">
                    <label runat="server" id="Label1"><i class='bx bx-sort-up'></i>Edit Team Project<i id="team_close_popup_projectUP" class='bx bx-x-circle update-project-popup'></i></label>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="project_edit_operations">
                                <div class="curd-btns">
                                    <div id="curd_btns_team" style="display: none">
                                        <asp:LinkButton runat="server" ID="team_edit_project_btn" OnClick="team_edit_project_btn_Click" Text='<i class="fas fa-pen-square"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="team_delete_project_btn" OnClick="team_delete_project_btn_Click" Text='<i class="fas fa-trash-alt"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="team_cancel_project_btn" OnClick="team_cancel_project_btn_Click" Text='<i class="fas fa-window-close"></i>'></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="project_edit_operations_right">
                                    <a href="#" style="text-decoration: none; color: inherit;"><i class="fas fa-sort"></i></a>
                                    <asp:TextBox runat="server" ID="team_project_edit_search" CssClass="project_edit_search" TextMode="Search" placeholder="Search Projects"></asp:TextBox>
                                </div>

                            </div>
                            <asp:Panel ID="team_project_edit_popup_panel" runat="server" ScrollBars="Auto" CssClass="update-project-panel">
                                <%--team Edit project main content--%>
                                <asp:GridView runat="server" ID="team_project_edit_gridview" CssClass="main-grid-table" HeaderStyle-CssClass="main-grid-header" RowStyle-CssClass="main-grid-row" AutoGenerateColumns="false" OnRowDataBound="project_edit_gridview_RowDataBound" OnRowCancelingEdit="team_project_edit_gridview_RowCancelingEdit" OnRowEditing="team_project_edit_gridview_RowEditing" OnRowUpdating="team_project_edit_gridview_RowUpdating" OnRowDeleting="team_project_edit_gridview_RowDeleting">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <%--<asp:CheckBox runat="server" ID="checkbox_project_all" />--%>
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" ID="Cancel_edit" Text='<i class="fas fa-times-circle"></i>' Style="color: inherit" OnClick="cancel_project_selected_Click"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="checkbox_team_project" runat="server" OnClick="checkboxteam(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_id" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Project ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_pid" runat="server" Text='<%# Bind("project_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_pname" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_team_project_pname" Text='<%# Bind("project_name") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_emp_team" runat="server" Text='<%# Bind("project_team") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_project_team" Text='<%# Bind("project_team") %>'>
                                                    <asp:ListItem>Data Management</asp:ListItem>
                                                    <asp:ListItem>Systems</asp:ListItem>
                                                    <asp:ListItem>Client Services</asp:ListItem>
                                                    <asp:ListItem>FrontEnd</asp:ListItem>
                                                    <asp:ListItem>BackEnd</asp:ListItem>
                                                    <asp:ListItem>Database</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_product_name" runat="server" Text='<%# Bind("product_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_product_name" Text='<%#Bind("product_name") %>'>

                                                    <asp:ListItem>Product 1</asp:ListItem>
                                                    <asp:ListItem>Product 2</asp:ListItem>
                                                    <asp:ListItem>Others</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Client Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_client" runat="server" Text='<%# Bind("client_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_client_name" Text='<%#Bind("client_name") %>'>
                                                    <asp:ListItem>Client 1</asp:ListItem>
                                                    <asp:ListItem>Client 2</asp:ListItem>
                                                    <asp:ListItem>Client 3</asp:ListItem>
                                                    <asp:ListItem>Client 4</asp:ListItem>
                                                    <asp:ListItem>Client 5</asp:ListItem>
                                                    <asp:ListItem>Client 6</asp:ListItem>
                                                    <asp:ListItem>Others</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Started From">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_sdate" runat="server" Text='<%# Bind("start_date") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="date" ID="txt_team_project_sdate" Text='<%# Bind("start_date") %>' ViewStateMode="Enabled" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team Member">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_project_Temail" runat="server" Text='<%# Bind("project_team_email_id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="SingleLine" ID="txt_team_project_Temail" Text='<%# Bind("project_team_email_id") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <div id="status-project">
                                                    <i class="fas fa-chart-pie" style="font-size: smaller;"></i>
                                                    <asp:Label ID="lbl_project_status" runat="server" Text='<%# Bind("project_status") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_project_status" Text='<%# Bind("project_status")%>'>
                                                    <asp:ListItem>Pending</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                    <asp:ListItem>Terminated</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ControlStyle-CssClass="action-btns">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Edit" ID="edit_project_btn"><i class="fas fa-pen-square"></i></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="delete" ID="delete_project_btn" CssClass="delete_checked"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Update" ID="update_project_btn" Text='<i class="fas fa-upload"></i>'></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="Cancel" ID="cancel_project_btn" Text='<i class="fas fa-times"></i>'></asp:LinkButton>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:LinkButton runat="server" Style="color: gray" Text='<i class="fas fa-plus-square"></i>' OnClientClick="Tprojectempty()"></asp:LinkButton>
                                        <br />
                                        <span>Create Team Project</span>
                                    </EmptyDataTemplate>
                                    <EmptyDataRowStyle CssClass="empty-gridview" />
                                </asp:GridView>
                            </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <%--Team task Edit panel--%>
                <div id="team_task_edit_panel" class="popup" style="margin-left: 40px">
                    <label runat="server" id="team_task_overview"><i class='bx bx-sort-up'></i>Edit Team Task<i id="close_popup_team_taskUP" class='bx bx-x-circle update-project-popup'></i></label>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="project_edit_operations">
                                <div class="curd-btns">
                                    <div id="curd_btns_team_task" style="display: none">
                                        <asp:LinkButton runat="server" ID="Edit_all_team_task_btn" OnClick="Edit_all_team_task_btn_Click" Text='<i class="fas fa-pen-square"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="Delete_all_team_task_btn" OnClick="Delete_all_team_task_btn_Click" Text='<i class="fas fa-trash-alt"></i>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="cancel_all_team_task_btn" OnClick="cancel_all_team_task_btn_Click" Text='<i class="fas fa-window-close"></i>'></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="project_edit_operations_right">
                                    <a href="#" style="text-decoration: none; color: inherit;"><i class="fas fa-sort"></i></a>
                                    <asp:TextBox runat="server" ID="team_task_edit_search" CssClass="project_edit_search" TextMode="Search" placeholder="Search Team Tasks"></asp:TextBox>
                                </div>

                            </div>
                            <asp:Panel ID="team_task_edit_popup_panel" runat="server" ScrollBars="Auto" CssClass="update-project-panel">
                                <%--Team Edit task main content--%>
                                <asp:GridView runat="server" ID="team_task_edit_gridview" CssClass="main-grid-table" HeaderStyle-CssClass="main-grid-header" RowStyle-CssClass="main-grid-row" AutoGenerateColumns="false" OnRowUpdating="team_task_edit_gridview_RowUpdating" OnRowEditing="team_task_edit_gridview_RowEditing" OnRowDeleting="team_task_edit_gridview_RowDeleting" OnRowCancelingEdit="team_task_edit_gridview_RowCancelingEdit" OnRowDataBound="team_task_edit_gridview_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" ID="Cancel_edit" Text='<i class="fas fa-times-circle"></i>' Style="color: inherit" OnClick="cancel_project_selected_Click"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="checkbox_team_task" runat="server" OnClick="checkboxteamtask(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_id" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Task ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_tid" runat="server" Text='<%# Bind("task_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Task Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_tname" runat="server" Text='<%# Bind("task_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_team_task_tname" Text='<%# Bind("task_name") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Ticket ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_task_ticket_id" runat="server" Text='<%# Bind("ticket_id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txt_team_task_ticket_id" Text='<%# Bind("ticket_id") %>' ViewStateMode="Enabled" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_pname" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_task_pname" DataSourceID="Team_Existing_project_DS" DataTextField="project_name" DataValueField="project_id">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_sdate" runat="server" Text='<%# Bind("created_at") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="date" ID="txt_team_task_sdate" Text='<%# Bind("created_at") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Team ">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_team_task_Temail" runat="server" Text='<%# Bind("team_task_email") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" TextMode="SingleLine" ID="txt_team_task_Temail" Text='<%# Bind("team_task_email") %>' />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <div id="status-project">
                                                    <i class="fas fa-chart-pie" style="font-size: smaller;"></i>
                                                    <asp:Label ID="lbl_team_task_status" runat="server" Text='<%# Bind("task_status") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="DD_team_task_status">
                                                    <asp:ListItem>Pending</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                    <asp:ListItem>Terminated</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ControlStyle-CssClass="action-btns">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Edit" ID="edit_task_btn"><i class="fas fa-pen-square"></i></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="delete" ID="delete_task_btn" CssClass="delete_checked"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="Update" ID="update_task_btn" Text='<i class="fas fa-upload"></i>'></asp:LinkButton>
                                                <asp:LinkButton runat="server" CommandName="Cancel" ID="cancel_task_btn" Text='<i class="fas fa-times"></i>'></asp:LinkButton>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:LinkButton runat="server" Style="color: gray" Text='<i class="fas fa-plus-square"></i>' OnClientClick="Ttaskempty()"></asp:LinkButton>
                                        <br />
                                        <span>Create Team Task</span>
                                    </EmptyDataTemplate>
                                    <EmptyDataRowStyle CssClass="empty-gridview" />
                                </asp:GridView>
                            </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <%--Welcome Screen Profile update--%>

                <div id="profile_update_div" class="popup" style="margin-left: 40px">
                    <div>
                        <div class="welcome-div">
                            <div class="welcome-left">
                                <img src="IMG/Welcomeimg.png" />
                                <br />
                                <div class="welcome-text">
                                    <span>Hi </span>
                                    <asp:Label ID="welcome_txt_lbl" runat="server"></asp:Label><span> !</span><br />
                                    <label>Welcome to Gabriels Timesheet</label>
                                </div>
                            </div>
                            <div class="welcome-right">
                                <div>
                                    <span><i class="fas fa-user-edit"></i></span>
                                    <span style="font-weight: 500">Profile Update</span>
                                </div>

                                <br />
                                <table class="welcome-table" runat="server">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" Text="Employee Role"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_role" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:TextBox runat="server" ID="emp_role" AutoCompleteType="None" placeholder="Eg: SDE,FE Dev, etc.,"></asp:TextBox><br />
                                        </td>
                                        <td>
                                            <asp:Label runat="server" Text="Employee Team"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_team" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:TextBox runat="server" ID="emp_team" AutoCompleteType="None" placeholder="Eg: FE,Backend, etc.,"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" Text="Date Of Joining"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_doj" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:TextBox runat="server" ID="emp_doj" TextMode="SingleLine" placeholder="Pick the Date(DOJ)"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" Text="Date of Birthday"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_dob" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:TextBox runat="server" ID="emp_dob" TextMode="SingleLine" placeholder="Pick the Date(DOB)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" Text="Gender"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_gender" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:DropDownList ID="emp_gender" runat="server">
                                                <asp:ListItem>Male</asp:ListItem>
                                                <asp:ListItem>Female</asp:ListItem>
                                                <asp:ListItem>General</asp:ListItem>
                                            </asp:DropDownList>

                                        </td>
                                        <td>
                                            <asp:Label runat="server" Text="Employee Contact"></asp:Label><%--&nbsp<asp:RequiredFieldValidator runat="server" ControlToValidate="emp_contact" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                            <br />
                                            <asp:TextBox runat="server" ID="emp_contact" TextMode="Phone" placeholder="Eg: +91-00000 00000"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <div class="welcome-btns">
                                    <asp:Button runat="server" ID="profile_update_btn" Text="Update" OnClick="profile_update_btn_Click" />
                                    <asp:Button ID="profile_skip_btn" runat="server" Text="Skip" Style="display: none" />
                                </div>
                            </div>
                        </div>
                        <br />
                    </div>
                </div>


                <%--project panel--%>
                <div class="project-panel" id="project_panel">


                    <%--projects popup controls--%>
                    <%--create Project--%>
                    <ajaxToolkit:ModalPopupExtender ID="project_popup" runat="server" BehaviorID="create_project_icon" BackgroundCssClass="popup-container" PopupControlID="project_create_panel" TargetControlID="project_create_popup" CancelControlID="close_popup_project">
                    </ajaxToolkit:ModalPopupExtender>

                    <%--Tasks popup controls--%>
                    <%--create Task--%>
                    <ajaxToolkit:ModalPopupExtender ID="task_popup" runat="server" BackgroundCssClass="popup-container" PopupControlID="task_create_panel" TargetControlID="task_create_popup" CancelControlID="close_popup_task"></ajaxToolkit:ModalPopupExtender>

                    <%-- Team projects popup controls--%>
                    <%--create Team Project--%>
                    <ajaxToolkit:ModalPopupExtender ID="team_project_popup" runat="server" BehaviorID="team_create_project_icon" BackgroundCssClass="popup-container" PopupControlID="team_project_create_panel" TargetControlID="project_create_team_popup" CancelControlID="close_popup_team_project"></ajaxToolkit:ModalPopupExtender>

                    <%--Team Task popup controls--%>
                    <%--create Team Task--%>
                    <ajaxToolkit:ModalPopupExtender ID="team_task_popup" runat="server" BackgroundCssClass="popup-container" PopupControlID="team_task_create_panel" TargetControlID="task_create_team_popup" CancelControlID="close_popup_team_task"></ajaxToolkit:ModalPopupExtender>

                    <%--projects edit popup controls--%>
                    <%--edit Project--%>
                    <ajaxToolkit:ModalPopupExtender ID="edit_project_popup" runat="server" BackgroundCssClass="popup-container " PopupControlID="project_edit_panel" TargetControlID="project_edit_popup" CancelControlID="close_popup_projectUP"></ajaxToolkit:ModalPopupExtender>

                    <%--edit Task--%>
                    <ajaxToolkit:ModalPopupExtender ID="edit_task_popup" runat="server" BackgroundCssClass="popup-container" PopupControlID="task_edit_panel" TargetControlID="task_edit_popup" CancelControlID="close_popup_taskUP"></ajaxToolkit:ModalPopupExtender>

                    <%--team edit Project--%>
                    <ajaxToolkit:ModalPopupExtender ID="edit_team_project_popup" runat="server" BackgroundCssClass="popup-container" PopupControlID="team_project_edit_panel" TargetControlID="project_edit_team_popup" CancelControlID="team_close_popup_projectUP"></ajaxToolkit:ModalPopupExtender>

                    <%--edit Task--%>
                    <ajaxToolkit:ModalPopupExtender ID="edit_team_task_popup" runat="server" BackgroundCssClass="popup-container" PopupControlID="team_task_edit_panel" TargetControlID="task_edit_team_popup" CancelControlID="close_popup_team_taskUP"></ajaxToolkit:ModalPopupExtender>

                    <%-- popup btns --%>
                    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender9" runat="server" BehaviorID="update_create_icon" BackgroundCssClass="popup-container" PopupControlID="navigation_btn" TargetControlID="nav_click_icon" CancelControlID="btn_close_nav"></ajaxToolkit:ModalPopupExtender>

                    <%-- popup btns --%>
                    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender10" runat="server" BackgroundCssClass="popup-container" PopupControlID="profile_update_div" TargetControlID="profile_img" CancelControlID="profile_skip_btn"></ajaxToolkit:ModalPopupExtender>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hidden_field_val" runat="server" />
        <asp:HiddenField ID="hidden_field_txt" runat="server" />
        <asp:HiddenField ID="Thidden_field_val" runat="server" />
        <asp:HiddenField ID="Thidden_field_txt" runat="server" />
    </form>
    <!-- REQUIRED JS SCRIPTS -->
    <script>
        $('#Existing_Project').change(function () {
            var data_Project_Value = $(this).val();
            var data_Project_Text = $("#Existing_Project option:selected").text();
            document.getElementById("hidden_field_val").value = data_Project_Value;
            document.getElementById("hidden_field_txt").value = data_Project_Text;
        });

        $('#team_Existing_Project').change(function () {
            var Tdata_Project_Value = $(this).val();
            var Tdata_Project_Text = $("#team_Existing_Project option:selected").text();
            document.getElementById("Thidden_field_val").value = Tdata_Project_Value;
            document.getElementById("Thidden_field_txt").value = Tdata_Project_Text;
        });


    </script>

</body>
</html>

