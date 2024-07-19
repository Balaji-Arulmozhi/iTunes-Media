//
//  SearchViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import UIKit
import Combine

protocol GetFilterListDelegate{
    func getFilterList(_ list: [Items])
}

class SearchViewController: UIViewController, GetFilterListDelegate {
    @IBOutlet weak var SearchField: UITextField!
    var vm: SearchViewModel = SearchViewModel()
    var selectedItems:[Items] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchField.autocorrectionType = .no
        SearchField.returnKeyType = .done
        SearchField.delegate = self
    }
    
    
    func getFilterList(_ list: [Items]) {
        self.selectedItems = list
    }

    func getApiData(){
        
        if  let searchText = SearchField.text, !(searchText.isEmpty){
            
            let path = vm.filterPath(selectedItems)
            print("Filtered path \(path)")
            vm.getiTunesData(searchText: searchText, path:path, completion: { [weak self] groupedResults , error in
                
                if let error = error{
                    self?.showToast(message: error.localizedStrings, font: .systemFont(ofSize: 12.0))
                }
                
                if let groupedResults = groupedResults{
                    if groupedResults.count != 0 {
                            self?.navigationToiTunesDetail(groupedResults)
                    }
                    else{
                        self?.showToast(message: "No reslts found", font: .systemFont(ofSize: 12.0))
                    }
                }
                
            })
        }else{
            self.showToast(message: "Please enter search field key", font: .systemFont(ofSize: 12.0))
        }
        
    }

    @IBAction func searchAction(_ sender: Any) {
        navigation()
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        getApiData()
    }
}

extension SearchViewController{
    func navigation(){
        DispatchQueue.main.async {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : MediaViewController = storyboard.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
            vc.getFilterListDelegate = self
            vc.selectedItems = self.selectedItems
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
    
    func navigationToiTunesDetail(_ groupedResults : [String: [resultsDataModel]]){
        DispatchQueue.main.async {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : ItunesDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ItunesDetailsViewController") as! ItunesDetailsViewController
            vc.groupedItems = groupedResults
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SearchViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
       }
    
}
