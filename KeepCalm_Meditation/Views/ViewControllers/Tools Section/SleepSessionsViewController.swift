import UIKit
import DGCharts

class SleepSessionsViewController: UIViewController {
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private var cellData : [SleepInfoCollectionViewDataModel] = [
        .init(imageStringSystemName: "moon.zzz", valueLabelText: "Unknow", titleLabelText: "Sleep"),
        .init(imageStringSystemName: "bed.double", valueLabelText: "Unknow", titleLabelText: "Deep"),
        .init(imageStringSystemName: "star.fill", valueLabelText: "Unknow", titleLabelText: "Quality")
    ]
    
    // MARK: - UI Elements
    
    private lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.contentSize = contentSize
        s.isScrollEnabled = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var contentView : UIView = {
        let content = UIView()
        content.frame.size = contentSize
        return content
    }()
    
    private let contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let sleepTimerTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Sleep Timer"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var sleepTimeLabelsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var hoursLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var minutsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var secondsLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var firstSeparate : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ":"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var secondSeparate : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium35()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ":"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var sleepSessionsActionsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var goToSleepButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Go to Sleep", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .buttonBackground()
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        btn.addTarget(self, action: #selector(goSleepTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var awakeButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Awake", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .buttonBackground()
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        btn.addTarget(self, action: #selector(awakeTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let sleepSessionTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Last Sleep Info"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let sleepSessionQuolityCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        if K.DeviceSizes.currentDeviceHeight <= 667 {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.height / 3.5))
        } else {
            layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3.5), height: (UIScreen.main.bounds.height / 5))
        }
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        c.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentDeviceHeight / 3).isActive = true
        c.indicatorStyle = .white
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c
    }()
    
    private let bedTimeTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .alegreyaMedium30()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Bedtime"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
  //  private let bedTimeChart = LineChartView()
    
    private lazy var bedTimeChart : LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        chart.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentDeviceHeight / 3).isActive = true
        chart.rightAxis.enabled = false
        chart.doubleTapToZoomEnabled = false
        chart.dragEnabled = false
        chart.leftAxis.gridColor = .clear
        chart.xAxis.gridColor = .clear
        
        let yAxis = chart.leftAxis
        yAxis.labelFont = .alegreyaSansRegular14() ?? UIFont.systemFont(ofSize: 14)
        yAxis.labelTextColor = .white
        yAxis.setLabelCount(8, force: false)
        yAxis.axisLineColor = .white
        yAxis.axisLineWidth = 2.5
        yAxis.labelPosition = .outsideChart
        
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .alegreyaSansRegular14() ?? UIFont.systemFont(ofSize: 14)
        chart.xAxis.labelTextColor = .white
        chart.xAxis.setLabelCount(12, force: false)
        chart.xAxis.axisLineWidth = 2.5
        chart.xAxis.axisLineColor = .white
        let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        chart.xAxis.granularity = 1
        
        chart.animate(xAxisDuration: 2.0)
        return chart
    }()
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
        setupConstraints()
        configureNavBar()
        configureCollectionView()
        configureChart()
        bindSleepViewModel()
    }
    
    // MARK: - Buttons Methods
    
    @objc private func goSleepTaped() {
        SleepSessionViewModel.shared.startSleepTimer()
    }
    
    @objc private func awakeTaped() {
        SleepSessionViewModel.shared.stopTimer()
    }
    
    // MARK: - Configure UI
    
    private func configureCollectionView() {
        sleepSessionQuolityCollection.delegate = self
        sleepSessionQuolityCollection.dataSource = self
        sleepSessionQuolityCollection.register(SleepQuolityCollectionViewCell.self, forCellWithReuseIdentifier: "SleepCell")
    }
    
    private func configureChart() {
        bedTimeChart.delegate = self
        
        var sampleData = [ChartDataEntry]()
        
        for x in 0..<10 {
            sampleData.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: sampleData, label: "Hours per month")
        set.colors = [NSUIColor.systemGreen]
        set.drawCircleHoleEnabled = false
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 2.5
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawVerticalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)

        bedTimeChart.data = data
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(sleepTimerTitleLabel)
        contentStackView.addArrangedSubview(sleepTimeLabelsStack)
        sleepTimeLabelsStack.addArrangedSubview(hoursLabel)
        sleepTimeLabelsStack.addArrangedSubview(firstSeparate)
        sleepTimeLabelsStack.addArrangedSubview(minutsLabel)
        sleepTimeLabelsStack.addArrangedSubview(secondSeparate)
        sleepTimeLabelsStack.addArrangedSubview(secondsLabel)
        contentStackView.addArrangedSubview(sleepSessionsActionsStack)
        sleepSessionsActionsStack.addArrangedSubview(goToSleepButton)
        sleepSessionsActionsStack.addArrangedSubview(awakeButton)
        contentStackView.addArrangedSubview(sleepSessionTitleLabel)
        contentStackView.addArrangedSubview(sleepSessionQuolityCollection)
        contentStackView.addArrangedSubview(bedTimeTitleLabel)
        contentStackView.addArrangedSubview(bedTimeChart)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            K.DeviceSizes.currentDeviceHeight <= 568 ? scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70) : scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            K.DeviceSizes.currentDeviceHeight <= 568 ? scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60) : ((K.DeviceSizes.currentDeviceHeight <= 667) ? scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70) : scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            sleepTimerTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            sleepSessionTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            bedTimeTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
        ])
    }
    
    private func bindSleepViewModel() {
        SleepSessionViewModel.shared.sleepTimerStatus.bind { sleepTime in
            DispatchQueue.main.async {
                self.hoursLabel.text = "\(sleepTime.hours)"
                self.minutsLabel.text = "\(sleepTime.minuts)"
                self.secondsLabel.text = "\(sleepTime.seconds)"
            }
        }
        
        SleepSessionViewModel.shared.sleepDuration.bind { duration in
            DispatchQueue.main.async {
                self.cellData[0].valueLabelText = duration
                self.sleepSessionQuolityCollection.reloadData()
            }
        }
        
        SleepSessionViewModel.shared.deepSleepHoursValue.bind { deepSleep in
            DispatchQueue.main.async {
                self.cellData[1].valueLabelText = deepSleep
                self.sleepSessionQuolityCollection.reloadData()
            }
        }
        
        SleepSessionViewModel.shared.sleepQualityStatus.bind { quality in
            DispatchQueue.main.async {
                self.cellData[2].valueLabelText = String(quality)
                self.sleepSessionQuolityCollection.reloadData()
            }
        }
    }
}

// MARK: - CollectionView Delegate & DataSource

extension SleepSessionsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SleepCell", for: indexPath) as! SleepQuolityCollectionViewCell
        
        let currentData = cellData[indexPath.row]
        cell.cellData = currentData
        
        return cell
    }
}

// MARK: - DGChart Delegate

extension SleepSessionsViewController: ChartViewDelegate {
 
}
