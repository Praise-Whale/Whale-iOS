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
    var monthArray:[String] = ["전체", "1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
    let loopingMargin: Int = 40
    let date = Date()
    let calendar = Calendar.current
    var year: Int = 0
    var month: Int = 0
    var currentYearRow: Int = 0
    var currentMonthRow: Int = 0
    var firstMonthRow: Int = 0
    var selectedYearTitle: Int = 0
    var selectedMonthTitle: Int = 0
    var firstPraiseDate = UserDefaults.standard.string(forKey: "praiseFirstDate")
    var firstPraiseYearRow: Int = 0
    var firstPraiseMonthRow: Int = 0
    var firstPraiseYear: Int = 0
    var firstPraiseMonth: Int = 0
    
    @IBOutlet var praiseDateLabel: UILabel!
    @IBOutlet var customDatePickerView: CustomPickerView!
    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var settingBtn: UIButton!
    
    override func draw(_ rect: CGRect) {
        setDefaultDateRow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        makeYearArray()
        setFirstPraiseYearMonth()
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
        view.layer.cornerRadius = 16
        addSubview(view)
        setUIComponentProperty()
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

//MARK: - UI 레이아웃 구성부
extension praiseDatePickerView {
    
    // setUIComponentProperty
    func setUIComponentProperty() {
        //praiseDateLabel
        praiseDateLabel.font = .AppleSDGothicR(size: 20)
        praiseDateLabel.text = "칭찬 날짜"
        praiseDateLabel.textColor = .brown_2
        
        //settingBtn
        settingBtn.layer.cornerRadius = 20
        settingBtn.tintColor = .black
        settingBtn.titleLabel?.letterSpacing = -0.75
    }
    
    // yearArray 만드는 함수
    func makeYearArray() {
        DispatchQueue.main.async { [self] in
            for i in 2010...2050 {
                yearArray.append("\(i)년")
            }
        }
    }
    
    // 유저가 첫 칭찬을 한 날짜 기반으로 firstPraiseYear, firstPraiseMonth에 값을 지정하는 함수
    func setFirstPraiseYearMonth() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.date(from: firstPraiseDate ?? "")
        let yyFormatter = DateFormatter()
        yyFormatter.dateFormat = "yyyy"
        let convertYearStr = yyFormatter.string(from: convertDate ?? Date())
        let mmFormatter = DateFormatter()
        mmFormatter.dateFormat = "MM"
        let convertMonthStr = mmFormatter.string(from: convertDate ?? Date())
        firstPraiseYear = Int(convertYearStr) ?? 0
        firstPraiseMonth = Int(convertMonthStr) ?? 0
    }
    
    // 현재 year, 전체 month 기반으로 picker를 설정하는 함수
    func setDefaultDateRow() {
        let components = calendar.dateComponents([.year, .month], from: date)
        let loopingYearIndex = (loopingMargin / 2) * yearArray.count
        let loopingMonthIndex = (loopingMargin / 2) * monthArray.count
        year =  components.year ?? 0
        month = components.month ?? 0
        
        // picker를 선택안하고 설정버튼을 눌렀을 경우 default값이 currentyear가 되도록 설정
        selectedYearTitle = year
        
        for i in 0...yearArray.count - 1 {
            if yearArray[i] == year.toString() + "년" {
                currentYearRow = i
            }
            if yearArray[i] == firstPraiseYear.toString() + "년" {
                firstPraiseYearRow = i
            }
        }
        
        for i in 0...monthArray.count - 1 {
            if monthArray[i] == month.toString() + "월" {
                currentMonthRow = i
            }
            if monthArray[i] == firstPraiseMonth.toString() + "월" {
                firstPraiseMonthRow = i
            }
        }
        
        customDatePickerView.selectRow(loopingYearIndex + currentYearRow, inComponent: 0, animated: false)
        customDatePickerView.selectRow(loopingMonthIndex + firstMonthRow, inComponent: 1, animated: false)
    }
    
    // dismiss when set date
    @IBAction func setDateBtn(_ sender: UIButton) {
        let yearMonthDict = [ "year": selectedYearTitle, "month": selectedMonthTitle]
        NotificationCenter.default.post(name: Notification.Name.selectDatePickerPopUp, object: yearMonthDict)
    }
    
    // dismiss datePicker
    @IBAction func dismissBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.dismissDatePickerPopUp, object: nil)
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
        let loopingYearIndex = (loopingMargin / 2) * yearArray.count
        let monthLoopingIndex = (loopingMargin / 2) * monthArray.count
        let selectedYearRow = customDatePickerView.selectedRow(inComponent: 0) % yearArray.count
        let selectedmonthRow = customDatePickerView.selectedRow(inComponent: 1) % monthArray.count
        
        for i in 0...yearArray.count - 1 {
            if selectedYearRow == i {
                selectedYearTitle = i + 2010
            }
        }
        
        for i in 0...monthArray.count - 1 {
            if selectedmonthRow == i {
                selectedMonthTitle = i
            }
        }
        
        // 현재년도와 같지만 월을 앞서갔을 때
        if (year == selectedYearTitle && month < selectedMonthTitle) {
            customDatePickerView.selectRow(monthLoopingIndex + currentMonthRow, inComponent: 1, animated: true)
            selectedMonthTitle = month
        }
        
        // 현재년도 이후로 피커를 돌릴 때
        else if (year < selectedYearTitle) {
            // 현재년도와 월을 모두 앞서갔을 때
            if (month < selectedMonthTitle) {
                customDatePickerView.selectRow(monthLoopingIndex + currentMonthRow, inComponent: 1, animated: true)
                selectedMonthTitle = month
            }
            customDatePickerView.selectRow(loopingYearIndex + currentYearRow, inComponent: 0, animated: true)
            selectedYearTitle = year
        }
        
        
        // 첫 칭찬 시점 이전으로 월 피커를 돌릴 때 (년도는 같은 경우)
        if (firstPraiseYear == selectedYearTitle && firstPraiseMonth > selectedMonthTitle) {
            // '전체'인 경우 제외
            if selectedMonthTitle != 0 {
                customDatePickerView.selectRow(monthLoopingIndex + firstPraiseMonthRow, inComponent: 1, animated: true)
                selectedMonthTitle = firstPraiseMonth
            }
        }
        // 첫 칭찬 시점 이전으로 년도 피커를 돌릴 때 (선택된 월 상관없이 모두 firstDate로 이동)
        else if (firstPraiseYear > selectedYearTitle) {
            
            customDatePickerView.selectRow(monthLoopingIndex + firstPraiseMonthRow, inComponent: 1, animated: true)
            selectedMonthTitle = firstPraiseMonth
            customDatePickerView.selectRow(loopingYearIndex + firstPraiseYearRow, inComponent: 0, animated: true)
            selectedYearTitle = firstPraiseYear
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

