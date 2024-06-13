<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js' />"></script>
</head>
<body>
    <div id="app">
        <!-- 탑 영역  -->
        <jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>

        <div id="main">
            <!-- 반응형 메뉴바 -->
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none"> <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
            <!-- 메뉴 끝 -->

            <!-- 게시글 작성 폼 -->
            <div class="container">
                <h2>게시글 작성</h2>
                <form id="boardForm" action="<c:url value='/boardWriteDo' />" method="post" onsubmit="return fn_check()">
                    <table class="table table-striped table-bordered">
                        <tr>
                            <th>제목</th>
                            <td><input class="form-control input-sm" type="text" name="boardTitle" required="required"></td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td><input class="form-control input-sm" type="text" name="memId" required="required"></td>
                        </tr>
                        <tr>
                       <th>분류</th>
                       <td>
                          <select name="boCategory" class="form-control input-sm">
                             <option value="">---선택---</option>
                             <c:forEach items="${comList }" var="code">
                                <option value="${code.commCd }">${code.commNm }</option>
                             </c:forEach>
                          </select>
                       </td>
                    </tr>
                        <tr>
                            <th>내용</th>
                            <td><textarea class="form-control" id="content" name="boardContent" rows="5" ></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button type="submit" class="btn btn-primary">전송</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- 게시글 작성 폼 끝 -->

            <!-- footer 영역 -->
            <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
        </div>
    </div>
</body>
<script type="text/javascript">
    var oEditors = [];
    $(document).ready(function(){
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "content",
            sSkinURI: "<c:url value='/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html' />",
            htParams: {
                bUseToolbar: true,
                bUseVerticalResizer: true,
                bUseModeChanger: true,
                bSkipXssFilter: true,
                fOnBeforeUnload: function(){
                    alert("전송!");
                }
            },
            fCreator: 'createSEditor2'
        }); 
    });

    function fn_check(){
        // Update the textarea with the editor's content
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

        // Check the textarea's content
        var content = document.getElementById("content").value;
        if(content == '' || content == null || content == '&nbsp;' || content =='<p>&nbsp;</p>'){
            alert("내용을 입력하세요!!");
            return false;
        }

        if(!confirm("전송할까요?")){
            return false;
        }
        alert("전송하였습니다.");
        return true;
    }
</script>
</html>
