//
//  NotificationVC.swift
//  Be-Liv-It
//
//  Created by mac on 10/01/23.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class NotificationVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let identifier = "CellForNotification"
    var arrNotify: [ResNotification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.getNotification()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getNotification() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/get_employee_notification"
        
        AF.request(urlString, parameters: [:]).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetNotification.self, from: responseData)
                    print(root)
                    if let loginStatus = root.status {
                        if loginStatus == "1" {
                            self.arrNotify = root.result ?? []
                        }else{
                            self.arrNotify = []
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotify.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForNotification", for: indexPath) as! CellForNotification
        
        cell.tittleLabel.text = self.arrNotify[indexPath.row].title ?? ""
        cell.subTittleLabel.text = self.arrNotify[indexPath.row].message ?? ""
        cell.dateLabel.text = self.arrNotify[indexPath.row].date_time ?? ""
        return cell
    }
}

extension NotificationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
