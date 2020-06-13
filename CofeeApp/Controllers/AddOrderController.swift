//
//  AddOrderController.swift
//  CofeeApp
//
//  Created by Jefin on 12/04/20.
//  Copyright © 2020 Jefin. All rights reserved.
//

import Foundation
import UIKit

class AddOrderController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    
}
