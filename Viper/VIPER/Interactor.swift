import Foundation

protocol AnyInteractor {
    var presentar:AnyPresenter? { get set }
    func getUsers()
}

class UserInteractor:AnyInteractor {
    var presentar: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://bwf-api.herokuapp.com/api/men-singles") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                self.presentar?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let entities = try JSONDecoder().decode([BWFEntity].self, from: data)
                self.presentar?.interactorDidFetchBWFEntites(with: .success(entities))
            } catch {
                self.presentar?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}


