//
//  ViewController2.swift
//  Lesson 5 Log In + Picker
//
//  Created by Валентин Ремизов on 09.01.2023.
//

import UIKit

//MARK: - ViewController2 Delegate
protocol ViewController2Delegate {
    func configure1(name: String, dateOfBirth: String, days: String, tintColor: UIColor)
}

class ViewController2: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var string1Label: UILabel!
    @IBOutlet weak var days1Label: UILabel!
    @IBOutlet weak var img1View: UIImageView!

    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var string2Label: UILabel!
    @IBOutlet weak var days2Label: UILabel!
    @IBOutlet weak var img2View: UIImageView!

    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var string3Label: UILabel!
    @IBOutlet weak var days3Label: UILabel!
    @IBOutlet weak var img3View: UIImageView!

    var nameProperty = String()
    var stringProperty = String()
    var daysProperty = String()

    //MARK: - Lificycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK: - Говорим, если сегвей приведет нас на 3 контролер, то мы инициализируем у него свойство делегейт нашим классом, а именно методом, написанным в экстеншене внизу этого класса.
        guard let viewController3 = segue.destination as? ViewController3 else { return }
        viewController3.delegate = self
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        img1View.tintColor = .white
        img2View.tintColor = .white
        img3View.tintColor = .white
    }
}

//MARK: - ViewController2 Delegate
extension ViewController2: ViewController2Delegate {
    func configure1(name: String, dateOfBirth: String, days: String, tintColor: UIColor) {
        if name1Label.text == "" {
            name1Label.text = name
            string1Label.text = dateOfBirth
            days1Label.text = days
            img1View.tintColor = tintColor
        } else if name2Label.text == "" {
            name2Label.text = name
            string2Label.text = dateOfBirth
            days2Label.text = days
            img2View.tintColor = tintColor
        } else {
            name3Label.text = name
            string3Label.text = dateOfBirth
            days3Label.text = days
            img3View.tintColor = tintColor
        }
    }


}

