import java.sql.*;
import java.sql.Date;
import java.util.*;


public class GobabyApp {

    public static boolean validPractID(int practID) throws SQLException {
        try {
            String querySQL = "SELECT PRACTID FROM MIDWIFE WHERE PRACTID = " + practID;
            ResultSet rs = sqlConnection.statement.executeQuery(querySQL);
            return rs.next();
        } catch (SQLException e) {
            return false;
        }
    }

    public static void listappointment(String SQLdate, int practID, String input) throws SQLException {
        ResultSet meet = sqlConnection.statement.executeQuery(SQLdate);
        //System.out.println("meet have input ="+meet.next());
        if (meet.next() == true) {
            System.out.println("Below are your appointment(s) for the date " + input);
            String querySQL1 = String.format("with meet as(" +
                    "    select  * from appointment" +
                    "    where PRACTID = %d  and adate = date('%s')) , findBP as(" +
                    "   select atime, case when pregnancy.ppractID = %d then 'P' when pregnancy.bpractID = %d then 'B' " +
                    "   end PorB, meet.paID,mID" +
                    "   from meet join  pregnancy on (pregnancy.paID,pregnancy.pregtime)=(meet.paID,meet.pregtime) " +
                    "   join couple on couple.paID= meet.paID )" +
                    "   SELECT atime,PorB,name,healthID" +
                    "   from findBP join person on person.personID = findBP.mID order by atime", practID, input, practID, practID);
            ResultSet rs = sqlConnection.statement.executeQuery(querySQL1);
            int i = 1;
            while (rs.next()) {
                System.out.println(i + ": " + rs.getTime("atime").toString() + " " +
                        rs.getString("PORB") + " " +
                        rs.getString("NAME") + " " +
                        rs.getString("HealthID"));
                i++;
            }
            rs.close();
        }
    }


