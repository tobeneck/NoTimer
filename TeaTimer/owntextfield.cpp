#include "owntextfield.h"

OwnTextField::OwnTextField(QObject *parent)
    : QAbstractItemModel(parent)
{
}

QVariant OwnTextField::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

QModelIndex OwnTextField::index(int row, int column, const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

QModelIndex OwnTextField::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int OwnTextField::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int OwnTextField::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

QVariant OwnTextField::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}
