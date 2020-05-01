//
//  BooksViewController.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 29.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    var objects = BookItem.getBooks()
    
    enum Section: Int {
        case activeNow = 0, psychology, children, novels, detectives
        
        func description() -> String {
            switch self {
            case .activeNow:
                return "ВАШ ВЫБОР"
            case .psychology:
                return "ПСИХОЛОГИЯ, МОТИВАЦИЯ"
            case .children:
                 return "ДЕТСКИЕ КНИГИ"
            case .novels:
                return "ЛЮБОВНЫЕ РОМАНЫ"
            case .detectives:
                return "ДЕТЕКТИВЫ"
            }
        }
        
        func genreType() -> GenreType {
            switch self {
            case .activeNow:
                return .activeNow
            case .psychology:
                return .psychology
            case .children:
                return .children
            case .novels:
                return .novels
            case .detectives:
                return .detectives
            }
        }
    }
    
    var tableView: UITableView!
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        setupConstraints()
        configureDataSource()
    }
    
    func initialSnapshot() -> NSDiffableDataSourceSnapshot<Section, BookItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookItem>()
        
        let pickedBooks = Set(UserSettings.userBooks.lazy.map({ $0.name }))
        let noPickedBooks = objects.filter { !pickedBooks.contains($0.name) }
        objects = noPickedBooks
        
        snapshot.appendSections([.activeNow])
        snapshot.appendItems(UserSettings.userBooks, toSection: .activeNow)
        snapshot.appendSections([.psychology])
        snapshot.appendItems(objects.filter({ $0.genre == .psychology}), toSection: .psychology)
        
        snapshot.appendSections([.children])
        snapshot.appendItems(objects.filter({ $0.genre == .children}), toSection: .children)
        
        snapshot.appendSections([.novels])
        snapshot.appendItems(objects.filter({ $0.genre == .novels}), toSection: .novels)
        
        snapshot.appendSections([.detectives])
        snapshot.appendItems(objects.filter({ $0.genre == .detectives}), toSection: .detectives)
        
        return snapshot
    }
    
    func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, bookItem) -> UITableViewCell? in
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
            cell.textLabel?.text = bookItem.name
            cell.backgroundColor = .systemBackground
            cell.editingAccessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        })
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - View Setup
extension BooksViewController {
    func setupElements() {
        view.backgroundColor = .systemBackground
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.setEditing(true, animated: true)
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "Pocked Reader"
    }
}

// MARK: - Setup Constraints
extension BooksViewController {
    func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
}

// MARK: - Data Source
extension BooksViewController {
    class DataSource: UITableViewDiffableDataSource<Section, BookItem> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            if section == 0 {
                return "Добавляй в эту секцию те книги, которые хочешь прочитать!"
            } else {
                return nil
            }
        }
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .insert {
                let destinationIndexPath = IndexPath(row: 0, section: 0)
                guard let sourceIdentifier = itemIdentifier(for: indexPath) else { return }
                let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
                
                var snapshot = self.snapshot()
                
                if let destinationIdentifier = destinationIdentifier {
                    snapshot.deleteItems([sourceIdentifier])
                    snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
                    apply(snapshot)
                } else {
                    let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
                    snapshot.deleteItems([sourceIdentifier])
                    snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
                    apply(snapshot)
                }
            }
            if editingStyle == .delete {
                guard let sourceIdentifier = itemIdentifier(for: indexPath) else { return }
                var snapshot = self.snapshot()
                for section in snapshot.sectionIdentifiers {
                    if section.genreType() == sourceIdentifier.genre {
                        snapshot.deleteItems([sourceIdentifier])
                        snapshot.appendItems([sourceIdentifier], toSection: section)
                        apply(snapshot)
                    }
                }
            }
            let snapshot = self.snapshot()
            let pickedBooks = snapshot.itemIdentifiers(inSection: .activeNow)
            UserSettings.userBooks = pickedBooks
            
        }
    }
}

// MARK: - UITableViewDelegate
extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .delete
        } else {
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let bookItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        let detailVC = DetailViewController()
        detailVC.setup(bookitem: bookItem)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

