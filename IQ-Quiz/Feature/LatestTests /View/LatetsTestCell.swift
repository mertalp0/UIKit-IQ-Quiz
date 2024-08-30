//
//  LatetsTestCell.swift
//  IQ-Quiz
//
//  Created by mert alp on 24.08.2024.
//
import UIKit

class LatestTestCell: UITableViewCell {
    // MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iqLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let correctAnswersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Custom initializer
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
extension LatestTestCell{
    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(iqLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(correctAnswersLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iqLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            iqLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iqLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            correctAnswersLabel.topAnchor.constraint(equalTo: iqLabel.bottomAnchor, constant: 4),
            correctAnswersLabel.leadingAnchor.constraint(equalTo: iqLabel.leadingAnchor),
            correctAnswersLabel.trailingAnchor.constraint(equalTo: iqLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: correctAnswersLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: iqLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: iqLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
}

//MARK: - Configure Cell
extension LatestTestCell{
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
