package com.spring.mvc.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.mvc.board.model.BoardVO;
import com.spring.mvc.board.model.BoardVO_third;
import com.spring.mvc.board.model.BoardVO_two;
import com.spring.mvc.board.model.ImageVO;
import com.spring.mvc.board.repository.IBoardMapper;
import com.spring.mvc.board.repository.second_IBoardMapper;
import com.spring.mvc.board.repository.third_IBoardMapper;
import com.spring.mvc.commons.SearchVO;

@Service
public class BoardService implements IBoardService {

	private static final String ARTICLE_IMAGE_REPO = "C:+File.separator+board+File.separator+article_image";
	
	@Inject
	private IBoardMapper mapper;
	
	@Inject
	private second_IBoardMapper mapper2;
	
	@Inject
	private third_IBoardMapper mapper3;

	@Override
	public void insert(BoardVO article) {
			
		System.out.println("Debug "  + article.toString());		
				 mapper.insert(article);
	}
				
	
	@Override
	public BoardVO getArticle(Integer boardNo, HttpServletRequest request, HttpServletResponse response) {
	

		   Cookie[] cookies = request.getCookies(); //모든 ㅋ
	        
	        // 비교하기 위해 새로운 쿠키
	        Cookie viewCookie = null;
	      
	        // 쿠키가 있을 경우 
	        if (cookies != null && cookies.length > 0) 
	        {
	            for (int i = 0; i < cookies.length; i++)
	            {
	                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
	                if (cookies[i].getName().equals("cookie"+boardNo))
	                { 
	                    //System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
	                    int limitTime = 300;
	                   viewCookie = cookies[i];
	                   viewCookie.setMaxAge(limitTime);
	                }
	            }
	        }
	        
	        //처음에는 무조건 여기로 떨어지겠지?
	        if (viewCookie == null) {  //쿠키가없어야만 조회수 증가로직 처리
                System.out.println("cookie 없음");
                
              
                // 쿠키 생성(이름, 값)
                Cookie newCookie = new Cookie("cookie"+boardNo, "|" + boardNo + "|");
                newCookie.setMaxAge(300);
                                
                // 쿠키 추가
                response.addCookie(newCookie); 
                
        		mapper.updateViewCnt(boardNo);
        		return mapper.getArticle(boardNo);
        		
	        } else { //viewCookie가 있다면 여기로 빠지는데
	        	
	        	if (viewCookie.getMaxAge() < 1) {
	        	
	        	mapper.updateViewCnt(boardNo);
	        	
	        	}
	        	
	        	return mapper.getArticle(boardNo);
	    		
	        }
		

		

	}

	@Override
	public void update(BoardVO article) {
		mapper.update(article);
		
	}

	@Override
	public void delete(Integer boardNo) {
		mapper.delete(boardNo);
		
	}

	@Override
	public List<BoardVO> getArticleList(SearchVO search) {
		
		List<BoardVO> list = mapper.getArticleList(search);
		
		
		return list;
	}

	
	@Override
	public Integer countArticles(SearchVO search) {
		
		return mapper.countArticles(search);
	}

	@Override
	public Integer viewCount(int boardNo) {
		//
		return mapper.viewCount(boardNo);
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	//첨부파일 글쓰기~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@Override //insertNewAritlce로직을 다실행해야한다.
	public int addNewArticle(Map articleMap) throws Exception{
		
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO); 
		
		mapper2.insertNewArticle(articleMap);
		
		return articleNO; 
	}
	
	private int selectNewArticleNO() throws DataAccessException {
		return mapper2.selectNewArticleNO();
	}
	
	

