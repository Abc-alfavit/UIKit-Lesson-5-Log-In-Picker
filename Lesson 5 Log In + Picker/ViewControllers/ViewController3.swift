//
//  ViewController3.swift
//  Lesson 5 Log In + Picker
//
//  Created by Валентин Ремизов on 13.01.2023.
//

import UIKit

class ViewController3: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ageOldTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var instTextField: UITextField!

    //MARK: - Views
    private let dateBirthPicker = UIDatePicker()
    private let ageOldPicker = UIPickerView()
    private let genderPicker = UIPickerView()
    
    //MARK: - Private Properties
    //Создаём массив Int от 18 до 80
    private let ageOldArr = Array(18...80)
    private let genderArr = ["Не выбрано", "Мужской", "Женский"]
    
    //MARK: - Public Properties
    var delegate: ViewController2Delegate?

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatepicker()
        ageOldTextField.inputView = ageOldPicker
        genderTextField.inputView = genderPicker
        //Подключаем протоколы, выскачит ошибка, для этого нужно расширить наш класс или создать протоколы эти для работы Picker.
        ageOldPicker.dataSource = self
        ageOldPicker.delegate = self
        genderPicker.delegate = self
        genderPicker.dataSource = self
        //Делаем тэг для пикеров, но не понял до конца что это такое, используется это в свитчах методов ниже
        dateBirthPicker.tag = 1
        ageOldPicker.tag = 2
        genderPicker.tag = 3
        //Показывает на фоне в окошке ввода подсказку что нужно ввести.
        nameTextField.placeholder = "Введите Ваше имя"
        dateOfBirthTextField.placeholder = "Выберите дату Вашего рождения"
        ageOldTextField.placeholder = "Выберите Ваш возраст, нам лень считать"
        genderTextField.placeholder = "Выберите Ваш пол (не потолок)"
        instTextField.placeholder = "Введите Ваш инстаграм"
        instTextField.addTarget(self, action: #selector(addInst), for: .allTouchEvents)
    }

    //MARK: - Функция всплытия алерта при нажатии на текстовое поле для ввода инстаграма
    @objc func addInst() {
        let alertController = UIAlertController(title: "", message: "Введите Ваш логин Instagram", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) {_ in
            self.instTextField.text = alertController.textFields?[0].text
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)

        //добавление текстового поля с фоновой подсказкой "введите Ваш instagram"
        alertController.addTextField() {(text) in
            text.placeholder = "Введите Ваш instagram"
        }
        alertController.addAction(alertActionOk)
        alertController.addAction(alertActionCancel)
        self.present(alertController, animated: true)
    }

    @IBAction func doneButton(_ sender: Any) {
        //MARK: - Извлекаем не опциональные значения из текстовых полей
        guard let name = nameTextField.text else { return }
        guard let dateOfBirth = dateOfBirthTextField.text else { return }
        guard let ageOld = ageOldTextField.text else { return }
        //MARK: - Вызываем у делегата метод нашего контроллера2, который написан в протоколе контроллера2 вверху, а так же реализован в эекстеншене контроллера2 внизу + инициализировано свойство при переходе с контроллера2 на контроллер3 в методе override func prepare( это свойство классом контроллера2
        delegate?.configure1(
            name: name,
            dateOfBirth: "\(dateOfBirth) исполнится \(ageOld)",
            days: "13 дней",
            tintColor: .blue
        )

        //Позволяет вернуться назад в предыдущее окно
        navigationController?.popViewController(animated: true)
     
    }
}

extension ViewController3: UIPickerViewDelegate, UIPickerViewDataSource {

    //Количество столбцов в нашем пикере
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //Количество строк в нашем пикере
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 2:
            return ageOldArr.count
        case 3:
            return genderArr.count
        default:
            return 2
        }
        //genderArr.count
    }

    //В этом методе мы задаем что мы будем писать вообще в наших строчках
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Будет возвращать значение массива в соответствии с его индексом соответствующий значению row
        switch pickerView.tag {
        case 2: return String(ageOldArr[row])
        case 3: return genderArr[row]
        default: return ""
        }
    }

    //Этим методом мы назначаем что будет при выборе ответа в пикере
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 2:
            switch row {
        case 0: ageOldTextField.text = nil
        default: ageOldTextField.text = String(ageOldArr[row])
        }

        case 3:
            //Делаем switch на то, чтоб если человек не выбрал пол, то было пусто, в остальных значениях текстовое поле заполнялось данными из массива
            switch row {
            case 0 : genderTextField.text = nil
            default: genderTextField.text = genderArr[row]
            }
        default: break
        }
        //после выбранного ответа пикер закрывается
        genderTextField.resignFirstResponder()
        ageOldTextField.resignFirstResponder()
    }

    func createToolBar() -> UIToolbar {
        //Создаём tool bar
        let toolBar = UIToolbar()
        //устанавливается размер скорее всего
        toolBar.sizeToFit()

        //Создаётся кнопка done
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        //И добавляется в tool bar я так понимаю
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        toolBar.setItems([doneButton, cancelButton], animated: true)

        return toolBar
    }

    func createDatepicker() {
        //Сначала задаём стиль пикера (колёсики)
        dateBirthPicker.preferredDatePickerStyle = .wheels
        //Обозначаем что там будет содержаться - дата
        dateBirthPicker.datePickerMode = .date
        //Присваиваем наш пикер с датой в текстовое поле
        dateOfBirthTextField.inputView = dateBirthPicker
        //Присваиваем нашему пикеру в текстовом поле tool bar
        dateOfBirthTextField.inputAccessoryView = createToolBar()
    }

    @objc func donePressed() {
        //Создаём формат даты в виде константы
        let dateFormatter = DateFormatter()
        //Назначаем константе средний по длине формат даты
        dateFormatter.dateStyle = .medium
        //Назначаем константе длину времени - в этом случае без него
        dateFormatter.timeStyle = .none

        //Назначаем нашему текстовому полю нашу дату в виде строки в таком формате, который 2-мя строчками выше назначили
        self.dateOfBirthTextField.text = dateFormatter.string(from: dateBirthPicker.date)
        self.view.endEditing(true)
    }
}
