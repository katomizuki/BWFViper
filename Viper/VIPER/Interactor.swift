import Foundation

protocol AnyInteractor {
    var presentar:AnyPresenter? { get set }
    func getBWFData()
}

class BWFInteractor:AnyInteractor {
    var presentar: AnyPresenter?
    
    func getBWFData() {
        guard let url = URL(string: "https://bwf-api.herokuapp.com/api/men-singles") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                self.presentar?.interactorDidFetchBWF(with: .failure(FetchError.failed))
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let entities = try JSONDecoder().decode([BWFEntity].self, from: data)
                self.presentar?.interactorDidFetchBWF(with: .success(entities))
            } catch {
                self.presentar?.interactorDidFetchBWF(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}


