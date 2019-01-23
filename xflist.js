function getinitobj(){
    document.getElementById('svbtn').hidden=true;
    document.getElementById('showdata').innerHTML='';
    return {tindex:11,pageSize:500,pageNumber:1,idw:0,strw:'',dataList:[],lastData:{},resp:false};
}

var obj=getinitobj();

function getuserinfo(){
    var soflag = document.getElementById('soflag').value;
    var sovalue = document.getElementById('sovalue').value;
    var vurl = ['getUserInfo?soflag=',soflag,'&sovalue=',sovalue].join('');

    var xhr = new XMLHttpRequest();
    xhr.open("get", vurl,true);
    xhr.onload = function(){
        if(xhr.status != 200){
            console.error([xhr.status,'=>',vurl].join(''));
            return;
        }
        var bk=JSON.parse(xhr.responseText);
        if(bk.idw>0&&bk.strw.length>0){
            if(bk.idw==obj.idw){
                return;
            }

            obj=getinitobj();
            obj.idw=bk.idw;
            obj.strw=bk.strw;
        }

        document.getElementById('sobtn').disabled=true;
        xflist(obj);
    }

    xhr.send(null);

}

function xflist(){
    var obj = arguments[0];

    var vurl = ['getConsumerPage?tindex=',obj.tindex,'&pageSize=',obj.pageSize,'&pageNumber=',obj.pageNumber,
                ,'&idw=',obj.idw].join('');

    document.getElementById('showdata').innerHTML=['正在查询数据==>',obj.tindex,obj.pageSize,obj.pageNumber,obj.idw,obj.strw].join(' ');

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
        // savefile(obj.dataList);
        obj.html=gethtml(obj.dataList);
        showhtml();
        document.getElementById('sobtn').disabled=false;
        obj.resp=true;
        return;
    }
    obj.tindex-=1;
    obj.pageNumber=1;
    xflist(obj);
}

function gethtml(){
    var list = arguments[0];
    var resp = ['<table border=1><tr><th>作品</th><th>章节</th><th>时间</th><th>贝数</th><th>消费类别</th></tr>'];
    for(let key in list){
        var map = list[key];
        resp = resp.concat(['<tr><td>',map.bookTitle,'</td><td>',map.chapterTitle,'</td><td>',map.msgTime,'</td><td>',map.xfBei,'</td><td>',map.xfCategory,'</td></tr>']);
    }
    resp.push('</table>');
    return resp.join('');
}

function showhtml(){
    document.getElementById('svbtn').hidden=false;
    document.getElementById('showdata').innerHTML=obj.html;
    // var btn = document.createElement('button');
    // btn.type='button';
    // btn.innerText='下载';
    // btn.addEventListener('click',savehtml);
    // document.body.appendChild(btn);

    // var div = document.createElement('div');
    // div.id='showdata';
    // div.innerHTML=obj.html;
    // document.body.appendChild(div);
}


function savehtml(){
    if(!obj.resp)return;
    var resp = [obj.html];
    if(typeof(saveAs) == "function"){
        //以下代码要求FileSaver.js
        var file = new File(resp, "xflist.xlsx", {type: "html/plain;charset=utf-8"});
        saveAs(file);
        return;
    }

    if(typeof(streamSaver) == "object"){
        //以下代码要求StreamSaver.js
        const fileStream = streamSaver.createWriteStream('xflist.xlsx')
        const writer = fileStream.getWriter()
        const encoder = new TextEncoder
        let uint8array = encoder.encode(resp.join(''))

        writer.write(uint8array)
        writer.close()
        return;
    }
    console.error('未找到合适的下载插件');
}

// var obj={tindex:11,pageSize:500,pageNumber:1,idw:122592181,dataList:[],lastData:{},resp:false};
// xflist(obj);
// console.log(log);

// var interval = setInterval( function(){
//     if(obj.resp){
//         savefile(obj.dataList);
//         console.log(obj);
//         clearInterval(interval);
//     }
// }, 3 * 1000);//延迟3000毫米
