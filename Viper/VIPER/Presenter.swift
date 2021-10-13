import Foundation
import CoreText
enum FetchError:Error {
    case failed
}
protocol AnyPresenter {
    var router:AnyRouter? { get set }
    var interactor:AnyInteractor? { get set }
    var view:AnyView? { get set }
    func interactorDidFetchBWF(with result:Result<[BWFEntity],Error>)
}

class BWFPresenter:AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getBWFData()
        }
    }
    var view: AnyView?
    
    init() {
        interactor?.getBWFData()
    }
    
    func interactorDidFetchBWF(with result: Result<[BWFEntity], Error>) {
        switch result {
        case .success(let entities):
            view?.update(with: entities)
        case .failure:
            view?.update(with: "something went wrong")
        }
    }
  
}
