function generateIcon(selectedValue) {
  var cat_icon = '';

  switch (selectedValue) {
    case '급여':
      cat_icon = '<i class="fas fa-wallet table-icon"></i>';
      break;
    case '저축':
      cat_icon = '<i class="fas fa-piggy-bank table-icon"></i>';
      break;
    case '통신비':
      cat_icon = '<i class="fas fa-mobile-alt table-icon"></i>';
      break;
    case '교통비':
      cat_icon = '<i class="fas fa-bus table-icon"></i>';
      break;
    case '주거비':
      cat_icon = '<i class="fas fa-home table-icon"></i>';
      break;
    case '식비':
      cat_icon = '<i class="fas fa-utensils table-icon"></i>';
      break;
    case '보험':
      cat_icon = '<i class="fas fa-hand-holding-medical table-icon"></i>';
      break;
    case '반려동물':
      cat_icon = '<i class="fas fa-paw table-icon"></i>';
      break;
    case '생활용품':
      cat_icon = '<i class="fas fa-shopping-basket table-icon"></i>';
      break;
    case '의료비':
      cat_icon = '<i class="fas fa-briefcase-medical table-icon"></i>';
      break;
    case '교육비':
      cat_icon = '<i class="fas fa-school table-icon"></i>';
      break;
    case '경조교제비':
      cat_icon = '<i class="fas fa-handshake table-icon"></i>';
      break;
    case '문화생활':
      cat_icon = '<i class="fas fa-theater-masks table-icon"></i>';
      break;
    case '차량유지비':
      cat_icon = '<i class="fas fa-car table-icon"></i>';
      break;
    case '투자':
      cat_icon = '<i class="fa-solid fa-arrow-trend-up table-icon"></i>';
      break;  // 투자 케이스에 break 추가
    default:
      // 기본값 설정
      cat_icon = '<i class="fas fa-question table-icon"></i>'; // 원하는 기본값으로 변경 가능
  }

  return cat_icon;
}
