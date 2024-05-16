//
//  KisilerDaoRepository.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation
import RxSwift
import FMDB


class KisilerDaoRepository {
    
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appending(path: "contact.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func save(name: String, phoneNumber: String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO contacts (person_name,person_phoneNumber) VALUES (?,?)", values: [name,phoneNumber])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func update(kisi_id: Int, kisi_ad: String, kisi_tel: String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE contacts SET person_name=?,person_phoneNumber=? WHERE person_id=?", values: [kisi_ad,kisi_tel,kisi_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func search(searchText: String){
        print("Kişi ara: \(searchText)")
        db?.open()
        var list = [Kisiler]()
        do{
            let result = try db!.executeQuery("SELECT * FROM contacts WHERE person_name like '%\(searchText)%'", values: nil)
            
            while result.next() {
                let person_id = Int(result.string(forColumn: "person_id")!)!
                let person_name = result.string(forColumn: "person_name")!
                let person_phoneNumber = result.string(forColumn: "person_phoneNumber")!
                
                let person = Kisiler(kisi_id: person_id, kisi_ad: person_name, kisi_tel: person_phoneNumber)
                list.append(person)
                
            }
            contactsList.onNext(list)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func delete(personId:Int) {
        print("Kişi sil: \(personId)")
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM contacts WHERE person_id=?", values: [personId])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func uploadContacts(){
        db?.open()
        var list = [Kisiler]()
        do{
            let result = try db!.executeQuery("SELECT * FROM contacts", values: nil)
            
            while result.next() {
                let person_id = Int(result.string(forColumn: "person_id")!)!
                let person_name = result.string(forColumn: "person_name")!
                let person_phoneNumber = result.string(forColumn: "person_phoneNumber")!
                
                let person = Kisiler(kisi_id: person_id, kisi_ad: person_name, kisi_tel: person_phoneNumber)
                list.append(person)
                
            }
            contactsList.onNext(list)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veritabanıKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "contact", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appending(path: "contact.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
    
    
    
}
