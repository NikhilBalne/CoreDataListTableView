//
//  CDEmployee+CoreDataProperties.swift
//  SuperDoc
//
//  Created by Nikhil Balne on 21/11/20.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?

    func convertToEmployee() -> Employee
    {
        return Employee(name: self.name, email: self.email)
    }
}

extension CDEmployee : Identifiable {

}
