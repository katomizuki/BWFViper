//
//  Interactor.swift
//  Viper
//
//  Created by ミズキ on 2021/10/13.
//

import Foundation
//Objcect
//protocol
//ref to presentar

protocol AnyInteractor {
    var presentar:AnyPresenter? { get set }
    func getUsers()
}

class UserInteractor:AnyInteractor {
    var presentar: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                self.presentar?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presentar?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self.presentar?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}


