//
//  ListingViewController.swift
//  MyiTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit

class ListingViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    var musicList = [[Music]]()
    
    var tagsArray = [String]()
    
    fileprivate var isGrid = true {
        didSet {
            cellIdentifier = isGrid ? "MediaCollectionViewCellGrid" : "MediaCollectionViewCellList"
        }
    }
    
    fileprivate var cellIdentifier = "MediaCollectionViewCellGrid"
    
    fileprivate var girdLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        return layout
    }
    
    fileprivate var listLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width, height: 100)
        layout.scrollDirection = .vertical
        return layout
    }
    
    //MARK: - Controller Flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorScheme = .light
        collectionView.setCollectionViewLayout(girdLayout, animated: true)
        collectionView.register(UINib(nibName: "FolderHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FolderHeaderCollectionReusableView")
    }
    
    
    //MARK: - IBActions
    @IBAction func didClickedGrid(_ sender: Any) {
        isGrid = true
        collectionView.setCollectionViewLayout(girdLayout, animated: true)

    }
    @IBAction func didClickedList(_ sender: Any) {
        isGrid = false
        collectionView.setCollectionViewLayout(listLayout, animated: true)
    }
    
    //MARK: - Methods


}

extension ListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MediaCollectionViewCell else {return UICollectionViewCell()}
        
        let item = musicList[indexPath.section][indexPath.item]
        
        cell.setup(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FolderHeaderCollectionReusableView", for: indexPath) as! FolderHeaderCollectionReusableView
            if indexPath.section > tagsArray.count {return headerView}
            headerView.lblTitle.text = tagsArray[indexPath.section]
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}
