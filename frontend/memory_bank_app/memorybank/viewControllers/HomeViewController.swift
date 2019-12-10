//
//  HomeViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import ESPullToRefresh

class HomeViewController: UIViewController {

    var identifications = [Identification]()
    
    var fileDownloadCounter = 0
    var fileDownloadCounterMax = 0
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadIdentifications()
        self.setUpPullToRefresh()
        if let isPatient = getUserSession()?.isPatient {
            if !isPatient {
                if let button = self.navigationItem.rightBarButtonItem {
                    button.isEnabled = false
                    button.tintColor = UIColor.clear
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func setUpPullToRefresh() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadIdentifications()
            self.tableView.es.stopPullToRefresh()
        }
    }
    
    func loadIdentifications() {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let identificationsObject = db.collection("identifcations")
        identificationsObject.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.identifications = []
                self.fileDownloadCounter = 0
                self.fileDownloadCounterMax = querySnapshot!.documents.count
                for document in querySnapshot!.documents {
                    let id = document.data()
                    print("\(document.documentID) => \(id)")
                    let imageRef = storageRef.child("images/" + document.documentID + ".jpg")
                    print("imageRef", imageRef.fullPath)
                    imageRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
                      if let error = error {
                        // Uh-oh, an error occurred!
                        print(error)
                      } else {
                        let image = UIImage(data: data!)
                        print("id", id)
                        self.identifications = self.identifications + [(
                            Identification(id: document.documentID, image: image!, guess: id["guess"] as! String, familyLabel: id["family_label"] as? String, familyDescription: id["family_description"] as? String, created: (id["created"] as! Timestamp))
                        )]
                        self.identifications = self.identifications.sorted {
                            $0.created.compare($1.created) == .orderedDescending
                        }
                        self.fileDownloadCounter = self.fileDownloadCounter + 1
                        if self.fileDownloadCounter >= self.fileDownloadCounterMax {
                            DispatchQueue.main.async(execute: {
                                self.tableView.reloadData()
                            })
                        }
                      }
                    }
                }
            }
        }
    }
    
    func labelIdentification(id: Identification) {
        let addLabelNavVC = UIStoryboard(name: "Identify", bundle: nil).instantiateViewController(withIdentifier: "Submit-root") as! UINavigationController
        let addLabelVC = addLabelNavVC.viewControllers.first as! AddFamilyLabelViewController
        addLabelVC.identification = id
        addLabelVC.updateForm()
        self.present(addLabelNavVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.identifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "identification", for: indexPath) as? IdentificationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of chatTableViewCell.")
        }

        let id = self.identifications[indexPath.row]

        cell.labelImage.image = id.image
        cell.labelImage.layer.cornerRadius = 12.0
        cell.labelImage.clipsToBounds = true
        if let familyLabel = id.familyLabel {
            cell.label.text = "From your family"
            cell.descript.text = familyLabel
        } else {
            cell.label.text = "Our guess"
            cell.descript.text = id.guess
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        let id = self.identifications[indexPath.row]
        self.labelIdentification(id: id)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
