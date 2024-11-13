//
//  MainVC.swift
//  Be-Liv-It
//
//  Created by mac on 10/01/23.
//

import UIKit
import Alamofire
import DropDown
import IQKeyboardManagerSwift

class MainVC: UIViewController {
    
    @IBOutlet var btnDrop: UIButton!
    @IBOutlet var textBatchNumber: UITextField!
    @IBOutlet var textViewOt: UIView!
    
    var arrQuestions: [ResQuestions] = []
    var arrAreaList: [ResAreaList] = []
    var selectedAreaId = ""
    var selectedAreaName = ""
    let dropDown = DropDown()
    var departmentId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        textViewOt.layer.borderWidth = 0.5
        textViewOt.layer.borderColor = UIColor.green.cgColor
        
        btnDrop.layer.borderWidth = 0.5
        btnDrop.layer.borderColor = UIColor.green.cgColor
        self.getAreaList()
        self.dropDown.backgroundColor = UIColor.white
        print(UserDefaults.standard.value(forKey: "id"))
        print(UserDefaults.standard.value(forKey: "user_name"))
    }
    
    @IBAction func btnContinue(_ sender: UIButton) {
        if let text = textBatchNumber.text {
            if text == ""{
                openAlert(title: "Alert", message: "Please Enter Batch Number", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Clicked Okay")
                }])
            } else if self.selectedAreaId == "" {
                openAlert(title: "Alert", message: "Please Select Area", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Clicked Okay")
                }])
            } else {
                self.getQuestionList()
            }
        }
    }
    
  
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "id")
        userDefaults.removeObject(forKey: "user_name")
        let newViewObj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func getAreaList() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/get_area_list"
        let paramAreaList = [
            "department_id": self.departmentId
        ]
        AF.request(urlString, parameters: paramAreaList).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(AreaListDetails.self, from: responseData)
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
            arrAreaId.append(val.department_id ?? "")
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
    
    func getQuestionList() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/get_queston_list?"
        let paramLGetCategory = [
            "area_id": self.selectedAreaId,
            "batch_number": self.textBatchNumber.text!,
            "version_number": "",
            "expire_date": ""
        ]
        
        AF.request(urlString, parameters: paramLGetCategory).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetQuestionsList.self, from: responseData)
                    print(root)
                    if let AreaQuestionStatus = root.status {
                        if AreaQuestionStatus == "1" {
                            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionsVC") as! QuestionsVC
                            vc.areaId = self.selectedAreaId
                            vc.batchNumber = self.textBatchNumber.text!
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Sorry", message: "No Data Available", preferredStyle: .alert)
                            
                            let Ok = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                                print("OK tapped")
                            })
                            
                            alert.addAction(Ok)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