    public static void main(String[] args) throws SQLException {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode = 0;      // Variable to hold SQLCODE
        String sqlState = "00000";  // Variable to hold SQLSTATE
        Statement statement;
        // Register the driver.  You must register the driver before you can use it.
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "";
        String your_password = "";

        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if (your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection(url, your_userid, your_password);
        Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        Statement stmt2 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        Statement stmt3 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);


        try {
            sqlConnection sql = new sqlConnection();
        } catch (SQLException e) {
            sqlConnection.printerror(e);
        }

        boolean checkID = false;
        boolean checkDate = false;
        boolean checkchoice = false;
        int practID = 0;
        String adate = "";
        Scanner sc = new Scanner(System.in);
        System.out.println("Hello you will be connected to cs421 midwife DataBase.");
        System.out.println("Please enter your practitioner id [E] to exit:");

        while (!checkID) {
            if (sc.hasNextLine()) {
                String input = sc.nextLine();
                if (input.equals("E")) {
                    sqlConnection.closeConnection();
                    System.out.println("midwifeAPP will quit now");
                    System.exit(0);
                }
                String querySQL = "SELECT PRACTID FROM MIDWIFE WHERE PRACTID = " + input;
                ResultSet rs = sqlConnection.statement.executeQuery(querySQL);
                checkID = rs.next();
                // System.out.println(checkID);
                if (checkID == false) {
                    System.out.println("Not a valid 9 digit practitioner id, Please enter a valid 9 digit practitioner id or [E] to exit");
                } else {
                    practID = Integer.parseInt(input);
                }
            }
        }

        System.out.println("Find your practID in cs421 database!");
        //System.out.println(practID);

        while (checkDate != true) {
            System.out.println("Please enter the date for appointment list [E] to exit ");
            System.out.println("Enter the date in the format YYYY-MM-DD");
            String input = sc.nextLine();
            adate = input;

            if (input.equals("E")) {
                sc.close();
                sqlConnection.closeConnection();
                System.out.println("midwifeAPP will quit now");
                System.exit(0);
            }
            String querySQL = String.format("SELECT * FROM appointment WHERE PRACTID = %d AND ADATE = date('%s')", practID, adate);
            ResultSet meet = stmt.executeQuery(querySQL);
            //System.out.println("meet have input ="+meet.next());
            if (meet.next() == true) {
                System.out.println("Below are your appointment(s) for the date " + input);
                String querySQL1 = String.format("with meet as(" +
                        "    select  * from appointment" +
                        "    where PRACTID = %d  and adate = date('%s')) , findBP as(" +
                        "   select atime, case when pregnancy.ppractID = %d then 'P' when pregnancy.bpractID = %d then 'B' " +
                        "   end PorB, meet.paID,mID,pregnancy.pregtime,aID" +
                        "   from meet join  pregnancy on (pregnancy.paID,pregnancy.pregtime)=(meet.paID,meet.pregtime) " +
                        "   join couple on couple.paID= meet.paID )" +
                        "   SELECT atime,PorB,name,healthID,pregtime,paID,aID" +
                        "   from findBP join person on person.personID = findBP.mID order by atime", practID, input, practID, practID);
                ResultSet rs = sqlConnection.statement.executeQuery(querySQL1);
                ArrayList<String> pregtime = new ArrayList<String>();
                ArrayList<Integer> paIDlist = new ArrayList<Integer>();
                ArrayList<Integer> aIDlist= new ArrayList<Integer>();
                int i = 1;
                while (rs.next()) {
                    System.out.println(i + ": " + rs.getTime("atime").toString() + " " +
                            rs.getString("PORB") + " " +
                            rs.getString("NAME") + " " +
                            rs.getString("HealthID"));
                    pregtime.add(rs.getString("pregtime"));
                    paIDlist.add(Integer.parseInt(rs.getString("paID")));
                    aIDlist.add(rs.getInt("aID"));
                    i++;
                }

                //find all the appointment associated with that date
                boolean loop = false;
                while(!loop) {
                    System.out.println("Enter the appointment number that you would like to work on. \n [E] to exits [D] to go back another date: ");
                    String input2 = sc.nextLine();
                    if (input2.equals("D")) {
                        break;
                    } else if (input2.equals("E")) {
                        sqlConnection.closeConnection();
                        System.out.println("midwifeAPP will quit now");
                        System.exit(0);
                    } else {
                        int appnum = Integer.parseInt(input2);
                        String pregT = pregtime.get(appnum - 1);
                        int paID = paIDlist.get(appnum - 1);
                        int aID = aIDlist.get(appnum - 1);
                        ResultSet rs1 = stmt2.executeQuery(querySQL1);
                        do {

                            rs1.absolute(appnum);
                            System.out.println("\n--------------menu option------------------");
                            System.out.println("For " + rs1.getString("NAME") + " " + rs1.getString("HealthID"));
                            System.out.println("--------------------------------------------");
                            System.out.println("1) Review Notes                           ");
                            System.out.println("2) Review tests                           ");
                            System.out.println("3) Add a notes                            ");
                            System.out.println("4) Prescribe a test                       ");
                            System.out.println("5) Go back to the appointments            ");
                            System.out.println("------------------------------------------\n");
                            System.out.println("Enter your choice:");
                            //ResultSet rs1 = listappointment(querySQL, practID, input);
                            if (sc.hasNextInt()) {
                                int choice = sc.nextInt();
                                sc.nextLine();
                                if ((choice >= 1) && (choice <= 5)) {
                                    if (choice == 1) {
                                        reviewN(con, pregT, paID);
                                    } else if (choice == 2) {
                                        reviewT(con, pregT, paID);
                                    } else if (choice == 3) {
                                        addN(con, aID, pregT, paID, sc);
                                    } else if (choice == 4) {
                                        presT(con, practID, pregT, paID, sc);
                                    } else if (choice == 5) {
                                        listappointment(querySQL, practID, adate);
                                        //  continue;
                                        break;
                                    }
                                } else {
                                    System.out.println("Enter a valid integer number 1-5");
                                }
                            } else {
                                String temp = sc.nextLine();

                                if (temp.equals("D")) {
                                    System.out.println("back to the change list appointments step \n");
                                    break;
                                }
                                if (temp.equals("E")) {
                                    stmt.close();
                                    stmt2.close();
                                    System.out.println("midwifeAPP will quit now");
                                    System.exit(0);
                                }
                            }
                        } while (!checkchoice);
                    }
                }
            } else {
                System.out.println("not valid date entered,please do it again");
                continue;
            }
        }
        sc.close();
    }

    //=====================================================================================================================================
    //all the 4 methods starts here

