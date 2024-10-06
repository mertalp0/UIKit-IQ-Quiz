//
//  LatetsTestCell.swift
//  IQ-Quiz
//
//  Created by mert alp on 24.08.2024.
//
import UIKit
import SnapKit

class LatestTestCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let iqLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let correctAnswersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
}

//MARK: - Setup Cell
extension LatestTestCell {
    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(iqLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(correctAnswersLabel)
        
        // SnapKit ile constraint'ler
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
        
        iqLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
        }
        
        correctAnswersLabel.snp.makeConstraints { make in
            make.top.equalTo(iqLabel.snp.bottom).offset(4)
            make.leading.equalTo(iqLabel.snp.leading)
            make.trailing.equalTo(iqLabel.snp.trailing)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(correctAnswersLabel.snp.bottom).offset(4)
            make.leading.equalTo(iqLabel.snp.leading)
            make.trailing.equalTo(iqLabel.snp.trailing)
            make.bottom.equalTo(containerView.snp.bottom).inset(10)
        }
    }
}

//MARK: - Configure Cell
extension LatestTestCell {
    func configure(with quizResult: QuizResult) {
        iqLabel.text = "IQ: \(quizResult.iqScore)"
        correctAnswersLabel.text = "Doğru Cevaplar: \(quizResult.correctAnswers)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if let date = quizResult.date {
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
        } else {
            dateLabel.text = "Tarih mevcut değil"
        }
    }
}
