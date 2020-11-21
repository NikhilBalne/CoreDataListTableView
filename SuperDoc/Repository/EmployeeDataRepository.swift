//
//  EmployeeDataRepository.swift
//  SuperDoc
//
//  Created by Nikhil Balne on 21/11/20.
//

import Foundation
import CoreData

protocol EmployeeRepository {

    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(id: UUID) -> Bool
    func clearCoreData()
}

struct EmployeeDataRepository : EmployeeRepository
{
    func clearCoreData() {
        PersistentStorage.shared.clearCoreDataStore()
    }
    
    func prepare(dataForSaving: [Employee]){
        
        // loop through all the data received from the Web and then convert to managed object and save them
        _ = dataForSaving.map{self.create(employee: $0)}
        PersistentStorage.shared.saveContext()
    }
    
    func create(employee: Employee) {

        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name

        debugPrint("Called")
        
        PersistentStorage.shared.saveContext()

    }

    func getAll() -> [Employee]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)

        var employees : [Employee] = []

        result?.forEach({ (cdEmployee) in
            employees.append(cdEmployee.convertToEmployee())
        })

        return employees
    }

    func get(byIdentifier id: UUID) -> Employee? {

        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToEmployee()
    }

    func update(employee: Employee) -> Bool {

//        let cdEmployee = getCDEmployee(byIdentifier: employee.id)
//        guard cdEmployee != nil else {return false}
//
//        cdEmployee?.email = employee.email
//        cdEmployee?.name = employee.name
//
//        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(id: UUID) -> Bool {

        let cdEmployee = getCDEmployee(byIdentifier: id)
        guard cdEmployee != nil else {return false}

        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    }


    private func getCDEmployee(byIdentifier id: UUID) -> CDEmployee?
    {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }

    
}
