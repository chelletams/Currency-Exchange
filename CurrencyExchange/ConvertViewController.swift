//
//  ConvertViewController.swift
//  CurrencyExchange
//
//  Created by Yui Tamaki on 5/7/17.
//  Copyright © 2017 Yui Tamaki. All rights reserved.
//

import UIKit
import Foundation

class ConvertViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var homeCurrency: UIPickerView!
    @IBOutlet weak var foreignCurrency: UIPickerView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var homeData:[String] = []
    var currencyValue:[Double] = []
    var currentCurrency:Double = 0
    
    @IBAction func convertButton(_ sender: Any) {
        if (inputField.text != " ")
        {
            currencyLabel.text = String(Double(inputField.text!)! == currentCurrency)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCurrency.dataSource = self
        homeCurrency.delegate = self
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"EURUSD\")"
        
        myYQL.query(queryString) { jsonDict in
            let queryDict = jsonDict["query"] as! [String: Any]
            let resultsDict = queryDict["results"] as! [String: Any]
            let rateDict = resultsDict["rate"] as! [String: Any]
            let rate = rateDict["Rate"]
            let id = rateDict["id"]
            
            self.homeData.append((id as? String)!)
            self.currencyValue.append((rate as? Double)!)
        }
        homeCurrency.reloadAllComponents()
    }
    
    func handleSwipe(_ sender: UIGestureRecognizer) {
        self.performSegue(withIdentifier: "showFavorites", sender: self)
    }
    
    @IBAction func unwindToCalculatorViewController(segue: UIStoryboardSegue) {
        //self.performSegue(withIdentifier: "unwindToCalculator", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in homeCurrency: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return homeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return homeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCurrency = currencyValue[row]
    }
}
