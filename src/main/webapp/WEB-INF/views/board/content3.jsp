<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <!--  이 구문을 넣으면 jQuery를 쓸 수 있다. -->
        <script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>


</head>


<script>


function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}  


function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
       	 
       	 var count = 0;
       	 $('#i_imageFileName'+count).attr('src', e.target.result);
       	 //$('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}  

</script>



<style>

.grid {
     
        margin: 0 auto;
        text-align: center; /*inline-block의 장점은 폰트의 성질도 포함되고 있어서 text-align으로 정렬을 쉽게 할수가 있다.*/
        font-size: 0; /*양 옆쪽, 밑에 4px정도 여백을 없에주는 방법 하지만 크로스브라우징 호환성헤서는 문제가 있다.*/
}




   		
            table, th, td  { border: 1px solid; }
            th, td         { padding: 4px; }
            /* Additional style */
            thead tr       { background-color: #cccccc; }
            td.center      { text-align: center; }
            td.right       { text-align: right; }
            
            
.button {

  background-color: red;

  border: none;

  color: white;

  padding: 5px 10px;

  text-align: center;

  text-decoration: none;

  display: inline-block;

  font-size: 12px;

  margin: 4px 2px;

  cursor: pointer;
  
  WIDTH: 50pt;

}

.update-button {

  background-color: #1E96FF;

  border: none;

  color: white;

  padding: 5px 10px;

  text-align: center;

  text-decoration: none;

  display: inline-block;

  font-size: 12px;

  margin: 4px 2px;

  cursor: pointer;
  
  WIDTH: 50pt;

}

.to-list {

  background-color: #969696;

  border: none;

  color: white;

  padding: 5px 10px;

  text-align: center;

  text-decoration: none;

  display: inline-block;

  font-size: 12px;

  margin: 4px 2px;

  cursor: pointer;
  
  WIDTH: 50pt;

}



.size2 {

width: 150px

}

.downlord {
border:none;
cursor:pointer;
background-color:transparent;
}

.position {

position: relative;
left:1250px;

}



 
</style>
 <!--      width: 100%;-->
 

<body>

<br>

<table align="center" width="800" style="text-align:center; border-color: white;    border-style: dashed;">

<tr style="background-color :#1E82FF">
<td ><a href="<c:url value='/board/list/'/>" style="color:white;">일반게시판</a></td>
<td ><a href="<c:url value='/board/list2/'/>" style="color:white;">첨부파일 게시판</a></td>
<td ><a href="<c:url value='/board/list3/'/>" style="color:white;">다중 첨부파일 게시판</a></td>
<td ><a href="<c:url value='/board/list4/'/>" style="color:white;">댓글 게시판</a></td>
</tr>
</table>

<br>
<br>

					<table align="center">
				
						<tbody>
						
 						
						<tr>
							<td scope="row"  align="center">제목</td>
							<td class="size">${article.title}</td>
					<%-- 		<td><input style="border:none" class="size" type="text" id="i_title" name="title" value="${article.title}" readonly/></td> --%>
						</tr>
						<tr>
						    <td scope="row"  width=30 align="center">작성자</td>
						    <td id="check">${article.writer}</td>
							<%-- <td><input style="border:none" class="size2" type="text" id="i_title" name="writer" value="${article.writer}" readonly/></td>	 --%>					
						</tr>
						<tr>
							<td scope="row" width=30 align
							="center">내용</td>
							<td colspan="3"><textarea id="i_content" name="content" cols="90" rows="10" readonly>${article.content}</textarea></td>
						</tr>
						
		 <c:if test="${not empty imageFileList && imageFileList!='null' }">
                 <!-- 밖에다 써야함. -->
                 
                <div id="num">
			   <c:set var="count" value="0"/>
			   </div>
			   
	 		 <c:forEach var="item" items="${imageFileList}" varStatus="status" >
		    <tr>
			    <td width="150" align="center" rowspan="2">
			          첨부파일${status.count }
			   </td>
			   <td>
			     <input  type= "hidden" name="originalFileName" value="${item.imageFileName }" />	
			     <!-- 추가 --> 
			     <c:set var="aa" value="preview${count }"/>
			     
			      <input id="imageFileNO" type="hidden" name="imageFileNO" value="${item.imageFileNO}"/>
	 			 
	 		
		
				
			  	<!-- 배열요소를 반복해서 처리할 수 있다? -->
				 <c:forTokens var="ext" items="${item.imageFileName}" delims="." varStatus="status_token">  	     
				
				<!--  마지막 루프 -->							    
				<c:if test="${status_token.last}">
				<c:choose>
				<c:when test="${ext eq 'txt'}">
			    <img class="imageclass" src="${contextPath}/download.do?boardNo=${article.boardNo}&imageFileName=${item.imageFileName}" id="" width="200"  onerror="this.style.display='none';"/> 
				</c:when>
				<c:otherwise>
			    <img class="imageclass2" src="${contextPath}/download.do?boardNo=${article.boardNo}&imageFileName=${item.imageFileName}" id="${aa}" width="200"/> 
				</c:otherwise>
				</c:choose>
				</c:if>
			
				</c:forTokens>
				
				
				<form id="formimagedown" method="post" action="${contextPath}/download.do?boardNo=${article.boardNo}&imageFileName=${item.imageFileName}">

			    다운로드:<input class="downlord" type="submit" value="${item.imageFileName}" />
				</form>
				
					 <c:set var="count" value="${count +1 }" />
								   
			    	 <%--    <img src="${contextPath}/download.do?boardNo=${article.articleNO}&imageFileName=${item.imageFileName}" id="${aa}" /><br> --%>
			   </td>   
			  </tr>  
			  <tr>
			<%--     <td>  
			    <!--  인자로  img 태그 id값도 보낸다. --> <!-- 여기선 imageFileName이 board_type의 역할을 한다. -->
			       <input  class="selectimage" type="file"  name="imageFileName" id="i_imageFileName" disabled   onchange="readURL(this, '${aa}');"   />
			    </td> --%>
			 </tr>
			 
			 
		</c:forEach>
	
		</c:if>
		
	
						</tbody>
</table>

 <form id="formObj" action="<c:url value='/board/delete3'/>" method="post">  

   		  <input type="hidden" name="boardNo" value="${article.boardNo}">
          <input type="hidden" name="page" value="${p.page}">
          <input type="hidden" name="countPerPage" value="${p.countPerPage}">
          <input type="hidden" name="imageFileName" value="${article.imageFileName}">



<div class="position">
    <input id="modBtn" class="update-button" type="button" value="수정" class="btn" id="">
    <input type="submit" class="button" value="삭제" id="" onclick="return confirm('정말로 삭제하시겠습니까?')">
    <input type="button" class="to-list" value="목록" class="btn" id="list-btn">
</div>

</form>


		
<c:forEach var="image" items="${imageFileList}" varStatus="status">
<c:if test="${not empty image.imageFileName}">
		
</c:if>	

</c:forEach>


</body>

<script>


//제이쿼리 시작
$(function() {
	
	$("#list-btn").click(function() {
	
		console.log("목록 버튼이 클릭됨");
		location.href='/board/list3?page=${p.page}' 
				+ '&countPerPage=${p.countPerPage}';		
		
	});
	
	
	const formElement = $("#formObj"); 
	
	var modifyBtn = $("#modBtn");
	modifyBtn.click(function() { //클릭 했을때 생성되는 이벤트 처리
		console.log("수정 버튼이 클릭됨!");
		formElement.attr("action" , "/board/modify3");//attr(속성 , 변경값 ) 태그의 내부 속성을 변경 , action 속성을 /board/modify로 변경
		formElement.attr("method", "get"); 
		formElement.submit();
	});
	
	  var count = 0;
	  
	  //.class로 접근하면 차례대로 변한다.
	  $(".selectimage").click(function() {
		    
		  //alert('');
		  
		  $('#i_imageFileName').attr(
				  "name" , "file" + count++
				);	 	  
  }); 	
  	
});

</script>

</html>