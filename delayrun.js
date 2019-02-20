var errary=[];
function delayrun(){
    var obj = arguments;
    var runtype=obj[0];
    var runid=obj[1];
    var runcount=obj[2];
    var from=obj[3];
    var to=obj[4];
// "runtype","runid","runcount","from","to"
    var vurl = ['delay_run_req_insertMore?runtype=',runtype,'&runid=',runid
                ,'&runcount=',runcount,'&from=',from,'&to=',to].join('');

    var xhr = new XMLHttpRequest();
    xhr.open("get", vurl, true);
    xhr.onload = function(){
        if(xhr.status != 200){
            errary.push(['(',runtype,',',runid,',',runcount,',',from,',',to,');'].join(''));
            console.error([xhr.status,'=>',vurl].join(''));
            return;
        }
        var bk=JSON.parse(xhr.responseText);
        console.log(bk);
    }

    xhr.send(null);
}


/**
var runids=[2,3,4,5,6,7];
var runcounts=[132087,130931,135578,130254,124319,130273];

//1,给作品加皇冠;2,给读者加皇冠;3,投虚拟票;
var runobj={runtype:3,from:'2019-2-19 12:20',to:'2019-2-23 18:30'};
for(let key in runids)delayrun(runobj.runtype,runids[key],runcounts[key],runobj.from,runobj.to);

 */

// var book={comefrom:0,bookids:[]};
// for(let key in book.bookids)getbookinfo(book.comefrom,book.bookids[key]);
