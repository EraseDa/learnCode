<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>

<h1>upload with Ajax</h1>
<%--21.3 Ajax를 이용한 파일 업로드--%>
<div class="uploadDiv">
    <input type="file" name="uploadFile" multiple>
</div>
<button id="uploadBtn">upload</button>

<script
        src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<script>

    $(document).ready(function (){

        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 5242880; //5MB

        function checkExtension(fileName, fileSize) {
            if(fileSize >= maxSize) {
                alert("파일 사이즈 초괌");
                return false;
            }
            if(regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }
            return true;
        }

        $("#uploadBtn").on("click", function (e){
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");
            var files = inputFile[0].files;

            console.log(files);

        //     Ajax를 이용해서 첨부파일을 전송하는 경우 가장 중요한 객체는 FormData 타입의 객체에 각 파일 데이터를
            //  추가하는 것과 이를 Ajax로 전송할 때 약간의 옵션이 붙어야 한다는 점

            //add file Data to formData
            for(var i =0; i<files.length; i++) {

                if(checkExtension(files[i].name,files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url:'/uploadAjaxAction',
                processData: false,
                contentType: false,
                data: formData,
                type:'post',
                dataType:'json',
                success: function (result){
                    console.log(result);
                }
            }); //end ajax 유의 : 첨부파일 데이터는 fileData를 formData에 추가한 후에
            // Ajax를 통해서 formData자체를 전송해야함. processData 및 contentType은 반드시 false로 지정해야한 전송됨
        });
    });
</script>

</body>
</html>
