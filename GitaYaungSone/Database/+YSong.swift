//
//  +YSong.swift
//  Myanmar Song Book
//
//  Created by Aung Ko Min on 3/5/22.
//

import CoreData

extension YSong {
    
    var song: Song {
        Song(ySong: self)
    }
    class func save(song: Song) -> YSong {
        let context = PersistenceController.shared.context
        let x = YSong(context: context)
        x.id = song.id
        x.title = song.title
        x.artist = song.artist
        x.artists = song.artists
        x.composer = song.composer
        x.album = song.album
        x.key = song.key
        x.tempo = song.tempo
        x.genre = song.genre
        x.mediaLink = song.mediaLink
        x.rawText = song.rawText
        x.created = song.created
        x.createrID = song.createrID
        x.popularity = Int16(song.popularity)
        PersistenceController.shared.save()
        return x
    }
    
    class func all() -> [YSong] {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        request.sortDescriptors = [NSSortDescriptor(key: "lastViewed", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }

    class func sameItems(title: String, artist: String) -> [YSong] {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        let title = NSPredicate(format: "title == %@", title)
        let artist = NSPredicate(format: "artist == %@", artist)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [title, artist])
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    class func hasSaved(for id: String) -> YSong? {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        } catch {
            fatalError()
        }
    }
    
    class func delete(ySong: YSong) {
        let context = PersistenceController.shared.context
        context.delete(ySong)
    }
    
    class func search(text: String) -> [YSong] {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        let title = NSPredicate(format: "title CONTAINS[cd] %@", text)
        let artist = NSPredicate(format: "artist CONTAINS[cd] %@", text)
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [title, artist])
        request.sortDescriptors = [NSSortDescriptor(key: "lastViewed", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
//    class func search(value: String, property: Song.Property) -> [YSong] {
//        let context = PersistenceController.shared.context
//        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
//        request.predicate = NSPredicate(format: "\(property.rawValue) ==[cd] %@", value)
//        request.sortDescriptors = [NSSortDescriptor(key: "lastViewed", ascending: false)]
//        do {
//            return try context.fetch(request)
//        } catch {
//            fatalError()
//        }
//    }
}

extension Song {
    init(ySong: YSong) {
        id = ySong.id
        title = ySong.title.str
        artists = ySong.artists ?? []
        composer = ySong.composer.str
        album = ySong.album.str
        key = ySong.key.str
        tempo = ySong.tempo.str
        genre = ySong.genre.str
        mediaLink = ySong.mediaLink.str
        rawText = ySong.rawText.str
        created = ySong.created ?? Date()
        createrID = ySong.createrID.str
        artist = ySong.artist.str
        popularity = Int(ySong.popularity)
    }
}
