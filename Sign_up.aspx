<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sign_up.aspx.cs" Inherits="TimeSheet.Signup" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" >
    <title>Timesheet Sign In</title>
    <!--Favicon-->
    <link rel="icon" href="favicon.ico" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="~/bower_components/bootstrap/dist/css/bootstrap.min.css">
 
    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
   
    <!-- CSS -->
    <link href="Stylesheet.css" rel="stylesheet" />
    
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous" />

</head>
<body >
    <div class="parent signup wrapper ">
    <%--Page left--%>
    <form class="form-left" runat="server">
        <div class="logo">
            <img src="IMG/logo.png" />
        </div>
        <div class="form">
            <label style="font-weight: 500; font-size: 20px;">
                Sign up
            </label>
            <div class="container">
                <table class="tableinput">
                    <tr>
                        <td>
                            <lable>Employee ID</lable>
                            <asp:TextBox ID="emp_id" class="inputarea Up" runat="server" placeholder="Enter Employee ID" Style="width: 145px; text-transform:uppercase" ValidationGroup="uppercase" />

                        </td>
                        <td style="padding-left:27px">
                            <lable>Employee Username</lable>
                            <asp:TextBox ID="emp_name" class="inputarea" runat="server" placeholder="Enter Full Name" style="width:200px" />
                        </td>
                    </tr>
                </table>
                <lable style="padding-top:0px">Email</lable>
                <asp:TextBox ID="login_email" class="inputarea" runat="server" placeholder="Enter work Email" TextMode="Email" />
                <lable>Passowrd</lable>
                <asp:TextBox ID="user_psw" type="password" class="inputarea" runat="server" placeholder="Enter password" />
                <div class="btn">
                    <asp:Button ID="signupbtn" CssClass="btnsubmit inputarea" runat="server" Text="Sign up " ToolTip="Submit"  OnClick="signup_btn_Click"/>
                </div>
            <div "others">
                <div>
                    <label style="font-size: small; color: black;">or sign up with</label>
                    <div class="links">
                         <asp:LinkButton ID="GoogleAPI_btn" runat="server" Text="<i class='bx bxl-google'></i>"></asp:LinkButton>
                         <asp:LinkButton ID="MicrosoftAPI_btn" runat="server" Text="<i class='fab fa-windows'></i>"></asp:LinkButton>
                    </div>
                </div>
                <div class="accountexist">
                    <span>already have an account? <a href="Login.aspx">Sign in</a></span>
                </div>
            </div>
           </div>
        </div>
    </form>
    <%--Page Right--%>

    <div class="right">
        <image src="/IMG/Sign_up.png" />
    </div>
        
    <%-- <!-- Script Links -->
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Dropify/0.2.2/js/dropify.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="~/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- AdminLTE App -->
    <script src="~/dist/js/adminlte.min.js"></script>--%>
        </div>
    
</body>
</html>
