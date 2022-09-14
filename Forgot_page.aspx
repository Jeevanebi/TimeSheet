<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgot_page.aspx.cs" Inherits="TimeSheet.Forgot_page" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible">
    <title>Timesheet Login</title>
    <!--Favicon-->
    <link rel="icon" href="favicon.ico" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Google Font -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <!-- CSS -->
    <link href="Stylesheet.css" rel="stylesheet" />
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <!-- jQuery 3 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <!-- Javascript-->
    <script type="text/javascript" src="JavaScript.js"></script>


</head>
<body>
    <div class=" parent login wrapper">
        <%--Page left--%>
        <form class="form-left" runat="server">
            <div class="logo">
                <img src="IMG/logo.png" />
            </div>
            <div class="form">
                <label style="font-weight: 500; font-size: 20px;">
                    Forgot password</label>
                <div class="container">
                    <div id="reset_div" runat="server" class="reset-div">
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button runat="server" OnClick="email_switch_Click" CssClass="btnsubmit inputarea" Style="margin-left: 0px" Text="via Email" UseSubmitBehavior="False" />
                                    </td>
                                    <td>
                                        <asp:Button runat="server" OnClick="mobile_switch_Click" CssClass="btnsubmit inputarea" Style="margin-left: 10px" Text="via Mobile" />
                                    </td>
                                </tr>
                            </table>

                        </div>



                        <div>
                            <div id="error_text" runat="server" class="error-text">
                                <i class='bx bx-error'></i><span>Invalid Authentication</span>
                            </div>
                            <!--Email-->
                            <div id="collapse_email" runat="server">
                                <lable>Email ID</lable>
                                <label style="font-size: small; color: black;">
                                    <asp:TextBox ID="forgot_email" CssClass="inputarea" runat="server" class="txtusername" placeholder="Enter Email Id" TextMode="Email"></asp:TextBox>
                                </label>
                                <br />
                                <br />
                                <lable>Employee ID</lable>
                                <label style="font-size: small; color: black;">
                                    <asp:TextBox ID="forgot_empId" CssClass="inputarea" runat="server" class="txtusername" placeholder="Enter Employee Id"></asp:TextBox>
                                </label>
                                <div class="btn">
                                    <asp:Button ID="email_btn" runat="server" CssClass="btnsubmit inputarea" Text="Send code" OnClick="email_btn_Click" />
                                </div>
                            </div>

                            <!--Phone-->
                            <div id="collapse_mobile" runat="server">
                                <lable>Mobile Number</lable>
                                <asp:TextBox ID="forgot_mobile" CssClass="inputarea" runat="server" placeholder="Enter Mobile number" TextMode="Phone" />
                                 <br />
                                <br />
                                <lable>Employee ID</lable>
                                <label style="font-size: small; color: black;">
                                    <asp:TextBox ID="forgot_empId_mobile" CssClass="inputarea" runat="server" class="txtusername" placeholder="Enter Employee Id"></asp:TextBox>
                                </label>
                                <div class="btn">
                                    <asp:Button ID="mobile_btn" runat="server" CssClass="btnsubmit inputarea btnforgot" Text="Send OTP" OnClick="mobile_btn_Click" />
                                </div>
                            </div>
                        </div>

                        <!--Sent Success-->
                        <%--Email--%>
                        <div id="email_success" runat="server" style="width: 450px">
                            <label>Email sent Successfully to  </label>
                            &nbsp<asp:Label ID="iblemail" Style="color: var(--blue)" runat="server" />
                            <asp:TextBox ID="email_OTP" runat="server" CssClass="inputarea" MaxLength="8" Wrap="False" placeholder="Enter the code"></asp:TextBox>
                            <asp:Button ID="eOTP_sucess_btn" runat="server" CssClass="btnsubmit inputarea btnforgot" Text="Verify Code" OnClick="eOTP_sucess_btn_Click" />
                            <%--mail error--%>
                            <div class="wrong-password" id="wrong_email_code" runat="server">
                                <table class="wrong-password-tbl">
                                    <tr>
                                        <td>
                                            <span><i class='bx bx-error-circle'></i></span>
                                        </td>
                                        <td>
                                            <div class="invalid-code">
                                                <span>Invalid Reset Code </span>
                                                <asp:Button runat="server" OnClick="email_btn_Click" Text="Resend ?" />
                                            </div>
                                        </td>

                                    </tr>
                                </table>
                            </div>
                        </div>
                        <%--mobile--%>
                        <div id="mobile_success" runat="server" style="width: 450px">
                            <label>OTP sent Successfully to +91 </label>
                            <asp:Label ID="iblmobile" runat="server"  style="color:var(--blue);"/>
                            <asp:TextBox ID="mobile_OTP" runat="server" class="inputarea" MaxLength="6" Wrap="False" TextMode="Phone" placeholder="Enter the OTP"></asp:TextBox>
                            <asp:Button ID="mOTP_sucess_btn" runat="server" CssClass="btnsubmit inputarea btnforgot" Text="Verify OTP" OnClick="mOTP_sucess_btn_Click" />
                            <%--mobile error--%>
                            <div class="wrong-password" id="wrong_mobile_code" runat="server">
                                <table class="wrong-password-tbl">
                                    <tr>
                                        <td>
                                            <span><i class='bx bx-error-circle'></i></span>
                                        </td>
                                        <td>
                                            <div class="invalid-code">
                                            <span>Invalid OTP</span>
                                            <asp:Button runat="server" OnClick="mobile_btn_Click" Text="Resend ?" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div>
                        <asp:CompareValidator runat="server" style="display:block" ControlToCompare="reset_NPWD_txt" ControlToValidate="reset_RNPWD_txt" Display="Dynamic"  CssClass="error-text" ErrorMessage="<i class='bx bx-error'></i> Password Does not match"></asp:CompareValidator>
                    </div>
                    <div id="reset_visible_div" runat="server" style="margin-top: 25px;">
                        <div>
                            <lable>New Password</lable><br />
                            <asp:TextBox runat="server" ID="reset_NPWD_txt" CssClass="inputarea" placeholder="Enter the New Password"></asp:TextBox>
                        </div>
                        <br />
                        <div>
                            <label style="color:black">Re-Enter the New Password</label><br />
                            <asp:TextBox runat="server" ID="reset_RNPWD_txt" CssClass="inputarea" TextMode="Password" placeholder="Re-Enter the New Password"></asp:TextBox>
                        </div>
                        <br />
                        <div class="btn">
                            <asp:Button runat="server" Text="Reset" ID="reset_pwd_btn" CssClass="btnsubmit inputarea"  OnClick="reset_pwd_btn_Click"/>
                        </div>
                    </div>
                    <!--footer-->
                    <div id="remember_login" runat="server" class="footer">
                        <label style="font-size: small; color: black;">Remember Creditionals?</label>
                        <a href="Login.aspx">Log in?</a>
                    </div>
                </div>
                <div id="psd_reset_success" runat="server" style="width:300px;">
                    <div class="error-text">
                    <i class='bx bx-check bx-tada' style="color:green; font-size:larger;"></i>
                    <span>Your Password Reset is Successfull</span>
                    </div>
                    <div>
                         <asp:Button runat="server" Text="Login" CssClass="btnsubmit inputarea" ID="nav_login_btn" OnClick="nav_login_btn_Click"/>
                    </div>
                </div>
            </div>
        </form>

        <%--Page Right--%>

        <div class="right">
            <image src="/IMG/Sign_in.png" />
        </div>

        <%--  <%-- <!-- Script Links -->
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Dropify/0.2.2/js/dropify.min.js"></script>--%>
    </div>

</body>
</html>
