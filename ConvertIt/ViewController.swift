//
//  ViewController.swift
//  ConvertIt
//
//  Created by Richard Jove on 9/25/19.
//  Copyright © 2019 Richard Jove. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    
    var formulaArray = ["miles to kilometers",
                        "kilometers to miles",
                        "feet to meters",
                        "yards to meters",
                        "meters to feet",
                        "meters to yards"]
    
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        conversionString = formulaArray[formulaPicker.selectedRow(inComponent: 0)] //How does this work here... also is it supposed to change each time you click on a different amount of decimals to round to?
    }
    //Learning about switch statements... variable, constant, expresssion... have something to evaluate on
    func calculateConversion() {
        
        
        
        guard let inputValue = Double(userInput.text!) else {
            print("Show alert here to say the value entered was not a number")
            return
        }
        
        //if let inputValue = Double(userInput.text!) { //Why do you need this?
        
        var outputValue = 0.0
        switch conversionString {
        case "miles to kilometers":
            outputValue = inputValue / 0.62137
        case "kilometers to miles":
            outputValue = inputValue * 0.62137
        case "feet to meters":
            outputValue = inputValue / 3.2808
        case "yards to meters":
            outputValue = inputValue / 1.0936
        case "meters to feet":
            outputValue = inputValue * 3.2808
        case "meters to yards":
            outputValue = inputValue * 1.0936
        default:
            print("Show alert - For some reason we didn't have a conversion string")
        }
        let formatString = (decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments - 1 ? "%.\(decimalSegment.selectedSegmentIndex + 1)f" : "%f")
        let outputString = String(format: formatString, outputValue)
            resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputString) \(toUnits)"
        }
    
    
    @IBAction func decimalSelected(_ sender: UISegmentedControl) {
        calculateConversion()
    }
    
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        calculateConversion()
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulaArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulaArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        conversionString = formulaArray[row]
        let unitsArray = formulaArray[row].components(separatedBy: " to ") //Why select this one vs. the other?
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        calculateConversion()
    }
}

