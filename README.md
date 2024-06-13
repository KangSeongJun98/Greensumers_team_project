# 탄소 중립을 목표로 한 재정관리 프로그램
<p align="center">
  <br>
 <img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EB%A9%94%EC%9D%B8.png">
  <br>
</p>

## 프로젝트 소개

<p align="justify">
<h5>주제: 탄소중립을 목표로한 재정 관리 프로그램</h5>
<h5>기간: 2024.04.12. ~
2024.06.14</h5>
<h5>담당한 기능: 캘린더, 탄소배출량 비교, OCR, 유사도비교</h5>

<p>최근 기후변화적인 측면에서 탄소중립이 굉장히 중요한 화두입니다.<br> 이렇다보니 대다수의 사람들이 탄소중립이 필요하다 라고 생각을 하는데 우리는 여기서 개인 실천에 포커스를 맞췄습니다.<br>
현대 경영학에서는 "측정하지 못하면 관리할 수 없다"라는 명언이 있습니다.<br>
대부분의 사람들이 탄소중립이 필요하다는 사실을 알고있지만 눈에 보이지 않으니 관리가 어렵다고 생각했습니다.<br>
이에, 우리는 개인의 탄소 배출량을 식별할 수 있는 프로그램을 만들고자 하였습니다.<br>
여기서 더 나아가, 개인이 탄소중립을 어떻게 실천할 수 있을 지 고민하다 <br>
개인의 소비를 줄이는 것이 자연스럽게 탄소 배출량을 줄이는 것으로 이어질 것이라는 착안점에 기초하여 해당 프로젝트를 기획하게 됐습니다. 
</p>

</p>
<br>

## 기능 설명
### 탄소 배출량 비교
#### 메인 페이지
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EB%A9%94%EC%9D%B8.png">
<br>
1. 가구별 수도, 전기의 데이터의 히스토리 테이블과 사용자의 가계부 작성 평균을 토대로 탄소배출량을 계산<br /><br />
2. Chart.js를 사용해 시각화<br />

- 자신의 이번달, 전달 배출량 비교<br />
- 사용자 평균별 사용량 비교<br />
- 자신의 월별 탄소 배출량<br />
- 작년대비 탄소 배출량<br />
- 이번달 탄소 배출에서 수도, 전기, 가스, 교통이 차지하는 비율 <br />

#### 사용자별 비교 페이지
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%ED%83%84%EC%86%8C%EB%B0%B0%EC%B6%9C%EB%9F%89%EB%B9%84%EA%B5%90.png"><br />
1. 사용자 별 탄소배출량 비교 기능을 구현
2. 메인페이지와 다르게 로그인 했을 때만 사용할 수 있다.
3. 사용자 별 가계부의 내역과 전기, 가스 사용량의 히스토리 테이블을 토대로 탄소 배출량을 계산한다.
<hr>

### 가계부
#### 가계부 메인
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EA%B0%80%EA%B3%84%EB%B6%80.png">
1. 데이터 피커를 사용하여 월을 선택<br />
2. 월별 자신의 수입, 지출, 잔액이 표시한다. <br />
3. 그래프로는 3개월치 수입 지출 내역이 표시한다. <br />
4. 유사도 비교를 통해 자신과 가장 유사한 사용자의 저축 내역을 비교할 수 있다 <br />
5. 원형차트를 사용해 자신의 이번달 지출내역의 비율을 확인할 수 있습니다. <br />
<hr>

#### 가계부 작성
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EA%B0%80%EA%B3%84%EB%B6%80%EC%9E%91%EC%84%B1.png">
1. 작성 버튼을 클릭하면 모달창이 표시<br> 
2. 항목별 아이콘을 선택해 손쉽게 가계부를 작성 가능<br>
<hr>

#### OCR 메인
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR_main.png">
<br>
1. 가계부 작성페이지에서 이미지 인식 버튼을 클릭하면 모달창이 열린다.<br>
2. 사진의 가이드를 제공한다.<br>
3. 사진을 업로드하면 썸네일 기능을 제공한다.
  
##### OCR 실행
<img src ="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR_do.png">
<br>
1. OCR을 진행하면 전처리가 완료된 이미지가 표시된다.<br>
2. 인식된 사용량 데이터가 테이블로 표시된다.<br>
3. 저장하고 싶지 않은 데이터는 삭제버튼을 활용해 지울 수 있다.<br>

#### OCR 처리 과정
<img src ="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR.png">
<br>
1. 기울어진 사진이면 각도를 보정<br>
2. 멀리 찍힌 사진은 여백을 제거<br>
3. 흑백처리<br>
4. 텍스트 후처리를 통해 최종적으로 인식률을 향상시켰다.<br>

#### 유사도 비교
<img src = https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EC%9C%A0%EC%82%AC%EB%8F%84%EB%B9%84%EA%B5%90.png>
1. 사용자가 처음 회원가입을 하면 가계부에서 설문조사를 진행할 수 있다 <br />
2. 클릭하면 간략한 설문조사를 진행 응답내역을 토대로 코사인 유사도 비교를 진행<br /> 
3. 자신과 가장 유사한 사용자의 월별 저축 내역이 표시된다. <br />
<hr>

### 캘린더
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/calendar3.png">
<br>
1. 해당 월에 데이터가 없다면 가계부를 작성해달라는 페이지가 표시<br>
2. 마우스를 올리면 가계부 작성 페이지로 가는 이미지가 표시된다.

#### 캘린더 상세
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/calendar_detail.png">
<br>
1. 캘린더에 수입 또는 지출을 클릭하면 상세 내역이 표시된다.<br>
2. 쿼리문의 결과 값을 ajax를 활용해 받아오고 모달창으로 이를 표시한다.
<hr>

### 회원관리
#### 회원가입
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85.png">
1. Ajax를 활용해 비동기로 아이디 중복체크가 진행된다.<br>
2. 구글 메일 API를 사용해 이메일 인증을 구현했다.

#### 이메일 인증
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/%EC%9D%B4%EB%A9%94%EC%9D%BC%EC%9D%B8%EC%A6%9D.png"> 
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/redis.png"> 
1. 이메일 인증 템플릿을 제작</br>
2. Redis를 사용해 이메일 인증을 구현했다.

## 힘들었던 점 & 어려웠던 점

 1. easyOCR을 사용하면서 사용량의 단위인 t와 m3을 인식해야됐지만 인식률이 낮았다. 이를 해결하기 위해 이미지 각도 보정 흑배처리 등의 이미지 전처리를 진행한뒤 필요한 텍스트가 있는 곳을 상대좌표로 확대해 OCR을 진행했다.
 이후 텍스트 후처리를 통해 유사한 글자도 인식하도록 했다.

 2. 탄소배출량 비교 페이지를 제작하면서 히스토리 테이블에 있는 전기, 가스의 사용량과
 사용자가 작성한 가계부의 사용량을 가져와 탄소배출량을 계산하는 과정에서 단순한 조인으로는 원하는 모든 값이 나오지 않아서 풀아우터 조인과 서브쿼리를 활용해서 이를 구현했는데 쿼리문 구현 과정이 어려웠다.


<br>
</p>
<br>
