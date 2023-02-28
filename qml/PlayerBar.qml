import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import QtMultimedia 5.4


import "../qml" as VB;



Rectangle{

    id:toolBar;
    property var player;
    anchors{
        left:parent.left;
        right:parent.right;
    }
    height: 40;
    color: "#5c5858"

    Slider {//进度条
        id:temp;
        anchors{
            left: toolBar.left;
            right: toolBar.right;
            leftMargin:toolBar.height*r.children.length;
            verticalCenter: toolBar.verticalCenter;
            rightMargin: toolBar.height*1.2;
        }

        property bool sync: false
        maximumValue: player.duration;
        onValueChanged: {//点击选择进度
            if(!sync)
                player.seek(value);
        }
        style: SliderStyle {
            groove: Rectangle {
                implicitWidth: parent.width;
                implicitHeight: 8
                color: "gray"
                radius: 8
            }
            // control : Slider read-only
            handle: Rectangle {
                anchors.centerIn: parent
                color: control.pressed ? "white" : "lightgray"
                border.color: "gray"
                border.width: 2
                implicitWidth: toolBar.height*0.4
                implicitHeight: toolBar.height*0.4
                radius:toolBar.height*0.2
            }
        }
        Connections {//进度条和player的进度绑定
            target: player
            onPositionChanged: {
                temp.sync = true
                temp.value = player.position
                temp.sync = false
            }
        }
    }

    Label {//总时间(从视频中获取)
        // position time;
        width: toolBar.height*1.2;
        height: toolBar.height;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        anchors.right: toolBar.right;
        font.pointSize: toolBar.height / 5;
        color:"yellow";

        // 21 May 2001 14:13:09
        //var dateTime = new Date(2001, 5, 21, 14, 13, 09);

        readonly property int minutes: Math.floor(player.position / 60000);
        readonly property int seconds: Math.round((player.position % 60000) / 1000);
        readonly property int hours : (player.position / 3600000 > 1) ?Math.floor(player.position / 3600000):0;

        text: Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds), qsTr("hh:mm:ss"));
    }

//on process 一个组件一个组件调试
    Row{//其他视频控制组件
        id:r
        anchors.verticalCenter: toolBar.verticalCenter;
        VB.MenuButton{
            // menu
            name: "about..."
            width: toolBar.height;
            height: toolBar.height;
            sourceReleased: "qrc:/src/icon/menu.png"
            sourcePressed: "qrc:/src/icon/menu_.png"
            source:  sourceReleased
            onClicked:{
                about.open();
            }
        }
        VB.MenuButton{
            // openFile
            name:"open file ...."
            width: toolBar.height;
            height: toolBar.height;
            sourceReleased: "qrc:/src/icon/open.png"
            sourcePressed: "qrc:/src/icon/open_.png"
            source:  sourceReleased
            onClicked:{
                fileDialog.open();
            }
        }
        VB.MenuButton{
            // rewind
            name: "backward"
            width: toolBar.height;
            height: toolBar.height;
            sourceReleased: "qrc:/src/icon/rewind.png"
            sourcePressed: "qrc:/src/icon/rewind_.png"
            source:  sourceReleased
            onClicked:{
                player.seek(player.position - 5000);
            }
        }
        //playcontrol
        /*2 VB ui to do*/
        VB.MenuButton{
            // play_pause
            id: play_controller
            name: "play"
            width: toolBar.height;
            height: toolBar.height;

            source:  "qrc:/src/icon/play.png"
            property bool doesItPlay: false
            sourcePressed: doesItPlay? "qrc:/src/icon/pause_.png" : "qrc:/src/icon/play_.png"
            sourceReleased: doesItPlay? "qrc:/src/icon/pause.png" : "qrc:/src/icon/play.png"
            onDoesItPlayChanged: {
                source = doesItPlay? "qrc:/src/icon/pause.png" : "qrc:/src/icon/play.png";
                sourcePressed = doesItPlay? "qrc:/src/icon/pause_.png" : "qrc:/src/icon/play_.png";
                sourceReleased = doesItPlay? "qrc:/src/icon/pause.png" : "qrc:/src/icon/play.png";
            }
            onClicked:{
                player.playbackState == MediaPlayer.PlayingState ? player.pause() : player.play();
            }
            Connections{
                target: player
                onPlaybackStateChanged:{
                    switch(player.playbackState)
                    {
                    case   MediaPlayer.PlayingState:
                        //console.debug("PlayingState");
                        play_controller.doesItPlay = true;
                        break;

                    case   MediaPlayer.PausedState:
                        //console.debug("PausedState");
                        play_controller.doesItPlay = false;
                        break;

                    case   MediaPlayer.StoppedState:
                        //console.debug("StoppedState");
                        play_controller.doesItPlay = false;
                        break;
                    }
                }

            }
        }
        VB.MenuButton{
            // stop
            name: "stop"
            width: toolBar.height;
            height: toolBar.height;
            sourceReleased: "qrc:/src/icon/stop.png"
            sourcePressed: "qrc:/src/icon/stop_.png"
            source:  sourceReleased
            onClicked:{
                videoOutput.extractFrame();
                player.stop();
            }
        }
        VB.MenuButton{
            // speed
            name: "forward"
            width: toolBar.height;
            height: toolBar.height;
            sourceReleased: "qrc:/src/icon/speed.png"
            sourcePressed: "qrc:/src/icon/speed_.png"
            source:  sourceReleased
            onClicked:{
                player.seek(player.position + 5000);
            }
        }

        Label {
            // tool time;
            width: toolBar.height*1.2
            height: toolBar.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color:"white"

            // 21 May 2001 14:13:09
            //var dateTime = new Date(2001, 5, 21, 14, 13, 09)

            readonly property int minutes: Math.floor(player.duration / 60000)
            readonly property int seconds: Math.round((player.duration % 60000) / 1000)
            readonly property int hours : (player.duration / 3600000 > 1) ?Math.floor(player.duration / 3600000):0

            text: Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds), qsTr("hh:mm:ss"))

        }

    }
//on process
    FileDialog {//选择视频源
        id: fileDialog
        title: "Please choose a file";
        onAccepted: {
            player.source = fileDialog.fileUrl;//这里应当使用一个类中的属性来代替player
            player.play();
        }
        //onRejected: {console.log("Canceled");}
    }

    MessageDialog {//查看辅助信息
        id: about
        title: "how to use"
        text:
"功能:
    1.打开文件
    2.播放 暂停
    3.错误信息提示
    4.鼠标菜单 移动隐藏 可拖拽
    5.全屏
    6.隐藏播放栏
    7.时间显示
    8.播放模式一次或者无限循环
    9.快捷键:
        ctrl+H : 隐藏播放栏
        空格键 : 暂停/播放
        回车键 : 全屏/正常窗口
        esc : 退出全屏
        → : 快进
        ← : 快退
        ↓ : 声音加
        ↑ : 声音减
菜单可以用鼠标拖拽，点击菜单空白处隐藏，单击鼠标右键可以显示菜单

"
        onAccepted: {
            about.close();
        }
    }

}

