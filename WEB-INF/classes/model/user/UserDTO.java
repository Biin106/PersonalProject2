package model.user;

import java.util.Arrays;

public class UserDTO {
    private String username;
    private String password;
    private String passwordConfirm;
    private String gender;
    private String[] interests;
    private String grade;
    private String self;
    private String token; // 추가된 필드: 토큰

    public UserDTO(String username, String password, String passwordConfirm, String gender, String[] interests, String grade, String self) {
        this.username = username;
        this.password = password;
        this.passwordConfirm = passwordConfirm;
        this.gender = gender;
        this.interests = interests;
        this.grade = grade;
        this.self = self;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String[] getInterests() {
        return interests;
    }

    public void setInterests(String[] interests) {
        this.interests = interests;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getSelf() {
        return self;
    }

    public void setSelf(String self) {
        this.self = self;
    }
    
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Override
    public String toString() {
        return "UserDTO{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender='" + gender + '\'' +
                ", interests=" + Arrays.toString(interests) +
                ", grade='" + grade + '\'' +
                ", self='" + self + '\'' +
                ", token='" + token + '\'' +
                '}';
    }
}

