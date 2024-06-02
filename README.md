# 탄소 중립을 목표로 한 재정관리 프로그램
<p align="center">
  <br>
 <img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/calendar.png">
  <br>
</p>

## 프로젝트 소개

<p align="justify">
<h5>최근 기후변화적인 측면에서 탄소중립이 굉장히 중요한 화두입니다.<br> 이렇다보니 대다수의 사람들이 탄소중립이 필요하다 라고 생각을 하는데 우리는 여기서 개인 실천에 포커스를 맞췄습니다.<br>
현대 경영학에서는 "측정하지 못하면 관리할 수 없다"라는 명언이 있습니다.<br>
대부분의 사람들이 탄소중립이 필요하다는 사실을 알고있지만 눈에 보이지 않으니 관리가 어렵다고 생각했습니다.<br>
이에, 우리는 개인의 탄소 배출량을 식별할 수 있는 프로그램을 만들고자 하였습니다.<br>
여기서 더 나아가, 개인이 탄소중립을 어떻게 실천할 수 있을 지 고민하다 <br>
개인의 소비를 줄이는 것이 자연스럽게 탄소 배출량을 줄이는 것으로 이어질 것이라는 착안점에 기초하여 해당 프로젝트를 기획하게 됐습니다. 
</h5>

</p>
<br>

## 담당한 기능 설명
### 캘린더
- #### 캘린더 메인 화면
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/calendar.png">
<br>
1. FullCalendar API를 기반으로 캘린더 페이지를 제작<br>
2. 현재 월 데이터를 ajax를 사용해 Controller로 전달<br>
3. 비동기로 달을 변경해도 페이지 이동 없이 수입 지출 합계 그래프가 변경

 - #### 캘린더 2
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/calendar2.png">

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

### OCR
- #### OCR 메인
<img src="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR_main.png">
<br>
1. 가계부 작성페이지에서 이미지 인식 버튼을 클릭하면 모달창이 열린다.<br>
2. 사진의 가이드를 제공한다.<br>
3. 사진을 업로드하면 썸네일 기능을 제공한다.
  
- ##### OCR 실행
<img src ="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR_do.png">
<br>
1. OCR을 진행하면 전처리가 완료된 이미지가 표시된다.<br>
2. 인식된 사용량 데이터가 테이블로 표시된다.<br>
3. 저장하고 싶지 않은 데이터는 삭제버튼을 활용해 지울 수 있다.<br>

- #### OCR 처리 과정
<img src ="https://raw.githubusercontent.com/KangSeongJun98/KangSeongJun98.github.io/main/assets/img/portfolio/detail/Carbonbudget/OCR.png">
<br>
1. 기울어진 사진이면 각도를 보정<br>
2. 멀리 찍힌 사진은 여백을 제거<br>
3. 흑백처리<br>
4. 텍스트 후처리를 통해 최종적으로 인식률을 향상시켰다.<br><hr>

## 힘들었던 점 & 어려웠던 점

 easyOCR을 사용하면서 사용량의 단위인 t와 m3을 인식해야됐지만 인식률이 낮았다. 이를 해결하기 위해 이미지 각도 보정 흑배처리 등의 이미지 전처리를 진행한뒤 필요한 텍스트가 있는 곳을 상대좌표로 확대해 OCR을 진행했다.
 이후 텍스트 후처리를 통해 유사한 글자도 인식하도록 했다.
<br>
</p>
<br>
