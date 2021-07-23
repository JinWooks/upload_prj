<%--
  Created by IntelliJ IDEA.
  User: JinWook
  Date: 2021-07-22
  Time: 오후 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .uploadResult{
            width: 100%;
            background-color: gray;
        }
        .uploadResult ul {
            display: flex;
            flex-flow: row;
            justify-content: center;
            align-items: center;
        }
        .uploadResult ul li {
            list-style: none;
            padding: 10px;
        }
        .uploadResult ul li img {
            width: 20px;
        }
    </style>
</head>
<body>
    <h1>Upload With Ajax</h1>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>
    <div class="uploadResult">
        <ul>

        </ul>
    </div>
    <button id="uploadBtn">Upload</button>

    <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous"></script>
    <script>
        $(document).ready(function(){
            var cloneObj = $(".uploadDiv").clone();
            var uploadResult = $(".uploadResult ul");

            function showUploadFile(uploadResultArr){
                var str="";
                $(uploadResultArr).each(function (i,obj){
                   str += "<li>"+obj.fileName+"</li>";
                });
                uploadResult.append(str);
            }
            $("#uploadBtn").on("click",function (e){

                var formData = new FormData();
                var inputFile = $("input[name='uploadFile']");
                var files = inputFile[0].files;
                var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
                var maxSize = 5242880;

                function checkExtension(fileName,fileSize){
                    if(fileSize >= maxSize){
                        alert("파일 초과");
                        return false;
                    }
                    if(regex.test(fileName)){
                        alert("해당 종류의 파일은 업로드할 수 없습니다.");
                        return false;
                    }
                    return true;
                }
                console.log(files);

                for(var i = 0; i<files.length; i++){
                    if(!checkExtension(files[i].name,files[i].size)){
                        return false;
                    }
                    formData.append("uploadFile",files[i]);
                }

                $.ajax({
                    url: '/uploadAjaxAction',
                        processData: false,
                        contentType: false,
                        data: formData,
                        type: 'POST',
                        dataType:'json',
                        success: function (result){
                            console.log(result);

                            showUploadFile(result);
                            $(".uploadDiv").html(cloneObj.html());
                        }
                });
            });
        });
    </script>
</body>

</html>
