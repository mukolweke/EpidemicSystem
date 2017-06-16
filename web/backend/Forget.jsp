<%-- 
    Document   : Forget
    Created on : Apr 6, 2017, 5:29:19 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farmers Epidemic System Forget</title>

        <!--css links-->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body>
        <%@page import="sys.classes.*" %>
        <%
            Error_class user_error = (Error_class) request.getAttribute("signupErr");
            if (user_error == null) {
                user_error = new Error_class();
            }
            String emailForget = request.getParameter("signupSuccess");
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
                    <a class="navbar-brand" href="../index.jsp"><span><img src="../assets/img/favicon.png" style="height: 40px;width: 50px;"></span>FARMERS EPIDEMIC SYSTEM </a>
                </div>
            </div><!-- /.container-fluid -->
        </nav>
        <!--end nav-->
        <!--main content-->
        <%            if (emailForget == null) {
        %>
        <div class="forget-panel">
            <div class="container">
                <div class="login-brand">
                    <h2 class="text-center">Forgot Password <i style="margin-left: 10px;font-size: 30px;" class="fa fa-gears"></i></h2>
                    <p class="text-center">A link to reset your password will be sent to your email address<br>
                        associated with your sign-in Details;
                    </p>
                    <p class="text-center"><span class="text-danger"><%= user_error.getErrorMessage()%></span></p>

                </div>
                <!--login form-->
                <div class="panel panel-login">
                    <div class="panel-body">
                        <form class="form account-form" method="POST" action="Forget">
                            <div class="form-group">
                                <input type="text" name="user-email" class="form-control" id="user-email" placeholder="Email / Username" tabindex="1">
                            </div> <!-- /.form-group -->

                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-block btn-lg" tabindex="4">
                                    Submit Email <span class="glyphicon glyphicon-send" style="margin-left: 10px;"></span></i>
                                </button>
                            </div> <!-- /.form-group -->
                        </form>                    
                        <p class="text-center">Farmer <a class="btn1" id="btn" href="SignUp.jsp">Create an Account</a> | &CenterDot; | Remember Password <a class="btn btn-sign1" id="btn"href="Login.jsp"> Log In</a></p>
                    </div>
                </div>
            </div>
        </div>

        <%} else {%>
        <div class="forget-panel">
            <div class="container">
                <div class="login-brand">
                    <i style="margin-left: 540px;" class="fa fa-5x fa-thumbs-up"></i>
                    <hr>
                    <h2 class="text-center">Reset Password</h2>
                    <p class="text-center" style="margin-top: 50px;">A link to reset your password was sent to <b><%=emailForget%></b></p>
                    <hr>
                </div>
            </div>
        </div>
        <%}%>

        <!--end main content-->
        <!-- Footer -->
        <footer>
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>
        <script type="text/javascript" src="../assets/js/bootstrap.js"></script>
        <script type="text/javascript" src="../assets/js/jquery.js"></script>
    </body>
</html>
