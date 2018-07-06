//
//  ServiceErrorPresentable.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

protocol ServiceErrorPresentable {
    func showAlert(error: ServiceError)
}

extension ServiceErrorPresentable where Self: UIViewController {
    func showAlert(error: ServiceError) {
        let alert = UIAlertController(
            title: getTitle(error),
            message: getMessage(error),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getTitle(_ error: ServiceError) -> String {
        switch error {
        case .connectionError:
            return "Отсутствует соединение с интернетом"
        case .serverError(_):
            return "Ошибка сервера"
        }
    }
    
    private func getMessage(_ error: ServiceError) -> String {
        let defaultStr = "Повторите попытку позже"
        switch error {
        case .connectionError:
            return defaultStr
        case .serverError(let message):
            return message ?? defaultStr
        }
    }
}
