//
//  HomeViewController.swift
//  iTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit
import TagListView

class HomeViewController: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtTerm: UITextField!
    @IBOutlet weak var tagView: TagListView!
    
    //MARK: - Properties
    
    var selectedTags = ["musicVideo"] {
        didSet {
            tagView.removeAllTags()
            tagView.addTags(selectedTags)
            self.view.layoutIfNeeded()
        }
    }
    
    var musicArrays = [[Music]]()
    
    //MARK: - Controller Flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorScheme = .none
        tagView.addTags(selectedTags)
    }
    
    
    
    //MARK: - IBActions
    @IBAction func didClickedSelectTags(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EntityPickerViewController") as! EntityPickerViewController
        
        controller.delegate = self
        controller.selectedEntities = selectedTags
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func didClickedSearch(_ sender: Any) {
        let group = DispatchGroup()
        SVProgressHUD.show()
        
        selectedTags.forEach { (tag) in
            group.enter()
            self.getListOfMusic(group: group, entity: tag)
        }
        
        group.notify(queue: .main) { [weak self] in
            SVProgressHUD.dismiss() // all task done
            self?.navigateToListing()
        }
    }
    //MARK: - Methods
    
    func navigateToListing() {
        print(musicArrays)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController

        controller.musicList = musicArrays
        controller.tagsArray = selectedTags
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomeViewController: EntityPickerViewControllerDelegate {
    func entityPickerViewController(_ controller: EntityPickerViewController, didSelect entities: [String]) {
        self.selectedTags = entities
    }
}


//MARK: - Api

extension HomeViewController {
    func getListOfMusic(group:DispatchGroup ,entity: String) {
       
        print("called with \(entity)")
        
        let params: [String: Any] = ["term": txtTerm.text ?? "", "entity": entity]
        
        MusicApiManager().getAllCountries(params: params) {[weak self] (response) in
            guard let weakSelf = self else {return}
            defer {group.leave()}
            
            if let musicList = response {
                weakSelf.musicArrays.append(musicList)
            }
            
        } failure: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }

        
    }
}
