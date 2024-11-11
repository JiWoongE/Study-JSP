package dto;

import java.io.Serializable;

public class User implements Serializable {
    private String username;
    private String password;
    private String email;
    private String birthdate;
    private String phoneNumber;

    public User(String username, String password, String email, String birthdate, String phoneNumber) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.birthdate = birthdate;
        this.phoneNumber = phoneNumber;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }
}
