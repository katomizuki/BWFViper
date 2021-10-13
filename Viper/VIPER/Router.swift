
import Foundation
import UIKit
typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter {
    var entry:EntryPoint? { get }
    static func start()->AnyRouter
}
class UserRouter:AnyRouter {
    var entry: EntryPoint?
    static func start() -> AnyRouter {
        let router = UserRouter()
        var view:AnyView = UserViewController()
        var presenter:AnyPresenter = UserPresenter()
        var interactor:AnyInteractor = UserInteractor()
        view.presentar = presenter
        interactor.presentar = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
