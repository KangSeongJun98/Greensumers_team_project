<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="<c:url value="/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js" /> " ></script>
<style>
	th { font-size:20px;}
</style>
</head>
<body>
   <jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
   <section class="page-section" id="contact" style="margin-top: 200px;">
<!--       <div class="container" style="margin-top: 100px;"> -->
<!--       <div class="row justify-content-center" style="background-color:white;"> -->
<%--         <form action="<c:url value='/freeBoardWriteDo' />" method="post" onsubmit="return fn_check()"> --%>
<!--                 <table class="table center-table"> -->
<!--                     <tr> -->
<!--                         <th style="text-align:center;">제목</th> -->
<!--                         <td><input class="form-control input-sm" type="text" name="boTitle" required="required"></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th style="text-align:center;">작성자</th> -->
<!--                         <td><input class="form-control input-sm" type="text" name="boWriter" required="required"></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th style="text-align:center;">비밀번호</th> -->
<!--                         <td><input class="form-control input-sm" type="password" name="boPass" required="required"></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                        <th style="text-align:center;">분류</th> -->
<!--                        <td> -->
<!--                           <select name="boCategory" class="form-control input-sm"> -->
<!--                              <option value="">---선택---</option> -->
<%--                              <c:forEach items="${comList }" var="code"> --%>
<%--                                 <option value="${code.commCd }">${code.commNm }</option> --%>
<%--                              </c:forEach> --%>
<!--                           </select> -->
<!--                        </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th style="text-align:center;">내용</th> -->
<!--                         <td><textarea  class="form-control input-sm" name="boContent" id="bo_content"></textarea></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <td colspan="2"> -->
<!--                         	<div class="d-grid gap-2 col-6 mx-auto"> -->
<!--                            		<button type="submit" class="btn btn-primary">전송</button> -->
<!--                            </div> -->
<!--                         </td> -->
<!--                     </tr> -->
                    
<!--                 </table> -->
<!--             </form> -->
<!--           </div> -->
<!--       </div> -->
      
      
      <div class="recipe-write-form">
                        <div class="container">
                            <form action="<c:url value='/freeBoardWriteDo' />" method="post" method="post" onsubmit="return fn_check()">
                                <div class="input-group mb-3">
                                    <label for="boTitle"  class="input-group-text">제목</label>
                                    <input type="text" name="boTitle" id="boTitle" value="" class="form-control" placeholder="실천일지 제목을 입력해주세요." required>
                                </div>
                                 <div class="input-group mb-3">
                                    <label for="boWriter" class="input-group-text">작성자</label>
                                    <input type="text" name="boWriter" id="boWriter" value="" class="form-control" placeholder="작성자 이름을 입력해주세요." required>
                                </div>
                                 <div class="input-group mb-3">
                                    <label for="boPass"  class="input-group-text">비밀번호</label>
                                    <input type="password" name="boPass" id="boPass" class="form-control" placeholder="비밀번호를 입력해주세요." required>
                                </div>
                                <div class="input-group mb-3">
                                    <label for="boCategory"  class="input-group-text">분류</label>
                                        <select name="boCategory" id="boCategory" class="form-select" required>
				                             <option value="">---선택---</option>
				                             <c:forEach items="${comList }" var="code">
				                                <option value="${code.commCd }">${code.commNm }</option>
				                             </c:forEach>
				                        </select>
                                </div>
                                <div class="input-group mb-3">
                                    <textarea name="boContent" id="bo_content" class="form-control" style="height:500px; width:100%;" placeholder=''></textarea>
                                </div>
                              	<div class="d-grid col-12 mx-auto">
                           			<button type="submit" class="btn btn-primary">전송</button>
                         	    </div>
                            </form>
                            
                        </div>
                    </div>
   </section>
<%--    <jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include> --%>
</body>
<script type="text/javascript">
     var oEditors = [];
     $(document).ready(function(){
        nhn.husky.EZCreator.createInIFrame({
            oAppRef :oEditors
           ,elPlaceHolder: "bo_content"
           ,sSkinURI : "<c:url value='/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html' />"
           ,htParams:{
               bUseToolbar : true //  툴바 사용여부
              ,bUseVerticalResier : true // 입력창 크기 조절바 사용여부
              ,bUseModeChanger : true // 모든 탭(html, text, editor)
                ,bSkipXssFileter : true // xss 공격 무시여부
                ,fOnBeforeUnload : function(){
                   alert("전송!");
                }
           },
           fCreator : 'createSEditor2'
        });
     });
     
     function fn_check(){
        oEditors.getById['bo_content'].exec("UPDATE_CONTENTS_FIELD", []);
        let content = document.getElementById('bo_content').value;
        if(content == '' || content == null || content == '&nbsp;'
          || content =='<p>&nbsp;</p>'){
           alert("내용을 입력하세요!!");
           return false;
        }else{
           if(confirm("전송할까요?")){
             alert("전송하였습니다."); 
           }else{
              return false;
           }
        }
     }

</script>
</html>






