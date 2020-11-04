//
//  EntityPickerViewController.swift
//  MyiTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit

protocol EntityPickerViewControllerDelegate: class {
    func entityPickerViewController(_ controller: EntityPickerViewController, didSelect entities: [String])
}

class EntityPickerViewController: BaseViewController {

    //MARK: - IBOutlets
    
    //MARK: - Properties
    
    var entities = ["movie","podcast","music","musicVideo","audiobook","shortFilm","tvShow","software","ebook", "all"]
    var selectedEntities = [String]()
    
    weak var delegate: EntityPickerViewControllerDelegate?
    
    //MARK: - Controller Flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorScheme = .light
        title = "Select Media Types"
    }
    
    
    
    //MARK: - IBActions
    
    //MARK: - Methods

}

extension EntityPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntityTableViewCell") as? EntityTableViewCell else {return UITableViewCell()}
        
        cell.lblTitle.text = entities[indexPath.row]
        if selectedEntities.contains(entities[indexPath.row]) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if selectedEntities.contains(entities[indexPath.row]) {
            selectedEntities.remove(at: selectedEntities.firstIndex(of: entities[indexPath.row])!)
        } else {
            selectedEntities.append(entities[indexPath.row])
        }
        
        delegate?.entityPickerViewController(self, didSelect: selectedEntities)
        
        tableView.reloadData()
    }
}

