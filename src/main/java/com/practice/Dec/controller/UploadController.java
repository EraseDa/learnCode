package com.practice.Dec.controller;

import com.practice.Dec.domain.AttachFileDTO;
import lombok.Getter;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.SimpleFormatter;

@Controller
@Log4j2
public class UploadController {
//21.2 form 방식의 파일 업로드
    @GetMapping("/uploadForm")
    public void uploadForm(){
        log.info("upload form");
    }

    @PostMapping("/uploadFormAction")
    public void uploadFormPost(@RequestParam("uploadForm") MultipartFile[] uploadFile, Model model) {
//21.2.1 해당 코드에서는 파라미터에 @RequestParam 이 없다. 하지만 해당 어노테이션이 없는 경우에 MultipartFile에서 파일을 인식하지 못하기 때문에
        //nullPointExcepttion이 발생한다. 따라서 input 타입 file인 경우 name에 해당하는 value를 해당 어노테이션에 적어주어야 제대로 인식

        String uploadFolder = "C:\\upload";

        for(MultipartFile multipartFile : uploadFile) {

            log.info("============================");
            log.info("upload file name : " +multipartFile.getOriginalFilename());
            log.info("upload file size : " +multipartFile.getSize());

            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception e) {
                log.error(e.getMessage());
            } // transferTo 메서드는 파일의 저장 메서드임
        }
    }

    @GetMapping("/uploadAjax")
    public void uploadAjax(MultipartFile[] uploadFile){
        log.info("update ajax post................");
        String uploadFolder = "C:\\upload";

        //make folder--------
        File uploadPath = new File(uploadFolder,getFolder());
        log.info("upload path : " + uploadPath);

        if(uploadPath.exists()==false) {
            uploadPath.mkdirs();
        }

        //make yyyy/MM/dd folder
        for(MultipartFile multipartFile : uploadFile) {

            log.info("============================");
            log.info("upload file name : " +multipartFile.getOriginalFilename());
            log.info("upload file size : " +multipartFile.getSize());

            String uploadFileName = multipartFile.getOriginalFilename();

            //IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            log.info("only file name : " + uploadFileName);

            //File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
            File saveFile = new File(uploadPath, uploadFileName);

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception e) {
                log.error(e.getMessage());
            } // transferTo 메서드는 파일의 저장 메서드임
        }
    }

    private String getFolder(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date =  new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    }

    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "C:\\upload";
        String uploadFolderPath = getFolder();

        //make folder - -- - - -
        File uploadPath = new File(uploadFolder, getFolder());

        if(uploadPath.exists()==false) {
            uploadPath.mkdirs();
        }

        //make yyyy/MM/dd folder

        for(MultipartFile multipartFile : uploadFile) {

            AttachFileDTO attachDTO = new AttachFileDTO();

            String uploadFileName = multipartFile.getOriginalFilename();
            //IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            log.info("only file name : " + uploadFileName);

            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);

                //check image type file
                if(checkImageType(saveFile)){
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                    thumbnail.close();
                }
                list.add(attachDTO);
            }catch (Exception e) {
                log.error(e.getMessage());
            }//end catch
        }//end for
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        }catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

}
