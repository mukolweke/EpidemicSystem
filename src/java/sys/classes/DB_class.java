package sys.classes;

import java.io.Serializable;
import java.sql.*;

/**
 *
 * @author Michael Mukolwe
 */
public class DB_class implements Serializable {

    private static Connection connection;

    //Jstl SQL Connector
    public String jstlDriver() {
        return "com.mysql.jdbc.Driver";
    }

    public String jstlUrl() {
        return "jdbc:mysql://localhost:3306/farmer_sys_db";
    }

    public String jstlUser() {
        return "root";
    }

    public String jstlPassword() {
        return "";
    }

//    create connection
    public void newConn() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmer_sys_db", "root", "");
    }

    //add new farmer
    public int addUser(String user_email, String user_passcode, String userType) throws Exception {

        newConn();
        switch (userType) {
            case "admin": {
                int auth_key = 1;
                Statement stmt = connection.createStatement();
                return stmt.executeUpdate("INSERT INTO user VALUES (null,'" + user_email + "','" + user_passcode + "','" + auth_key + "')");
            }
            case "expert": {
                int auth_key = 2;
                Statement stmt = connection.createStatement();
                return stmt.executeUpdate("INSERT INTO user VALUES (null,'" + user_email + "','" + user_passcode + "','" + auth_key + "')");
            }
            case "farmer": {
                int auth_key = 3;
                Statement stmt = connection.createStatement();
                return stmt.executeUpdate("INSERT INTO user VALUES (null,'" + user_email + "','" + user_passcode + "','" + auth_key + "')");
            }
            default:
                break;
        }
        return 0;
    }

    //check if user exists
    public String checkUser(String email, String checkType) throws Exception {
        newConn();
        Statement stmt = connection.createStatement();
        switch (checkType) {
            case "email": {
                ResultSet rs = stmt.executeQuery("SELECT email FROM user WHERE email='" + email + "'");
                rs.next();
                return rs.getString("email");
            }
            case "pass": {
                ResultSet rs = stmt.executeQuery("SELECT password FROM user WHERE email='" + email + "'");
                rs.next();
                return rs.getString("password");
            }
            default:
                break;
        }
        return null;
    }

    //add new farmer
    public int addFarmer(String full_name, String user_email, String user_phone, String user_passcode, String location, String lat, String lng, String reg_date) throws Exception {
        double latDouble = Double.parseDouble(lat);
        double lngDouble = Double.parseDouble(lng);
        newConn();
        Statement stmt = connection.createStatement();
        addUser(user_email, user_passcode, "farmer");
        return stmt.executeUpdate("INSERT INTO farmer VALUES (null,'" + full_name + "','" + user_email + "','" + user_phone + "','" + user_passcode + "','" + location + "','" + latDouble + "','" + lngDouble + "', 0,'" + reg_date + "')");
    }

    //add new expert
    public int addExpert(String fullName, String email, String phone, String fieldStudy, String passcode, String city, String lat, String lng, String regDate, String userType) throws Exception {
        double latDouble = Double.parseDouble(lat);
        double lngDouble = Double.parseDouble(lng);
        newConn();
        Statement stmt = connection.createStatement();
        addUser(email, passcode, userType);
        return stmt.executeUpdate("INSERT INTO expert VALUES (null,'" + fullName + "','" + email + "','" + phone + "','" + fieldStudy + "','" + passcode + "','" + city + "','" + latDouble + "','" + lngDouble + "', 0 ,'" + regDate + "')");
    }

    //User login
    public int userLogin(String user_email, String user_pass) throws SQLException, Exception {
        newConn();
        int acctype = getAuthKey(user_email);
        //staus of account
        if (getAccountStatus(user_email, acctype) == 3) {
            int account_inactive = 4;
            return account_inactive;
        } else {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT auth_key FROM user WHERE email='" + user_email + "' and password='" + user_pass + "'");
            rs.next();
            return rs.getInt("auth_key");
        }
    }

    //account verified or not
    public int getAccountStatus(String user_email, int acctype) throws SQLException, Exception {
        newConn();
        switch (acctype) {
            case 1: {
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT status FROM admin WHERE email='" + user_email + "'");
                rs.next();
                return rs.getInt("status");
            }
            case 2: {
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT status FROM expert WHERE email='" + user_email + "'");
                rs.next();
                return rs.getInt("status");
            }
            case 3: {
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT status FROM farmer WHERE email='" + user_email + "'");
                rs.next();
                return rs.getInt("status");
            }
            default:
                break;
        }
        return 0;
    }
    //account authentication key

    public int getAuthKey(String email) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT auth_key FROM user WHERE email ='" + email + "'");
        rs.next();
        return rs.getInt("auth_key");

    }

    //   post the question
    public int postQuestion(int user, String blog_title, String blog_desc, double lat, double lng, String blog_date) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();

        return stmt.executeUpdate("INSERT INTO post_epidemic VALUES(null,'" + user + "','" + blog_title + "','" + blog_desc + "'," + lat + "," + lng + ",'" + blog_date + "')");

    }

    //send email
    public int sendEmail(String from, String to, int msg, String type, String blog_date) throws Exception {
        newConn();
        Statement stmt = connection.createStatement();
        if (type.equals("post")) {
            return stmt.executeUpdate("INSERT INTO email VALUES(null,'" + to + "','" + from + "','New Post'," + msg + ",0,'" + blog_date + "')");
        } else {
            return stmt.executeUpdate("INSERT INTO email VALUES(null,'" + to + "','" + from + "','New Message'," + msg + ",0,'" + blog_date + "')");

        }
    }
    //get the message/post id
    public String getEmailMsg(String user_email)throws SQLException, Exception{
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs1 = stmt.executeQuery("SELECT email_msg FROM email WHERE email_to= '" + user_email + "'");
        rs1.next();
        return rs1.getString("email_msg");
    }
    //count users email
    public int countEmail(String user_email)throws SQLException, Exception{
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(email_id) AS email_count FROM email WHERE email_to= '" + user_email + "'");
        rs1.next();
        return rs1.getInt("email_count");
    }
    //update status
    public int updateEmail(int postid)throws SQLException, Exception{
        newConn();
        Statement stmt = connection.createStatement();
        return stmt.executeUpdate("UPDATE email SET email_status = 1 WHERE email_msg = " + postid);
    }
            //get nearby farmers
    public String getFarmerNear(int userId) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        String mail = getUserEmail(userId);
        double lat = getLat(mail, "farmer");
        ResultSet rs1 = stmt.executeQuery("SELECT email FROM farmer WHERE lat= " + lat + " AND farmer_id != " + userId);
        rs1.next();
        return rs1.getString("email");
    }

    //get specific post
    public int getQuestion(int user_id, String notf_type, String blog_date) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT post_id FROM post_epidemic WHERE user_id = " + user_id + " AND post_title ='" + notf_type + "' AND reg_date ='" + blog_date + "';");
        rs.next();
        return rs.getInt("post_id");
    }
