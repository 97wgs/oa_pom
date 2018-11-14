<%--
  Created by IntelliJ IDEA.
  User: ken
  Date: 2018/11/7
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen" />
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen" />

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <%--<script type="text/javascript"
            src="resources/scripts/jquery-1.3.2.min.js"></script>--%>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>


    <!-- 富文本编辑器 -->
    <link rel="stylesheet" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
    <link href="resources/widget/dist/summernote.css" rel="stylesheet"/>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js"></script>
    <script src="resources/widget/dist/summernote.js"></script>
    <script src="resources/widget/dist/lang/summernote-zh-CN.js"></script>

    <!-- 自动补全插件 -->
    <link href="resources/widget/autocompleter/styles.css" rel="stylesheet"/>
    <script src="resources/widget/autocompleter/jquery.autocomplete.min.js"></script>

    <script>
        $(function(){

            //初始化富文本编译插件
            $('.summernote').summernote({
                height: 400,
                tabsize: 2,
                lang: 'zh-CN'
            });

            //初始化自动补全插件
            $('#autocomplete').autocomplete({
                lookup: function (query, done) {

                    $.post("/emp/queryinfo", {keyword: query}, function(data){
                        done(data);
                    }, "json");

                    // Do Ajax call or lookup locally, when done,
                    // call the callback and pass your results:
                    // var result = {
                    //     suggestions: [
                    //         { "value": "United Arab Emirates", "data": "AE" },
                    //         { "value": "United Kingdom",       "data": "UK" },
                    //         { "value": "United States",        "data": "US" }
                    //     ]
                    // };
                    //
                    // done(result);
                },
                onSelect: function (suggestion) {
                    // alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                    console.log(suggestion.value + "-" + suggestion.data);
                    $("#to_id").val(suggestion.data);
                }
            });
        })
    </script>

</head>
<body>
<div id="main-content">
    <div class="content-box">
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab2">
                <form id="form_id" action="/mail/sendmail" method="post" enctype="multipart/form-data">
                    <fieldset>
                        <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                        <p>
                            <label>标题</label> <input
                                class="text-input small-input" type="text" id="subject-input"
                                name="subject" />
                        </p>
                        <p>
                            <label>收件人</label> <input
                                class="text-input medium-input datepicker" type="text"
                                id="autocomplete" />
                            <input type="hidden" id="to_id" name="to" value=""/>
                        </p>
                        <p>
                            <label>附件</label> <input
                                class="text-input large-input" type="file" id="file_id"
                                name="file" />
                        </p>

                        <p>
                            <label>内容</label>
                            <%--<textarea class="text-input textarea wysiwyg" id="textarea"
                                      name="textfield" cols="79" rows="15"></textarea>--%>
                            <div class="summernote"></div><!-- 获得富文本的内容$('.summernote').summernote('code') -->
                            <input type="hidden" name="content" id="content_id"/>
                        </p>
                        <p>
                            <input class="mybutton" type="button" onclick="sendMail();" value="发送邮件" />
                        </p>
                    </fieldset>
                    <div class="clear"></div>

                    <script>
                        function sendMail(){
                            //获得富文本的内容
                            var content = $('.summernote').summernote('code');
                            $("#content_id").val(content);
                            $("#form_id").submit();
                        }
                    </script>
                    <!-- End .clear -->
                </form>
            </div>
            <!-- End #tab2 -->
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->
</body>
</html>
