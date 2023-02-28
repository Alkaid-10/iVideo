#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QObject>
#include "videoplayer.h"
#include "pagecontrol.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    //注册cpp类
    qmlRegisterSingletonType<VideoPlayer>("com.jin.videoplayer",1,0,"VideoPlayerClass",VideoPlayer::createVideoPlayerSingle);
    qmlRegisterType<PageControl>("com.jin.pagecontrol",1,0,"PageControl");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    //处理视频(从中提取帧并另存为image)
    auto qmlVideoPlayer = engine.rootObjects()[0]->findChild<QObject*>("video_source");

    return app.exec();
}
