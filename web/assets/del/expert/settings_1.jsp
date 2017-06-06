<%-- 
    Document   : settings
    Created on : Apr 14, 2017, 9:58:18 PM
    Author     : Michael Mukolwe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sys.classes.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; EXPERT SETTINGS</title>
        <!--css links-->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
        <%@page import="sys.classes.*,sys.servlets.*" %>
        <%
            //create database object
            DB_class DB = new DB_class();

            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
            String user_email = user.getUserEmail();
            //or
            String user_mail = request.getParameter("user_email");
            if (user_mail == null) {
                user_mail = user.getUserEmail();
            }

            //get account status
            int accStatus = DB.getAccountStatus(user_email, DB.getAuthKey(user_email));

            //error + success messages displayed after update
            Error_class user_error = (Error_class) request.getAttribute("ErrorMessage");
            if (user_error == null) {
                user_error = new Error_class();
            }
            Success_class user_sucess = (Success_class) request.getAttribute("signupSuccess");
            if (user_sucess == null) {
                user_sucess = new Success_class();
            }

        %>
    <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

    <sql:query dataSource="${bgGet}" var="reqUsers">
        <%= DB.user_Details(user_mail)%>
    </sql:query> 

    <header>
        <!--navbar one-->
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
                    <a class="navbar-brand" href="../../index.jsp"><span style="color:#5cb85c;">FEWS</span> LOGO</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <div class="dropdown navbar-right">
                        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                            Experts Action
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu " role="menu" aria-labelledby="dropdownMenu1">
                            <li role="presentation" class="text-center"><p>Signed in as <bold>username</bold></p></li>
                            <li role="presentation" class="divider"></li>   
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="ExpertDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                        </ul>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </nav>
    </header>
    <div class="container" style="margin-top: 50PX;">
        <div class="row" >
            <div class="col-md-3">
                <div class="list-group" role="tablist" id="myTab">
                    <a href="#" class="list-group-item disabled">
                        Personal Settings
                    </a>
                    <a href="#profile_setting" class="list-group-item" role="tab" data-toggle="tab">Profile</a>
                    <a href="#account_setting" class="list-group-item" role="tab" data-toggle="tab">Account</a>
                </div>
            </div>
            <!--tabs content-->
            <div class="col-md-9">
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="profile_setting">
                        <div class="panel panel-default">
                            <div class="panel-heading"style="background-color: transparent;">
                                <h3 class="panel-title">Public Profile Settings</h3>
                            </div>
                            <c:forEach var="user" items="${reqUsers.rows}">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-7">
                                            <form class="form account-form" action="Settings" method="post">
                                                <div class="form-group">
                                                    <label>Full Name:</label>
                                                    <input type="text" name="user-name" class="form-control" placeholder="Full Name" tabindex="1">
                                                </div> <!-- /.form-group -->
                                                <div class="form-group">
                                                    <label>Phone:</label>
                                                    <input type="text" name="user-phone" class="form-control" placeholder="Phone" tabindex="1">
                                                </div> <!-- /.form-group -->
                                                <div class="form-group">
                                                    <label>Expert Profession:</label>
                                                    <input type="text" name="user-profession" class="form-control" placeholder="Expert Field" tabindex="1" >
                                                </div> <!-- /.form-group -->
                                                <div class="form-group">
                                                    <label>Email Address:</label><span class="help-block">If you want to change email contact Admin</span>
                                                    <input type="text" name="user-email" class="form-control" value="${user.email}" placeholder="Email" tabindex="1"disabled>
                                                </div> <!-- /.form-group -->
                                                <input type="hidden" name="userEmail" value="<%=user.getUserEmail()%>"/>
                                                <input type="hidden" name="settingType" value="ex_prof_settings"/>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-primary" tabindex="4">
                                                        EDIT PROFILE <span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-md-5">
                                            <form class="form account-form" action="" method="">
                                                <div class="form-group">
                                                    <label>Profile Picture</label>
                                                    <div class="row">
                                                        <div class="col-xs-6 col-md-7">
                                                            <a href="#" type="file"class="thumbnail">
                                                                <img src="../../assets/img/1.jpg"alt="...">
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div> <!-- /.form-group -->

                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-default" tabindex="4">
                                                        UPDATE PICTURE<span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="account_setting">
                        <div class="panel panel-default">
                            <div class="panel-heading"style="background-color: transparent;">
                                <h3 class="panel-title">Account Settings</h3>
                            </div>
                            <div class="panel-body">
                                <h3 class="panel-title" style="">Change Password:</h3>
                            </div>
                            <div class="row">
                                <div class="col-md-8" style="margin-left: 10px;">
                                    <form action="" class="" method="">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Old Password:</label>
                                            <input type="password" name="user-email" class="form-control" id="user-email" placeholder="e.g. ******" tabindex="1">
                                        </div> <!-- /.form-group -->
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">New Password:</label>
                                            <input type="password" name="user-email" class="form-control" id="user-email" placeholder="e.g. ******" tabindex="1">
                                        </div> <!-- /.form-group -->
                                        <p class="help-block">Must be more than 6 characters</p>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">New Password:</label>
                                            <input type="password" name="user-email" class="form-control" id="user-email" placeholder="e.g. ******" tabindex="1">
                                        </div> <!-- /.form-group -->
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-primary" tabindex="4">
                                                UPDATE PASSWORD <span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                            </button>               
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading"style="background-color: transparent;">
                                <h3 class="panel-title">Delete Account</h3>
                            </div>
                            <div class="panel-body">
                                <p>Delete Account; Once deleted you will lost your details</p>
                                <form class="" action="" method="">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-danger" tabindex="4">
                                            DELETE ACCOUNT <span class="glyphicon glyphicon-off" style="margin-left: 10px;"></span></i>
                                        </button>                                
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--<div class="col-md-2 clearfix"></div>-->
        </div>
    </div>


    <!-- Footer -->
    <footer class="navbar-fixed-bottom">
        <div class="container text-center">
            <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
            <p>Terms of Services Applied</p>
        </div>
    </footer>

    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript">
        $(function () {
            $('#myTab a:last').tab('show')
        });
        function maxLength(el) {
            if (!('maxLength' in el)) {
                var max = el.attributes.maxLength.value;
                el.onkeypress = function () {
                    if (this.value.length >= max)
                        return false;
                };
            }
        }

        maxLength(document.getElementById("blog-content"));
    </script>
    <script type="text/javascript" src="../../assets/js/jquery.js"></script>
    <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>
</body>
</html>