//
//  ViewController.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 29/09/21.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadData()
        }
    }
    
    var items: Results<Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTodoEuy(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add todo euy", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let item = Item()
            item.title = textField.text!
            item.check = false
            item.date = Date.now
            
            self.saveData(item: item)
        }
        
        alert.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "add todo"
            textField = textFieldAlert
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoEuyCell", for: indexPath)
        
        if let item = items?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.check ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Empty items"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let safeCategory = selectedCategory {
            do {
                try realm.write {
                    safeCategory.items[indexPath.row].check = !safeCategory.items[indexPath.row].check
                }
            } catch {
                print("eerror")
            }
        }
        
        self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func saveData(item: Item) {
        do {
            try realm.write {
                selectedCategory?.items.append(item)
            }
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        
        items = selectedCategory?.items.sorted(byKeyPath: "date", ascending: true)
        
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let predicate = NSPredicate(format: "title CONTAINS [cd] %@", argumentArray: [searchBar.text!])
        
        items = selectedCategory?.items.filter(predicate).sorted(byKeyPath: "date", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText.count == 0) {
            
            loadData()
            
            searchBar.resignFirstResponder()
        }
    }
    
}
