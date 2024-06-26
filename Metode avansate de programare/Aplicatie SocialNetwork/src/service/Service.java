package service;

import domain.Friendship;
import domain.User;
import domain.validators.ValidationException;
import repository.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

public class Service {
    /**
     * Repository containing the Users with the ID of type Long
     * */

    private final Repository<Long, User> repositoryUser;
    private final Repository<Long, Friendship> repositoryFriendship;

    public Service() throws ValidationException {
        this.repositoryUser = new UserDBRepository("jdbc:postgresql://localhost:5432/socialnetwork", "postgres", "postgres");
        this.repositoryFriendship = new FriendshipDBRepository("jdbc:postgresql://localhost:5432/socialnetwork", "postgres", "postgres");
    }

    /**
     * Searches a user in the repository.
     * @return   the user if it is found and not deleted, null otherwise
     * @param    ID   User's ID
     * @return   the user, if it's found, null otherwise
     * @throws   IllegalArgumentException if the data read is not the correct format
     */
    private User searchUser(long ID) throws IllegalArgumentException, SQLException {
        Optional<User> searchedUser = this.repositoryUser.findOne(ID);
        if (searchedUser.isPresent()) {
            return searchedUser.get();
        }
        System.out.println("Can not find the user with the ID " + ID + "!");
        return null;
    }

    /**
     * Adds a user to repository.
     * A new user is created based on the information provided as parameters
     * and the id is set with the next value in the repository.
     * The user is added only if it doesn't exist already and if it exists but is deleted, then it will be restored.
     * @param: FirstName  user's first name
     * @param: LastName   user's last name
     * @param: Email      user's email address
     * @throws   ValidationException if the user is not defined as required
     * @throws   IllegalArgumentException if the data read is not in the correct format
     */
    public void addUser(String FirstName, String LastName, String Email) throws IllegalArgumentException, ValidationException, SQLException {
        User newuser = new User(FirstName, LastName, Email);
        long id = this.repositoryUser.size();
        while(this.repositoryUser.findOne(id).isPresent()) {
            id++;
        }
        newuser.setId(id);
        Optional<User> existingUser = Optional.empty();
        for (User user : this.repositoryUser.findAll()) {
            if (user.getEmail().equals(newuser.getEmail())) {
                existingUser = Optional.of(user);
                break;
            }
        }
        if (existingUser.isPresent()) {
            newuser = existingUser.get();
            Optional<User> restoredUser = this.repositoryUser.update(newuser); // Restore if it was deleted
            if (restoredUser.isPresent()) {
                System.out.println(newuser + " has been restored.");
            } else {
                System.out.println(newuser + " does already exist.");
            }
        } else {
            Optional<User> savedUser = this.repositoryUser.save(newuser);
            if (savedUser.isPresent()) {
                System.out.println(newuser + " has been added.");
            }
        }
    }

