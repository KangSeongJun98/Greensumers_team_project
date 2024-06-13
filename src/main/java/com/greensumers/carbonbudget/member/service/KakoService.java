package com.greensumers.carbonbudget.member.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.mybatis.spring.annotation.MapperScan;

import com.greensumers.carbonbudget.member.vo.KakaoUserVo;
import com.greensumers.carbonbudget.member.mapper.KakaoUserMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
@MapperScan("com.greensumers.carbonbudget.member.mapper")
public class KakoService {

    @Autowired
    private KakaoUserMapper kakaoUserMapper;

    public String getAccessToken(String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=9c660e710311cc2c921e701ceda99c06"); //본인이 발급받은 key
            sb.append("&redirect_uri=http://192.168.0.21:8080/carbonbudget/kakaoLogin"); // 본인이 설정한 주소
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            BufferedReader br;
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 응답일 때
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else { // 오류 응답일 때
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String line;
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            // JSON 파싱 부분 추가
            JsonElement element = JsonParser.parseString(result);
            if (element != null && element.isJsonObject()) {
                JsonObject jsonObject = element.getAsJsonObject();
                if (jsonObject.has("access_token")) {
                    access_Token = jsonObject.get("access_token").getAsString();
                }
                if (jsonObject.has("refresh_token")) {
                    refresh_Token = jsonObject.get("refresh_token").getAsString();
                }
            }
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return access_Token;
    }


    public HashMap<String, Object> getUserInfo(String access_Token) {
        HashMap<String, Object> userInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 응답일 때
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line;
                StringBuilder result = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    result.append(line);
                }
                br.close();
                System.out.println("response body : " + result.toString());
                JsonElement element = JsonParser.parseString(result.toString());

                JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
                JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

                String nickname = properties.getAsJsonObject().get("nickname").getAsString();
                String email = kakao_account.getAsJsonObject().get("email").getAsString();
                String kakaoId = element.getAsJsonObject().get("id").getAsString(); // Kakao ID 추가

                userInfo.put("nickname", nickname);
                userInfo.put("email", email);
                userInfo.put("id", kakaoId); // Kakao ID 추가
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return userInfo;
    }

    
   
 // 카카오 사용자 정보를 데이터베이스에 저장하는 메서드
    public void saveKakaoUserInfo(HashMap<String, Object> userInfo) {
        KakaoUserVo kakaoUser = new KakaoUserVo();
        
        // 이메일과 닉네임을 userInfo에서 가져와서 설정합니다.
        kakaoUser.setEmail((String) userInfo.get("email"));
        kakaoUser.setNickname((String) userInfo.get("nickname"));
        
        // 여기서 userInfo에서 "id" 키를 이용하여 Kakao ID를 가져옵니다.
        // Long 타입이므로 String으로 형변환하여 저장합니다.
        Long kakaoId = (Long) userInfo.get("id");
        kakaoUser.setKakaoUserId(String.valueOf(kakaoId));
        
        

        kakaoUserMapper.insertKakaoUser(kakaoUser);
    }



}
