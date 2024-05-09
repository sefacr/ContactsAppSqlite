//
//  ViewController.swift
//  ContactsApp
//
//  Created by Sefa Acar on 7.05.2024.
//

import UIKit

class MainScreen: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("anasayfaya dönüldü, sayfa ilk açıldığı an çalışır")
    }

    @IBAction func detailBtnClicked(_ sender: Any) {
        let person = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "1111")
        performSegue(withIdentifier: "toDetail", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let person = sender as? Kisiler { //sender'i any'den Kisiler'e çevirdik super class sub class dönüşümünü sağlatık ??
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.person = person
                
            }
        }
    }
    
}


extension MainScreen : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Kişi Ara:\(searchText)")
    }
}
