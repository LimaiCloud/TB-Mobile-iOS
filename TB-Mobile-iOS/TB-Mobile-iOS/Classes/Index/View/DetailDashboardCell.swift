//
//  DetailDashboardCell.swift
//  TB-Mobile-iOS
//
//  Created by dongmingming on 2018/7/3.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

import UIKit
import Charts

class DetailDashboardCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    // data
    var productArr = NSMutableArray()
    // date
    var weekArr = NSMutableArray()
    var typeStr = ""
    var week = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSubViews(_ arr: NSArray, type: String) {
        productArr.removeAllObjects()
        weekArr.removeAllObjects()
        
        self.typeStr = type
        
        for dataValue in arr {
            let value = dataValue as! NSArray
            let productCount = Double("\(value[1])")!
            let weekStr = DateConvert.MonthDateFormatter("\(value[0])")
            weekArr.add(weekStr)
            productArr.add(productCount)
        }

        for dateStr in weekArr {
            print("======%@", dateStr)
        }
        
        // chartView
        self.setupUI()
    }
    
    // chartView
    func setupUI() {
        chartView.delegate = self
        chartView.noDataText = "暂无统计数据"
        chartView.chartDescription?.enabled = false // 是否显示描述
        chartView.dragEnabled = true     //启用拖拽图标
        chartView.setScaleEnabled(true)  //取消Y轴缩放
        chartView.pinchZoomEnabled = true
        chartView.drawGridBackgroundEnabled = false
        // productArr
        if (self.productArr.count > 0) {
            setChart(weekArr as! [String], values: productArr as! [Double])
        }

    }
    
    // set up charts
    func setChart(_ dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "\(typeStr)：")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)

        chartView.data = lineChartData
        print("dataPoints:====%@", dataPoints)

        // X
       
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        
        
        // Y
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.enabled = false

        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 500
        
        // scale
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        
        chartView.pinchZoomEnabled = true
        
        lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 10.0)
        
        chartView.animate(xAxisDuration: 1)
    }
    
    
    // pragma mark - ChartViewDelegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
