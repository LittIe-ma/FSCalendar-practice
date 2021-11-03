//
//  ViewController.swift
//  FSCalendar-practice
//
//  Created by yasudamasato on 2021/11/02.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

//ディスプレイサイズ
let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    private let labelDate = UILabel(frame: CGRect(x: 5, y: 580, width: 400, height: 50))
    private let labelTitle = UILabel(frame: CGRect(x: 0, y: 530, width: 180, height: 50))
    private let dateView = FSCalendar(frame: CGRect(x: 0, y: 30, width: width, height: 400))
    private let date = UILabel(frame: CGRect(x: 5, y: 430, width: 200, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()

        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.today = nil
        self.dateView.tintColor = .red
        self.view.backgroundColor = .white
        dateView.backgroundColor = .white
        view.addSubview(dateView)
    }

    //日付設定表示
    private func setUpDate() {
        date.text = ""
        date.font = UIFont.systemFont(ofSize: 60)
        date.textColor = .black
        view.addSubview(date)
    }

    //主なスケジュール表示設定
    private func setUpSchedule() {
        labelTitle.text = ""
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(labelTitle)
    }

    //スケジュール内容表示設定
    private func setUpScheduleContent() {
        labelDate.text = ""
        labelDate.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(labelDate)
    }

    //スケジュール追加ボタン
    private func addSchedule() {
        let addButton = UIButton(frame: CGRect(x: width - 70, y: height - 70, width: 60, height: 60))
        addButton.setTitle("+", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.backgroundColor = .orange
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    //祝日判定
    private func judgeHoliday(_ date: Date) -> Bool {
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }

    //年月日取得
    private func getDay(_ date: Date) -> (Int, Int, Int) {
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        return (year, month, day)
    }

    //曜日判定
    private func getWeekIndex(_ date: Date) -> Int {
        let tmpCalendar = Calendar(identifier: .gregorian)

        return tmpCalendar.component(.weekday, from: date)
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.judgeHoliday(date) {
            return UIColor.red
        }

        let weekday = self.getWeekIndex(date)
        if weekday == 1 {
            return UIColor.red
        }else if weekday == 7 {
            return UIColor.blue
        }
        return nil
    }

    //画面遷移
    @objc func onClick(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
        present(SecondController, animated: true, completion: nil)
    }
}

