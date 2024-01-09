package com.practice.Dec.service;import com.practice.Dec.domain.BoardVO;import com.practice.Dec.domain.Criteria;import com.practice.Dec.mapper.BoardMapper;import lombok.AllArgsConstructor;import lombok.extern.log4j.Log4j2;import org.springframework.stereotype.Service;import java.util.List;@Service@Log4j2@AllArgsConstructor //모든 파라미터를 이용하는 생성자를 만들어줌public class BoardServiceImpl implements BoardService{    private BoardMapper mapper;    @Override    public void register(BoardVO board){        log.info("===== register() ====="+board);        //입력받은 BoardVO값을사용해 insertSelectKey()를 실행할거야 : 비즈니스        //이 메소드는 입력받아 등록하는 작업은 수행하지만 별도의 반환값은 없어        mapper.insertSelectKey(board);    }    //9.2.3 조회 작업의 구현과 테스트    @Override    public BoardVO get(Long bno) {        log.info("===== get() =====");        //게시물번호(bno)에 해당하는 데이터를 조회        return mapper.read(bno);    }    @Override    public boolean modify(BoardVO board) {        log.info("===== modify() =====");        return mapper.update(board) == 1;    }    @Override    public boolean remove(Long bno) {        log.info("===== remove() =====");        return mapper.delete(bno)==1;    }    //9.2.2 목록(리스트)작업의 구현과 테스트 > 13.2.1 BoardService 수정    @Override    public List<BoardVO> getList(Criteria cri) {        log.info("===== STAER : getList() =====");        log.info("[ cri ] : " + cri);        //return mapper.getList() // 13.2.1 BoardService 수정        return mapper.getListWithPaging(cri);    }    //14.6 MyBatis에서 전체 데이터의 개수 처리    @Override    public int getTotal(Criteria cri){        log.info("===== STAER : getTotal() =====");        return mapper.getTotalCount(cri);    }}