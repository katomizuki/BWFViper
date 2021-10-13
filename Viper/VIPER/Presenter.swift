import Foundation
import CoreText
//Enum Error
enum FetchError:Error {
    case failed
}
//Protocol Presentar
protocol AnyPresenter {
    var router:AnyRouter? { get set }
    var interactor:AnyInteractor? { get set }
    var view:AnyView? { get set }
    func interactorDidFetchBWF(with result:Result<[BWFEntity],Error>)
    func didTappedButton(text:String)
}
//Mark Presenter
class BWFPresenter:AnyPresenter {
    //Mark Properties
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getBWFData(text:"mens-singles")
        }
    }
    var view: AnyView?
    //Mark Initialize
    init() {
        interactor?.getBWFData(text:"mens-singles")
    }
    //Mark Interactorからきた結果を受け取り & updateUIの指示をViewに指示する
    func interactorDidFetchBWF(with result: Result<[BWFEntity], Error>) {
        //result success⇨update UI(tableView) failure⇨ update UI(update Label)
        switch result {
        case .success(let entities):
            view?.update(with: entities)
        case .failure:
            view?.update(with: "something went wrong")
        }
    }
    func didTappedButton(text:String) {
        print(#function)
        interactor?.getBWFData(text: text)
    }
}
