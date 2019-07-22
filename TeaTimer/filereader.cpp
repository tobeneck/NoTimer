#include "filereader.h"

#include <QDebug>

FileReader::FileReader()
{

}

/**
 * reads the File at filePath
 */
QString FileReader::readFile(QString filePath)
{
    QFile file(filePath);
    QString text = "";
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        text = stream.readAll();
    }
    else {
        qWarning() << "Can not open File: " << filePath;
    }
    return text;
}

/**
 * Creates or Overrides the File at the filePath with the content
 */
void FileReader::writeFile(QString filePath, QString content)
{
    qDebug() << "write " + content + " to " +filePath;
    QFile file(filePath);
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << content;
    }
    else {
        qWarning() << "Can not open File: " << filePath;
    }
}
