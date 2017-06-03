<%-- 
    Document   : Login
    Created on : Apr 6, 2017, 4:27:03 PM
    Author     : Michael Mukolwe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farmers Epidemic System | Login</title>

        <!--css links-->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body>
        <%@page import="sys.classes.*" %>
        <%
            Sign_class user_details = (Sign_class) request.getSession().getAttribute("user_details");
            if (user_details == null) {
                user_details = new Sign_class();
            }
            Error_class user_error = (Error_class) request.getAttribute("ErrorMessage");
            if (user_error == null) {
                user_error = new Error_class();
            }
            Success_class user_sucess = (Success_class) request.getAttribute("signupSuccess");
            if (user_sucess == null) {
                user_sucess = new Success_class();
            }
            //check existing user
            Cookie cookie = null;
            Cookie[] cookies = null;
            // Get an array of Cookies associated with this domain
            cookies = request.getCookies();

        %>
        <nav class="navbar navbar-primary navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../index.jsp"><span style="color:#5cb85c;">FEWS</span> LOGO</a>
                </div>
            </div><!-- /.container-fluid -->
        </nav>
        <div class="main-panel">
            <div class="container">
                <div class="login-brand">
                    <h2 class="text-center">Log In</h2>
                    <p class="text-center"><span class="text-danger" style="margin-bottom: 30px;"><%= user_error.getErrorMessage()%></span></p>
                    <p class="text-center"><span class="text-success" style="margin-bottom: 30px;"><%= user_sucess.getUserSuccess()%></span></p>
                </div>
                <!--login form-->
                <%
                    if (request.getSession().getAttribute("user_details") == null) {
                %>
                <div class="panel panel-login">
                    <div class="panel-body">
                        <form class="form account-form" method="POST" action="<%=response.encodeUrl("Login")%>">
                            <div class="form-group">
                                <input type="text" name="user-email" class="form-control" id="user-email" placeholder="Email / Username" tabindex="1">
                            </div> <!-- /.form-group -->

                            <div class="form-group">
                                <!--have a collapse panel with one email filed form for the forget pass-->
                                <input type="password" name="user-password" class="form-control" placeholder="Password" id="user-password" tabindex="2">
                            </div> <!-- /.form-group -->
                            <div class="form-group" >
                                <label for="rememberme" style="margin-bottom: 40px;"><input type="checkbox" id="rememberme" name="rememberme" style="margin-right: 10px;" value="remeber">Remember me </label><span class="pull-right"><a href="Forget.jsp" class="btn" id="btn">Forgot Password ?</a></span>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-block btn-lg" tabindex="4">
                                    Log In <span class="glyphicon glyphicon-log-in" style="margin-left: 10px;"></span></i>
                                </button>
                            </div> <!-- /.form-group -->
                        </form>                    
                        <p>Don't Have an account (FARMER) ? <a class="btn-sign1" id="btn"href="SignUp.jsp">Create an Account</a></p>
                    </div>
                </div>
                <%
                } else {
                %>
                <div class="panel panel-login">
                    <div class="panel-body">
                        <form class="form account-form" method="POST" action="<%=response.encodeUrl("Login")%>">
                            <div class="form-group">
                                <input type="text" name="user-email" class="form-control" id="user-email" value="<%=user_details.get_user_email()%>" tabindex="1">
                            </div> <!-- /.form-group -->

                            <div class="form-group">
                                <!--have a collapse panel with one email filed form for the forget pass-->
                                <input type="password" name="user-password" class="form-control" value="<%=user_details.get_user_pass()%>" id="user-password" tabindex="2">
                            </div> <!-- /.form-group -->
                            <div class="form-group" >
                                <label for="rememberme" style="margin-bottom: 40px;"><input type="checkbox" id="rememberme" style="margin-right: 10px;" value="remeber">Remember me </label><span class="pull-right"><a href="Forget.jsp" class="btn" id="btn">Forgot Password ?</a></span>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-block btn-lg" tabindex="4">
                                    Log In <span class="glyphicon glyphicon-log-in" style="margin-left: 10px;"></span></i>
                                </button>
                            </div> <!-- /.form-group -->
                        </form>                    
                        <p>Don't Have an account (FARMER) ? <a class="btn-sign1" id="btn"href="SignUp.jsp">Create an Account</a></p>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!--end form-->

        <!-- Footer -->
        <footer>
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>
        <script type="text/javascript" src="../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../assets/js/bootstrap.js"></script>
    </body>
</html>
