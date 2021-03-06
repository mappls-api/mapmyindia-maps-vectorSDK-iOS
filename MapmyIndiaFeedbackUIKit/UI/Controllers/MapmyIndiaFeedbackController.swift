//
//  MapmyIndiaFeedbackController.swift
//  MapmyIndiaFeedbackUIKit
//
//  Created by apple on 24/08/18.
//  Copyright © 2018 MapmyIndia. All rights reserved.
//

import UIKit
import CoreLocation
import MapmyIndiaFeedbackKit

@objc
public class MapmyIndiaFeedbackController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var step4View: UIView!
    
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepNumberDescriptionLabel: UILabel!
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var inputTextContainerView: UIView!
    @IBOutlet weak var pleaseWaitLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        backButtonHandler()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        submitButtonHandler()
    }
    
    @objc public var feedbackLocation: String?
    public var flag: Int?
    public var speed: Int?
    public var alt: Int?
    public var quality: Int?
    public var bearing: Int?
    public var accuracy: Int?
    public var utc: Double?
    public var expiry: Double?
    public var zeroId: String?
    public var pushEvent: Bool?
    public var appVersion: String?
    public var osVersionoptional: String?
    public var deviceName: String?
    
    let selectedStepColor = UIColor(red: 0.94, green: 0.52, blue: 0, alpha: 1)
    let unSelectedStepColor = UIColor.gray
    var childCategories = [ChildCategories]()
    var subChildCategories = [SubChildCategories]()
    var selectedSubChildCategories: SubChildCategories?
    var selectedParentCategory: ParentCategories?
    var selectedChildCategory: ChildCategories?
    var allReportCategories = [ParentCategories]() {
        didSet {
            self.inputTableView.reloadData()
        }
    }
    var currentStep: Int? {
        didSet {
            if let step = currentStep {
                stepNumberLabel.text = "Step \(step)"
                submitButton.setTitle("CONTINUE", for: .normal)
                backButton.setTitle("BACK", for: .normal)
                
                inputTableView.isHidden = true
                inputTextContainerView.isHidden = true
                
                switch step {
                case 1:
                    stepNumberDescriptionLabel.text = "Please select a report category"
                    step1View.backgroundColor = selectedStepColor
                    step2View.backgroundColor = unSelectedStepColor
                    step3View.backgroundColor = unSelectedStepColor
                    step4View.backgroundColor = unSelectedStepColor
                    backButton.setTitle("CANCEL", for: .normal)
                    
                    inputTableView.isHidden = false
                    inputTextContainerView.isHidden = true
                    inputTableView.reloadData()
                case 2:
                    stepNumberDescriptionLabel.text = "Please select a report subcategory"
                    step1View.backgroundColor = selectedStepColor
                    step2View.backgroundColor = selectedStepColor
                    step3View.backgroundColor = unSelectedStepColor
                    step4View.backgroundColor = unSelectedStepColor
                    inputTableView.isHidden = false
                    inputTextContainerView.isHidden = true
//                    inputTableView.reloadData()
                case 3:
                    if subChildCategories.count > 0 {
                        stepNumberDescriptionLabel.text = "Please select a report subcategory"
                        step1View.backgroundColor = selectedStepColor
                        step2View.backgroundColor = selectedStepColor
                        step3View.backgroundColor = selectedStepColor
                        step4View.backgroundColor = unSelectedStepColor
                        inputTableView.isHidden = false
                        inputTextContainerView.isHidden = true
                        submitButton.setTitle("Continue", for: .normal)
                    } else {
                        stepNumberDescriptionLabel.text = "Tell us more about the issue"
                        step1View.backgroundColor = selectedStepColor
                        step2View.backgroundColor = selectedStepColor
                        step3View.backgroundColor = selectedStepColor
                        step4View.isHidden = true
                        submitButton.setTitle("SUBMIT", for: .normal)
                        inputTableView.isHidden = true
                        inputTextContainerView.isHidden = false
                    }
                
                case 4:
                    stepNumberDescriptionLabel.text = "Tell us more about the issue"
                    step1View.backgroundColor = selectedStepColor
                    step2View.backgroundColor = selectedStepColor
                    step3View.backgroundColor = selectedStepColor
                    step4View.backgroundColor = selectedStepColor
                    submitButton.setTitle("SUBMIT", for: .normal)
                    
                    inputTableView.isHidden = true
                    inputTextContainerView.isHidden = false
                default:
                    seupNoStepView()
                }
            } else {
                seupNoStepView()
            }
        }
    }
    
    var isInProgress: Bool = false {
        didSet {
            if isInProgress {
                inputContainerView.isHidden = true
                pleaseWaitLabel.isHidden = false
                backButton.isHidden = true
                submitButton.isHidden = true
            } else {
                inputContainerView.isHidden = false
                pleaseWaitLabel.isHidden = true
                backButton.isHidden = false
                submitButton.isHidden = false
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

    //MARK: Functions
    
    func initialSetup() {
        inputTableView.register(UINib(nibName: String(describing: MapmyIndiaReportCategoryCell.self), bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: String(describing: MapmyIndiaReportCategoryCell.self))
        
        inputContainerView.layer.borderColor = UIColor.lightGray.cgColor
        inputContainerView.layer.borderWidth = 0.3
        inputContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        inputContainerView.layer.shadowOpacity = 0.3
        inputContainerView.layer.shadowRadius = 5.0
        inputContainerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        inputTextField.setBottomBorder()
        
        self.title = "Report an Issue"
        inputTableView.separatorStyle = .none
        //inputTableView.tintColor = UIColor.clear
        currentStep = 1
        
        isInProgress = true
        MapmyIndiaFeedbackKit.shared.getReportCategories { (reportCategories, error)   in
            self.isInProgress = false
            if let error = error {
                print(error.localizedDescription)
                self.dismiss(animated: true, completion: nil)
            } else {
                let categories = reportCategories ?? [ParentCategories]()
                if categories.count > 0 {
                    self.allReportCategories = categories
                    print(self.allReportCategories.first?.id)
                    self.currentStep = 1
                } else {
                    print("No report categories found")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func seupNoStepView() {
        stepNumberLabel.text = ""
        stepNumberDescriptionLabel.text = ""
        inputContainerView.isHidden = true
        pleaseWaitLabel.isHidden = false
        
        step1View.backgroundColor = unSelectedStepColor
        step2View.backgroundColor = unSelectedStepColor
        step3View.backgroundColor = unSelectedStepColor
        step4View.backgroundColor = unSelectedStepColor
    }
    
    func backButtonHandler() {
        if let step = currentStep {
            // if step is between 2 and 3 then decrease value of current step by 1
            if step > 1 && step <= 4 {
                currentStep = step - 1
                inputTableView.reloadData()
            } else if step == 1 {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func submitButtonHandler() {
        if let step = currentStep {
            if step == 1 {
                if selectedParentCategory == nil {
                    showNoOptionAlert()
                } else {
                    currentStep = step + 1
                    inputTableView.reloadData()
                }
            }
            else if step == 2 {
                if selectedChildCategory == nil {
                    showNoOptionAlert()
                } else {
                    currentStep = step + 1
                    inputTableView.reloadData()
                }
            } else if step == 3 {
                if selectedSubChildCategories == nil && subChildCategories.count > 0{
                    showNoOptionAlert()
                } else if subChildCategories.count > 0 {
                    currentStep = step + 1
                    inputTableView.reloadData()
                } else {
                    saveReport()
                }
                
            }
            else if step == 4 {
                saveReport()
            }
        }
    }
    
    func saveReport() {
        guard let parentCategory = selectedParentCategory else { return }
        guard let childCategory = selectedChildCategory else { return }
        
        
        let alertController = UIAlertController(title: "Submit", message: "Do you want to submit", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            
            let saveOptions = MapmyIndiaSaveUserDataOptions(location: self.feedbackLocation ?? "", parentCategory: parentCategory.id ?? 0, childCategory: childCategory.id ?? 0, description: "\(self.inputTextField.text ?? "")", subChildCategory: self.selectedSubChildCategories?.id, flag: self.flag, alt: self.alt, quality:self.quality, bearing: self.bearing, accuracy: self.accuracy, utc: self.utc, expiry:  self.expiry, zeroId: self.zeroId, pushEvent: self.pushEvent, appVersion: self.appVersion, osVersionoptional: self.osVersionoptional, deviceName: self.deviceName)
            
            let _ = MapmyIndiaSaveUserDataAPIManager.shared.saveUserData(saveOptions, { (isSucess, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else if isSucess {
                    print("Created")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("No results")
                }
            })
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNoOptionAlert() {
        let alertController = UIAlertController(title: "Please select!", message: "Please select an option.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let step = currentStep ?? 0
        if step == 1 {
            return allReportCategories.count
        }
        else if step == 2 {
            return childCategories.count
        } else if step == 3 {
            return subChildCategories.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MapmyIndiaReportCategoryCell.self)) as? MapmyIndiaReportCategoryCell  {
            let step = currentStep ?? 0
            cell.accessoryType = .none
            cell.setSelected(false, animated: false)
            if step == 1 {
                let category = allReportCategories[indexPath.row]
                
                cell.categoryLabel?.text = category.name
                if let selectedCategory = selectedParentCategory {
                    if selectedCategory.id == category.id {
                        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        //cell.isSelected = true
                        cell.setSelected(true, animated: false)
                    }
                }
            }
            else if step == 2 {
                let category = childCategories[indexPath.row]
                cell.categoryLabel?.text = category.name
                if let selectedCategory = selectedChildCategory {
                    if selectedCategory.id == category.id {
                        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        //cell.isSelected = true
                        cell.setSelected(true, animated: false)
                    }
                }
            } else if step == 3 {
                let category = subChildCategories[indexPath.row]
                cell.categoryLabel?.text = category.name
                if let selectedCategory = selectedSubChildCategories {
                    if selectedCategory.id == category.id {
                        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        //cell.isSelected = true
                        cell.setSelected(true, animated: false)
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let step = currentStep ?? 0
        if step == 1 {
            let category = allReportCategories[indexPath.row]
            selectedParentCategory = category
            selectedChildCategory = nil
            if let cell = tableView.cellForRow(at: indexPath) as? MapmyIndiaReportCategoryCell {
                cell.setSelected(true, animated: true)
            }
            childCategories = category.childCategories ?? [ChildCategories]()

        }
        else if step == 2 {
            let category = childCategories[indexPath.row]
            selectedChildCategory = category
            if let cell = tableView.cellForRow(at: indexPath) as? MapmyIndiaReportCategoryCell {
                cell.setSelected(true, animated: true)
            }
            subChildCategories = category.subChildCategories ?? [SubChildCategories]()
            if subChildCategories.count > 0 {
                step4View.isHidden = false
            } else {
                step4View.isHidden = true
            }
            
        } else if step == 3 {
            let category = subChildCategories[indexPath.row]
            selectedSubChildCategories = category
            if let cell = tableView.cellForRow(at: indexPath) as? MapmyIndiaReportCategoryCell {
                cell.setSelected(true, animated: true)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MapmyIndiaReportCategoryCell {
            cell.setSelected(false, animated: true)
        }
    }
}
