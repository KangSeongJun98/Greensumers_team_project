package com.greensumers.carbonbudget.member.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class KakaoUserVo {
    
    private String id_kakao_user;
    private String email;
    private String nickname;

    public String getKakaoUserId() {
        return id_kakao_user;
    }

    public void setKakaoUserId(String id) {
        this.id_kakao_user = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "KakaoUserVo [id_kakao_user=" + id_kakao_user + ", email=" + email + ", nickname=" + nickname + "]";
    }

}
