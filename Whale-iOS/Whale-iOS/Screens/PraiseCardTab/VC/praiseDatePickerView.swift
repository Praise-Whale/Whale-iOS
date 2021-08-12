//
//  praiseDatePickerView.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/11.
//

import UIKit
import SnapKit

class praiseDatePickerView: UIView {
    
    var yearArray:[String] = []
    var monthArray:[String] = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월","전체"]
    let loopingMargin: Int = 40
    let date = Date()
    let calendar = Calendar.current
    var currentYearRow: Int = 0
    var currentMonthRow: Int = 0
    var selectedYearTitle: Int = 0
    var selectedMonthTitle: Int = 0
    
    @IBOutlet var praiseDateLabel: UILabel!
    @IBOutlet var customDatePickerView: CustomPickerView!
    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var settingBtn: UIButton!
    
    override func draw(_ rect: CGRect) {
       // setUIComponentProperty()
        setCurrentDateRow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        makeYearArray()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nib: "praiseDatePicker") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setUIComponentProperty()
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    //MARK: - setUIComponentProperty
    func setUIComponentProperty() {
        praiseDateLabel.font = .AppleSDGothicR(size: 20)
        praiseDateLabel.text = "칭찬 날짜"
        praiseDateLabel.textColor = .brown_2
        
        settingBtn.layer.cornerRadius = 20
        settingBtn.tintColor = .black
        settingBtn.titleLabel?.letterSpacing = -0.75
    }
    
    //MARK: - yearArray 만드는 함수
    func makeYearArray() {
        DispatchQueue.main.async { [self] in
            for i in 2010...2050 {
                yearArray.append("\(i)년")
            }
        }
    }
    
    //MARK: - 현재 year, month 기반으로 picker를 설정하는 함수
    func setCurrentDateRow() {
        let components = calendar.dateComponents([.year, .month], from: date)
        let year =  components.year ?? 0
        let month = components.month ?? 0
        let loopingYearIndex = (loopingMargin / 2) * yearArray.count
        let loopingMonthIndex = (loopingMargin / 2) * monthArray.count
        
        for i in 0...yearArray.count - 1 {
            if yearArray[i] == String(year) + "년" {
                currentYearRow = i
            }
        }
        
        for i in 0...monthArray.count - 1 {
            if monthArray[i] == String(month) + "월" {
                currentMonthRow = i
            }
        }
        customDatePickerView.selectRow(loopingYearIndex + currentYearRow, inComponent: 0, animated: false)
        customDatePickerView.selectRow(loopingMonthIndex + currentMonthRow, inComponent: 1, animated: false)
    }
}

//MARK: - UIPickerViewDelegate
extension praiseDatePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return yearArray[row % yearArray.count]
        }
        else {
            return monthArray[row % monthArray.count]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 69
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let components = calendar.dateComponents([.year, .month], from: date)
        let year =  components.year ?? 0
        let month = components.month ?? 0
        let selectedYearRow = customDatePickerView.selectedRow(inComponent: 0) % yearArray.count
        
        for i in 0...yearArray.count - 1 {
            if selectedYearRow == i {
                selectedYearTitle = i + 2010
            }
        }
        
        if component == 0 {
            let loopingIndex = (loopingMargin / 2) * yearArray.count
            
            if (year < selectedYearTitle) {
                customDatePickerView.selectRow(loopingIndex + currentYearRow, inComponent: 0, animated: true)
            }
        }
        else {
            let loopingIndex = (loopingMargin / 2) * monthArray.count
            let selectedRow = customDatePickerView.selectedRow(inComponent: component) % monthArray.count
            
            for i in 0...monthArray.count - 1 {
                if selectedRow == i {
                    selectedMonthTitle = i
                }
            }
            
            // 현재년도와 같지만 월을 앞서갔을 때
            if (year == selectedYearTitle && month < selectedMonthTitle + 1) {
                customDatePickerView.selectRow(loopingIndex + currentMonthRow, inComponent: 1, animated: true)
            }
        }
        pickerView.tintColor = .black
    }
}

//MARK: - UIPickerViewDataSource
extension praiseDatePickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return loopingMargin * yearArray.count
        }
        else {
            return loopingMargin * monthArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var title = UILabel()
        if let view = view {
            title = view as! UILabel
        }
        title.font = .AppleSDGothicM(size: 21)
        if component == 0 {
            title.text =  yearArray[row % yearArray.count]
        }
        else {
            title.text =  monthArray[row % monthArray.count]
        }
        title.textAlignment = .center
        
        return title
    }
}

