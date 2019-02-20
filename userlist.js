var buffary=[];
function getuserinfo(){
    var soflag = arguments[0];
    var sovalue = arguments[1];
    var vurl = ['getUserInfo?soflag=',soflag,'&sovalue=',sovalue].join('');

    var info = [0,''];
    if(soflag==1){
        info[0]=sovalue;
    }else if(soflag==2){
        info[1]=sovalue;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("get", vurl,true);
    xhr.onload = function(){
        if(xhr.status != 200){
            buffary.push(info.join('\t'));
            console.error([xhr.status,'=>',vurl].join(''));
            return;
        }
        var bk=JSON.parse(xhr.responseText);
        if(bk.idw>0&&bk.strw.length>0){
            if(soflag==1){
                info[1]=bk.strw;
            }else if(soflag==2){
                info[0]=bk.idw;
            }
            buffary.push(info.join('\t'));
            console.log(bk.idw,'\t',bk.strw);
            return;
        }
    }

    xhr.send(null);
}
/*
var
*/
var strws='大七七712,一束红颜,我是喜爷,猫生欢乐,告别20115,天赐三千,ty_妙笔生,一碗扁食,darkillison2018,葡萄牙月桂,o雪语星枫o,jiegaoyin,北冥鬼叔,曾今2018,鲜于冶銋,十五年韩薇,有毛僧,鱼,有骨难画,陟云子,小荷我2017,百年过客2016,百年过客2016,旧时艳阳,大野孤行,冷月888,一枝杏香兔儿风,泪痕春雨,太阳出来2018,欧远良的微笑,村人老李,醉酒的猫S,羽落晨兮,会讲故事的刘老贼,装龙做雅,闲云了了,春光辉耀,迷清浅,春光辉耀,tsz983,逍遥羽士,杨又芷,此消彼长奈何,我是喜爷,可可和老郑,游泳的猫咪ABC,河谷少年,小叙V,八月寒流,冬阳熔雪,狸教授,宁波小阿哥1985,69号店,公子草民乎,路小黑,千里明月2016,大胡子卢梭,贺五窝,一束红颜,淮水居士,楼蓉蓉,财迷道长V,苗棋淼丶,水晶红幽灵,不吃不睡的猫,Doris千里婵娟,一个落魄文人,余不愚,探竹,羽落晨兮,装龙做雅,杨又芷,此消彼长奈何,我是喜爷,可可和老郑,游泳的猫咪ABC,幽灵帝国,淮水居士,不吃不睡的猫,ty_妙笔生,o雪语星枫o,十五年韩薇,小荷我2017,一枝杏香兔儿风,大野孤行,醉酒的猫S,安平可乐,会讲故事的刘老贼,闲云了了,和谐新时代,迷清浅,大七七712,一九四三,公子草民乎,路小黑,千里明月2016,迷清浅,大胡子卢梭,一束红颜,贺五窝,我是喜爷,告别20115,一束红颜,ty_妙笔生,一碗扁食,darkillison2018,葡萄牙月桂,o雪语星枫o,jiegaoyin,北冥鬼叔,曾今2018,鲜于冶銋,十五年韩薇,有毛僧,鱼,有骨难画,陟云子,小荷我2017,百年过客2016,百年过客2016,旧时艳阳,大野孤行,冷月888,一枝杏香兔儿风,泪痕春雨,太阳出来2018,欧远良的微笑,村人老李,醉酒的猫S,羽落晨兮,安平可乐,会讲故事的刘老贼,装龙做雅,闲云了了,和谐新时代,春光辉耀,迷清浅,春光辉耀,tsz983,逍遥羽士,杨又芷,此消彼长奈何,我是喜爷,可可和老郑,游泳的猫咪ABC,大七七712,河谷少年,截拳妖皇,小叙V,八月寒流,北冥魔界,冬阳熔雪,狸教授,宁波小阿哥1985,69号店,幽灵帝国,公子草民乎,路小黑,千里明月2016,大胡子卢梭,一束红颜,贺五窝,我是喜爷,猫生欢乐,告别20115,一束红颜,天赐三千,淮水居士,楼蓉蓉,财迷道长V,苗棋淼丶,水晶红幽灵,不吃不睡的猫,Doris千里婵娟,一个落魄文人,余不愚,探竹'.split(',');

for(let key in strws)getuserinfo(2,strws[key]);


var bufmap={};
for(let key in buffary){
    var ppp = buffary[key].split('\t');
    bufmap[ppp[1]]=ppp[0];
}

var strws2 = [];
for(let key in strws){
    strws2.push([strws[key],bufmap[strws[key]]].join('\t'));
}
