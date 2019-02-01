#!/bin/bash

<<'COMMENT'
知识点：
xdotool getmouselocation #得到鼠标点位置
COMMENT

#数据初始化区域
init-data(){
    SPLITDOT=:
    JAVAHOMEBIN=/opt/java/jdk1.6.0_45/bin/
    if [[ ! -d $JAVAHOMEBIN ]];then
        JAVAHOMEBIN=''
    else
        echo "===>$JAVAHOMEBIN"
    fi

    LIBREPOSITORYPATH=/media/win/E/chuanqing/workspace/repository/lib
    BUILDARGS=' -encoding utf-8 -nowarn -source 1.6 -target 1.6 -sourcepath . -d WebRoot/WEB-INF/classes -cp '
    # -Xlint:unchecked

    # 子程序需要实现以下5个方法
    set-build-libs
    set-uml-libs
    set-resin-conf-name
    set-ice-main-class
}

set-build-libs(){
    BUILDLIBS='

'
}

set-uml-libs(){
    UMLLIBS='
    plantuml
    jlatexmath-1.0.4
'
# batik-all-1.10
}

set-resin-conf-name(){
    RESINCONFNAME=''
}

set-ice-proj-name(){
    ICEPROJNAME=''
}

set-ice-main-class(){
    ICEMAINCLASS='cn.tianya.fw.server.component.ice.ComponentServer'
}

build-uml22(){
    init-data
    LINES=''
    for yy in $UMLLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    if [[ $1 =~ ^- ]];then
        java -cp $LINES net.sourceforge.plantuml.Run $@
        return
    fi

    mypwd=`pwd`

    for yy in `find puml|grep .puml$`;do
        xx=`dirname $yy`
        java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'$xx $yy
    done
    # java -cp $LINES -jar $LIBREPOSITORYPATH/plantuml.jar -tpdf `find puml|grep .puml$`
    # java -cp $LINES net.sourceforge.plantuml.Run `find puml|grep .puml$`
}

build-uml(){
    init-data
    LINES=''
    for yy in $UMLLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    if [[ $1 =~ ^- ]];then
        java -cp $LINES net.sourceforge.plantuml.Run $@
        return
    fi

    mypwd=`pwd`
    if [[ $# > 0 ]];then
        for yy in $@;do
            if [[ ! -f $yy ]];then
                echo "${yy}不存在!"
                continue
            fi
            xx=`dirname $yy`
            java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'${xx:4} $yy
        done
        return
    fi

    for yy in `find src|grep .puml$`;do
        xx=`dirname $yy`
        java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'${xx:4} $yy
    done
    # java -cp $LINES -jar $LIBREPOSITORYPATH/plantuml.jar -tpdf `find puml|grep .puml$`
    # java -cp $LINES net.sourceforge.plantuml.Run `find puml|grep .puml$`
}

run-class(){
    init-data
    LINES=''
    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    ${JAVAHOMEBIN}java -cp $LINES'WebRoot/WEB-INF/classes' $@
}

clear-class(){
    for yy in $@;do
        rm -rf WebRoot/WEB-INF/classes/$yy
    done
    # rm -rf WebRoot/WEB-INF/classes/cn/tianya
}

build-src(){
    init-data
    LINES=''
    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    ${JAVAHOMEBIN}javac $BUILDARGS $LINES `find src|grep java$`
}

#调用前要指定 RESINCONFNAME
start-resin(){
    init-data

    class=com.caucho.server.resin.Resin
    resinhome=/media/win/E/resin-3.0.21
    resinconfpath=/media/win/E/chuanqing/workspace/repository/resin-conf

    basepath=$(cd `dirname $0`; pwd)

    LINES=`ls ${resinhome}/lib/*.jar | tr '\n' ':'`

    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    ${JAVAHOMEBIN}java -cp ${LINES}"$basepath/WebRoot/WEB-INF/classes" -Xss1m -Dresin.home=${resinhome} -Dserver.root=${resinhome} -Djava.util.logging.manager=com.caucho.log.LogManagerImpl -Djavax.management.builder.initial=com.caucho.jmx.MBeanServerBuilderImpl ${class} -conf ${resinconfpath}/${RESINCONFNAME}
}

#调用前要指定 ICEMAINCLASS
start-ice(){
    init-data
    basepath=$(cd `dirname $0`; pwd)
    LINES="$basepath/WebRoot/WEB-INF/resources/:"
    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

varpid=`ps -ef|grep $ICEMAINCLASS |grep -v grep|awk '{print $2}'`
jvmarg='-Xmx2048m -Xms2048m -Xmn1024m -Xss256k -XX:PermSize=128m -XX:MaxPermSize=128m -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.port=11020 -Djava.rmi.server.hostname=127.0.0.1'
   ${JAVAHOMEBIN}java -cp ${LINES} $jvmarg ${ICEMAINCLASS}
}

git-commit(){
    git commit -a -m "修改"
    git push origin master
}

svn-commit(){
    svn ci -m "修改"
}


test-echo(){
echo "你好"$1"==="
echo "你好"$2"==="
echo "你好"$3"==="
}
