//
//  DepartmentListVC.swift
//  Be-Liv-It
//
//  Created by mac on 23/01/23.
//

import UIKit
import DropDown
import Alamofire
import IQKeyboardManagerSwift

class DepartmentListVC: UIViewController {
    
    @IBOutlet var viewOutlet: UIView!
    @IBOutlet var btnDrop: UIButton!
    
    var arrAreaList: [ResDepartmentDetails] = []
    var selectedAreaId = ""
    var selectedAreaName = ""
    let dropDown = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutlet.layer.borderWidth = 0.5
        viewOutlet.layer.borderColor = UIColor.green.cgColor
        self.getDepartmentList()
        self.navigationController?.navigationBar.isHidden = true
        self.dropDown.backgroundColor = UIColor.white
        print(UserDefaults.standard.value(forKey: "id"))
        print(UserDefaults.standard.value(forKey: "user_name"))
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "Status")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnContinue(_ sender: UIButton) {
        
        if self.selectedAreaId == "" {
            openAlert(title: "Alert", message: "Please Select Department", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Clicked Okay")
            }])
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
            vc.departmentId = self.selectedAreaId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnDropDown(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func getDepartmentList() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/get_department_list"
        AF.request(urlString, parameters: [:]).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(DepartmentDetails.self, from: responseData)
                    print(root)
                    if let AreaListStatus = root.status {
                        if AreaListStatus == "1" {
                            self.arrAreaList = root.result ?? []
                            
                        }else{
                            self.arrAreaList = []
                        }
                        DispatchQueue.main.async {
                            self.configureAreaDropdown()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureAreaDropdown() {
        var arrAreaId:[String] = []
        var arrAreaName:[String] = []
        for val in self.arrAreaList {
            arrAreaId.append(val.id ?? "")
            arrAreaName.append(val.name ?? "")
        }
        dropDown.anchorView = self.btnDrop
        dropDown.dataSource = arrAreaName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedAreaId = arrAreaId[index]
            self.selectedAreaName = item
            self.btnDrop.setTitle(item, for: .normal)
            
        }
    }
}
