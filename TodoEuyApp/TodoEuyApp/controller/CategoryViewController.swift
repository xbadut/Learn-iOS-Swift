//
//  CategoryViewController.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 05/10/21.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let category = Category()
            
            category.name = textField.text!
            
            self.saveData(category: category)
        }
        
        alert.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "add category"
            textField = textFieldAlert
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        if let item = categories?[indexPath.row] {
            cell.textLabel?.text = item.name
        } else {
            cell.textLabel?.text = "Empty category"
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToDetail", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            
            if let safeIndex = tableView.indexPathForSelectedRow?.row {
                
                let vc = segue.destination as! ViewController
                
                vc.selectedCategory = categories?[safeIndex]
                
            }
        }
    }
    
    
    func saveData(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
