//
//  KisilerDaoRepository.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation
import RxSwift


class KisilerDaoRepository {
    
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    func save(name: String, phoneNumber: String){
        print("Kişi Kaydet : \(name) - \(phoneNumber)")
    }
    
    func update(kisi_id: Int, kisi_ad: String, kisi_tel: String){
        print("Kişi Güncelle : \(kisi_id) - \(kisi_ad) - \(kisi_tel)")
    }
    
    func search(searchText: String){
        print("Kişi ara: \(searchText)")
    }
    
    func delete(personId:Int) {
        print("Kişi sil: \(personId)")
    }
    
    func uploadContacts(){
        var list = [Kisiler]()
        let k1 = Kisiler(kisi_id: 1, kisi_ad: "ali", kisi_tel: "1111")
        let k2 = Kisiler(kisi_id: 2, kisi_ad: "sef", kisi_tel: "2432")
        let k3 = Kisiler(kisi_id: 3, kisi_ad: "esm", kisi_tel: "2432")
        list.append(k1)
        list.append(k2)
        list.append(k3)
        contactsList.onNext(list)
    }
}
