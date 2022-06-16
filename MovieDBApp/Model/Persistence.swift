//
//  Persistence.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MovieDBApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
                print("Could not load. \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func retrieveData(type:String ,completion: ([MovieData]) -> ())
    {
        // Create a fetch request for a NamedEntity
        let fetchRequest: NSFetchRequest<MovieData>
        fetchRequest = MovieData.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "type LIKE %@", type
        )

        // Get a reference to a NSManagedObjectContext
        let context = container.viewContext

        var objects: [MovieData] = []
        
        do {
            objects = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            //Return empty
            completion(objects)
            return
        }
        
        completion(objects)
    }
    
    func deleteData(popular isPopular:Bool)
    {
        let context = container.viewContext
        
        var type = "popular"
        
        if !isPopular
        {
            type = "upcoming"
        }
        
        self.retrieveData (type:type){ objects in
            for object in objects {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
    func saveImage(movieArray:[(movie:Movie, data:Data)], type:String, imageType:String)
    {
        let fetchRequest: NSFetchRequest<MovieData>
        fetchRequest = MovieData.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "type LIKE %@", type
        )

        // Get a reference to a NSManagedObjectContext
        let context = container.viewContext
        
        var objects: [MovieData] = []
        
        do {
            objects = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return
        }
        
        for item in movieArray {
            for object in objects {
                if (Int(object.id) == item.movie.id) {
                    object.setValue(item.data, forKey: imageType)
                }
            }
        }
                
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(_ movieArray:[Movie], type:String)
    {
        let context = container.viewContext
        
        self.retrieveData (type:type){ objects in
            
            for movie in movieArray {
                if objects.firstIndex(where: { $0.id == movie.id ?? 0}) == nil {
                    let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: context)!
                    let movieData = NSManagedObject(entity: entity, insertInto: context)
                    movieData.setValue(movie.id, forKeyPath: "id")
                    movieData.setValue(movie.title, forKeyPath: "title")
                    movieData.setValue(movie.releaseDate, forKeyPath: "releaseDate")
                    movieData.setValue(movie.voteAverage, forKeyPath: "voteAverage")
                    movieData.setValue(movie.overview, forKeyPath: "overview")
                    movieData.setValue(type, forKeyPath: "type")
                }
            }
            
        }
        
        do {
            try context.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        
        
    }
    
    func addFavourite(movie:Movie, completion: () -> ())
    {
        // Get a reference to a NSManagedObjectContext
        let context = container.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: context)!
        let movieData = NSManagedObject(entity: entity, insertInto: context)
        movieData.setValue(movie.id, forKeyPath: "id")
        movieData.setValue(movie.title, forKeyPath: "title")
        movieData.setValue(movie.releaseDate, forKeyPath: "releaseDate")
        movieData.setValue(movie.voteAverage, forKeyPath: "voteAverage")
        movieData.setValue(movie.overview, forKeyPath: "overview")
        movieData.setValue("favourite", forKeyPath: "type")
        
        do {
            try context.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        
        completion()
    }
}
