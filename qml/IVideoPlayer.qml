import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.3
import QtMultimedia 5.4
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
//VideoPlayer part

    VideoOutput{
        id: videoOutput
        objectName: "video_source"
        source: player
        anchors.fill: parent
        fillMode: videoOutput.PreserveAspectCrop
        property alias totalTime: player.totalTime;//尝试写到一个类里


        function extractFrame(){
            //Create an Image element
            var image = Qt.createQmlObject('import QtQuick 2.0; Image {}',videoOutput,"image");

            image.width = videoOutput.width;
            image.height = videoOutput.height;

            videoOutput.grabToImage(function(result){
                image.source = result.url;
                var savePath = "/home/user/Pictures/img_generated.jpg";
                image.saveToFile(savePath);
                image.destory();

            });
        }
        ErrorDialog{
            player: player
        }
        MediaPlayer{
            id: player
            loops: MediaPlayer.Infinite//默认无限循环播放

            //时间轴，尝试写到一个类里
            readonly property int minutes: Math.floor(player.duration / 60000);
            readonly property int seconds: Math.round((player.duration % 60000) / 1000);
            readonly property int hours : (player.duration / 3600000 > 1) ?Math.floor(player.duration / 3600000):0;
            readonly property string totalTime:Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds), qsTr("hh:mm:ss"));

        }

        //videoOutput 的时间轴属性，尝试使用类来处理
        readonly property int minutes: Math.floor(player.position / 60000);
        readonly property int seconds: Math.round((player.position % 60000) / 1000);
        readonly property int hours : (player.position / 3600000 > 1) ?Math.floor(player.position / 3600000):0;
        readonly property string positionTime:Qt.formatTime(new Date(0, 0, 0, hours, minutes, seconds), qsTr("hh:mm:ss"));

        MouseArea{//videoOutput 的鼠标区域
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onClicked: {//鼠标点击打开menu
                if(mouse.button == Qt.LeftButton){//鼠标左侧点击
                    player.playbackState = MediaPlayer.PlayingState ? player.pause() : player.play();
                }
                if(mouse.button == Qt.RightButton){//鼠标右侧点击
                    //打开menu
                    menu.open(mouse.x,mouse.y);
                }
                else{
                    //关闭menu
                    menu.close();
                }
            }

            onWheel: {//滚轮调整声音
                if(wheel.angleDelta.y < 0){
                    if(player.volume != 0) player.volume -= 0.1;
                }
                else if(wheel.angleDelta.y > 0 ){
                    if(player.volume != 1) player.volume +=0.1;
                }
            }
        //键盘控制部分
        focus: true
        Keys.onSpacePressed: player.playbackState == MediaPlayer.PlayingState ? player.pause() : player.play() //space键控制播放暂停
        Keys.onLeftPressed: player.seek(player.position - 5000) //<-控制后退（ 1 次 5s）
        Keys.onRightPressed: player.seek(player.position + 5000) //->控制前进（ 1 次 5s）
        Keys.onReturnPressed: appWindow.visibility = (appWindow.visibility == Window.FullScreen)? Window.Windowed : Window.FullScreen;
        Keys.onUpPressed: {
            if (player.volume != 1){//up键控制音量+
                player.volume += 0.1;
            }
        }
        Keys.onDownPressed: {
            if (player.volume != 0){//down键控制音量-
                player.volume -= 0.1;
            }
        }
        Keys.onPressed:{//H键按下
            //隐藏statusBar，待实现
            if (event.key == Qt.Key_H){
                bar.visible = !bar.visible;
            }
        }

        }
        //menu 待实现在这里
        MouseClickedMenu{
            id: menu
            Column{
                spacing: 10
                Rectangle{
                    width: menu.width
                    height: 20
                    color: "#4079FF"
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("恭喜发现隐藏menu")
                    }
                }
                Text {
                    text: player.loops < 0? "Video Never End":"One Last Play"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: (player.loops != -1)? (player.loops = MediaPlayer.Infinite) : (player.loops = 1)
                    }
                }
                Text {
                    text: bar.visible? "隐藏播放栏":"显示播放栏"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: bar.visible? (bar.visible = false): (bar.visible = true)
                    }
                }

            }
        }
    }






