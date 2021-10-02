//
//  ViewController.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 29/09/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var listArray: [Item] = []
    
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func addTodoEuy(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add todo euy", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let item = Item(title: textField.text!)
            
            self.listArray.append(item)
            
            self.saveData()
        }
        
        alert.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "add todo"
            textField = textFieldAlert
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoEuyCell", for: indexPath)
        
        let item = listArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.check ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].check = !listArray[indexPath.row].check
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveData() {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(listArray)
            try data.write(to: dataFile!)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadData() {
        do {
            if let data = try? Data(contentsOf: dataFile!) {
                let decoder = PropertyListDecoder()
                self.listArray = try decoder.decode([Item].self, from: data)
            }
        } catch {
            print(error)
            
        }
        tableView.reloadData()
    }
}

