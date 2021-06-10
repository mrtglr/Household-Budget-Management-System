import java.sql.*;
import java.util.InputMismatchException;
import java.util.Scanner;

public class dbtasks {

	/*
	
	Alp Eren Keskin
	Hasanalp Temiz
	Halil Mert Güler

	*/

	private static Connection connect = null;
	private static Statement statement = null;
	private static ResultSet resultSet = null;
	private static int resultSet2;
	private static int resultSet3;

	final private static String host = "SET HERE";
	final private static String user = "SET HERE";
	final private static String password = "SET HERE";

	public static void main(String[] args) {

		try {
			Connection connection = DriverManager.getConnection(host, user, password);
			statement = connection.createStatement();
			Scanner scan = new Scanner(System.in);
			System.out.println("Welcome to Household Budget Admin Panel");
			System.out.println("#######################################");
			System.out.println();
			loop: while (true) {
				System.out.println("MENU:");
				System.out.println("------------------------");
				System.out.println("1 - List family members");
				System.out.println("2 - Enter the expense ");
				System.out.println("3 - Remove extra income");
				System.out.println("4 - Update house rent");
				System.out.println("0 - exit");
				System.out.println("------------------------");
				System.out.print("Enter a number>");
				String command = scan.nextLine();
				int choose = Integer.parseInt(command);
				if (command.equals("0")) {
					System.out.println("Bye.");
					break;
				}
				switch (choose) {
				case 1:
					System.out.println();
					resultSet = statement
							.executeQuery("SELECT family.surname from family order by family.surname asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("surname"));
					}
					System.out.println();
					System.out.print("Enter a surname >");
					String surname = scan.nextLine();
					surname = capitalize(surname.toLowerCase());
					resultSet = statement
							.executeQuery("select users.name, users.surname from users where users.surname = '"
									+ surname + "' order by users.name asc;");
					if (!(resultSet.next())) {
						System.out.println("Surname not found!");
					}
					while (resultSet.next()) {
						System.out.println(resultSet.getString("name") + " " + resultSet.getString("surname"));
					}
					System.out.println();
					System.out.print("Continue? (Y/N) >");
					String cont = scan.nextLine();
					if (cont.toUpperCase().equals("N")) {
						break loop;
					}
					break;
				case 2:
					System.out.println();
					int houseNo = 0;
					int expID = 0;
					resultSet = statement
							.executeQuery("SELECT family.surname from family order by family.surname asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("surname"));
					}
					System.out.println();

					System.out.print("Enter a surname >");
					surname = scan.nextLine();
					surname = capitalize(surname.toLowerCase());

					resultSet = statement.executeQuery(
							"SELECT family.houseno from family where family.surname = '" + surname + "';");

					while (resultSet.next()) {
						houseNo = Integer.parseInt(resultSet.getString("houseno"));
					}

					System.out.println();
					System.out.print("1-Enter the expense name >");
					String expname = scan.nextLine();
					System.out.println();
					System.out.print("2-Enter the expense cost >");
					String billc = scan.nextLine();
					System.out.println();
					System.out.print("3-Enter the expense date format(YYYY-MM-DD)>");
					String expdate = scan.nextLine();
					resultSet2 = statement
							.executeUpdate("INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo) \n"
									+ "VALUES (DEFAULT, '" + expname + "', '" + expdate + "', " + houseNo + ");");

					resultSet = statement.executeQuery(
							"SELECT expense.expid from expense where expense.houseno = '" + houseNo + "';");
					while (resultSet.next()) {
						expID = Integer.parseInt(resultSet.getString("expid"));
					}

					String billName = expname.replaceAll("\\s", "");
					billName = billName + "Bill";
					resultSet3 = statement.executeUpdate(
							"INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID) \n" + "VALUES (DEFAULT,'"
									+ billc + "', '" + billName + "', '" + expdate + "', " + expID + ");");

					System.out.println("Expense added with bill.");
					System.out.println();
					System.out.print("Continue? (Y/N) >");
					cont = scan.nextLine();
					if (cont.toUpperCase().equals("N")) {
						break loop;
					}
					break;

				case 3:
					System.out.println();
					ResultSet resultSet_users = null;
					ResultSet resultSet_extinc = null;
					int[] ids = new int[10];
					int idCount = 0, userId = 0;
					String choseExtinc, choseExtinc2;
					String[] Str = new String[10];
					boolean isUserExist = false, isEctCor = false;

					resultSet_users = statement
							.executeQuery("select name,surname, users.userid from users,income,extraincome "
									+ "where users.hasincome = true and income.hasextra = true and users.userid = income.userid "
									+ "and income.incomeid = extraincome.incomeid " + "order by userid;");
					ResultSetMetaData rsmd_user = resultSet_users.getMetaData();
					int columnsNumber_user = rsmd_user.getColumnCount();
					while (resultSet_users.next()) {
						for (int i = 1; i <= columnsNumber_user; i++) {

							if (i % 3 == 0) {
								System.out.print("- ");
							}
							System.out.print(resultSet_users.getString(i) + " ");

							if (i % 3 == 0) {

								ids[idCount] = Integer.parseInt(resultSet_users.getString(i));
								idCount++;
							}
						}
						System.out.println();
					}
					System.out.println();
					System.out.println(">all users that has extra income are shown..");
					System.out.print(">type the id of user that you want to choose: ");

					del: while (true) {

						try {
							userId = scan.nextInt();

							for (int j = 0; j < idCount; j++) {

								if (ids[j] == userId) {

									isUserExist = true;
									resultSet_extinc = statement.executeQuery(
											"select extraincome.extname, extraincome.extworth from users, income, extraincome "
													+ "where users.userid = " + userId
													+ " and users.userid = income.userid and income.incomeid = extraincome.incomeid;");
									ResultSetMetaData rsmd_ext = resultSet_extinc.getMetaData();
									int columnsNumber_ext = rsmd_ext.getColumnCount();
									while (resultSet_extinc.next()) {
										int inC = 0;
										System.out.println();
										System.out.println(">INCOMES");
										System.out.print((++inC) + ": ");
										for (int i = 1; i <= columnsNumber_ext; i++) {

											System.out.print(resultSet_extinc.getString(i) + " ");
											Str[i - 1] = resultSet_extinc.getString(i);
										}
										System.out.println();
									}
									System.out.println();
									System.out.println(">all extra income that user has are shown..");
									System.out.print(">type the name of extra income that you want to delete: ");

									while (true) {

										choseExtinc = scan.next();
										choseExtinc2 = scan.nextLine();
										choseExtinc = (choseExtinc + choseExtinc2);

										for (int k = 0; k < Str.length; k++) {

											if (isAlph(Str[k].charAt(1)) && Str[k].equals(choseExtinc.toLowerCase())) {

												isEctCor = true;
												String query = "delete from extraincome where extname = ?";
												PreparedStatement preparedStmt = connection.prepareStatement(query);
												preparedStmt.setString(1, choseExtinc.toLowerCase());
												preparedStmt.execute();
												System.out.println();
												System.out.println(
														choseExtinc.toLowerCase() + " has deleted successfuly...");
												break del;

											}
										}
										if (!isEctCor) {
											System.out.println(">wrong extra income name please enter a valid name");
										}
									}
								}
							}
							if (!isUserExist) {
								System.out.println(">wrong user id please enter a valid id number");
							}

						} catch (InputMismatchException ex) {
							System.err.println("Invalid string in argumment, please enter a integer!");
							break;
						}
					}
					System.out.println();
					System.out.print("Continue? (Y/N) >");
					cont = scan.nextLine();
					if (cont.toUpperCase().equals("N")) {
						break loop;
					}
					break;
				case 4:
					System.out.println();
					int prvrent = 0;
					resultSet = statement.executeQuery(
							"select house.houseno ,house.rent ,house.location from house order by houseno asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("houseno") + " - " + resultSet.getString("rent") + "₺ "
								+ resultSet.getString("location"));
					}
					System.out.println();
					System.out.print("Enter a house ID >");
					int id = Integer.parseInt(scan.nextLine());
					resultSet = statement
							.executeQuery("select house.rent from house where house.houseno = " + id + ";");
					while (resultSet.next()) {
						prvrent = Integer.parseInt(resultSet.getString("rent"));
					}
					System.out.println();
					System.out.println("Previous rent:" + prvrent);
					System.out.print("Enter a new rent>");
					int newRent = Integer.parseInt(scan.nextLine());
					System.out.println();
					resultSet2 = statement
							.executeUpdate("UPDATE house SET rent =" + newRent + "where houseno =" + id + ";");
					System.out.println("Rent updated successfully.");
					System.out.println();
					System.out.print("Continue? (Y/N) >");
					cont = scan.nextLine();
					if (cont.toUpperCase().equals("N")) {
						break loop;
					}
					break;
				}

			}
			connection.close();

		} catch (Exception e) {
			System.out.println("Error!");
			e.printStackTrace();
		} finally {
			close();
		}

	}

	int breaker = 0;

	private static void close() {
		try {
			if (resultSet != null) {
				resultSet.close();
			}

			if (statement != null) {
				statement.close();
			}
			if (connect != null) {
				connect.close();
			}
		} catch (Exception e) {
		}
	}

	public static String capitalize(String str) {
		if (str == null)
			return str;
		return str.substring(0, 1).toUpperCase() + str.substring(1);
	}

	public static boolean isAlph(char c) {

		boolean b = false;
		if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
			b = true;
		} else {
			b = false;
		}
		return b;
	}
}
