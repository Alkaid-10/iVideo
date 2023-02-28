import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.3
import QtMultimedia 5.4
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

import com.jin.videoplayer 1.0
import com.jin.pagecontrol 1.0
import "./qml"

ApplicationWindow {
    id: appWindow

    width: 600
    height: 400
    title: qsTr("iVideo")

    //set the visible property true
    visible: true

    style: ApplicationWindowStyle{
        id: styleSetting
        background: Rectangle{
            width: appWindow.width
            height: appWindow.height
            Image{
                id:backgroundItem
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/src/background.jpg"
            }
        }
    }
    //使用page loader加载login界面，后面可以拓展一个视频剪辑界面
    Loader{
        id: pageLoader
        anchors.fill: parent
        anchors.centerIn: parent
    }
    PageControl{
        id: pageController
        onLoginPageChanged: {

            videoOutput.visible = true;
            bar.visible = true;
            pageLoader.visible = false;
        }
    }
    Component.onCompleted: pageLoader.sourceComponent = loginPageItem
    Component{//默认进入登录界面
        id: loginPageItem
        LoginPage{}
    }
    IVideoPlayer{//
        //解决player源的设置问题
        visible: false
        id: videoOutput
    }
    //状态栏
    statusBar: PlayerBar{//默认false，通过一个pagecontoller类来控制是否展示，和IVideoPlayer同步
        id: bar
        visible: false
        player: videoOutput.source
    }

}
