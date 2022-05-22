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
        x.title = song.title
        x.artist = song.artist
        x.rawText = song.rawText
        x.key = song.key
        x.album = song.album
        x.composer = song.composer
        x.date = Date()
        x.genre = song.genre
        x.id = song.id
        x.tempo = song.tempo
        x.mediaLink = song.mediaLink
        x.lastViewed = Date()
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
    
    class func create(song: Song) {
        let sameItems = sameItems(title: song.title, artist: song.artist)
        let sorted = sameItems.sorted { one, two in
            one.version > two.version
        }
        let x = YSong.save(song: song)
        x.version = (sorted.first?.version ?? -1) + 1
        PersistenceController.shared.save()
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
    class func cLyrics(for id: String) -> YSong? {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        request.predicate = NSPredicate(format: "id == %@", id)
        request.sortDescriptors = [NSSortDescriptor(key: "lastViewed", ascending: false)]
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
    
    class func search(value: String, property: Song.Property) -> [YSong] {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YSong>(entityName: YSong.entity().name!)
        request.predicate = NSPredicate(format: "\(property.key) ==[cd] %@", value)
        request.sortDescriptors = [NSSortDescriptor(key: "lastViewed", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}
