//
//  ViewController.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 29/09/21.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var listArray: [Item] = []
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func addTodoEuy(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add todo euy", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let item = Item(context: self.viewContext)
            item.title = textField.text
            item.check = false
            
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
            try viewContext.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            listArray = try viewContext.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with: request)
    }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0) {
            loadData()
            
            searchBar.resignFirstResponder()

        }
    }
    
}
