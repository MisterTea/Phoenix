#ifndef GAMEFILEINFO_H
#define GAMEFILEINFO_H

#include "frontendcommon.h"

#include "systemdatabase.h"
#include "metadatadatabase.h"

namespace Library {

    class GameFileInfo : public QFileInfo {
    public:
        GameFileInfo( const QString &file );

        struct HeaderData {
            QString result;
            QString systemIndex;
            qint64 seekPosition;
            qint64 byteLength;
        };

        struct CueData {
            QString system;
            QString sha1;
        };

        QString system() const;
        QString crc32CheckSum() const;
        QString title() const;
        QString fullFilePath() const;
        QString timePlayed() const;
        QString crc32Checksum() const;
        QString artworkUrl() const;

        enum FileType {
            UnsupportedFile = -1,
            GameFile = 0,
            ZipFile,
            BiosFile,
            CueFile,
        };

        FileType fileType() const;

        static QStringList gameFilter();
        QList<HeaderData> getPossibleHeaders( const QStringList &possibleSystems );
        QString getRealSystem( const QList<HeaderData> &possibleHeaders );

        void cache( const QString &location );

        static QString getRealSystem( const QList<HeaderData> &possibleHeaders, const QString &localFile );
        void prepareMetadata();

    protected:
        FileType mFileType;
        QString mSystem;
        QString mCrc32Checksum;
        QString mTitle;
        QString mFullFilePath;
        QString mArtworkUrl;
        QSqlQuery mQuery;

        QStringList getAvailableSystems( const QString &extension );
        QString getCheckSum( const QString &filePath );

        void update( const QString &extension );

        bool isBios( QString &biosName );

        void fillMetadata( int romID, QSqlQuery &query );


    private:
        QString mTimePlayed;

    };


}

#endif // GAMEFILEINFO_H
