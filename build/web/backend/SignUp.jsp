<%-- 
    Document   : SignUp
    Created on : Apr 6, 2017, 4:27:21 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="sys.classes.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farmers Epidemic System Sign Up</title>
        <!--css links-->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon"/>
        <style type="text/css">
            input[type=file]{
                padding:10px;
            }
        </style>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <script language="javascript" type="text/javascript">

            function checkNumber() {
                //PHONE REGEX 
                var phoneno = /^\+\d{12}$/;
                if ((document.getElementById('user-phone').value.match(phoneno))) {
                    document.getElementById('help2').innerHTML = "";
                } else {
                    document.getElementById('help2').innerHTML = "Incorrect Phone: start +254";
                }
            }

            function checkLength() {
                //password length
                if ((document.getElementById('user-password').value).length < 6) {
                    document.getElementById('help2').innerHTML = "Password too short";
                } else {
                    document.getElementById('help2').innerHTML = "";
                }
            }
            function checkMatch(inputPass) {
                // pass dont match error
                if (inputPass.value !== document.getElementById('user-password').value) {
                    document.getElementById('help2').innerHTML = "Password Don't Match";
                } else {
                    //valid match
                    document.getElementById('help2').innerHTML = "";
                }
            }

            function initAutocomplete() {
                var autocomplete = new google.maps.places.Autocomplete(document.getElementById('user-search'));
                google.maps.event.addListener(autocomplete, 'place_changed', function () {
                    var place = autocomplete.getPlace();
                    document.getElementById("lat").value = place.geometry.location.lat();
                    document.getElementById("lng").value = place.geometry.location.lng();
                });
            }
            ;
        </script>
    </head>
    <body>
        <%
            Error_class user_error = (Error_class) request.getAttribute("signupErr");
            if (user_error == null) {
                user_error = new Error_class();
            }
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
                    <h2 class="text-center">Farmer Sign Up</h2>
                    <p class="text-center">Please fill in your Details Correctly:
                    </p>
                    <p class="text-center"><span class="text-danger"><%= user_error.getErrorMessage()%></span></p>
                </div>
                <!--login form-->
                <div class="panel panel-signup">
                    <div class="panel-body">
                        <form class="form account-form" method="post" action="SignUp">
                            <div class="">
                                <div class="form-group">
                                    <input type="text" name="user-full-name" class="form-control" id="user-email" placeholder="Full Name" tabindex="1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="email" name="user-email" class="form-control" id="user-email" placeholder="Email Address" tabindex="1">
                                    </div> <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="user-phone" class="form-control" id="user-phone" placeholder="Phone Contact (+254)" oninput="checkNumber(this)"tabindex="1">
                                    </div> <!-- /.form-group -->
                                </div>
                            </div> <!-- /.row -->
                            <div class="row">
                                <span class="help-block hidden" style=""id="help1">6 characters: mix Capital,Numbers,alphanumerics</span>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="user-password" class="form-control" placeholder="Password" id="user-password" oninput="checkLength()"tabindex="1">
                                    </div> <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="user-con-password" class="form-control" placeholder="Confirm Password" id="user-con-password" oninput="checkMatch(this)"  tabindex="1">
                                    </div> <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="user-search" class="form-control" placeholder="Search Location" id="user-search" tabindex="1">
                                    </div> <!-- /.form-group --> 
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group" >
                                        <span class="pull-right">Already have an Account? <a class="btn-sign1" id="btn"href="Login.jsp"><strong>LOG IN</strong></a></span>
                                    </div>
                                    <div class="form-group">
                                        <p class="text-danger text-right" id="help2"></p>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="lat" id="lat"/>
                            <input type="hidden" name="lng" id="lng"/>
                            <input type="hidden" name="reg_date" value="<%= (new java.util.Date().toLocaleString())%>"/>

                            <div class="form-group" style="margin-top: 10px;">
                                <button type="submit" class="btn btn-success btn-block btn-lg" tabindex="4">
                                    Sign Up <span class="glyphicon glyphicon-check" style="margin-left: 10px;"></span></i>
                                </button>
                            </div> <!-- /.form-group -->
                        </form>                    
                    </div>
                </div>
            </div>
        </div>

        <!--end form-->

        <!-- Footer -->
        <footer class="">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>

        <script type="text/javascript">
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#blah')
                                .attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }


        </script>
        <script type="text/javascript" src="../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../assets/js/bootstrap.js"></script>

    </body>
</html>
