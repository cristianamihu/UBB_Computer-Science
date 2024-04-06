package repository;

import domain.User;
import domain.validators.Validator;

import java.sql.*;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

public class UserDBRepository implements Repository<Long, User> {
    private String url;
    private String username;
    private String password;
    private Validator<User> validator;

    public UserDBRepository(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
        this.validator = validator;
    }

    @Override
    public Optional<User> findOne(Long aLong) {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE id = ?");) {
            preparedStatement.setLong(1, aLong);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String firstName = resultSet.getString("firstName");
                    String lastName = resultSet.getString("lastName");
                    String email = resultSet.getString("email");
                    User user = new User(firstName, lastName, email);
                    user.setId(aLong);
                    return Optional.ofNullable(user);
                }
                return Optional.empty();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Iterable<User> findAll() {
        Set<User> users = new HashSet<>();
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from users");) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Long id = resultSet.getLong("id");
                String firstName = resultSet.getString("firstName");
                String lastName = resultSet.getString("lastName");
                String email = resultSet.getString("email");

                User user = new User(firstName, lastName, email);
                user.setId(id);
                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long size() {
        long size = 0;
        for (User user : this.findAll())
            size++;
        return size;
    }

    @Override
    public Optional<User> save(User entity) {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users (firstName, lastName, email) VALUES (?, ?, ?)");) {
            preparedStatement.setString(1, entity.getFirstName());
            preparedStatement.setString(2, entity.getLastName());
            preparedStatement.setString(3, entity.getEmail());
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows == 0 ? Optional.empty() : Optional.ofNullable(entity);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Optional<User> delete(Long aLong) {
        Optional<User> user = this.findOne(aLong);
        int affectedRows = 0;
        if(user.isPresent()) {
            try (Connection connection = DriverManager.getConnection(url, username, password);
                 PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM users WHERE id = ?");) {
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
    public Optional<User> update(User entity) {
        try(Connection connection= DriverManager.getConnection(url, username, password);
            PreparedStatement preparedStatement=connection.prepareStatement("UPDATE users SET firstName = ?, lastName = ?, email = ? WHERE id = ?");){
            preparedStatement.setString(1,entity.getFirstName());
            preparedStatement.setString(2,entity.getLastName());
            preparedStatement.setString(3,entity.getEmail());
            preparedStatement.setLong(4,entity.getId());
            int affectedRows=preparedStatement.executeUpdate();
            return affectedRows == 0 ? Optional.ofNullable(entity) : Optional.empty();
        }
        catch (SQLException e){
            throw new RuntimeException(e);
        }
    }
}
