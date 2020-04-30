//
//  DetailViewController.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 30.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let authorLabel = UILabel()
    let authorNameLabel = UILabel()
    let editionLabel = UILabel()
    let editionYearLabel = UILabel()
    let pagesLabel = UILabel()
    let pagesNumberLabel = UILabel()
    let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

//        setup(bookitem: BookItem(name: "Поллианна", genre: .children,
//        author: "Элинор Портер", edition: 1913, pages: 260,
//        bookDescription: "После смерти папы маленькую Поллианну отправляют жить к сварливой тётке. Впереди у неё ещё много испытаний… Эта книга, написанная ровно сто лет назад, вошла в золотой фонд литературы для детей.",
//        imageName: "444"))
        setupElements()
        setupConstraints()
    }
    
    func setup(bookitem: BookItem) {
        nameLabel.text = bookitem.name
        authorNameLabel.text = bookitem.author
        editionYearLabel.text = String(bookitem.edition)
        pagesNumberLabel.text = String(bookitem.pages)
        descriptionLabel.text = bookitem.bookDescription
        imageView.image = UIImage(named: bookitem.imageName)
    }

}

// MARK: - View Setup
extension DetailViewController {
    func setupElements() {
        view.backgroundColor = .systemBackground
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .red
        authorLabel.text = "Автор:"
        editionLabel.text = "Издание:"
        pagesLabel.text = "Страниц:"
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        editionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pagesLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        authorNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pagesNumberLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        nameLabel.numberOfLines = 0
        authorNameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
}

// MARK: - Setup constraints
extension DetailViewController {
    func setupConstraints() {
        let labelsStackView = UIStackView(arrangedSubview: [
            nameLabel, authorLabel, authorNameLabel, editionLabel, editionYearLabel, pagesLabel, pagesNumberLabel
        ], axis: .vertical, spacing: 8)
        
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2.5 * 1.4).isActive = true
        let topStackView = UIStackView(arrangedSubview: [imageView, labelsStackView], axis: .horizontal, spacing: 10)
        topStackView.alignment = .top
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topStackView)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct DetailBookProvider: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                ContainerView().edgesIgnoringSafeArea(.all)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                    .previewDisplayName("iPhone 11 Pro")
                
                ContainerView().edgesIgnoringSafeArea(.all)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 7"))
                    .previewDisplayName("iPhone 7")
            }
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = DetailViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DetailBookProvider.ContainerView>) -> DetailViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: DetailBookProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DetailBookProvider.ContainerView>) {
            
        }
    }
}




