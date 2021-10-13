import Foundation

protocol AnyInteractor {
    var presentar:AnyPresenter? { get set }
    func getBWFData()
}
//Mark BWFInteractor
class BWFInteractor:AnyInteractor {
    //Mark:Properties
    var presentar: AnyPresenter?
    //Mark getData (データ生成の関数)
    func getBWFData() {
        guard let url = URL(string: "https://bwf-api.herokuapp.com/api/men-singles") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                //Mark resultをPresentarに通達する
                self.presentar?.interactorDidFetchBWF(with: .failure(FetchError.failed))
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let entities = try JSONDecoder().decode([BWFEntity].self, from: data)
                //Mark resultをPresentarに通達する
                self.presentar?.interactorDidFetchBWF(with: .success(entities))
            } catch {
                //Mark resultをPresentarに通達する
                self.presentar?.interactorDidFetchBWF(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}


