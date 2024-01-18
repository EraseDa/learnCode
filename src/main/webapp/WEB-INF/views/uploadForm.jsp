<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%--21.2 파일 업로드에서 가장 신경써야 하는 부분은 enctype을 멀티파일 폼데이터로 지정하는 것 --%>
<form action="uploadFormAction" method="post" enctype="multipart/form-data">
    <input type="file" name="uploadForm">
    <button>Submit</button>
</form>
</body>

</html>
