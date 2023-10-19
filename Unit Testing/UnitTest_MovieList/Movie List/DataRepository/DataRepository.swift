//
//  DataRepository.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 19/10/23.
//

import Foundation
import CoreData

protocol Repository {
    func addUser(entity: UserModel)
    func saveUser()
    func fetchUser() -> [User]
}

class MockRespository: Repository{
    
    var userModel: UserModel!
    var userList: [User] = [User]()
    
    var container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MovieDataModel")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    func addUser(entity: UserModel) {
        userModel = entity
        saveUser()
    }
    
    func saveUser() {
        let newUser = User(context: container.viewContext)
        
        newUser.name = userModel.name
        newUser.email = userModel.email
        newUser.password = userModel.password
        
        userList.append(newUser)
    }
    
    func fetchUser() -> [User] {
        return userList
    }
}


class DataRepository: Repository {
    var container: NSPersistentContainer
    var savedEntities: [User] = []
    
    init() {
        container = NSPersistentContainer(name: "MovieDataModel")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    func fetchUser() -> [User] {
        let request = NSFetchRequest<User>(entityName: "User")
        do {
            savedEntities = try container.viewContext.fetch(request)
            for item in savedEntities {
                print(item.email)
            }
            return savedEntities
        } catch let error {
            print("Error fetching. \(error)")
        }
        return []
    }
    
    
    func addUser(entity: UserModel) {
        let newUser = User(context: container.viewContext)
        newUser.name = entity.name
        newUser.email = entity.email
        newUser.password = entity.password
        
        saveUser()
    }
    
    func saveUser() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

