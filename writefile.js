// const base64 = (s)=>{
//   return window.btoa(unescape(encodeURIComponent(s)));
// }
// const str= '你好，7954！';
// const uri = 'data:text/plain;charset=UTF-8;base64,';
// const url = uri + base64(str);
// const a = document.createElement('a');
// a.href = url;
// a.download = 'hellow.txt';
// a.click();

function base64(){
    var s = arguments[0];
    return window.btoa(unescape(encodeURIComponent(s)));
}

function writefile(){
    var str=arguments[0];
    var filename=arguments[1];
    const uri = 'data:text/plain;charset=UTF-8;base64,';
    const url = uri + base64(str);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    a.click();
}

var a=[];
for(let i=0;i<1000000;i++)a.push('你好，黎明海南大学\r\n');
writefile(a.join(''),'hello.txt');
