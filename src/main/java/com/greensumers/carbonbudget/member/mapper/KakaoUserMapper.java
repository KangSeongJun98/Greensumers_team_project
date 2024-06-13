package com.greensumers.carbonbudget.member.mapper;

import com.greensumers.carbonbudget.member.vo.KakaoUserVo;

public interface KakaoUserMapper {
    // 기존 코드는 생략합니다.

    // 카카오 사용자 정보를 데이터베이스에 저장하는 메서드
    void insertKakaoUser(KakaoUserVo kakaoUser);
}