	@Override
	public BoardVO_two getArticle2(Integer boardNo, HttpServletRequest request, HttpServletResponse response) {
		
		
		   Cookie[] cookies = request.getCookies(); //모든 ㅋ
	        
	        // 비교하기 위해 새로운 쿠키
	        Cookie viewCookie = null;
	      
	        // 쿠키가 있을 경우 
	        if (cookies != null && cookies.length > 0) 
	        {
	            for (int i = 0; i < cookies.length; i++)
	            {
	                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
	                if (cookies[i].getName().equals("cookie"+boardNo))
	                { 
	                    //System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
	                    int limitTime = 300;
	                   viewCookie = cookies[i];
	                   viewCookie.setMaxAge(limitTime);
	                }
	            }
	        }
	        
	        //처음에는 무조건 여기로 떨어지겠지?
	        if (viewCookie == null) {  //쿠키가없어야만 조회수 증가로직 처리
             System.out.println("cookie 없음");
             
           
             // 쿠키 생성(이름, 값)
             Cookie newCookie = new Cookie("cookie"+boardNo, "|" + boardNo + "|");
             newCookie.setMaxAge(300);
                             
             // 쿠키 추가
             response.addCookie(newCookie); 
             
     		mapper2.updateViewCnt2(boardNo);
     		return mapper2.getArticle2(boardNo);
     		
	        } else { //viewCookie가 있다면 여기로 빠지는데
	        	
	        	if (viewCookie.getMaxAge() < 1) {
	        	
	        	mapper2.updateViewCnt2(boardNo);
	        	
	        	}
	        	
	        	return mapper2.getArticle2(boardNo);
	    		
	        }
		
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//첨부파일 게시판 수정
	@Override
	public void updateArticle(Map articleMap) throws Exception{
		
		System.out.println("서비스 articleMap" + articleMap);
		mapper2.updateArticle(articleMap);
	
		
	}
	public void update2(Map articleMap) throws Exception{
		
		System.out.println("서비스 articleMap" + articleMap);
		mapper2.update2(articleMap);
	
		
	}
	
	

	@Override
	public void delete2(Integer boardNo) {
		mapper2.delete2(boardNo);
		
	}

	@Override
	public List<BoardVO_two> getArticleList2(SearchVO search) {
	
		List<BoardVO_two> list = mapper2.getArticleList2(search);
		
		return list;
	}

	@Override
	public Integer countArticles2(SearchVO search) {
		// TODO Auto-generated method stub
		return mapper2.countArticles2(search);
	}

	@Override
	public Integer viewCount2(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////
	//다중 첨부파일
	//////////////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public int insertNewArticle3(Map articleMap) throws DataAccessException {
		
		int boardNo = mapper3.insertNewArticle3(articleMap);
		articleMap.put("boardNO" , boardNo);
		mapper3.insertNewArticle3(articleMap);
		return boardNo;
	}
	
	
	
	@Override
	public BoardVO_third getArticle3(Integer boardNo, HttpServletRequest request, HttpServletResponse response) {
		
		
		   Cookie[] cookies = request.getCookies(); 
		   
		   System.out.println("최초의 cookies: " + cookies);
	        
	        // 비교하기 위해 새로운 쿠키
	        Cookie viewCookie = null;
	      
	        // 쿠키가 있을 경우 
	        if (cookies != null && cookies.length > 0) 
	        {
	            for (int i = 0; i < cookies.length; i++)
	            {
	                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
	                if (cookies[i].getName().equals("cookie"+boardNo))
	                { 
	                    //System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
	                    int limitTime = 300;
	                   viewCookie = cookies[i];
	                   viewCookie.setMaxAge(limitTime);
	                }
	            }
	        }
	        
	        //처음에는 무조건 여기로 떨어지겠지?
	        if (viewCookie == null) {  //쿠키가없어야만 조회수 증가로직 처리
             System.out.println("cookie 없음");
             
           
             // 쿠키 생성(이름, 값)
             Cookie newCookie = new Cookie("cookie" + boardNo, "|" + boardNo + "|");
             newCookie.setMaxAge(300);
                             
             
             // 쿠키 추가
             response.addCookie(newCookie); 
             
             //조회수 업데이트문
     		mapper3.updateViewCnt3(boardNo);
     		
     		return mapper3.getArticle3(boardNo);
     		
	        } else { //viewCookie가 있다면 여기로 빠지는데
	        	
	        	if (viewCookie.getMaxAge() < 1) {
	        	
	        	mapper3.updateViewCnt3(boardNo);
	        	
	        	}
	        	
	        	return mapper3.getArticle3(boardNo);
	    		
	        }
		
	}
	
	
	

	@Override
	public void updateViewCnt3(Integer boardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete3(Integer boardNo) {
		mapper3.delete3(boardNo);
		
	}
	
	public void deleteImageFile(int imageFileNo) {
		System.out.println(imageFileNo);
		mapper3.deleteImageFile(imageFileNo);
	}
	

	@Override
	public void updateArticle3(Map articleMap) throws DataAccessException {
		
		//articleMap을 넘겨서 정상적으로 데이터가 수정이된다.
		mapper3.updateArticle3(articleMap); 

		List<ImageVO> imageFileList = (ArrayList) articleMap.get("imageFileList");
		
		System.out.println("=========================");
		System.out.println(">size="+imageFileList.size());
	
		
		//imageFileList에 바뀐 imageFileName 이미지가 들어온다.
		
	
		for(ImageVO imageVO : imageFileList) {
			System.out.println(">> start for");
			
			if(imageVO.getImageFileName() != null && imageVO.getImageFileName() != "") {
		
			  String imageFileName = imageVO.getImageFileName(); 
			  int boardNo = imageVO.getBoardNo();
			  int imageFileNO = imageVO.getImageFileNO();
		  		
			  System.out.println("DAO까지 파일이름이 넘어왔는가?: " + imageFileName);
			  System.out.println("DAO까지 글번호가 넘어왔는가?: " + boardNo); 
			  System.out.println("DAO까지 이미지번호가 넘어왔는가?: " + imageFileNO);

			  articleMap = imageFileList.stream()
				      	.collect(Collectors.groupingBy( arg -> arg, HashMap::new, Collectors.counting()));

			  
			  mapper3.updateNewImage(imageVO);
		  }
		
		}
	}
		
		
	
	@Override
	public void update3(Map articleMap) throws DataAccessException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardVO_third> getArticleList3(SearchVO search) {
			
			List<BoardVO_third> list = mapper3.getArticleList3(search);
		
		return list;
	}

	@Override
	public Integer countArticles3(SearchVO search) {
	
		return mapper3.countArticles3(search);
	}

	@Override
	public Integer viewCount3(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectNewArticleNO3() {
		// TODO Auto-generated method stub
		return mapper3.selectNewArticleNO3();
	}

	@Override //insertNewAritlce로직을 다실행해야한다.
	public int addNewArticle3(Map articleMap) throws Exception{
		
		
		//selectNewArticleNO3(): SELECT  IFNULL(MAX(board_no), 0) + 1 from new_board3
		int boardNo = mapper3.selectNewArticleNO3();
		

		System.out.println("등록시 boardNo" + boardNo);
		
		articleMap.get("boardNo");
		
		//이건 이미지글 번호 없는 글 수정할때 가져오는 번호 -- 일단 확인된바 없음.
	
		 //추측임: articleMap.get("boardNo")의 객체를 toString()으로 나타내어 String으로 나타낸다. 
		 //Integer.parseInt: String값을 +- 를 지닌 십진수 정수로 분석한다. 
		int boardNo_map = Integer.parseInt(articleMap.get("boardNo").toString());
		//int boardNo_map2 = Integer.parseInt((String) articleMap.get("boardNo"));
		
		//컨트롤러에서 리턴된 글 번호와 selectNewArticleNO3()에서 가져온 글번호가 같지 않을 경우
		if( boardNo_map != boardNo) {
			
			//delete3: DELETE FROM new_board3 WHERE board_no = #{boardNo}
			delete3(boardNo_map);
			
			//그리고 그 boardMap을 다시 넣고
			articleMap.put("boardNo_map1",boardNo_map);
			
		//일단 디버깅 했을때 저 if문을 타지 않고 바로 else문으로 떨어진다. 
		//왜냐면 	@GetMapping("/write_and_modify3")에서 등록화면으로 넘어갈시에,  																									
		//int boardNo = service.selectNewArticleNO3(); model.addAttribute("boardNo" , boardNo);하여 이미 새글번호를 보내준다.
		//따라서 articleMap.get("boardNo")에서 가져온 값이 같기 때문에 else문으로 떨어진다.
			
			
		} else {
			
			//새글번호를 put하는데 else문이면 굳이 하지않아도 되지 않나 싶다.
			articleMap.put("boardNo", boardNo);
		}

		 mapper3.insertNewArticle3(articleMap);
		
		//articleMap.get("imageFileList")의 값을 List<imageVO>타입을 받는 imageFileList에다 넣어줌.
		//일단 Map에대한 공부가 필요해보임.
		List<ImageVO> imageFileList = (ArrayList<ImageVO>)articleMap.get("imageFileList");
		
		System.out.println("boarservice3의 articleMap" + articleMap);
		
		//System.out.println("insertNewArticle3_boardNo" + insertNewArticle3_boardNo + "번");
		
		//SELECT IFNULL(MAX(imageFileNO) ,0) + 1 from t_imageFile;	
		int imageFileNO = selectNewImageFileNO3(); //MAX값 가져오는것.
		//int new_boardNo = Integer.parseInt(articleMap.get("boardNo").toString());
		
		for(ImageVO imageVO : imageFileList){
			//최초로 imageFileNO가 256이 들어간 이후에 코드가 실행된 이후 곧바로 257이 된다.
			imageVO.setImageFileNO(++imageFileNO); 
			
			//이미지 글번호가 없는 글 수정할때 번호랑 새글 번호가 맞지 않을시
			if(boardNo_map != boardNo) {
				
				imageVO.setBoardNo(boardNo_map); 
				
		  
			}
				//if문 안걸리면 그냥 하면되고.
				
				imageVO.setBoardNo(boardNo); 
			
			
			System.out.println("파일 이름:" + imageVO.getImageFileName());
		}
				
		return mapper3.insertNewImage3(articleMap);
		
	}

	@Override
	public int selectNewImageFileNO3() throws DataAccessException {
	
		return mapper3.selectNewImageFileNO3();
	}

	@Override
	public List <ImageVO>selectImageFileList(int articleNO) throws DataAccessException {
	
		return mapper3.selectImageFileList(articleNO);
	}

	@Override
	public List selectImageFileList3() throws DataAccessException {
	
		return mapper3.selectImageFileList3();
	}

	@Override
	public List<ImageVO>selectImageFileNO(int articleNO) throws DataAccessException {
	
		return mapper3.selectImageFileNO(articleNO);
	}

	@Override
	public int addNewArticle3(Map articleMap, HttpServletRequest request) throws Exception {
	
		return 0;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
