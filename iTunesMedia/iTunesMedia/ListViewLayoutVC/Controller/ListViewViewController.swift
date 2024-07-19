//
//  ListViewViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class ListViewViewController: UIViewController {

    @IBOutlet weak var listViewTbleView: UITableView!
    var groupedItems: [String: [resultsDataModel]]?
    var keyStrings: [String] = []
    var values: [[resultsDataModel]] = [[]]
    let vm: ListViewViewModel = ListViewViewModel()
    var items: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewTbleView.delegate = self
        listViewTbleView.dataSource = self
        listViewTbleView.reloadData()

        listViewTbleView.register(UINib(nibName: "ListViewLayOutTableViewCell", bundle: nil), forCellReuseIdentifier: "ListViewLayOutTableViewCell")
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let groupedItems = groupedItems{
            let data = vm.seperateKeyAndValues(groupedItems)
            keyStrings = data.0
            values = data.1
        }
        listViewTbleView.reloadData()
    }
    
}

extension ListViewViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (keyStrings.isEmpty) ? 0 : keyStrings.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((values.isEmpty)) ? 0 : values[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listViewTbleView.dequeueReusableCell(withIdentifier: "ListViewLayOutTableViewCell", for: indexPath) as! ListViewLayOutTableViewCell
        
        cell.updateCellData(values[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return keyStrings[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        header.backgroundColor = .gray
        
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: header.frame.size.width, height: header.frame.size.height))
        
        label.textColor = .white
        label.text = keyStrings[section]
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor.black
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : MediaDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MediaDetailsViewController") as! MediaDetailsViewController
        vc.mediaDetails = values[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
