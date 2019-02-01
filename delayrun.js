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
var runids=[90952,91904,91536,91355,92222,78832,89249,92014,91416,89063,89557,90567,91353,90954,82963,86396,78351,83237,88933,90055,86387,89658,87754,90789,89612,88227,91028,89649,91349,88140,90812,87587,74473,89223,70821,64921,89615,89599,90576,80064,75074,90597,90059,88251,90063,91177,81500,90290];
var runcounts=[1039,1029,1008,971,968,959,948,938,928,925,903,902,900,887,870,826,819,807,800,789,782,774,774,765,750,726,723,714,703,678,672,630,614,604,565,517,505,482,443,430,424,371,363,327,274,270,250,244];

//1,给作品加皇冠;2,给读者加皇冠;
var runobj={runtype:1,from:'2019-2-1 18:00:56',to:'2019-2-28 18:30'};
for(let key in runids)delayrun(runobj.runtype,runids[key],runcounts[key],runobj.from,runobj.to);

 */

// var book={comefrom:0,bookids:[]};
// for(let key in book.bookids)getbookinfo(book.comefrom,book.bookids[key]);
