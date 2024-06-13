package com.greensumers.carbonbudget.boards.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.boards.service.BoardService;
import com.greensumers.carbonbudget.boards.vo.BoardVO;
import com.greensumers.carbonbudget.boards.vo.ReplyVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
public class BoardController {   
	@Autowired      
	BoardService boardService;    
	private static String CURR_IMATE_PATH ="c:\\tools\\spring_dev\\img";
	
	  
	/*
	 * // 해당 컨트롤러에서 연결되는 모든 화면에서 comList를 모두 사용 가능
	 * 
	 * @ModelAttribute("comList") public ArrayList<CodeVO>getCodeList(){ return
	 * codeService.getCodeList(null); }
	 */
	
	@RequestMapping("/boardView")
	public String boardView(Model model, HttpSession session) {
		ArrayList<BoardVO> boardList = boardService.getBoardList();
		model.addAttribute("boardList", boardList);
		return "board/boardView";
	}

	@RequestMapping("/boardWriteView")
	public String boardWriteView(HttpSession session) {
		if (session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "board/boardWriteView";
	}

	@RequestMapping("/boardWriteDo")
	public String boardWriteDo(HttpSession session, BoardVO board) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("login");
		board.setMemId(vo.getMemId());
		boardService.writeBoard(board);
		return "redirect:/boardView";
	}
	



	@RequestMapping("/boardDetailView")
	public String boardDetailView(int boardNo, Model model) throws Exception {
		BoardVO vo = boardService.getBoard(boardNo);
//		ArrayList<ReplyVO> replyList = boardService.getReplyList(boardNo);
		model.addAttribute("board", vo);
//		model.addAttribute("replyList", replyList);

		return "board/boardDetailView";
	}

	// @RequestMapping은 get post 둘 다 받음 메소드에 추가하면 post만 가능
	@RequestMapping(value = "/boardEditView", method = RequestMethod.POST)
	public String boardEditView(int boardNo, Model model) throws Exception {
		System.out.println(boardNo);
		BoardVO vo = boardService.getBoard(boardNo);
		model.addAttribute("board", vo);
		return "board/boardEditView";
	}

	@RequestMapping("/boardEditDo")
	public String boardEditDo(BoardVO vo) throws Exception {
		boardService.updateBoard(vo);
		return "redirect:/boardView";
	}

	@RequestMapping(value = "/boardDel", method = RequestMethod.POST)
	public String boardDel(int boardNo) throws Exception {
		boardService.deleteBoard(boardNo);
		return "redirect:/boardView";
	}

	// 객체를 joson 형태로 리턴 (@ResponseBody)
	@ResponseBody
	@PostMapping("writeReplyDo") // @RequestBody json 데이터 형태로 요청을 받음
	public ReplyVO writeReplyDo(@RequestBody ReplyVO vo) throws Exception {
		System.out.println(vo);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
		String uniqu = sdf.format(date);
		vo.setReplyNo(uniqu);
		boardService.writeReply(vo);
		ReplyVO result = boardService.getReply(uniqu);
		return result;
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/replyDel", method = RequestMethod.POST)
	public String clippingDel(@RequestBody ReplyVO vo, RedirectAttributes re, Model model) {
		try {
			boardService.replyDel(vo);
			System.out.println("삭제 정상처리");
			return "Y";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "N";
	}
	@RequestMapping("/multiImgUpload")
	public void multiImagUpload(HttpServletRequest req, HttpServletResponse resp) {
		try {
		String sFileInfo = "";
		String fileName = req.getHeader("file-name");
		String prifix =fileName.substring(fileName.lastIndexOf(".") + 1);
		prifix = prifix.toLowerCase();
		String path = CURR_IMATE_PATH;
		File file = new File(path);
		// 저장 폴더 없을경우 생성
		if(!file.exists()) {
			file.mkdir();
		}
		// 저장될 파일 이름
		String realName = UUID.randomUUID().toString() + "." +prifix;
		InputStream is = req.getInputStream();
		OutputStream os = new FileOutputStream(new File(path + "\\" + realName));
		int read = 0;
		byte buffer[] = new byte[1024];
		while((read = is.read(buffer)) !=-1) {
			os.write(buffer, 0, read);
		}
		if(is != null) {
			is.close();
		}
		os.flush();
		os.close();
		sFileInfo +="&bNewList=true";
		sFileInfo +="&sFileName=" + fileName;
		sFileInfo +="&sFileURL=/download?imageFileName=" + realName;
		PrintWriter print = resp.getWriter();
		print.print(sFileInfo);
		print.flush();
		print.close();
		}catch (IOException e) {
		   e.printStackTrace();
		}
	}
	

	
	@RequestMapping("/download")
	public void download(@RequestParam("imageFileName")String imageFileName
			, HttpServletResponse resp) throws IOException {
		OutputStream out = resp.getOutputStream();
		String downFile = CURR_IMATE_PATH + "\\" + imageFileName;
		File file = new File(downFile);
		// 해당경로 파일 없을경우
		if(!file.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found");
		}
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Content dispostion", "attachment fileName=" + imageFileName);
		try(FileInputStream in = new FileInputStream(file)){
			byte[] buffer = new byte[1024 * 8];
			while(true) {
				int count = in.read(buffer);
				if(count == -1) {
					break;
				}
				out.write(buffer, 0, count);
			}
		}catch (IOException ex) {
			ex.printStackTrace();
		}finally {
			out.close();
		}
	}
}
