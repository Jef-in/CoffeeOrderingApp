//
//  AddOrderController.swift
//  CofeeApp
//
//  Created by Jefin on 12/04/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate {
    
    func addcoffeeordersavedelegate(order:Order,controller:UIViewController)
    func addcoffeeorderclosedelegate(controller:UIViewController)
}

class AddOrderController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: AddCoffeeOrderDelegate?
    private var CoffeeSizesSegmentedControl: UISegmentedControl!
    private var vm = AddCoffeeOrderViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        
        self.CoffeeSizesSegmentedControl = UISegmentedControl(items: self.vm.sizes)
    self.CoffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.CoffeeSizesSegmentedControl)
        
        self.CoffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        
        self.CoffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vm.types.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.vm.types[indexPath.row]
        
        return cell
    }
    
    @IBAction func close() {
        
        if let delegate = self.delegate {
            
            delegate.addcoffeeorderclosedelegate(controller: self)
        }
    }
    
    @IBAction func save() {
        
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let CoffeeSize = self.CoffeeSizesSegmentedControl.titleForSegment(at: self.CoffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexpath =  self.tableView.indexPathForSelectedRow else {  fatalError("Error in selecting cofee! ") }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.CofeeSize = CoffeeSize
        self.vm.CofeeType = self.vm.types[indexpath.row]
        
        WebService().load(resource: Order.create(vm: self.vm)){ result in
            
            switch result {
                
            case .success(let order):
                
                if let order = order,let delegate = self.delegate {
                    
                    DispatchQueue.main.async {
                        
                          delegate.addcoffeeordersavedelegate(order: order, controller: self)
                    }
                  
                }
                
            case .failure(let error):
                print(error)
          
                
            }
            
        }
        
    }
    
}
