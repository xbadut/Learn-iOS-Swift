//
//  CategoryViewController.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 05/10/21.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var listArray = [Category]()
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let category = Category(context: self.viewContext)
            
            category.name = textField.text
            
            self.listArray.append(category)
            
            self.saveData()
            
        }
        
        alert.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "add category"
            textField = textFieldAlert
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let item = listArray[indexPath.row]
        
        cell.textLabel?.text = item.name
                
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
                
                vc.selectedCategory = listArray[safeIndex]

            }
        }
    }
    
    
    func saveData() {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            listArray = try viewContext.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
}