//   post the comment

    public int postComment(String postId, int userId, String comm_desc, String blog_date) throws SQLException, Exception {
        int postid = Integer.parseInt(postId);
        newConn();
        Statement stmt = connection.createStatement();
        return stmt.executeUpdate("INSERT INTO comment_epidemic VALUES(null,'" + userId + "','" + postid + "','" + comm_desc + "','" + blog_date + "')");

    }

    //Select all Blog Post
    public String blogsPosted() {
        return "SELECT * FROM post_blog";
    }

    //Select all epidemic Post
    public String postPosted() {
        return "SELECT * FROM post_epidemic";
    }

    //get all experts
    public String getExpert() {
        return "SELECT * FROM expert";
    }
//    get all farmers

    public String getFarmer() {
        return "SELECT * FROM farmer";
    }

    //get user details
    public String user_Details(String email) throws Exception {
        switch (getAuthKey(email)) {
            case 1:
                return "SELECT * FROM admin WHERE email='" + email + "'";
            case 2:
                return "SELECT * FROM expert WHERE email='" + email + "'";
            case 3:
                return "SELECT * FROM farmer WHERE email='" + email + "'";
            default:
                break;
        }
        return "";
    }

    public int getUserId(String mail) throws SQLException, Exception {
        newConn();

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT user_id FROM user WHERE email='" + mail + "'");
        rs.next();
        return rs.getInt("user_id");
    }

    public String getUserEmail(int user_id) throws SQLException, Exception {
        newConn();

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT email FROM user WHERE user_id=" + user_id);
        rs.next();
        return rs.getString("email");
    }

    public String getUserName(int post_id) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT user_id FROM post_epidemic WHERE post_id=" + post_id);
        rs.next();
        int user_id = rs.getInt("user_id");
        ResultSet rs1 = stmt.executeQuery("SELECT name FROM farmer WHERE farmer_id=" + user_id);
        rs1.next();
        return rs1.getString("name");
    }

    public int updateProfile(String update, String type, String email) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();

        switch (getAuthKey(email)) {
            case 1:
                if (type.equals("name")) {
                    return stmt.executeUpdate("UPDATE admin SET name = '" + update + "' WHERE email = '" + email + "'");

                } else if (type.equals("phone")) {
                    return stmt.executeUpdate("UPDATE admin SET phone = '" + update + "' WHERE email = '" + email + "'");
                }
            case 2:
                if (type.equals("name")) {
                    return stmt.executeUpdate("UPDATE expert SET name = '" + update + "' WHERE email = '" + email + "'");
                } else if (type.equals("phone")) {
                    return stmt.executeUpdate("UPDATE expert SET phone = '" + update + "' WHERE email = '" + email + "'");
                } else if (type.equals("proff")) {
                    return stmt.executeUpdate("UPDATE expert SET field = '" + update + "' WHERE email = '" + email + "'");
                } else if (type.equals("location")) {
                    return stmt.executeUpdate("UPDATE expert SET addr = '" + update + "' WHERE email = '" + email + "'");
                }
            case 3:
                if (type.equals("name")) {
                    return stmt.executeUpdate("UPDATE farmer SET name = '" + update + "' WHERE email = '" + email + "'");
                } else if (type.equals("phone")) {
                    return stmt.executeUpdate("UPDATE farmer SET phone = '" + update + "' WHERE email = '" + email + "'");
                } else if (type.equals("location")) {
                    return stmt.executeUpdate("UPDATE farmer SET addr = '" + update + "' WHERE email = '" + email + "'");
                }
            default:
                break;
        }
        return 0;
    }

    public String getPass(String userEmail) throws SQLException, Exception {
        newConn();

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT password FROM user WHERE email='" + userEmail + "'");
        rs.next();
        return rs.getString("password");
    }

    public int updatePassword(String email, String newPass) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        switch (getAuthKey(email)) {
            case 1:
                return 0;
            case 2:
                stmt.executeUpdate("UPDATE user SET password = '" + newPass + "' WHERE email = '" + email + "'");
                stmt.executeUpdate("UPDATE expert SET password = '" + newPass + "' WHERE email = '" + email + "'");
                return 1;
            case 3:
                stmt.executeUpdate("UPDATE user SET password = '" + newPass + "' WHERE email = '" + email + "'");
                stmt.executeUpdate("UPDATE farmer SET password = '" + newPass + "' WHERE email = '" + email + "'");
                return 1;
            default:
                break;
        }
        return 0;

    }

    public int deactivateAccount(String email) throws SQLException, Exception {
        newConn();

        Statement stmt = connection.createStatement();

        return stmt.executeUpdate("UPDATE user SET auth_key = 4 WHERE email = '" + email + "'");
    }
