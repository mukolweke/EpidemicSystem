<%-- 
    Document   : messages
    Created on : Apr 14, 2017, 5:15:58 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page import="sys.classes.*,java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; FARMER DASHBOARD</title>
        <!--css links-->
        <link href="../../assets/css/material.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body style="background-color: #f9f9f9;font-family:'Oxygen-Regular';" onload="notify();">
        <%@page import="sys.classes.*" %>
        <%
            DB_class db = new DB_class();

            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();
            String reply = request.getParameter("reply");

            int email_frm = db.getUserId(user_email);
            if (reply != null) {
                String msg_ = request.getParameter("msg_to");
                int msg_to = Integer.parseInt(msg_);
                db.postMsg(email_frm, msg_to, reply);
            }
            int countNotification = db.countNotifications(user_email);
            int msgCount = db.countMsg(user_email);
            int accStatus = db.getAccountStatus(user_email, db.getAuthKey(user_email));

        %>
        <sql:setDataSource var='bgGet' driver='<%= db.jstlDriver()%>' url='<%= db.jstlUrl()%>' user='<%= db.jstlUser()%>'  password='<%= db.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqMsg">
            <%= db.getAllMsg(user_email)%>
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
                    <div class="collapse navbar-collapse" id="">
                        <div class="dropdown navbar-right">

                            <ul class="nav navbar-nav">
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"><%=countNotification%></span></a></li>
                                <li class="" ><a href="messages.jsp" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span> <%=msgCount%></a></li>
                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user_.getUserEmail()%>
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
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </header>
        <div class="container" style="">
            <div class="row" >
                <div class="col-md-2 clearfix"></div>
                <div class="col-md-8">
                    <!--check if account is confirmed to view message or not-->
                    <input type="number" class="hidden" value="<%=accStatus%>" id='acc'/>
                    <!--confirmation message-->
                    <div class="alert alert-warning" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>

                    <div class="panel" style="margin-top: 50px;background-color: #f9f9f9;">
                        <div class="panel-heading" style="background-color: transparent;">
                            <h2 class="panel-title" style="font-size: 20px;">Messages :</h2>
                        </div>
                        <div class="panel-body" style="margin-left: 5px;">
                            <div class="row">
                                <c:forEach var="msg" items="${reqMsg.rows}">
                                    <div class="media">
                                        <div class="col-md-3">
                                            <a class="" href="#">
                                                <img class="img img-responsive" src="../../assets/img/default.svg" alt="epidemic photo" style="width: 100%;height: 100%;">
                                            </a>
                                        </div>
                                        <div class="col-md-9">
                                            <p>${msg.msg} 
                                                <a  data-toggle="collapse" data-parent="#accordion" href="#collapseReply">Reply </a>
                                            </p>
                                            <div id="collapseReply" class="panel-collapse collapse" style="margin: 0 auto;">
                                                <div class="panel-body">
                                                    <form action="messages.jsp" method="post">
                                                        <input type="hidden" name="msg_to" value="${msg.to_id}"/>
                                                        <div class="form-group">
                                                            <input name="reply" type="text"  style="height: 40px;width: 100%"required/>
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="submit" value="reply" style="border-radius: 0px; width: 100%;"class="btn btn-success"/>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div> 
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 clearfix"></div>
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
            function notify() {
                if (document.getElementById("not").value !== "0") {
                    document.getElementById("not").style.color = "#FF6666";
                } else if (document.getElementById("not").value === "0") {
                    document.getElementById("not").style.color = "yellow";
                }

                //check if account is confirmed
                if (document.getElementById("acc").value === "0") {
                    document.getElementById("alert_status").style.display = "block";
                } else if (document.getElementById("acc").value === "1") {
                    document.getElementById("alert_status").style.display = "none";
                }
            }
        </script>
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>
    </body>
</html>