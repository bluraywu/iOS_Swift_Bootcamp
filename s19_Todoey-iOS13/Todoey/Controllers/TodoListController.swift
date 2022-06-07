//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListController: SwipeTableViewController {
    let realm = try! Realm()
    var selectedCat: Category? {
        didSet {
            loadItems()
        }
    }
    var items: Results<Item>?
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //app path
        //print(dataFilePath!)
    }


    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No item added yet"
        }
        return cell
    }

//MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items?[indexPath.row] {
            do {
                try realm.write({
                    item.done = !item.done
                    //for realm delete
                    //realm.delete(item)
                })
            } catch {
                print("Error saving done status,\(error)")
            }
        }
        tableView.reloadData()
        //print(itemArray[indexPath.row])
        //for DELETE
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

//        items[indexPath.row].done = !items[indexPath.row].done
//        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

//MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var fieldText = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //what will happen once the user clicks the Add Item button on our UIAlert
            if let currentCategory = self.selectedCat {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = fieldText.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new item")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { field in
            field.placeholder = "Create new Item"
            fieldText = field
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

//    private func saveItems() {
//        do {
//            try realm.write({
//                realm.add(item)
//            })
//        } catch {
//            print("Error saving context \(error)")
//        }
//        tableView.reloadData()
///* for user defaults
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//            tableView.reloadData()
//        } catch {
//            print("Error saving context \(error)")
//
//        }
//        tableView.reloadData()
// */
//    }


    private func loadItems() {
        items = selectedCat?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    override func updateModel(at indexPath: IndexPath) {
        if let swipedItem = self.items?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(swipedItem)
                }
            } catch {
                print("Error deleting category,\(error)")
            }
            //tableView.reloadData()
        }
    }

//  For core data
//    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        let catPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCat!.name!)
//        if let addtionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catPredicate, addtionalPredicate])
//        }else{
//            request.predicate = catPredicate
//        }
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
///* for user defaults
//    if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
// */
//    }
}

//MARK - Search bar method
extension TodoListController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let safeSearchText = searchBar.text {
            items = items?.filter("title CONTAINS[cd] %@", safeSearchText).sorted(byKeyPath: "dateCreated", ascending: true)
        }
        tableView.reloadData()
//        if let safeSearchText = searchBar.text {
//            let request: NSFetchRequest<Item> = Item.fetchRequest()
//            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", safeSearchText)
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//            loadItems(with: request,predicate: predicate)
//        }
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
