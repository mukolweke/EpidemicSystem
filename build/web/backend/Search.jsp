<%-- 
    Document   : Search
    Created on : Apr 27, 2017, 10:33:45 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sys.classes.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &centerdot; Search Page</title>

        <!--css links-->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon">
        <script>
            var request = new XMLHttpRequest();
            function searchInfo() {
                var name = document.vinform.inputSearch.value;
                var url = "filter.jsp?val=" + name;
                try {
                    request.onreadystatechange = function () {
                        if (request.readyState === 4) {
                            var val = request.responseText;
                            document.getElementById('mylocation').innerHTML = val;
                        }
                    };//end of function
                    request.open("GET", url, true);
                    request.send();
                } catch (e) {
                    alert("Unable to connect to server");
                }
            }
        </script>
    </head>

    <%
        //database object
        DB_class DB = new DB_class();
        //get the search filter value
        String search_filter = (String) request.getAttribute("search_filter");
        if (search_filter == null) {
            search_filter = "";
        }

        Login_class user = (Login_class) session.getAttribute("user");
        if (user == null) {
            user = new Login_class();
        }
    %>
    <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

    <sql:query dataSource="${bgGet}" var="reqSearch">
        <%= DB.searchEpidemic(search_filter)%>
    </sql:query>

    <body style="font-family: 'Oxygen-Regular';">
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

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                    <ul class="nav navbar-nav">
                        <li class="hidden">
                            <a href="#page-top"></a>
                        </li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <%
                            if (request.getSession().getAttribute("user") == null) {
                        %>

                        <ul class="nav navbar-nav ">
                            <li><a href="SignUp.jsp"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px;"></span>FARMER SIGN UP</a></li>
                            <li><a href="Login.jsp"><span class="glyphicon glyphicon-log-in" style="margin-right: 5px;"></span> LOGIN</a></li>
                        </ul>
                        <%
                        } else {
                            if (DB.getAuthKey(user.getUserEmail().toString()) == 1) {
                        %>

                        <div class="dropdown navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"></span></a></li>
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span></a></li>

                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user.getUserEmail()%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="admin/AdminDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="admin/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="admin/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="admin/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                        } else if (DB.getAuthKey(user.getUserEmail().toString()) == 2) {
                        %>
                        <div class="dropdown navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"></span></a></li>
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span></a></li>

                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user.getUserEmail()%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="expert/ExpertDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="expert/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="expert/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="expert/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                        } else if (DB.getAuthKey(user.getUserEmail().toString()) == 3) {
                        %>
                        <div class="dropdown navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"></span></a></li>
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span></a></li>

                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user.getUserEmail()%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="farmer/FarmerDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="farmer/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="farmer/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="farmer/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                                }
                            }
                        %>
                    </ul>

                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <!--main section-->
        <div class="container" style="margin-top: 50px;">
            <div class="row">
                <div class="col-md-3 hidden-sm hidden-xs">
                    <div class="" style="background-color: transparent;">
                        <h2 class="panel-title" style="font-size: 30px;margin-top: 20px;"><i style="margin-right: 10px;font-size: 40px;" class="fa fa-search"></i>Search ...</h2>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="panel">
                        <div class="panel-body">
                            <form action="Search" name="vinform" class="form">
                                <input type="hidden" name="searchFrom" value="mainSearch"/>
                                <div class='row'>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <input type="text" class="form-control input-search" name="inputSearch" placeholder="Search Epidemic?" onkeyup="searchInfo()" required>
                                        </div><!-- /input-group -->
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <button type="submit" class="btn disabled btn-success btn-search" style="font-size: 20px;"><span class="glyphicon glyphicon-search"></span></button>
                                        </div><!-- /input-group -->
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <div style="margin-top: 50px;">
                        <span id="mylocation"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--end content-->
        <!-- Footer -->
        <footer class="navbar-fixed-bottom">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>    

        <script type="text/javascript" src="../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../assets/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../assets/js/custom.js"></script>
        <script type="text/javascript" src="../assets/js/paginate.js"></script>
    </body>
</html>
