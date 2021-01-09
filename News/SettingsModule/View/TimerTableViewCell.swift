//
//  TimerTableViewCell.swift
//  News
//
//  Created by Egor Oprea on 08.01.2021.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var timerPickerView: UIPickerView! {
        didSet {
            timerPickerView.dataSource = self
            timerPickerView.delegate = self
        }
    }
    
    private let minutes = Array(0...10)
    
    var currentInterval: TimeInterval? {
        didSet {
            if let interval = currentInterval {
                let row = Int(interval / 60)
                timerPickerView?.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    var timeintervalChoosen: ((TimeInterval) -> Void)?
}

extension TimerTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if minutes[row] == 0 {
            return "Disable"
        }
        return "\(minutes[row]) " + (minutes[row] > 1 ? "minutes" : "minute")
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeintervalChoosen?(TimeInterval(minutes[row] * 60))
    }
    
}
