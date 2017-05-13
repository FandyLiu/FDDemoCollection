//
//  ContactsManager.swift
//  Contact
//
//  Created by QianTuFD on 2017/5/8.
//  Copyright © 2017年 fandy. All rights reserved.
// 

import UIKit
import Contacts
import AddressBook
// Errors thrown from here are not handled because the enclosing catch is not exhaustive

typealias ContactsIndexTitles = ([String], [String: [PersonPhoneModel]])

class ContactsManager: NSObject { 
    class func getContactsList() -> [PersonPhoneModel] {
        var contactsList = [PersonPhoneModel]()
        if #available(iOS 9.0, *) {
            let store = CNContactStore()
            let keys: [CNKeyDescriptor] = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            do {
                try store.enumerateContacts(with: request) { (contact, _) in
                    let fullName = (contact.familyName + contact.givenName).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    let phoneNumbers = contact.phoneNumbers
                    for labeledValue in phoneNumbers {
                        let phoneNumber = labeledValue.value.stringValue.phoneNumberFormat()
                        let phoneLabel = labeledValue.label ?? ""
//                        print(fullName + phoneNumber + phoneLabel)
                        let model = PersonPhoneModel(fullName: fullName,
                                                     phoneNumber: phoneNumber,
                                                     phoneLabel: phoneLabel)
                        contactsList.append(model)
                    }
                }
            } catch {
                assertionFailure("请求 contacts 失败")
            }
        } else {
            let addressBook = ABAddressBookCreate().takeRetainedValue()
            let  allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecord]
            for person in allPeople {
                var firstName = ""
                var lastName = ""
                if let firstNameUnmanaged = ABRecordCopyValue(person, kABPersonLastNameProperty) {
                    firstName = firstNameUnmanaged.takeRetainedValue() as? String ?? ""
                }
                if let lastNameUnmanaged = ABRecordCopyValue(person, kABPersonFirstNameProperty) {
                    lastName = lastNameUnmanaged.takeRetainedValue() as? String ?? ""
                }
                let fullName = (firstName + lastName).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                let phones = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValue
                
                for i in 0..<ABMultiValueGetCount(phones) {
                    let phoneNumber = (ABMultiValueCopyValueAtIndex(phones, i).takeRetainedValue() as? String ?? "").phoneNumberFormat()
                    let phoneLabel = ABMultiValueCopyLabelAtIndex(phones, i).takeRetainedValue() as String
//                    print(fullName + phoneNumber + phoneLabel)
                    let model = PersonPhoneModel(fullName: fullName,
                                                 phoneNumber: phoneNumber,
                                                 phoneLabel: phoneLabel)
                    contactsList.append(model)
                }
            }
        }
        return contactsList
    }
    
    class func format(contantsList : [PersonPhoneModel]) -> ContactsIndexTitles {
//        let collection = UILocalizedIndexedCollation.current()
//        let indexArray = Array(collection.sectionTitles)
        if contantsList.count < 1 {
            return ([String](), [String: [PersonPhoneModel]]())
        }
        let indexs = contantsList.map { $0.firstCapital }
        
        let sortIndexs = Array(Set(indexs)).sorted(by: <)
        
        let sortList = contantsList.sorted(by: {$0.pinYinName < $1.pinYinName})
        var dict = [String: [PersonPhoneModel]]()
        for index in sortIndexs {
            var arr = [PersonPhoneModel]()
            arr = sortList.filter{ $0.firstCapital == index}
            dict[index] = arr
        }
        return (sortIndexs, dict)
    }
}

struct PersonPhoneModel {
    init(fullName: String,
         phoneNumber: String,
         phoneLabel: String) {
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.phoneLabel = phoneLabel
        self.pinYinName = fullName.pinYin().uppercased()
        self.firstCapital = String(describing: pinYinName.characters.first ?? "#")
    }
    
    let fullName: String
    let phoneNumber: String
    let phoneLabel: String
    let pinYinName: String
    var firstCapital: String
}





