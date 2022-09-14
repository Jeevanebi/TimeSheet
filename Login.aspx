<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TimeSheet.Pages.Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible">
    <title>Timesheet Login</title>
    <!--Favicon-->
    <link rel="icon" href="favicon.ico" />

    <!-- jQuery 3 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <!-- Google Font -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <!-- CSS -->
    <link href="Stylesheet.css" rel="stylesheet" />

    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous" />

    <!-- Javascript-->
    <script type="text/javascript" src="JavaScript.js"></script>

    <!-- Load the JS SDK asynchronously -->
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>


</head>
<body>
    <div class="parent login wrapper">
        <%--Page left--%>
        <form class="form-left" runat="server">
            <asp:ScriptManager runat="server" ID="Login_ScriptM"></asp:ScriptManager>
            <div class="logo">
                <a href="Login.aspx">
                    <img src="IMG/logo.png" /></a>
            </div>
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="form">
                        <label style="font-weight: 500; font-size: 20px;">
                            Sign In</label>

                        <div class="container">
                            <lable style="margin-top: 0px;">Username</lable><%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Enter the Username" ControlToValidate="user_name" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            <label style="font-size: small; color: black;">
                                <asp:TextBox ID="user_name" CssClass="inputarea" runat="server" class="txtusername" placeholder="Enter Username or Email" TextMode="Email"></asp:TextBox>
                            </label>
                            <lable>Passowrd</lable>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Enter the Passowrd" ControlToValidate="user_psw"></asp:RequiredFieldValidator>--%>
                            <asp:TextBox ID="user_psw" type="password" CssClass="inputarea" runat="server" placeholder="Enter password" TextMode="Password" />

                            <div class="wrong-password" id="wrong_passord" runat="server">
                                <table class="wrong-password-tbl">
                                    <tr>
                                        <td>
                                            <span><i class='bx bx-error-circle'></i></span>
                                        </td>
                                        <td>
                                            <span>Invalid Login Creditionals</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="btn">
                                <asp:Button ID="Login_btn" runat="server" CssClass="btnsubmit inputarea" Text="Sign In" OnClick="Login_btn_Click1" CausesValidation="False" UseSubmitBehavior="False" ViewStateMode="Disabled" />
                            </div>



                            <div>
                                <label style="font-size: small; color: black;">or sign in with</label>
                                <div class="links">
                                    <asp:LinkButton ID="GoogleAPI_btn" runat="server" Text="<i class='bx bxl-google'></i>" OnClick="GoogleAPI_btn_Click"></asp:LinkButton>
                                    <asp:LinkButton ID="MicrosoftAPI_btn" runat="server" Text="<i class='fab fa-windows'></i>" OnClick="MicrosoftAPI_btn_Click"></asp:LinkButton>
<%--                                    <asp:LinkButton ID="GitAPI_btn" runat="server" Text="<i class='bx bxl-github'></i>" OnClick="GitAPI_btn_Click"></asp:LinkButton>                                    --%>
                                </div>
                            </div>
                            <br />

                            <div class="forgot">
                                <span><a href="Forgot_page.aspx">Forgot password?</a></span>
                                <span>don't have an account? <a href="Sign_up.aspx">Sign up</a></span>
                            </div>
                        </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </form>

    </div>

    <%--Page Right--%>

    <div class="right">
        <image src="/IMG/Sign_in.png" />
    </div>

</body>
</html>