    /**
     * Marks a user as deleted if it exists. It is not removed from repository.
     * @param   ID   User's ID
     * @throws  IllegalArgumentException if the data read is not the correct format
     */
    public void removeUser(int ID) throws IllegalArgumentException, ValidationException {
        try {
            User userToRemove = this.searchUser(ID);
            if (userToRemove != null) {
                for (long i = 1; i <= this.repositoryUser.size(); i++) {
                    Friendship friends = searchFriendship(ID, i);
                    if (friends != null)
                        this.repositoryFriendship.delete(friends.getId());
                }
                this.repositoryUser.delete(userToRemove.getId());
                System.out.println(userToRemove + " has been deleted.");
            } else System.out.println("The user you want to remove does not exists.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Prints all the users without their friends.
     * @return     does not return
     */
    public void listUsers() {
        this.repositoryUser.findAll().forEach(System.out::println);
    }

    /**
     * Searches for a friendship between 2 users.
     * @param    ID1   User1's ID
     * @param    ID2   User2's ID
     * @return   the friendship if it exists, null otherwise
     * @throws   IllegalArgumentException if the data read is not the correct format
     */
    public Friendship searchFriendship(long ID1, long ID2) throws IllegalArgumentException {
        for(Friendship searchedFriendship: this.repositoryFriendship.findAll())
            if(searchedFriendship.getIdUser1() == ID1 || searchedFriendship.getIdUser2() == ID1)
                if(searchedFriendship.getIdUser1() == ID2 || searchedFriendship.getIdUser2() == ID2)
                    return searchedFriendship;
        return null;
    }

    /**
     * Creates a friendship between 2 users.
     * @param   ID   User1's ID
     * @param   ID2  User2's ID
     * @throws  IllegalArgumentException if the data read is not the correct format
     */
    public void addFriendship(long ID, long ID2) throws IllegalArgumentException {
        try {
            //verify if both of the users exists
            User user1 = this.searchUser(ID);
            User user2 = this.searchUser(ID2);
            if (user1 != null && user2 != null) {
                if (searchFriendship(ID, ID2) == null) {
                    LocalDate currentDate = LocalDate.now();
                    Friendship newFriendship = new Friendship(ID, ID2, LocalDate.now());
                    long id = this.repositoryFriendship.size();
                    while (repositoryFriendship.findOne(id).isPresent()) {
                        id++;
                    }
                    newFriendship.setId(id);
                    this.repositoryFriendship.save(newFriendship);
                    System.out.println(newFriendship + " has been added succesfuly!");
                } else System.out.println("They are already friends!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Delete a friendship
     * @param   ID   User's ID
     * @param   ID2  User2's ID
     * @throws  IllegalArgumentException if the data read is not the correct format
     */
    public void removeFriendship(long ID, long ID2) throws IllegalArgumentException {
        try {
            User user1 = this.searchUser(ID);
            User user2 = this.searchUser(ID2);
            if (user1 != null && user2 != null) {
                Friendship friendship = searchFriendship(ID, ID2);
                if (friendship != null) {
                    this.repositoryFriendship.delete(friendship.getId());
                    System.out.println(user1 + " and " + user2 + " are not friends anymore.");
                } else System.out.println(user1 + " and " + user2 + " are not even friends.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Prints all the users including their friends and the date of friendship.
     * @return     does not return
     */
    public void listUsersWithFriends() {
        this.repositoryUser.findAll().forEach(user -> {
            System.out.println(user);
            this.repositoryFriendship.findAll().forEach(friendship -> {
                try {
                    if (friendship.getIdUser1() == user.getId()) {
                        User friend = searchUser(friendship.getIdUser2());
                        System.out.println("        Friend: " + friend + " (Friends from: " + friendship.getFriendsFrom() + ")");
                    } else if (friendship.getIdUser2() == user.getId()) {
                        User friend = searchUser(friendship.getIdUser1());
                        System.out.println("        Friend: " + friend + " (Friends from: " + friendship.getFriendsFrom() + ")");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            });
        });
    }

    /**
     * Afiseaza toate relatiile de prietenie ale unui utilizator create intr-o anumita luna a anului
     * @param userID ID-ul utilizatorului
     * @param month luna din an (1-12)
     */
    public void listFriendshipsInMonth(long userID, Month month) {
        Iterable<Friendship> friendshipsIterable = repositoryFriendship.findAll();
        StreamSupport.stream(friendshipsIterable.spliterator(), false)
                .filter(friendship -> friendship.getIdUser1() == userID || friendship.getIdUser2() == userID)
                .filter(friendship -> friendship.getFriendsFrom().getMonth() == month)
                .forEach(friendship -> {
                    try {
                        User friend = searchUser((friendship.getIdUser1() == userID) ? friendship.getIdUser2() : friendship.getIdUser1());
                        System.out.println(friend.getLastName() + " | " + friend.getFirstName() + " | " + friendship.getFriendsFrom());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });
    }

    /**
     * Search for a community starting with a specific user
     * @param   user   the User we start the search with
     */
    private void DFS(User user) {
        user.setCommunity(true); //mark that this user is already in the community
        for(Friendship friendship: this.repositoryFriendship.findAll()) {
            try {
                if (friendship.getIdUser1() == user.getId()) {
                    User friend = searchUser(friendship.getIdUser2());
                    if (friend != null && !friend.isInCommunity())
                        DFS(friend); //continue the search with a friend that's not in the community and is not deleted.
                } else if (friendship.getIdUser2() == user.getId()) {
                    User friend = searchUser(friendship.getIdUser1());
                    if (friend != null && !friend.isInCommunity())
                        DFS(friend);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Counts the number of communities. Starting from every user, it adds to the same community all its friends.
     * The process continues for all the users.
     * @return     the number of communities
     */
    public int numberOfComunities() {
        int communities = 0;
        for (User user : this.repositoryUser.findAll()) {
            if (!user.isInCommunity()) {
                ++communities;
                DFS(user);
            }
        }
        this.repositoryUser.findAll().forEach(user -> { user.setCommunity(false); });
        return communities;
    }

    /**
     * Search for a community starting with a specific user using the Depth-First Search (DFS) algorithm.
     * @param   user              the user to start the community search with
     * @param   currentCommunity  list to which discovered community members will be added
     */
    private void DFSforSociableCommunity(User user, List<User> currentCommunity) {
        user.setCommunity(true);
        currentCommunity.add(user);
        for (Friendship friendship : this.repositoryFriendship.findAll()) {
            try {
                if (friendship.getIdUser1() == user.getId()) {
                    User friend = searchUser(friendship.getIdUser2());
                    if (friend != null && !friend.isInCommunity()) {
                        DFSforSociableCommunity(friend, currentCommunity);
                    }
                } else if (friendship.getIdUser2() == user.getId()) {
                    User friend = searchUser(friendship.getIdUser1());
                    if (friend != null && !friend.isInCommunity()) {
                        DFSforSociableCommunity(friend, currentCommunity);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Finds the most sociable community in the network.
     * Starting from each user, this method performs a depth-first search (DFS) to identify and calculate the
     * size of each community. The most sociable community is determined as the one with the largest number of
     * users. Users are considered part of a community if they are connected by friendships and are not already
     * in another community.
     * @return a list of users representing the most sociable community. Returns null if no
     *         community is found or no user is in a community.
     */
    public List<User> findMostSociableCommunity() {
        List<User> mostSociableCommunity = null;
        int maxCommunitySize = 0;
        for (User user : repositoryUser.findAll()) {
            if (!user.isInCommunity()) {
                List<User> currentCommunity = new ArrayList<>();
                DFSforSociableCommunity(user, currentCommunity);
                if (currentCommunity.size() > maxCommunitySize) {
                    maxCommunitySize = currentCommunity.size();
                    mostSociableCommunity = new ArrayList<>(currentCommunity);
                }
            }
        }
        return mostSociableCommunity;
    }
}