    /**
     * @param con       : connection
     * @param pregtime: pregtime and paID uniquely determine the pregnancy
     * @param paID
     */
    public static void reviewN(Connection con, String pregtime, int paID) throws SQLException {
        try {
            String QuerySQL =
                    "SELECT ndate,ntime,content " +
                            "FROM appointment JOIN notes ON notes.aID = appointment.aID " +
                            "JOIN pregnancy on (pregnancy.paID,pregnancy.pregtime)=(appointment.paID,appointment.pregtime)" +
                            " WHERE pregnancy.paID = " + paID + " and pregnancy.pregtime = \'" + pregtime + "\'" +
                            " ORDER BY ntime";
            //System.out.println(QuerySQL);
            Statement stmt4 = con.createStatement();
            ResultSet rs2 = stmt4.executeQuery(QuerySQL);
            while (rs2.next()) {
                System.out.println(rs2.getDate("ndate").toString() + " " +
                        rs2.getString("ntime") + " " +
                        rs2.getString("content") + " ");
            }
            stmt4.close();
        }catch (SQLException e){
            sqlConnection.printerror(e);
        }

    }

    /**
     * @param con       : connection
     * @param pregtime: pregtime and paID uniquely determined pregnancy
     * @param paID
     * @throws SQLException
     */
    public static void reviewT(Connection con, String pregtime, int paID) throws SQLException {
        try {
            String QuerySQL =
                    "select refdate,type," +
                            " case when results is null then 'PENDING'" +
                            " else results " +
                            " end display " +
                            " from tests where paID = " + paID + " and pregtime = \'" + pregtime + "\'" + " and babyID is null" +
                            " order by refdate";
            // System.out.println(QuerySQL);
            Statement stmt4 = con.createStatement();
            ResultSet rs3 = stmt4.executeQuery(QuerySQL);
            while (rs3.next()) {
                System.out.println(rs3.getDate("refdate").toString() + " " +
                        "[" + rs3.getString("type") + "] " +
                        rs3.getString("display") + " ");
            }
            stmt4.close();
        }catch(SQLException e){
            sqlConnection.printerror(e);

        }

    }

    /**
     *
     * @param con
     * @param aID
     * @param pregtime
     * @param paID
     * @param sc
     * @throws SQLException
     */

    public static void addN(Connection con,int aID, String pregtime, int paID,Scanner sc) throws SQLException {
        try {
            System.out.println("Please type your observation:");
            String userinput = sc.nextLine();
            int min = 0;
            int max = 99999999;
            //Generate random int value
            int random_int = (int) Math.floor(Math.random() * (max - min + 1) + min);
            java.sql.Date sqlDate = new Date(System.currentTimeMillis());
            java.sql.Time sqltime = new Time(System.currentTimeMillis());

            String QuerySQL = "insert into notes (nID, aID, ndate, ntime, content) " +
                    "values (" + random_int + ", " + aID + ",\'" + sqlDate + "\'" + " ,\'" + sqltime + "\', \'" + userinput + "\')";
            Statement stmt4 = con.createStatement();
            stmt4.executeUpdate(QuerySQL);
            //System.out.println ( "DONE" ) ;
            stmt4.close();
        }catch(SQLException e){
            sqlConnection.printerror(e);
        }
    }

    /**
     *
     * @param con
     * @param practID
     * @param pregtime
     * @param paID
     * @param sc
     * @throws SQLException
     */
    public static void presT(Connection con,int practID, String pregtime,int paID, Scanner sc )throws SQLException {
        try {
            System.out.println("Please enter thr type of the test:");
            String userinput = sc.nextLine();
            int min = 800000000;
            int max = 899999999;
            int random_int = (int) Math.floor(Math.random() * (max - min + 1) + min);
            java.sql.Date sqlDate = new Date(System.currentTimeMillis());
            String QuerySQL = "insert into tests (testID, paID, pregtime, babyID, practID, labtID, refdate, sampdate, labdate, type, results) values" +
                    "(" + random_int + ", " + paID + ", \'" + pregtime + "\', null, " + practID + ", null, \'" + sqlDate + "\', \'" + sqlDate + "\', null, \'" + userinput + "\', null)";
            Statement stmt4 = con.createStatement();
            stmt4.executeUpdate(QuerySQL);
            //System.out.println ( "done") ;
            stmt4.close();
        } catch (SQLException e) {
            sqlConnection.printerror(e);
        }
    }
}
















