#ifndef FILEREADER_H
#define FILEREADER_H

#include <QQuickItem>

class FileReader : public QQuickItem
{
    Q_OBJECT
public:
    FileReader();

    Q_INVOKABLE QString readFile(QString filePath);
    Q_INVOKABLE void writeFile(QString filePath, QString content);
};

#endif // FILEREADER_H
