//
//  SearchLocationViewController.swift
//  ByBus
//
//  Created by Güray Gül on 22.04.2024.
//

import UIKit

protocol LocationSelectionDelegate: AnyObject {
    func didSelectLocation(_ location: String, _ isFromStackView: Bool)
}

class SearchLocationViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var emptySearchView: UIView!
    
    weak var delegate: LocationSelectionDelegate?
    var isFromStackView: Bool?
    
    var filteredProvinces: [String] = []
    
    let turkishProvinces = [
        "Adana",
        "Adıyaman",
        "Afyonkarahisar",
        "Ağrı",
        "Aksaray",
        "Amasya",
        "Ankara",
        "Antalya",
        "Ardahan",
        "Artvin",
        "Aydın",
        "Balıkesir",
        "Bartın",
        "Batman",
        "Bayburt",
        "Bilecik",
        "Bingöl",
        "Bitlis",
        "Bolu",
        "Burdur",
        "Bursa",
        "Çanakkale",
        "Çankırı",
        "Çorum",
        "Denizli",
        "Diyarbakır",
        "Düzce",
        "Edirne",
        "Elazığ",
        "Erzincan",
        "Erzurum",
        "Eskişehir",
        "Gaziantep",
        "Giresun",
        "Gümüşhane",
        "Hakkari",
        "Hatay",
        "Iğdır",
        "Isparta",
        "İstanbul",
        "İzmir",
        "Kahramanmaraş",
        "Karabük",
        "Karaman",
        "Kars",
        "Kastamonu",
        "Kayseri",
        "Kırıkkale",
        "Kırklareli",
        "Kırşehir",
        "Kilis",
        "Kocaeli",
        "Konya",
        "Kütahya",
        "Malatya",
        "Manisa",
        "Mardin",
        "Mersin",
        "Muğla",
        "Muş",
        "Nevşehir",
        "Niğde",
        "Ordu",
        "Osmaniye",
        "Rize",
        "Sakarya",
        "Samsun",
        "Şanlıurfa",
        "Siirt",
        "Sinop",
        "Şırnak",
        "Sivas",
        "Tekirdağ",
        "Tokat",
        "Trabzon",
        "Tunceli",
        "Uşak",
        "Van",
        "Yalova",
        "Yozgat",
        "Zonguldak"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
                
        searchTableView.backgroundView = emptySearchView
        searchTableView.backgroundView?.isHidden = true
        self.searchTableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
        filteredProvinces = turkishProvinces
    }
}

extension SearchLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProvinces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! SearchLocationTableViewCell
        cell.searchLocationLabel.text = filteredProvinces[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = filteredProvinces[indexPath.row]
        delegate?.didSelectLocation(selectedLocation, isFromStackView ?? true)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProvinces = searchText.isEmpty ? turkishProvinces : turkishProvinces.filter { $0.range(of: searchText, options: .caseInsensitive) != nil }
        searchTableView.backgroundView?.isHidden = filteredProvinces.count == 0 ? false : true
        searchTableView.reloadData()
    }
}
