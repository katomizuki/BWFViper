import Foundation

protocol AnyInteractor {
    var presentar:AnyPresenter? { get set }
    func getBWFData(text:String)
}
//Mark BWFInteractor
class BWFInteractor:AnyInteractor {
    //Mark:Properties
    var presentar: AnyPresenter?
    //Mark getData (データ生成の関数)
    func getBWFData(text:String) {
        guard let url = URL(string: "https://bwf-api.herokuapp.com/api/\(text)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                //Mark resultをPresentarに通達する
                self.presentar?.interactorDidFetchBWF(with: .failure(FetchError.failed))
                print(error)
                return
            }
            guard let data = data else { return }
            print(data)
            do {
                
                let entities = try JSONDecoder().decode([BWFEntity].self, from: data)
                print("✊")
                //Mark resultをPresentarに通達する
                self.presentar?.interactorDidFetchBWF(with: .success(entities))
            } catch {
                //Mark resultをPresentarに通達する
                print("⚡️")
                self.presentar?.interactorDidFetchBWF(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}


