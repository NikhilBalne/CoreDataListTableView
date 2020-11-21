//
//  EmployeeViewController.swift
//  SuperDoc
//
//  Created by Nikhil Balne on 21/11/20.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    private let manager = EmployeeManager()
    var employees : [Employee]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGetApiCall()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        self.title = "Employees List"
        employees = manager.fetchEmployee()
        if(employees != nil && employees?.count != 0)
        {
            self.employeeTableView.reloadData()
        }
    }

    func makeGetApiCall(){
        URLSession.shared.dataTask(with: URL(string: "http://demo6035679.mockable.io/s")!) { (serviceData, serviceResponse, error) in
            
            if error == nil && serviceData != nil && serviceData?.count != 0 {
            
                let httpUrlResponse = serviceResponse as! HTTPURLResponse
                
                if httpUrlResponse.statusCode == 200 {
                    print("StatusCode:\(httpUrlResponse.statusCode)")
                    
                    do {
                        let result = try JSONDecoder().decode([Employee].self, from: serviceData!)
                        
                        print("Result:\(result)")
                        self.manager.clearRecords()
                        self.manager.createEmployees(employee: result)
                        
                    } catch let error {
                        print("Error:\(error.localizedDescription)")
                    }
                    
                } else {
                    print("StatusCode:\(httpUrlResponse.statusCode)")
                }
                
            }
            
            }.resume()
    }
    
}

extension EmployeeViewController : UITableViewDelegate, UITableViewDataSource
{

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employees!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as! EmployeeTableViewCell
        let employee = self.employees![indexPath.row]
       
        cell.nameLabel.text = employee.name
        cell.emailLabel.text = employee.email

        return cell
    }
}
