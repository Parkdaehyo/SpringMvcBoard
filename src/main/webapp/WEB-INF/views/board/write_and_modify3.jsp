<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 포맷팅 관련 태그라이브러리(JSTL/fmt) --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


  		<script
 		src="https://code.jquery.com/jquery-3.5.0.min.js" 
		integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
 		crossorigin="anonymous"></script>

</head>

<style>


.save {

background-color:red

}

.to-list {

background-color:#969696

}


.grid {
     
        margin: 0 auto;
        text-align: center; /*inline-block의 장점은 폰트의 성질도 포함되고 있어서 text-align으로 정렬을 쉽게 할수가 있다.*/
        font-size: 0; /*양 옆쪽, 밑에 4px정도 여백을 없에주는 방법 하지만 크로스브라우징 호환성헤서는 문제가 있다.*/
}

.size {

width: 615px

}

.size2 {

width: 150px

}

table, th, td  { border: 1px solid; }
th, td         { padding: 4px; }
         
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


.button2 {

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

.span_tag_removeimgclass {

cursor:pointer;

}
</style>


<body>


<br>

<table align="center" width="800" style="text-align:center; border-color: white;">

<tr style="background-color :#1E82FF">
<td ><a href="<c:url value='/board/list/'/>" style="color:white;">일반게시판</a></td>
<td ><a href="<c:url value='/board/list2/'/>" style="color:white;">첨부파일 게시판</a></td>
<td ><a href="<c:url value='/board/list3/'/>" style="color:white;">다중 첨부파일 게시판</a></td>
<td ><a href="<c:url value='/board/list4/'/>" style="color:white;">댓글 게시판</a></td>
</tr>
</table>

<br>
<br>
<!-- 
여백 지정
margin 5px 7px 3px 0px; (위, 오른쪽, 아래, 왼쪽 순)
 -->

 					<!--  form role == 부트스트랩 -->
 					<form id= "formObj" name="articleForm" method="post"  action="${contextPath}/board/write3" enctype="multipart/form-data" accept-charset="UTF-8">
 
					<table align="center">
						<tbody>
						<!--  이 페이지는 
						
						저장과 수정이 같은 한 화면이기 때문에
						write2.jsp로 진입할시에 value의 aritlce 값들은
						전혀 표시가 안된다.
						 -->
						 <c:if test="${A == 1}">
						<input type="hidden" id="ABC" name="boardNo" value="${boardNo}" />
						</c:if>
						<c:if test="${A == 2}">
						<input type="hidden" id="DEF" name="boardNo" value="${article.boardNo}"/>	
						</c:if>
				
 						 <!--  write.jsp에서 p객체가 넘어왔고 역시나 수정을 할때 페이지 객체정보가 넘어가기때문에
 						 
 						 /board/modify post요청에서 searchvo에서 조회문에 들어갔을때 저장된 페이지정보가
 						 셋팅된다.
 						  -->
 						  
 					
          				<input type="hidden" name="page" value="${p.page}">
          				<input type="hidden" name="countPerPage" value="${p.countPerPage}">
 						
 						
 						<!--  왜 제목에 width를 설정했는데 다 바뀌는거지? -->
						<tr>
							<td width="100"  scope="row"  align="center">제목</td>
							<td><input class="size" type="text" id="title" name="title" value="${article.title}" /></td>
						</tr>
						<tr>
						    <td scope="row"  width=30 align="center">작성자</td>
							<td><input class="size2" type="text" id="writer" name="writer" value="${article.writer}" /></td>						
						</tr>
						<tr>
							<td scope="row" width=30 align="center">내용</td>
							<td colspan="3" id=""><textarea id="content" name="content" cols="90" rows="10">${article.content}</textarea></td>
						
						</tr>
				
					<c:choose>
					
					<c:when test="${not empty imageFileList && imageFileList!='null' }">
					
					    <!-- 밖에다 써야함. -->
			   <c:set var="count" value="0"/>
	 	
	 	
	 		 <c:forEach var="item" items="${imageFileList}" varStatus="status" >
	 		 
	 		 	<tr>
	 		 	 <input class="GUBUNCLASS" type="hidden" name="GUBUN" value="1">
	 		 	 
	 			 <input id="imageFileNO" type="hidden" name="imageFileNO" value="${item.imageFileNO}"/>
	 			 
	 			 <c:out value="${item.imageFileNO}"/> 
	 			

			    <td width="150" align="center" rowspan="2">
			          첨부파일${status.count }
			   </td>
			   
			   
			   <td>
			     <input id="original" type="hidden" name="originalFileName" value="${item.imageFileName}" />	
			     
			 <%--      <c:out value="${item.imageFileName}"/> --%>
			     <!-- 추가 --> 
			     <c:set var="aa" value="preview${count}"/>
			   <!--   <c:out value="${aa}" /> -->	
			     <!-- id="preview"에서 ${aa}로 바꿈 -->
			     		     	     
			    <p><img name="imgname" id="imageshow" class="imgtagclass" src="${contextPath}/download.do?boardNo=${article.boardNo}&imageFileName=${item.imageFileName}"  width="200"
			    style="display:visible"/>
			 
			    <span class="span_tag_removeimgclass">x</span></p>
		
			     
			   </td> 
			   
			  </tr>
			  
			  <tr>
			    <td>  
			    <!-- 기존 파일선택 -->
			       <input class="selectimage" type="file"  name="file" id="i_imageFileName" onchange="readURL(this, '${aa}');" />
			     <input class="new_file_GUBUN" type="hidden" name="new_file" value="1" />
			    </td>	
			 </tr>
			 
			 <c:set var="count" value="${count +1 }" />

			 <!--  파일추가 -->
			 <tr>
			  <c:if test="${status.last}">
			 <td style="text-align: center">파일추가</td>
			
			  <td> <input type="button" class="add_fileimage" id="file_route_modify" name="file_route" value="파일추가" onClick="fn_addFile_modify()"/>	
			  
			     <input class="new_file_GUBUN" type="hidden" name="new_file" value="1" />
			  </td>
			
			 </c:if>
			 </tr>
			
			</c:forEach>
			
			 	<tr> <!-- tr이 빠지면 옆으로 갈라진다?? -->
			 	
			     <td colspan="4">
			     <div class="new_file_div_GUBUN" id="d_file2" name="All_file">
			    <!--  $("#d_file2").append("<br>"+"<input type='file' name='NEWFILE" +cnt+"' />"); 추가됨. -->
			     <input class="new_file_GUBUN" type="hidden" name="new_file" value="1" />
			     </div>		
			     </td>

		   	  </tr>
			</c:when>
					
			
			<c:otherwise>
			
						<tr>
						<td width=30 align="center">첨부파일</td>
						
						
						<div class="file_input">
						<td>
						
						 <input type="button" id="file_route" name="file_route" value="파일추가" onClick="fn_addFile()"/>
					
					
						</div>
						</td>	
						</tr>
	      				
						<tr>
	      				<td colspan="4"><div id="d_file" name="All_file"></div></td>
	      				<!--  여기에 글쓰기 할때 생성됨 -->
	      				<!-- 만일  
	      				파일추가가 되지 않았다면, 그 요소를 삭제한다
	      				-->
	      				
	      				
	  					 </tr>
	  					 
							<input type="hidden" id="A" name="aaa" value="${A}" />
			
						</c:otherwise>
					</c:choose>
						</tbody>
                    </table>

						 

<div style="position: absolute; left: 1000px;">
<!-- <div align="center" style="right: 700px;"> -->
		<button type="button" id="save" class="button" style="color:white;">저장</button>
	<!-- 	<input id="save" class="save" style="color:white;" type="submit" value="저장"> -->
		<input class="button2" type="button" value="목록" style="color:white;" id="list-btn2">
</div>
</form>

</body>

<script>

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
        	//alert('하하');
       	 
       	 var count = 0;
       //이게 각각의 파일선택이 어디에 업로드를 해줄지 위치를 찾아주는 역할을 한다
       	 $('#i_imageFileName'+ count).attr('src', e.target.result); 
       	 //$('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}  

var cnt=1;
function fn_addFile(){
	  $("#d_file").append("<br>"+"<input type='file' name='file"+cnt+"' />");
	  cnt++;
}  

function fn_addFile_modify() {
$("#d_file2").append("<br>"+"<input class='addnewfile' type='file' name='NEWFILE" +cnt+"' />");
cnt++;
}

//제이쿼리 시작
$(function() {
	
	//파일추가 버튼을 눌렀을시
	$(".add_fileimage").click(function() {
		
	
		$(this).closest("td").find(".new_file_GUBUN").val(1);
		
		
	});
	
	//기존파일이 있는 파일선택을 눌렀을시
	$(".selectimage").click(function() {
		
		$(this).closest("td").find(".new_file_GUBUN").val(0);
		
		
	});
	
	//기존엔 없다가 생성된 DOM이라면 document를 해야한다.
	//input[name=NEWFILE1] -- name으로 접근하기
	//input.addnewfile -- class로 접근하기
	$(document).on("change", $("input.addnewfile"), function(){

		//alert('ㅇㅇ');	
		
		$(this).closest("td").find(".new_file_GUBUN").val(1);
		
	});
	
	
	//파일선택을 눌렀는데 파일을 업로드하지 않으면 그 요소를 제거	
	
	
	//제이쿼리 change 이벤트의 경우 셀렉터를 정하여 해당 셀렉터의 값이 변할경우 변화를 캐치하는 이벤트입니다.
	
	
	
		
	$(".span_tag_removeimgclass").click(function() {
		
		const imgtagclass = $('.imgtagclass');  
		//$(this).siblings() == $(this)에서 가장 가까운 태그
		//$(this)가 .span_tag_removeimgclass에서 실질적으로 선택된 객체를 가리킨다.
		//그리고 $(this).siblings()은 그 선택된 객체들 중 가장 가까운 img태그를 가리킨다.
	      //console.log($(this).siblings()) 
	      alert('이미지삭제버튼 클릭됨!');
		
		const AA = $(this).siblings().attr("style" , "display:none");
		
		//var GUBUN = $('input[name=GUBUN]').val();
		
		//console.log(GUBUN);
		
	if($(this).closest("tr").find(".GUBUNCLASS").val() == 1) {
  	$(this).closest("tr").find(".GUBUNCLASS").val(0)
	} else {
  	$(this).closest("tr").find(".GUBUNCLASS").val(1)
	}
		 
	  });    
	  
	$("#list-btn2").click(function() {
	
		console.log("목록 버튼이 클릭됨");
		location.href='/board/list3?page=${p.page}' 
			+ '&countPerPage=${p.countPerPage}';	
		
	});
	
	
	//파일 추가를 클릭시
	$("#file_route").click(function() {
			
		//model로 전달된 value값을 1로 변경한 후에 board/write3으로 보냄
		  $("#A").val("1"); 

	});
	
	
	$("#file_route_modify").click(function() {
		
		  $("#A").val("2"); 

	});
	
	
	
	
	$(document).ready(function() {
		
	$("#save").click(function() {
	
		var blank_pattern = /^\s+|\s+$/g;
		
		
		var title = $("#title").val();
		var content = $("#content").val();
		var writer= $("#writer").val();
		var A = $("#A").val();
		
		if(title.replace(blank_pattern, "") == "") {
			
			alert("제목을 입력해주시겠습니까?");
			document.articleForm.title.focus();	
			return;
		}
		
		if(writer.replace(blank_pattern, "") == "") {
			
			alert("작성자를 입력해주시겠습니까?");
			document.articleForm.writer.focus();	
			return;
		}	
		
		if(content.replace(blank_pattern, "") == "") {
			
			alert("내용을 입력해주시겠습니까?");
			document.articleForm.content.focus();	
			return;
		}
	
			
		if(A == 1) {
			
			
			document.articleForm.action = "${contextPath}/board/write3"
			document.articleForm.submit();
			
		} else {
		
			const formElement = $("#formObj"); 
			
			formElement.attr("action" , "/board/modify3");//attr(속성 , 변경값 ) 태그의 내부 속성을 변경 , action 속성을 /board/modify로 변경
			formElement.attr("method", "post");
			formElement.submit();
		}

		
	
		console.log("저장 버튼이 클릭됨");
		
	});
	
	});
		  
		  var count = 0;
		  
		  //.class로 접근하면 차례대로 변한다.
		  $(".selectimage").click(function() {
			    
			  //alert('');
			  
			$($(this)).attr("name" , "file" + count++);
			$($(this)).attr('id' , 'i_imageFileName' + count++); 		  
		  	$($(this)).attr('name' , 'imageFileNO' + count++); 	
	  }); 	
	  
	  
	  $("#original").click(function() {
	  
	  $('#original').attr({
			'name' : 'originalFileName' + count++
			
			}); 	
	  });
});

</script>


</html>