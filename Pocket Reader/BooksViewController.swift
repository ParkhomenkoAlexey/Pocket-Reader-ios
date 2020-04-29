//
//  BooksViewController.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 29.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum GenreType: String {
    case activeNow
    case psychology
    case children
    case novels
    case detectives
}

struct BookItem: Hashable {
    var name: String
    let genre: GenreType
    var author: String
    let edition: Int
    let pages: Int
    let bookDescription: String
    let imageName: String
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    
    }
    
    static func == (lhs: BookItem, rhs: BookItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func getBooks() -> [BookItem] {
        return [
            BookItem(name: "Расширить сознание легально", genre: .psychology,
                     author: "Владислав Гайдукевич", edition: 2019, pages: 40,
                     bookDescription: "Уникальная книга о детальной работе социальной машины, построена в формате переплетения точек обзора: от объективного факта до наилучшего варианта его субъективной адаптации. Единственное в своем роде пособие, имеющее ключи дешифровки для экзистенциального кризиса любого масштаба. Все, что нужно понимать, для счастья и самореализации есть на этих страницах. Рекомендуется к прочтению вне зависимости от возраста и социального статуса.",
                     imageName: "111"),
            BookItem(name: "Психология влияния", genre: .psychology,
            author: "Роберт Чалдини", edition: 1993, pages: 380,
            bookDescription: "К искусству убеждения можно относиться по-разному. Одни стремятся овладеть им в совершенстве, чтобы всегда и везде добиваться своих целей, другие считают недопустимым, когда используя механизмы воздействия, людям навязывают невыгодные для них условия. Однако никто из нас не хочет стать жертвой манипуляторов, легкой добычей для продавцов, сборщиков средств и рекламодателей.\nВ этой книге Роберт Чалдини, доктор наук, профессор психологии и признанный эксперт в сфере влияния и убеждения, рассматривает шесть универсальных приемов, благодаря которым вы станете настоящим мастером уговоров. В то же время, зная об этих приемах, вы всегда сможете избежать нежелательного воздействия со стороны.",
            imageName: "222"),
            BookItem(name: "Календарь ма(й)я", genre: .children,
            author: "Виктория Ледерман", edition: 2016, pages: 210,
            bookDescription: "Просыпаться утром и обнаруживать, что проживаешь дни в обратном порядке, – штука посерьезней «Дня сурка»! Шестиклассник Глеб Елизаров всего лишь нацарапал на древней стене дату «23.05.2013» – и отправился с парой одноклассников сначала в 22 мая, а затем в 21-е, 20-е, 19-е… \nНедавно перешедший в новую школу Глеб, увалень-отличник Юра Карасев и погрязшая в домашних делах Лена Зюзина видят в повторении вчерашних и позавчерашних событий кое-какие плюсы. Можно переписать итоговую контрольную, уклониться от драки с хулиганом или даже без угрызений совести спустить все карманные деньги на угощение – ведь утром купюры и монеты снова окажутся в кошельке!.",
            imageName: "333"),
            BookItem(name: "Поллианна", genre: .children,
            author: "Элинор Портер", edition: 1913, pages: 260,
            bookDescription: "После смерти папы маленькую Поллианну отправляют жить к сварливой тётке. Впереди у неё ещё много испытаний… Эта книга, написанная ровно сто лет назад, вошла в золотой фонд литературы для детей.",
            imageName: "444"),
            BookItem(name: "Происхождение", genre: .detectives,
            author: "Дэн Браун", edition: 2017, pages: 530,
            bookDescription: "Происхождение» – пятая книга американского писателя Дэна Брауна о гарвардском профессоре, специалисте по религиозной символике Роберте Лэнгдоне. В этот раз все начинается с, возможно, одного из наиболее знаковых событий в истории: наконец-то стало известно, откуда произошло человечество. Футуролог Эдмонд Кирш, совершивший невероятное открытие, был всего лишь в шаге от того, чтобы полностью изменить представление современников о мире. Однако его речи не суждено было прозвучать в стенах Музея Гуггенхайма. Ученого убили на глазах гостей. И начался хаос…",
            imageName: "555"),
            BookItem(name: "Самая хитрая рыба", genre: .detectives,
            author: "Елена Михалкова", edition: 2019, pages: 390,
            bookDescription: "Перед вами двадцать шестой роман цикла загадочных детективных историй «Расследования Макара Илюшина и Сергея Бабкина» от признанного мастера остросюжетной прозы Елены Михалковой.\nПожилая женщина Анна Сергеевна Бережкова живет в маленьком поселке, где все друг друга знают. Когда в соседнем пустующем доме наконец появляются новые жильцы, старушка сначала радуется, однако после знакомства с Натальей и Антоном решает, что лучше бы дом и дальше пустовал.",
            imageName: "666"),
            BookItem(name: "Земное притяжение", genre: .novels,
            author: "Татьяна Устинова", edition: 2017, pages: 310,
            bookDescription: "Их четверо. Летчик из Анадыря; знаменитый искусствовед; шаманка из алтайского села; модная московская художница. У каждого из них своя жизнь, но возникает внештатная ситуация, и эти четверо собираются вместе. Точнее – их собирают для выполнения задания!.. В тамбовской библиотеке умер директор, а вслед за этим происходят странные события – библиотека разгромлена, словно в ней пытались найти все сокровища мира, а за сотрудниками явно кто-то следит. Что именно было спрятано среди книг?.. И отчего так важно это найти?..\nКто эти четверо? Почему они умеют все – управлять любыми видами транспорта, стрелять, делать хирургические операции, разгадывать сложные шифры?.. Летчик, искусствовед, шаманка и художница ответят на все вопросы и пройдут все испытания. У них за плечами – целая общая жизнь, которая вмещает все: любовь, расставания, ссоры с близкими, старые обиды и новые надежды. Они справятся с заданием, распутают клубок, переживут потери и обретут любовь – земного притяжения никто не отменял!..",
            imageName: "777"),
            BookItem(name: "Город женщин", genre: .novels,
            author: "Элизабет Гилберт", edition: 2019, pages: 470,
            bookDescription: "Нью-Йорк, сороковые годы XX века. Девятнадцатилетнюю Вивиан Моррис только что выгнали из колледжа Вассар за систематические прогулы и заваленные экзамены. Богатые, но вечно занятые собой родители отправляют непутевую дочь в Манхэттен к тетушке Пег, владеющей ярким, но, по всей видимости, доживающим последние годы театром «Лили».",
            imageName: "888")
        ]
    }
}

class BooksViewController: UIViewController {
    
    enum Section: Int {
        case activeNow = 0, psyhology, children, novels, detectives
    }
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, BookItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        setupConstraints()
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, BookItem>(tableView: tableView, cellProvider: { (tableView, indexPath, bookItem) -> UITableViewCell? in
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
            cell.textLabel?.text = bookItem.name
            cell.backgroundColor = .systemBackground
            cell.editingAccessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        })
    }
}

// MARK: - View Setup
extension BooksViewController {
    func setupElements() {
        view.backgroundColor = .systemBackground
        tableView = UITableView(frame: .zero, style: .grouped)
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

