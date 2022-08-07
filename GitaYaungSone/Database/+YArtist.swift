//
//  +YArtist.swift
//  GitaYaungSone
//
//  Created by Aung Ko Min on 7/8/22.
//

import CoreData

extension YArtist {

    func artist() async -> Artist? {
        await ArtistRepo.shared.fetch([.name(self.name ?? "")]).first
    }

    class func save(artist: Artist) -> YArtist {
        let context = PersistenceController.shared.context
        let x = YArtist(context: context)
        x.id = artist.id
        x.name = artist.name
        x.photoURL = artist.photoURL
        PersistenceController.shared.save()
        return x
    }

    class func all() -> [YArtist] {
        let context = PersistenceController.shared.context
        let request = NSFetchRequest<YArtist>(entityName: YArtist.entity().name!)

        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}