//count farmers
    public int countFarmer() throws SQLException, Exception {
        int auth_key = 3;
        return countUser(auth_key);
    }

    public int countExperts() throws SQLException, Exception {
        int auth_key = 2;
        return countUser(auth_key);
    }

    //count from user table
    public int countUser(int auth_key) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(user_id) AS count FROM user WHERE auth_key ='" + auth_key + "'");
        rs.next();
        return rs.getInt("count");
    }

    //count posts epidemics
    public int countPost() throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(post_id) AS count FROM post_epidemic");
        rs.next();
        return rs.getInt("count");
    }

    //count posts epidemics for user
    public int countPostUser(String email) throws SQLException, Exception {
        int user_id = getUserId(email);
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(post_id) AS count FROM post_epidemic WHERE user_id = '" + user_id + "'");
        rs.next();
        return rs.getInt("count");
    }

    //count all blogs
    public int countBlogs() throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(blog_id) AS count FROM post_blog");
        rs.next();
        return rs.getInt("count");
    }

    //searching for mentions of certain epidemics
    public String searchEpidemic(String filter) {

        String query = "SELECT * from post_epidemic WHERE post_title = '" + filter + "' OR post_desc = '" + filter + "'";
        return query;
    }

    public String getPost(int postId) {
        return "SELECT * from post_epidemic WHERE post_id = " + postId;
    }

    public String getComment(int postId) {
        return "SELECT * from comment_epidemic WHERE post_id = " + postId;
    }

    public String getTitle(int postId) throws SQLException, Exception {
        if (postId == 0) {
            postId = 1;
        } else if (postId > countPost()) {
            postId = 1;
        }
        newConn();

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT post_title FROM post_epidemic WHERE post_id='" + postId + "'");
        rs.next();
        return rs.getString("post_title");
    }

    public String allTitle() {
        return "SELECT * FROM post_epidemic";
    }

    public int searchZero(String filter) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(post_id) AS postCount FROM post_epidemic WHERE post_title = '" + filter + "' OR post_desc = '" + filter + "'");
        rs.next();
        return rs.getInt("postCount");
    }

    public int countComment(int postId) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(comment_id) AS commentCount FROM comment_epidemic WHERE post_id = " + postId);
        rs.next();
        return rs.getInt("commentCount");
    }

    public String user_Posts(String user_email) throws SQLException, Exception {
        int user_id = getUserId(user_email);
        String posts = ("SELECT * FROM post_epidemic WHERE user_id = '" + user_id + "'");
        return posts;
    }

    //post a message
    public int postMsg(int email_frm, int email_to, String msg) throws SQLException, Exception {

        newConn();
        Statement stmt = connection.createStatement();
        return stmt.executeUpdate("INSERT INTO message VALUES(null,'" + email_frm + "','" + email_to + "','" + msg + "',0)");
    }

    //get a message
    public String getMsg(String email, int msgid) throws Exception, SQLException {
        int rec_id = getUserId(email);
        newConn();
        return ("SELECT * FROM message WHERE msg_id = " + msgid + " AND to_id = " + rec_id);

    }

    //get all
    public String getAllMsg(String email) throws SQLException, Exception {
        int rec_id = getUserId(email);
        newConn();
        return ("SELECT * FROM message WHERE to_id = " + rec_id);
    }

    //count unread
    public int countMsg(String email) throws SQLException, Exception {
        int rec_id = getUserId(email);
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(msg_id) AS msgCount FROM message WHERE to_id = " + rec_id + " AND msg_status = 0");
        rs.next();
        return rs.getInt("msgCount");
    }

    //update msg status
    public int updateMsg(int msg_id) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        return stmt.executeUpdate("UPDATE message SET msg_status = 1'");
    }

    //mapwork
    //get lat
    public double getLat(String email, String type) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        switch (type) {
            case "expert": {
                ResultSet rs = stmt.executeQuery("SELECT lat FROM expert WHERE email ='" + email + "'");
                rs.next();
                return rs.getDouble("lat");
            }
            case "farmer": {
                ResultSet rs = stmt.executeQuery("SELECT lat FROM farmer WHERE email ='" + email + "'");
                rs.next();
                return rs.getDouble("lat");
            }
            default:
                break;
        }
        return 0;
    }
    //get lng

    public double getLng(String email, String type) throws SQLException, Exception {
        newConn();
        Statement stmt = connection.createStatement();
        switch (type) {
            case "expert": {
                ResultSet rs = stmt.executeQuery("SELECT lng FROM expert WHERE email ='" + email + "'");
                rs.next();
                return rs.getDouble("lng");
            }
            case "farmer": {
                ResultSet rs = stmt.executeQuery("SELECT lng FROM farmer WHERE email ='" + email + "'");
                rs.next();
                return rs.getDouble("lng");
            }
            default:
                break;
        }
        return 0;
    }
    //get address

    public String getAddr(String email, String type) throws SQLException, Exception {
        newConn();

        Statement stmt = connection.createStatement();
        switch (type) {
            case "expert": {
                ResultSet rs = stmt.executeQuery("SELECT addr FROM expert WHERE email = '" + email + "'");
                rs.next();
                return rs.getString("addr");
            }
            case "farmer": {
                ResultSet rs = stmt.executeQuery("SELECT addr FROM farmer WHERE email ='" + email + "'");
                rs.next();
                return rs.getString("addr");
            }
            default:
                break;
        }
        return "";
    }

    public double postLat(int post_id) throws Exception, SQLException {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT lat FROM post_epidemic WHERE post_id =" + post_id);
        rs.next();
        return rs.getDouble("lat");
    }

    public double postLng(int post_id) throws Exception, SQLException {
        newConn();
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT lng FROM post_epidemic WHERE post_id =" + post_id);
        rs.next();
        return rs.getDouble("lng");
    }

    //farmers coordinates
    public String coordsF() {
        return "SELECT * FROM farmer";
    }

    //experts cooordinates
    public String coordsE() {
        return "SELECT * FROM expert";
    }

}
