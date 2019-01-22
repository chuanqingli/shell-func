function xflist(){
    var obj = arguments[0];

    var vurl = ['getConsumerPage?tindex=',obj.tindex,'&pageSize=',obj.pageSize,'&pageNumber=',obj.pageNumber,
                ,'&idw=',obj.idw].join('');

    var xhr = new XMLHttpRequest();
    xhr.open("get", vurl,true);
    xhr.onload = function(){
        if(xhr.status != 200){
            console.error([xhr.status,'=>',vurl].join(''));
            return;
        }
        var bk=JSON.parse(xhr.responseText);
        console.log(bk);
        console.log(obj);

        obj.lastData = bk.data;
        if(bk.data==null){
            checkexit(obj);
            return;
        }
        bk=bk.data;
        obj.dataList=obj.dataList.concat(bk.dataList);
        if(obj.pageNumber>=bk.pageCount){
            checkexit(obj);
            return;
        }
        if(obj.pageNumber<bk.pageCount){
            obj.pageNumber+=1;
            console.log(obj);
            xflist(obj);
        }
    }

    xhr.send(null);
}

//检查程序是否可以退出
function checkexit(){
    var obj = arguments[0];
    if(obj.tindex<=0){
        savefile(obj.dataList);
        obj.resp=true;
        return;
    }
    obj.tindex-=1;
    obj.pageNumber=1;
    xflist(obj);
}


function savefile(){
    var list = arguments[0];
    var resp = ['<table><tr><th>作品</th><th>章节</th><th>时间</th><th>贝数</th><th>消费类别</th></tr>'];
    for(let key in list){
        var map = list[key];
        resp = resp.concat(['<table><tr><td>',map.bookTitle,'</td><td>',map.chapterTitle,'</td><td>',map.msgTime,'</td><td>',map.xfBei,'</td><td>',map.xfCategory,'</td></tr>']);
    }
    resp.push('</table>');
    console.log(resp);

const fileStream = streamSaver.createWriteStream('xflist.xlsx')
const writer = fileStream.getWriter()
const encoder = new TextEncoder
    let uint8array = encoder.encode(resp.join(''))

writer.write(uint8array)
writer.close()


    // var file = new File(resp, "xflist.xlsx", {type: "html/plain;charset=utf-8"});
    // saveAs(file);
}

var obj={tindex:11,pageSize:500,pageNumber:1,idw:122592181,dataList:[],lastData:{},resp:false};
xflist(obj);
// console.log(log);

// var interval = setInterval( function(){
//     if(obj.resp){
//         savefile(obj.dataList);
//         console.log(obj);
//         clearInterval(interval);
//     }
// }, 3 * 1000);//延迟3000毫米
