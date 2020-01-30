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
internal class MapmyIndiaFeedbackController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step3View: UIView!
    
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
    
    @objc public var feedbackLocation: CLLocation?
    
    @objc public var moduleId: String?
    
    let selectedStepColor = UIColor(red: 0.94, green: 0.52, blue: 0, alpha: 1)
    let unSelectedStepColor = UIColor.gray
    var allParentCategories = [MapmyIndiaReportCategories]()
    var childCategories = [MapmyIndiaReportCategories]()
    var selectedParentCategory: MapmyIndiaReportCategories?
    var selectedChildCategory: MapmyIndiaReportCategories?
    var allReportCategories = [MapmyIndiaReportCategories]() {
        didSet {
            allParentCategories = allReportCategories.filter({ ($0.parentId == nil || $0.parentId == "0") })
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
                    backButton.setTitle("CANCEL", for: .normal)
                    
                    inputTableView.isHidden = false
                    inputTextContainerView.isHidden = true
                    inputTableView.reloadData()
                case 2:
                    stepNumberDescriptionLabel.text = "Please select a report subcategory"
                    step1View.backgroundColor = selectedStepColor
                    step2View.backgroundColor = selectedStepColor
                    step3View.backgroundColor = unSelectedStepColor
                    
                    inputTableView.isHidden = false
                    inputTextContainerView.isHidden = true
                    //inputTableView.reloadData()
                case 3:
                    stepNumberDescriptionLabel.text = "Tell us more about the issue"
                    step1View.backgroundColor = selectedStepColor
                    step2View.backgroundColor = selectedStepColor
                    step3View.backgroundColor = selectedStepColor
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
        MapmyIndiaFeedbackKit.shared.getReportCategories { (reportCategories, error) in
            self.isInProgress = false
            if let error = error {
                print(error.localizedDescription)
                self.dismiss(animated: true, completion: nil)
            } else {
                let categories = reportCategories ?? [MapmyIndiaReportCategories]()
                if categories.count > 0 {
                    self.allReportCategories = categories
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
    }
    
    func backButtonHandler() {
        if let step = currentStep {
            // if step is between 2 and 3 then decrease value of current step by 1
            if step > 1 && step < 4 {
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
                guard let parentCategory = selectedParentCategory else { return }
                guard let childCategory = selectedChildCategory else { return }                
                guard let location = feedbackLocation else { return }
                
                let alertController = UIAlertController(title: "Submit", message: "Do you want to submit", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                    let saveOptions = MapmyIndiaSaveUserDataOptions(coordinate: location.coordinate, parentCategory: parentCategory, childCategory: childCategory, description: self.inputTextField.text ?? "", moduleId: self.moduleId)
                    
                    MapmyIndiaSaveUserDataAPIManager.shared.saveUserData(saveOptions, { (savedDataInfo, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let result = savedDataInfo {
                            print("Feedback submitted: \(result.url ?? "")")
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            print("No results")
                        }
                    })
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
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
            return allParentCategories.count
        }
        else if step == 2 {
            return childCategories.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MapmyIndiaReportCategoryCell.self)) as? MapmyIndiaReportCategoryCell  {            
            let step = currentStep ?? 0
            cell.accessoryType = .none
            cell.setSelected(false, animated: false)
            if step == 1 {
                let category = allParentCategories[indexPath.row]
                cell.categoryLabel?.text = category.reportName
                if let selectedCategory = selectedParentCategory {
                    if selectedCategory.reportId == category.reportId {
                        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        //cell.isSelected = true
                        cell.setSelected(true, animated: false)
                    }
                }
            }
            else if step == 2 {
                let category = childCategories[indexPath.row]
                cell.categoryLabel?.text = category.reportName
                if let selectedCategory = selectedChildCategory {
                    if selectedCategory.reportId == category.reportId {
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
            let category = allParentCategories[indexPath.row]
            selectedParentCategory = category
            selectedChildCategory = nil
            if let cell = tableView.cellForRow(at: indexPath) as? MapmyIndiaReportCategoryCell {
                cell.setSelected(true, animated: true)
            }
            childCategories = allReportCategories.filter( { $0.parentId == category.reportId } )
        }
        else if step == 2 {
            let category = childCategories[indexPath.row]
            selectedChildCategory = category
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
