//
//  QuestionsVC.swift
//  Be-Liv-It
//
//  Created by mac on 10/01/23.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class QuestionsVC: UIViewController {
    
    @IBOutlet var QuestionCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var labelUserName: UILabel!
    @IBOutlet var btnNextOutlet: UIButton!
    
    let identifier = "CellForQuestions"
    var currentIndex = 0
    var arrQuestions: [ResQuestions] = []
    var numberOfQuestions = ["1","2","3","4","5","6","7","8","9","10"]
    var areaId:String = ""
    var batchNumber:String = ""
    var dict:[Int: UIImage] = [:]
    var arrOfImages:[[Int: UIImage]] = []
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.QuestionCollectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
        self.getQuestionList()
        self.labelUserName.text = UserDefaults.standard.value(forKey: "user_name") as! String
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let status = self.validateAndSave(self.currentIndex)
        if status {
            print(self.currentIndex)
            print(self.arrQuestions.count)
            if self.currentIndex < (self.arrQuestions.count - 1) {
                self.currentIndex = self.currentIndex + 1
                self.pageControl.currentPage = self.currentIndex
                print(pageControl.currentPage)
                DispatchQueue.main.async {
                    self.QuestionCollectionView.isPagingEnabled = false
                    self.QuestionCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true
                    )
                    self.QuestionCollectionView.isPagingEnabled = true
                }
            }
        }
    }
    
    func validateAndSave(_ cIndex: Int) -> Bool {
        var status = false
        let myIndexPath = IndexPath(item: 0, section: 0)
        let cell: CellForQuestions = self.QuestionCollectionView.cellForItem(at: myIndexPath) as! CellForQuestions
        let nameVal = cell.textAnswerOt.text!
        let imageVal = cell.btnImageOutlet.image(for: .normal)!
        let image = UIImage(named: "uploadbtn")!
        
        if nameVal == "" && imageVal.isEqualToImage(image) {
            status = false
            self.displayAlert()
        } else {
            status = true
            let paramQuestion = self.paramUploadQuestion()
            let imageQuestion = self.imageUploadQuestion(self.returnOnlyImages(self.arrOfImages))
            NetworkManger.shared.uploadImageAndData(paramQuestion, self.arrOfImages, completionHandler: { isSuccessfull in
                if isSuccessfull {
                    if self.currentIndex == self.arrQuestions.count - 1 {
                        print(self.currentIndex)
                        print(self.arrQuestions.count)
                        let lastAlert = UIAlertController(title: "Thank You!", message: "Completed Successfully", preferredStyle: .alert)
                        
                        let OK = UIAlertAction(title: "Okay", style: .default, handler: {(action) in self.navigationController?.popViewController(animated: true)
                        })
                        
                        lastAlert.addAction(OK)
                        
                        self.present(lastAlert, animated: true, completion: nil)
                    } else {
                        self.openAlert()
                    }
                } else {
                    print("Something Went Wrong Please Check!")
                }
            })
        }
        return status
    }
    
    func displayAlert() {
        let dialogMessage = UIAlertController(title: "Be-Liv-It", message: "Please Upload Image Or Type Answer For Submit", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func openAlert(){
        let openAlert = UIAlertController(title: "Submitted", message: "Proceed To Next", preferredStyle: .alert)
        
        let Ok = UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
            print("Ok Button Tapped")
        })
        
        openAlert.addAction(Ok)
        
        self.present(openAlert, animated: true, completion: nil)
    }
    
    func paramUploadQuestion() -> [String: String] {
        let paramAnswer = [
            "user_id": "",
            "que_id": "",
            "batch_number": "",
            "version_number": "",
            "expire_date": "",
            "area_id": "",
            "area_name": "",
            "submit_date": "",
            "text_answers": ""
        ]
        return paramAnswer
    }
    
    func imageUploadQuestion(_ arr:[UIImage]) -> [String:[UIImage]]{
        let imageUpload = [
            "image[]": arr
        ]
        return imageUpload
    }
    
    func returnOnlyImages(_ arrayOfImages: [[Int: UIImage]]) -> [UIImage] {
        var arr:[UIImage] = []
        for (index, val) in arrayOfImages.enumerated() {
            if let img = val[index] {
                arr.append(img)
            }
        }
        return arr
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        if self.currentIndex < (self.arrQuestions.count - 1) {
            self.currentIndex = self.currentIndex + 1
            self.pageControl.currentPage = self.currentIndex
            DispatchQueue.main.async {
                self.QuestionCollectionView.isPagingEnabled = false
                self.QuestionCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true
                )
                self.QuestionCollectionView.isPagingEnabled = true
            }
        }
    }
    
    func getQuestionList() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/get_queston_list?"
        let paramLGetCategory = [
            "area_id": self.areaId,
            "batch_number": self.batchNumber,
            "version_number": "",
            "expire_date": ""
        ]
        
        AF.request(urlString, parameters: paramLGetCategory).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetQuestionsList.self, from: responseData)
                    print(root)
                    if let loginStatus = root.status {
                        if loginStatus == "1" {
                            self.arrQuestions = root.result ?? []
                            self.pageControl.numberOfPages = self.arrQuestions.count
                            for (index, val) in self.arrQuestions.enumerated() {
                                self.arrOfImages.append([index : UIImage()])
                            }
                        } else {
                            self.arrQuestions = []
                        }
                        DispatchQueue.main.async {
                            self.QuestionCollectionView.reloadData()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension QuestionsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForQuestions", for: indexPath) as! CellForQuestions
        
        cell.questionLabel.text = self.arrQuestions[indexPath.row].question ?? ""
        cell.numberLabel.text = self.numberOfQuestions[indexPath.row]
        
        cell.textAnswerOt.text = ""
        cell.btnImageOutlet.setImage(UIImage(named: "uploadbtn"), for: .normal)
        cell.onImageTappedButton = {
            ImagePickerManager().pickImage(self) { image in
                cell.btnImageOutlet.setImage(image, for: .normal)
                let dict = [indexPath.row : image]
                self.arrOfImages[indexPath.row] = dict
            }
        }
        return cell
    }
}

extension QuestionsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        self.currentIndex = indexPath.row
    }
}

extension QuestionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIImage {
    
    func isEqualToImage(_ image: UIImage) -> Bool {
        let data1 = self.pngData()
        let data2 = image.pngData()
        return data1 == data2
    }
}
