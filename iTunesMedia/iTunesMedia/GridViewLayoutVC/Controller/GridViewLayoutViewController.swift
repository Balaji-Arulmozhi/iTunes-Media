//
//  GridViewLayoutViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class GridViewLayoutViewController: UIViewController {
    
    @IBOutlet weak var collectionGridView: UICollectionView!
    var groupedItems: [String: [resultsDataModel]]?
    var keyStrings: [String] = []
    var values: [[resultsDataModel]] = [[]]
    var vm: GridViewViewModel = GridViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        collectionGridView.collectionViewLayout = layout
        
        collectionGridView.delegate = self
        collectionGridView.dataSource = self
        // Do any additional setup after loading the view.
        
        collectionGridView.register(UINib(nibName: "GridViewLayoutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridViewLayoutCollectionViewCell")
        
        collectionGridView.register(GridViewLayoutReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GridViewLayoutReusableView.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let groupedItems = groupedItems{
            let data = vm.seperateKeyAndValues(groupedItems)
            keyStrings = data.0
            values = data.1
        }
        
        collectionGridView.reloadData()
    }
    
    
    
}


extension GridViewLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((values.isEmpty)) ? 0 : values[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionGridView.dequeueReusableCell(withReuseIdentifier: "GridViewLayoutCollectionViewCell", for: indexPath)
        as! GridViewLayoutCollectionViewCell
        
        cell.updateCellData(values[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (keyStrings.isEmpty) ? 0 : keyStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : MediaDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MediaDetailsViewController") as! MediaDetailsViewController
        vc.mediaDetails = values[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension GridViewLayoutViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionGridView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GridViewLayoutReusableView.identifier, for: indexPath) as! GridViewLayoutReusableView
        
        header.setUp(keyStrings[indexPath.section])
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
