document.addEventListener('DOMContentLoaded', function() {
    var date = new Date();
    var currentYear = date.getFullYear();
    var currentMonth = ("0" + (date.getMonth() + 1)).slice(-2);  // 현재 월을 2자리 형식으로 가져옴
    var selectedYear = currentYear;

    // 초기 로드 시 yearMonth 값 설정
    var yearMonth = document.getElementById('monthPicker').value;
    if (!yearMonth) {
        yearMonth = currentYear + '-' + currentMonth;
        document.getElementById('monthPicker').value = yearMonth;
    }
    document.getElementById('selectedMonth').textContent = yearMonth.split('-')[1] + '월';

    function updateCalendar() {
        document.getElementById('year').textContent = selectedYear;
        var months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
        var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
        var calendarMonths = document.getElementById('calendarMonths');
        calendarMonths.innerHTML = '';
        months.forEach(function(month, index) {
            var monthDiv = document.createElement('div');
            monthDiv.textContent = monthNames[index];
            monthDiv.dataset.month = month;
            calendarMonths.appendChild(monthDiv);
        });
    }

    function toggleCalendar() {
        var calendar = document.getElementById('calendar');
        calendar.style.display = (calendar.style.display === 'block') ? 'none' : 'block';
    }

    function hideCalendar() {
        document.getElementById('calendar').style.display = 'none';
    }

    // 'selectedMonth' 클릭 시 달력 표시/숨김
    document.getElementById('selectedMonth').addEventListener('click', function(event) {
        event.stopPropagation(); // 이벤트가 상위 요소로 전파되는 것을 막음
        toggleCalendar();
    });

    document.getElementById('prevYear').addEventListener('click', function(event) {
        event.stopPropagation(); // 이벤트가 상위 요소로 전파되는 것을 막음
        selectedYear--;
        updateCalendar();
    });

    document.getElementById('nextYear').addEventListener('click', function(event) {
        event.stopPropagation(); // 이벤트가 상위 요소로 전파되는 것을 막음
        selectedYear++;
        updateCalendar();
    });

    document.getElementById('calendarMonths').addEventListener('click', function(event) {
        event.stopPropagation(); // 이벤트가 상위 요소로 전파되는 것을 막음
        if (event.target.dataset.month) {
            var month = event.target.dataset.month;
            var selectedMonth = selectedYear + "-" + month;
            document.getElementById('selectedMonth').textContent = month + '월';
            document.getElementById('monthPicker').value = selectedMonth;
            hideCalendar();
            console.log('Selected Year-Month:', selectedMonth);

            // jQuery to get the value and set the yearMonth variable
            var yearMonth = $("#monthPicker").val();
            console.log('yearMonth:', yearMonth);

            // Submit the form
            $("#searchForm").submit();
        }
    });

    // 문서 전체에 클릭 이벤트 추가하여 달력 영역 외부 클릭 시 달력 숨기기
    document.addEventListener('click', function(event) {
        var calendar = document.getElementById('calendar');
        var isClickInside = calendar.contains(event.target) || event.target.id === 'selectedMonth';

        if (!isClickInside) {
            hideCalendar();
        }
    });

    updateCalendar();
});
