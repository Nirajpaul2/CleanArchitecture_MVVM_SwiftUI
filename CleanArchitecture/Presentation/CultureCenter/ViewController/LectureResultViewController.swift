//
//  LectureResultViewController.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import UIKit
import RxSwift
import RxDataSources

class LectureResultViewController: UIViewController {
    @IBOutlet weak var lectureCountLabel: UILabel!
    @IBOutlet weak var lectureListTableView: UITableView!
    
    private var cultureCenterViewModel: CultureCenterViewModel
    private let disposeBag = DisposeBag()
    
    init(cultureCenterViewModel: CultureCenterViewModel) {
        self.cultureCenterViewModel = cultureCenterViewModel
        super.init(nibName: "LectureResultViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupBindings()
        setupNavigationBar()
        cultureCenterViewModel.searchCultureList()
    }

}

private extension LectureResultViewController {
    func setupDelegate() {
        lectureListTableView.delegate = self
        lectureListTableView.dataSource = self
        
        let nib = UINib(nibName: "LectureSearchCell", bundle: nil)
        lectureListTableView.register(nib, forCellReuseIdentifier: "LectureSearchCell")
    }
    
    func setupBindings() {
        cultureCenterViewModel.lectureList
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                let lectureCount = self.cultureCenterViewModel.lectureList.value.count
                self.lectureCountLabel.text = "\(lectureCount) lectures found." // Translated from "개의 강좌가 검색 되었어요."
                
                self.lectureListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    
        cultureCenterViewModel.errors.subscribe(on: MainScheduler.instance)
            .bind { error in
               print("🚨 Error Occurred: \(error)")
           }.disposed(by: disposeBag)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Lecture Search Results" // Translated from "강좌 검색 결과"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - TableView Delegate

extension LectureResultViewController: UITableViewDelegate {}

// MARK: - TableView DataSource

extension LectureResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cultureCenterViewModel.lectureList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LectureSearchCell",
            for: indexPath) as? LectureSearchCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let data = cultureCenterViewModel.lectureList.value[indexPath.row]
        cell.bindData(data: data, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
