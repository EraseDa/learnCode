package com.practice.Dec.controller;import com.practice.Dec.domain.Criteria;import com.practice.Dec.domain.ReplyPageDTO;import com.practice.Dec.domain.ReplyVO;import com.practice.Dec.service.ReplyService;import lombok.AllArgsConstructor;import lombok.extern.log4j.Log4j2;import org.springframework.http.HttpStatus;import org.springframework.http.MediaType;import org.springframework.http.ResponseEntity;import org.springframework.web.bind.annotation.*;import java.util.List;@RequestMapping("/replies/")@RestController@Log4j2@AllArgsConstructor //Setter주입 혹은 요 어노테이션 사용public class ReplyController {    private ReplyService service;    //17.3.2 등록작업과 테스트    @PostMapping //post방식으로만 동작하도록 설계            (value = "/new",            consumes = "application/json", //JSON방식의 데이터만 처리하도록,            produces = {MediaType.TEXT_PLAIN_VALUE}) //문자열을 반환하도록 설계    public ResponseEntity<String> create(@RequestBody ReplyVO vo){ //@RequestBody를 적용해 JSON데이터를 vo타입으로 변환하도록 지정함        log.info("[ ReplyVO ] : " + vo);        int insertCount = service.register(vo);        log.info("[ insertCount ] : " + insertCount);        return insertCount == 1 ?                new ResponseEntity<>("success", HttpStatus.OK) :                new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); //500에러    }    //테스트시에는 post방식으로 전송하고 content-type은 application/json으로 지정해야한다고?    //17.3.3 특정 게시물의 댓글 목록 확인    //17.6.5    @GetMapping(value = "/pages/{bno}/{page}",            produces = { MediaType.APPLICATION_XML_VALUE,                         MediaType.APPLICATION_JSON_VALUE })    public ResponseEntity<ReplyPageDTO> getList(            @PathVariable("bno") Long bno, @PathVariable("page") int page){        log.info("[---------- getList ----------]");        Criteria cri = new Criteria(page, 10);        log.info("[ bno ] : " + bno);        log.info("[ cri ] : " + cri);        return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);    }    //17.3.4 댓글 삭제/조회    @GetMapping(value = "/{rno}",            produces = {MediaType.APPLICATION_JSON_VALUE,                        MediaType.APPLICATION_XML_VALUE})    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){        log.info("[ get ] : " + rno);        return new ResponseEntity<>(service.get(rno),HttpStatus.OK);    }    @DeleteMapping(value = "/{rno}",            produces = {MediaType.TEXT_PLAIN_VALUE})    public ResponseEntity<String> remove(@PathVariable("rno") Long rno){        log.info("[ remove ] : " + rno);        return service.remove(rno) == 1 ?                new ResponseEntity<>("Success",  HttpStatus.OK) :                new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);    }    //17.3.5 댓글 수정    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},            value = "/{rno}",            consumes = "application/json",            produces = {MediaType.TEXT_PLAIN_VALUE})    public ResponseEntity<String> modify(            @RequestBody ReplyVO vo, @PathVariable("rno") Long rno){        vo.setRno(rno);        log.info("[ rno ] : " + rno);        log.info("[ modify ] : " + vo);        return service.modify(vo) == 1?                new ResponseEntity<>("Success",HttpStatus.OK):                new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);    }}