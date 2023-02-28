#include "videoplayer.h"

VideoPlayer::VideoPlayer()
{

}
void VideoPlayer::setPlayer(QString source){
    m_player = source;
    emit playerChanged();
}
