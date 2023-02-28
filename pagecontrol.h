#ifndef PAGECONTROL_H
#define PAGECONTROL_H
#include <QObject>
#include <QString>

class PageControl: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString loginPage READ loginPage WRITE setloginPage NOTIFY loginPageChanged)
public:
    PageControl();
    QString loginPage();
    void setloginPage(QString loginPage);
signals:
    void loginPageChanged();
private:
    QString m_loginPage;
};

#endif // PAGECONTROL_H
