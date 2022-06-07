//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ray WU on 04/06/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()

    var categories: Results<Category>?

    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No Categories Added"
        return cell
    }

    //MARK: - Data Manipulation Methods
    private func loadCategories() {
        categories = realm.objects(Category.self)
        /*Core data
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }*/
        tableView.reloadData()
    }

    private func save(_ category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }

    override func updateModel(at indexPath: IndexPath) {
        if let swipedCat = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(swipedCat)
                }
            } catch {
                print("Error deleting category,\(error)")
            }
            //tableView.reloadData()
        }
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var fieldText = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            //what will happen once the user clicks the Add Item button on our UIAlert
            let newCategory = Category()
            newCategory.name = fieldText.text!
            self.save(newCategory)
        }
        alert.addTextField { field in
            field.placeholder = "Create new Category"
            fieldText = field
        }
        alert.addAction(action)
        present(alert, animated: true)
    }


    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoListController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCat = categories?[indexPath.row]
            }
        }
    }

}
