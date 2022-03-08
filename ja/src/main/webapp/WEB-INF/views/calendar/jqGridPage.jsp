<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jqGrid Test Page</title>
	<link rel="stylesheet" type="text/css" href="../resources/jqgrid/jquery-ui/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="../resources/jqgrid/jquery.jqGrid/css/ui.jqgrid.css">

    <script type="text/javascript" src="../resources/jqgrid/jquery.jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../resources/jqgrid/jquery.jqGrid/js/i18n/grid.locale-kr.js"></script>
    <script type="text/javascript" src="../resources/jqgrid/jquery.jqGrid/js/jquery.jqGrid.min.js"></script>
    <script>
        var searchResultColNames = ['게시글관리번호', '번호', '제목', '작성자', '날짜', '조회수'];
        var searchResultColModel = [{
            name: 'bbsMgtNo',
            index: 'bbsMgtNo',
            align: 'center',
            width: '10%'
            //hidden: true
        }, {
            name: 'bbsNum',
            index: 'bbsNum',
            align: 'left',
            width: '10%'
        }, {
            name: 'bbsTitle',
            index: 'bbsTitle',
            align: 'center',
            width: '50%'
        }, {
            name: 'bbsWriter',
            index: 'bbsWriter',
            align: 'center',
            width: '10%'
        }, {
            name: 'bbsDate',
            index: 'bbsDate',
            align: 'center',
            width: '10%'
        }, {
            name: 'bbsHit',
            index: 'bbsHit',
            align: 'center',
            width: '10%'
        }];

        $(function() {
            $('#testGrid').jqGrid({
                height: 261,
                width: 1019,
                colNames: searchResultColNames,
                colModel: searchResultColModel,
                rowNum: 10,
                pager: 'pager'
            });
        });
    </script>
</head>
<body>
    <div class="table">
        <table id="testGrid"></table>
        <div id="pager"></div>
    </div>
</body>
</html>