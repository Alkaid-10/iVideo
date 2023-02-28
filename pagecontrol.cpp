#include "pagecontrol.h"

PageControl::PageControl()
{

}
QString PageControl::loginPage(){
    return m_loginPage;

}
void PageControl::setloginPage(QString loginPage){
    m_loginPage = loginPage;
    emit loginPageChanged();
}
