package com.practice.Dec.mapper;import com.practice.Dec.domain.Criteria;import com.practice.Dec.domain.ReplyVO;import org.apache.ibatis.annotations.Mapper;import org.apache.ibatis.annotations.Param;import java.util.List;@Mapperpublic interface ReplyMapper {    //17.2.3 CRUD작업    //등록    public int insert(ReplyVO vo);    //조회    public ReplyVO read(Long rno); //rno야 bno야... >> rno래요    //삭제    public int delete(Long rno); //여기두 오탈자 파티네    //수정    public int update(ReplyVO reply);    //17.2.4 @Param 어노테이션과 댓글 목록    public List<ReplyVO> getListWithPaging(            @Param("cri") Criteria cri,            @Param("bno")Long bno);    //17.6.3 댓글의 숫자 파악    public int getCountByBno(Long bno);}