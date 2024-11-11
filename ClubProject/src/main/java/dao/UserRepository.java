package dao;

import dto.User;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {
    private List<User> users = new ArrayList<>();

    public UserRepository() {
        users.add(new User("admin", "admin123", "admin@example.com", "1990-01-01", "010-1234-5678"));
    }

    public void addUser(User user) {
        users.add(user);
    }

    public boolean isValidUser(String username, String password) {
        return users.stream().anyMatch(u -> u.getUsername().equals(username) && u.getPassword().equals(password));
    }
}
