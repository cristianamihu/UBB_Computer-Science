package repository;

import domain.Friendship;
import domain.validators.Validator;

import java.sql.*;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

public class FriendshipDBRepository implements Repository<Long, Friendship> {
    private String url;
    private String username;
    private String password;
    private Validator<Friendship> validator;

    public FriendshipDBRepository(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
        this.validator = validator;
    }
    @Override
    public Optional<Friendship> findOne(Long aLong) {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM friendships WHERE id = ?");) {
            preparedStatement.setLong(1, aLong);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Integer id_user1 = resultSet.getInt("idUser1");
                    Integer id_user2 = resultSet.getInt("idUser2");
                    String friends_from = resultSet.getString("friendsFrom");
                    LocalDate from_parsed = LocalDate.parse(friends_from);
                    Friendship friendship = new Friendship(id_user1, id_user2, from_parsed);
                    friendship.setId(aLong);
                    return Optional.ofNullable(friendship);
                }
                return Optional.empty();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Iterable<Friendship> findAll() {
        Set<Friendship> friendships = new HashSet<>();
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM friendships");) {
             ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Long id = resultSet.getLong("id");
                Long idUser1 = (long)resultSet.getInt("idUser1");
                Long idUser2 = (long)resultSet.getInt("idUser2");
                String from = resultSet.getString("friendsFrom");
                LocalDate from_parsed = LocalDate.parse(from);
                Friendship friendship = new Friendship(idUser1, idUser2, from_parsed);
                friendship.setId(id);
                friendships.add(friendship);
            }
            return friendships;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long size() {
        long size = 0;
        for(Friendship friendship: this.findAll())
            size++;
        return size;
    }

    @Override
    public Optional<Friendship> save (Friendship entity) {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO friendships (idUser1, idUser2, friendsFrom) VALUES (?, ?, ?)");) {
            preparedStatement.setInt(1, ((int)entity.getIdUser1()));
            preparedStatement.setInt(2, ((int)entity.getIdUser2()));
            preparedStatement.setString(3, entity.getFriendsFrom().toString());
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows == 0 ? Optional.empty() : Optional.ofNullable(entity);
        } catch (SQLException e) {
           throw new RuntimeException(e);
        }
    }

    @Override
    public Optional<Friendship> delete(Long aLong) {
        Optional<Friendship> user = this.findOne(aLong);
        int affectedRows = 0;
        if (user.isPresent()) {
            try (Connection connection = DriverManager.getConnection(url, username, password);
                 PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM friendships WHERE id = ?");) {
                preparedStatement.setLong(1, aLong);
                affectedRows = preparedStatement.executeUpdate();
                return affectedRows == 0 ? Optional.empty() : user;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return Optional.empty();
    }

    @Override
    public Optional<Friendship> update(Friendship entity) {
        /*try(Connection connection= DriverManager.getConnection(url, username, password);
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE friendships SET id_user1 = ?, id_user2 = ?, friends_from = ? WHERE id = ?");) {
            preparedStatement.setString(1,entity.getIdUser1());
            preparedStatement.setString(2,entity.getIdUser2());
            preparedStatement.setString(3,entity.getFriendsFrom());
            preparedStatement.setLong(4,entity.getId());
            int affectedRows=preparedStatement.executeUpdate();
            return affectedRows == 0 ? Optional.ofNullable(entity) : Optional.empty();
        }
        catch (SQLException e){
            throw new RuntimeException(e);
        }*/
        return null;
    }
}
