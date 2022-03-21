<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Your page title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/themes/redmond/jquery-ui.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    <script>
        //이제 남은 것... 연동... 완료
        //삭제... 수정??
        


        $(function () {
            "use strict";
            $("#grid").jqGrid({
                colModel: [
                    { name: "name", label: "서버명", width: 53 , /*editable: true*/ },
                    { name: "ip", label: "IP", width: 90, align: "center" /*editable: true*/ },
                    { name: "os", label: "os", width: 65 },
                    { name: "loc", label: "loc", width: 41},
                    //{ name: "total", label: "Total", width: 51, template: "number" },
                    //{ name: "closed", label: "Closed", width: 59, template: "booleanCheckbox", firstsortorder: "desc" },
                    //{ name: "ship_via", label: "Shipped via", width: 87, align: "center"},
                ],
               
                pager: true,
                rowNum: 10,
                viewrecords: true,
                cellEdit : true,
                multiselect:true,

                //Data 연동 부분
                url : "./getDataTest",
                datatype : "JSON", //받을 때... 파싱... 설정
                //postData : "{}",
                mtype : "POST",
                loadtext : "로딩중...",
            
                //수정 완료 이벤트 찾기...
                //제약 사항 - 정말 변경 할것인지 경고창 띄우고 수정한다...
                //삭제...
                //local 빼고... - 
            
                onCellSelect: function(rowid, iCol, cellcontent, e) {
            
                var text = "";
                text += "rowid : " + rowid;
                text += "\niCol : " + iCol;
                text += "\ne : " + e;

                //alert(text);
                },
                /*
                onSelectRow: function(rowid, status, e) {
                var text = "";
                text += "rowid : " + rowid;
                text += "\nstatus : " + status;
                text += "\ne : " + e;

                //alert(text);

                //$("#grid").jqGrid('editRow',rowid);
            
                },
                */
                afterSaveCell : function (rowid, name, val, iRow, iCol){
                    //값이 변경 되었을 때만 발생하는 이벤트...

                    //rowid로 타이틀(PK) 가지고 오고... 업데이트...
                    alert(rowid);
                    
                    
                    
                    alert("test");
                },

                
                ondblClickRow: function (rowid, iRow, iCol) { 
                    //TODO : 더블클릭 이벤트... 더블클릭할 경우 에디트 모드로. 
                    if(iCol == 1){
                    var colModels = $(this).getGridParam('colModel'); 
                    var colName = colModels[iCol].name; 
                    //if (editableCells.indexOf(colName) >= 0) { 
                        $(this).setColProp(colName, { editable: true }); 
                        $(this).editCell(iRow, iCol, true); 
                        //} 
                    }	
                   
                }, 
 
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //에디트가 열릴면서... 발생하는 이벤트... 

                    
                    
                    
                    //TODO : 에디트가 종료되면, 셀의 에디트 가능 여부를 false 로 돌린다. 
                    $(this).setColProp(cellname, { editable: false }); 
                },
                /* 필요 없을듯.
                onPaging : function (button){
                	alert(button);
                },
                */

            });
        });
        
        
		function test(){
			
			$("#grid").jqGrid("clearGridData", true);
			
			$("#grid")
			.setGridParam({
				url : "./getData",
				mtype : "post",
				postData : {a:10},
				dataType : "json",
				loadComplete : function(data){
					alert("1 : " + data);
				},
				gridComplete : function(){ 
					alert("2");
				}
			})
			.trigger("reloadGrid");
			
			
		}        
		
		function testDelete(){
			$("#grid").getGridParam('selarrrow').forEach(function (rowId){
				
				var data = $("#grid").getRowData(rowId);
				console.log(data);
				
				//제목이...유니크하다는 가정하에 진행해야 될듯...
				
				
			});
			
			//refresh
			$("#grid").trigger('reloadGrid');  //******************************중요
		}
    </script>
</head>
<body>
<table id="grid"></table>
<div><button onclick="testDelete()">delete</button></div>
<div><button onclick="test()">test</button></div>
</body>
</html>