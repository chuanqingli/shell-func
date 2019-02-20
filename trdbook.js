var errary=[];
function trdbook(){
    var op = arguments.callee.caller.name;
    var obj = arguments[0];
    var comefrom=obj[0];
    var bookid=obj[1];
    var chapterid=obj[2];

    var vurl = ['trdbook?updflag=1&op='
                ,op,'&comefrom=',comefrom,'&bookid=',bookid,'&chapterid=',chapterid].join('');

    var xhr = new XMLHttpRequest();
    xhr.open("get", vurl, true);
    xhr.onload = function(){
        if(xhr.status != 200){
            errary.push([op,'(',comefrom,',',bookid,',',chapterid,');'].join(''));
            console.error([xhr.status,'=>',vurl].join(''));
            return;
        }
        var bk=JSON.parse(xhr.responseText);
        console.log(bk);
        if(op=='getbookinfo'){
            getchaplist(bk.comefrom,bk.bookid);
            return;
        }
        if(op!='getchaplist'){
            return;
        }

        var list=bk;
        for(let key in list){
            var bk=list[key];
            if(bk.chapterid>0&&bk.chaptertype==0)getchapinfo(bk.comefrom,bk.bookid,bk.chapterid);
        }
    }

    xhr.send(null);
}

function getbookinfo(){
    trdbook(arguments);
}

function getchaplist(){
    trdbook(arguments);
}


function getchapinfo(){
    trdbook(arguments);
}

/*
var book={comefrom:138191736,bookids:[94225]};
for(let key in book.bookids)getbookinfo(book.comefrom,book.bookids[key]);
 */
