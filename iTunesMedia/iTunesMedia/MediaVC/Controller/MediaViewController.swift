//
//  MediaViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import UIKit

class MediaViewController: UIViewController {
    @IBOutlet weak var mediaTbleView: UITableView!
    var getFilterListDelegate: GetFilterListDelegate?
    var filterItems: [Items] = [
        Items(title: "Album", isSelected: false),
        Items(title: "Ebook", isSelected: false),
        Items(title: "Movie", isSelected: false),
        Items(title: "Musicvideo", isSelected: false),
        Items(title: "Podcast", isSelected: false),
        Items(title: "Song", isSelected: false)
    ]
    
    var groupediTunedData: [String: [resultsDataModel]] = [:]
    var selectedItems: [Items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaTbleView.delegate = self
        mediaTbleView.dataSource = self
        
        mediaTbleView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        
        
        for (index, item) in filterItems.enumerated() {
            if selectedItems.contains(where: { $0.title == item.title }) {
                filterItems[index].isSelected = true
            }
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getFilterListDelegate?.getFilterList(selectedItems)
    }
    
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mediaTbleView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        let item = filterItems[indexPath.row]
        cell.mediaLabel.text = item.title
        cell.accessoryType = item.isSelected ? .checkmark : .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        filterItems[indexPath.row].isSelected.toggle()
        if filterItems[indexPath.row].isSelected {
            selectedItems.append(filterItems[indexPath.row])
        } else {
            selectedItems.removeAll { $0.title == filterItems[indexPath.row].title}
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}
