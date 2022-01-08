//
//  ViewController.swift
//  UIComponents
//
//  Created by Semih Emre ÜNLÜ on 19.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var myIntVariable = -1
    
    enum MyImages: String {
        case backgroundImage = "bgImage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("myVariable =", myIntVariable)
        
        configureUI()
        
        datePicker.minimumDate = Date()
        
        //        let image = UIImage(named: MyImages.backgroundImage.rawValue)
        //        let myImageView = UIImageView(image: image)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped(_:)))
        tapGesture.numberOfTapsRequired = 2
        tapGesture.numberOfTouchesRequired = 1
        self.scrollView.addGestureRecognizer(tapGesture)
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("activityIndicator animating: ", self.activityIndicator.isAnimating)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.activityIndicator.stopAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            print("activityIndicator animating: ", self.activityIndicator.isAnimating)
        }
    }
    
    @objc func imageDoubleTapped(_ sender: UITapGestureRecognizer) {
        let zoomScale = scrollView.zoomScale >= 3.0 ? 1.0 : 3.0
        scrollView.setZoomScale(zoomScale, animated: true)
    }
    
    func createPhoneTextFieldKeyboardToolbar() -> UIToolbar {
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        
        let doneBarButton = UIBarButtonItem()
        doneBarButton.target = self
        doneBarButton.action = #selector(doneBarButtonTapped(_:))
        doneBarButton.title = "Done"
        doneBarButton.style = .plain
        
        let toolbar = UIToolbar()
        toolbar.items = [flexibleSpace, doneBarButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    func configurePhoneTextField() {
        let toolbar = createPhoneTextFieldKeyboardToolbar()
        textField.inputAccessoryView = toolbar
        
        //        let widthConstraint = NSLayoutConstraint(item: textField,
        //                                                 attribute: .width,
        //                                                 relatedBy: .equal,
        //                                                 toItem: nil,
        //                                                 attribute: .notAnAttribute,
        //                                                 multiplier: 1.0,
        //                                                 constant: 100)
        //
        //        let xConstraint = NSLayoutConstraint(item: textField,
        //                                             attribute: .centerX,
        //                                             relatedBy: .equal,
        //                                             toItem: textFieldContainerView,
        //                                             attribute: .centerX,
        //                                             multiplier: 1.0,
        //                                             constant: 0)
        //
        //        NSLayoutConstraint.activate([widthConstraint, xConstraint])
    }
    
    func configureScrollView() {
        //        self.scrollView.contentSize = CGSize(width: 1000, height: 1000)
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
        
    }
    
    func configureUI() {
        configurePhoneTextField()
        configureScrollView()
    }
    
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        //firstTextField.resignFirstResponder()
        //textField.becomeFirstResponder()
        textField.resignFirstResponder()
    }
    
    
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print("selectedIndex:", sender.selectedSegmentIndex)
        
    }
    
    @IBAction func datePıckerValueChanged(_ sender: UIDatePicker) {
        //MARK: - Homework date format and date extentions recalls

        print("Date: ", sender.date) //"27<>12<>2021"  date.year
        // Sending date as string to chanceDateFormat func to get formatted date.
        let date = "\(sender.date)"
        print(chanceDateFormat(dateString: date, withFormat: "dd<>MM<>yyyy")!)
        // format argumant can be chanced as wish or "<<yyyy>>MM<<dd>>" is default
        print(sender.date.dateAsPrettyString(format: "dd<<yyyy"))
        // day - month - year methods added for homework
        print(sender.date.day())
        // month function takes format argument "MMM" as default and returns 3 letter word of month.
        // format: "MM" returns month with numeric.
        print(sender.date.month())
        print(sender.date.year())
        


    }
    
    func chanceDateFormat(dateString: String, withFormat format: String) -> String? {
        //MARK: - Homework formatting date first way
        // Gets date as "yyyy-MM-dd HH:mm:ss z" from date picker and chances it as we set
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
            
        }

        return nil
    }
    
}

// MARK: UIScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollView will Dragging")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollView will Decelerating")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("scrollView didScroll y position:", scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //        print("scrollView Decelerating")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        
        //        print("scrollView Dragging")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("scrollViewDidZoom")
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("scrollViewWillBeginZooming")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
}

extension Date {
    //MARK: - Date formatter as dateAsPrettyString method second way and .day() .month() .year() extensions.

    var dateAsPrettyString: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd<>MM<>yyyy"
        return formatter.string(from: self)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    var mouth: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    var year: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    func dateAsPrettyString(format: String = "dd<>MM<>yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func day(format: String = "dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func year(format: String = "yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func month(format: String = "MMM") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
