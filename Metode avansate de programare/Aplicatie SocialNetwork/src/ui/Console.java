package ui;

import domain.User;
import domain.validators.ValidationException;
import service.Service;

import java.time.Month;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

import java.sql.SQLException;

public class Console {
    final private Scanner in = new Scanner(System.in);
    private final Service service;

    public void addUserUI() throws InputMismatchException, IllegalArgumentException, ValidationException, SQLException {
        System.out.print("First Name: ");
        String firstName = in.next();
        System.out.print("Last name: ");
        String lastName = in.next();
        System.out.print("Email: ");
        String email = in.next();
        service.addUser(firstName, lastName, email);
    }

    public void removeUserUI() throws InputMismatchException, IllegalArgumentException, ValidationException {
        System.out.print("ID User: ");
        int id = in.nextInt();
        service.removeUser(id);
    }

    public void addFriendToUserUI() throws ValidationException {
        System.out.print("ID User1: ");
        int id = in.nextInt();
        System.out.print("ID User2: ");
        int id2 = in.nextInt();
        service.addFriendship(id, id2);
    }

    public void removeFriendFromUserUI() throws ValidationException {
        System.out.print("ID User1: ");
        int id = in.nextInt();
        System.out.print("ID User2: ");
        int id2 = in.nextInt();
        service.removeFriendship(id, id2);
    }

    public void mostSociableCommunityUI() {
        List<User> mostSociableCommunity = service.findMostSociableCommunity();
        if (mostSociableCommunity == null || mostSociableCommunity.isEmpty()) {
            System.out.println("No community found or no user is in a community.");
        } else {
            System.out.println("Most Sociable Community:");
            mostSociableCommunity.forEach(user -> System.out.println(user));
        }
    }

    public void listFriendshipsForUserInMonthUI() throws InputMismatchException, IllegalArgumentException {
        System.out.print("ID User: ");
        long userID = in.nextLong();
        System.out.print("Introduceti luna (1-12): ");
        int monthValue = in.nextInt();
        Month month = Month.of(monthValue);
        service.listFriendshipsInMonth(userID, month);
    }

    public Console(Service service)
    {
        this.service = service;
    }

    public void start() throws SQLException {
        boolean finished = false;
        while (!finished) {
            System.out.print("Menu: \n\t1 - add user\n\t2 - remove user\n\t3 - list users\n\t" +
                    "4 - add friend\n\t5 - remove friend\n\t6 - list users with friends\n\t" +
                    "7 - list friendships for user in month\n\t8 - number of comunities\n\t" +
                    "9 - most sociable comunitiy\n\t0 - exit\n>>> ");
            try {
                int option = in.nextInt();
                switch (option) {
                    case 1: {
                        addUserUI();
                        break;
                    }
                    case 2: {
                        removeUserUI();
                        break;
                    }
                    case 3: {
                        service.listUsers();
                        break;
                    }
                    case 4: {
                        addFriendToUserUI();
                        break;
                    }
                    case 5: {
                        removeFriendFromUserUI();
                        break;
                    }
                    case 6: {
                        service.listUsersWithFriends();
                        break;
                    }
                    case 7: {
                        listFriendshipsForUserInMonthUI();
                        break;
                    }
                    case 8: {
                        System.out.println("Number of communities: " + service.numberOfComunities());
                        break;
                    }
                    case 9: {
                        mostSociableCommunityUI();
                        break;
                    }
                    case 0: {
                        finished = true;
                    }
                    default:
                        break;
                }
            }
            catch (InputMismatchException exception) {
                System.err.println("Not an integer");
                if (in.next().isEmpty())
                    break;
            }
            catch (IllegalArgumentException | ValidationException exception) {
                System.err.println(exception);
            }
        }
        in.close();
    }
}
