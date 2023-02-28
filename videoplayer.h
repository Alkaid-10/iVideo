#ifndef VIDEOPLAYER_H
#define VIDEOPLAYER_H
#include <QObject>
#include <QString>
#include <QQmlEngine>

class VideoPlayer: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString player READ player WRITE setPlayer NOTIFY playerChanged)
public:
    VideoPlayer();
    static QObject *createVideoPlayerSingle(QQmlEngine *engine,QJSEngine *scriptEngine){return new VideoPlayer();}

    QString player(){return m_player;}
    void setPlayer(QString source);
signals:
    void playerChanged();

private:
    QString m_player;

};

#endif // VIDEOPLAYER_H
