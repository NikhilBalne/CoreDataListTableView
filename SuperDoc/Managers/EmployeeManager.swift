//
//  EmployeeManager.swift
//  SuperDoc
//
//  Created by Nikhil Balne on 21/11/20.
//

import Foundation

struct EmployeeManager
{
    private let _employeeDataRepository = EmployeeDataRepository()

    func createEmployees(employee: [Employee]) {
        _employeeDataRepository.prepare(dataForSaving: employee)
    }
    
    func createEmployee(employee: Employee) {
        _employeeDataRepository.create(employee: employee)
    }

    func fetchEmployee() -> [Employee]? {
        return _employeeDataRepository.getAll()
    }

    func clearRecords(){
        return _employeeDataRepository.clearCoreData()
    }
    
    func fetchEmployee(byIdentifier id: UUID) -> Employee?
    {
        return _employeeDataRepository.get(byIdentifier: id)
    }

    func updateEmployee(employee: Employee) -> Bool {
        return _employeeDataRepository.update(employee: employee)
    }

    func deleteEmployee(id: UUID) -> Bool {
        return _employeeDataRepository.delete(id: id)
    }
}
