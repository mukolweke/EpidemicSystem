<%-- 
    Document   : Search
    Created on : Apr 27, 2017, 10:33:45 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sys.classes.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &centerdot; Search Page</title>

        <!--css links-->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon">
    </head>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%
        //database object
        DB_class DB = new DB_class();
        //get the search filter value
        String search_filter = (String) request.getAttribute("search_filter");
        if (search_filter == null) {
            search_filter = "";
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
                    <a class="navbar-brand" href="../index.jsp"><span style="color:#5cb85c;">FEWS</span> LOGO</a>
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
                            <li><a href="SignUp.jsp"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px;"></span> SIGN UP</a></li>
                            <li><a href="Login.jsp"><span class="glyphicon glyphicon-log-in" style="margin-right: 5px;"></span> LOGIN</a></li>
                        </ul>
                        <%
                        } else {
                        %>
                        <div class="dropdown navbar-right">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                User Action
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="FarmerDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
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
                        <h2 class="panel-title" style="font-size: 30px;margin-top: 20px;">Search </h2>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="panel">
                        <div class="panel-body">
                            <form action="Search" method="post" class="form">
                                <input type="hidden" name="searchFrom" value="mainSearch"/>
                                <div class='row'>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <input type="text" class="form-control input-search" name="inputSearch" placeholder="Search what?" required>
                                        </div><!-- /input-group -->
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-success btn-search" style="font-size: 20px;"><span class="glyphicon glyphicon-search"></span></button>
                                        </div><!-- /input-group -->
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <div class="panel">
                        <div class="">
                            <p class="panel-title" style="font-size: 15px;padding-left: 15px;"><%=DB.searchZero(search_filter)%> articles found </p>
                        </div>
                        <hr>
                        <div class="panel-body">
                            <%
                                if (request.getAttribute("search_filter") == null | DB.searchZero(search_filter)== 0) {
                            %>
                            <div class="alert alert-info" role="alert">zero search result on the topic...<span><a href="http://www.google.com/" target="_blank"> try google.com</a></span> </div>
                            <%
                            } else {
                            %>
                            <c:forEach var="search" items="${reqSearch.rows}">

                                <div class="">
                                    <div class="media">
                                        <a class="pull-left" href="#">
                                            <img class="media-object well well-sm" src="..." alt="epidemic photo" style="width: 80px;height: 100px;margin-right: 20px;">
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><c:out value="${search.post_title}"/></h4>
                                            <p><c:out value="${search.post_timestamp}"/></p>
                                            <p><c:out value="${search.post_desc}"/> 
                                                <a href="#">Read Profile</a></p>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                            </c:forEach>
                            <%
                                }
                            %>
                        </div>

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
        <script type="text/javascript" src="../assets/js/bootstrap.js"></script>
    </body>
</html>
