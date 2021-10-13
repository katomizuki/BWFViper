import Foundation
import CoreText
enum FetchError:Error {
    case failed
}
protocol AnyPresenter {
    var router:AnyRouter? { get set }
    var interactor:AnyInteractor? { get set }
    var view:AnyView? { get set }
    func interactorDidFetchUsers(with result:Result<[BWFEntity],Error>)
}

class UserPresenter:AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyView?
    
    init() {
        interactor?.getUsers()
    }
    
    func interactorDidFetchUsers(with result: Result<[BWFEntity], Error>) {
        switch result {
        case .success(let entities):
            view?.update(with: entities)
        case .failure:
            view?.update(with: "something went wrong")
        }
    }
  
}
